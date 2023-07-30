# Creating and configuring a Droplet  <!-- omit from toc -->

## Docs and other links:  
[Youtube Nginx, Gunicorn, Flask droplet](https://www.youtube.com/watch?v=KWIIPKbdxD0)

## Contents  <!-- omit from toc -->
- [Docs and other links:](#docs-and-other-links)
- [Generating ssh-key on Windows 11](#generating-ssh-key-on-windows-11)
- [Accessing droplet from Windows machine Terminal](#accessing-droplet-from-windows-machine-terminal)
- [Starting the droplet for the first time](#starting-the-droplet-for-the-first-time)
- [Creating users](#creating-users)
- [Copy the SSH over to the new user](#copy-the-ssh-over-to-the-new-user)
- [Configuring the droplet](#configuring-the-droplet)
  - [Install Nginx](#install-nginx)
  - [Installing gunicorn](#installing-gunicorn)
  - [Configuring gunicorn](#configuring-gunicorn)
  - [Configuring nginx](#configuring-nginx)
  - [Configuring the firewall](#configuring-the-firewall)
  - [Creating a pipeline with Github actions](#creating-a-pipeline-with-github-actions)
- [Configuring the DNS](#configuring-the-dns)

## Generating ssh-key on Windows 11  
[Youtube ssh-keygen Win11](https://www.youtube.com/watch?v=qvmKLBKE2lM)  
A ssh-key on Win11 can be generated in a similar way to a Linux machine  
Open a terminal with PowerShell and type `ssh-keygen` to generate the ssh-key  
Follow the commands on the terminal  

Two files are generated and a folder in the user folder called `.ssh`  

The `.pub` file is the public file for entering in sites.  
Starts with "ssh-rsa" and ends with the name of the machine.  
**The other file is not to be shared!**  

## Accessing droplet from Windows machine Terminal  
To access your droplet from your machine you need to add a config file to the `.ssh` folder in `C:\Users\<username>\`.  
In the folder create a file named `config` and use VSCode to edit the file.  
The contents of the file are as shown in the block below:  
  
```
Host        <name for cli>
    User        <the user you want to login as on the target machine>
            IdentityFile <personal rsa file location>
            IdentitiesOnly yes
            ForwardAgent yes
    Hostname    <IP-adress of target>
    Port        <port you want to use>

----------------------------------------------------------------------

Host        sshconnect
    User        test
            IdentityFile ~/test_rsa
            IdentitiesOnly yes
            ForwardAgent yes
    Hostname    000.000.000.00
    Port        00
```  
  
With this you should be able to connect to your Drolet from the terminal (PS/cmd).  

## Starting the droplet for the first time  
[Youtube upgrading droplet](https://www.youtube.com/watch?v=q5nRJqjnWK0)  
After you used the terminal to ssh into the droplet with `ssh <name you set in config>`.  
You enter the droplet and have to do the first time things, such as updating the system and adding a sudo user.  

Update the system with the command: `apt upgrade`.  
Or use `apt update` (gets packages) and the `apt upgrade` (installs packages).  
[Best practice](https://www.howtogeek.com/791055/apt-vs.-apt-get-whats-the-difference-on-linux/) is to use `apt-get` for installing packages?  

## Creating users  
[Youtube users](https://www.youtube.com/watch?v=g68wuUrrRMs&t=1s)  
Setting or resetting the root password with `sudo -i passwd`.  
Create user with `adduser <name>` and follow the cli instructions.  
Add sudo rights to a user `usermod -aG sudo <username>`. The user now has sudo rights.  
Switch users with `su <name>` and enter the password.  
Change the user password with the `passwd` command.  
Change another user's password with `sudo passwd <name>`.  

## Copy the SSH over to the new user  
From the root account in the `.ssh` folder in the `authorized-keys` file, copy the key.  
Switch to the user and make the `.ssh` directory in the `/home/<user>` directory.  
Create a file `authorized_keys` and paste in the copied ssh-key.  
This should allow the user to ssh into the droplet directly.  

## Configuring the droplet  
[Youtube droplet config](https://www.youtube.com/watch?v=qaBo_IiE4Gc)  
The droplet comes with a version of python, which you can check by `python3 --version`.  

Install the Python-venv package: `sudo apt install python3-venv`.  
*Note: activating the venv on Linux is different from Windows. In linux it's in `/.venv/bin/activate`.*  

### Install Nginx  
Install nginx with `sudo apt install nginx`.  
Using `sudo systemctl start nginx` starts the Nginx server.  
Nginx has a default site in `/var/www/html` and default config in `/etc/nginx/nginx.conf`.  
The default listen port is 80 and can be set/changed in `/etc/nginx/sites-enabled/` here the default file can be overwritten or a new file can be created.  

### Installing gunicorn  
Gunicorn is a specific WSGI for Linux. It is installed through pip with: `pip install gunicorn` on Ubuntu.  

Create a service file in `/etc/systemd/system/<appname>.service` and configure the service file as shown below.  
[systemd docs](https://www.freedesktop.org/software/systemd/man/systemd.exec.html)  
[Systemd config](https://blog.miguelgrinberg.com/post/running-a-flask-application-as-a-service-with-systemd)  

An example of a Gunicorn config file (service):  
```Bash
[Unit]
# This could be anything that helps you and colleagues know what this
# service is for.
Description=farm gunicorn daemon
# This tells systemd when this application is ready to start
After=network.target

[Service]
Type=notify
DynamicUser=yes
RuntimeDirectory=farm
# Where the command supplied in ExecStart be run
WorkingDirectory=/home/farm/
ExecStart=/usr/local/bin/gunicorn main:app
ExecReload=/bin/kill -s HUP $MAINPID
Restart=on-failure
KillMode=mixed
TimeoutStopSec=5
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```  

You can test Gunicorn after install by executing `gunicorn main:app` where main is the module name (or path) and app is the variable name.  
*Note: this has to be executed in the directory where the main file lives.*  

If all is done correct you can see the website being served in the browser <ip>:8000 or with `curl 127.0.0.1:8000`.  

### Configuring gunicorn  
To configure gunicorn specifically for this droplet follow the next steps after the above.  
After creating the config file for gunicorn `<name>.service` use `sudo systemctl start <name>`.  
You might see a warning to reload daemon with `sudo systemctl daemon-reload`.  
After this type in `sudo systemctl start <name>` once more.  
With `sudo systemctl enable <name>` you enable the service to start-up automatically when system starts.  

\<name>.service template:  
```Bash
[Unit]
Description=<any description>
After=network.target

[Service]
User=thomas
Group=www-data
WorkingDirectory=/home/thomas/flask/portfolio
Environment="PATH=/home/thomas/flask/portfolio/.venv/bin"
ExecStart=/home/thomas/flask/portfolio/.venv/bin/gunicorn wsgi:app

[Install]
WantedBy=multi-user.target
```

You can check if it works with `curl 127.0.0.1:8000`, the service is not sent to the front just yet.  
To stop the service use `sudo systemctl stop <name>`.  

### Configuring nginx  
After installing Nginx create a new file `/etc/nginx/sites-available/<name>.conf`.  
Create a link (publish the changes) `sudo ln -s /etc/nginx/sites-available/<name>.conf /etc/nginx/sites-enabled/`.  
As shown in the comments of the default file, remove the default file of nginx from `/etc/nginx/sites-enabled/`.  
Check the nginx config with `sudo nginx -t` for errors.  
Restart nginx `sudo systemctl restart nginx`.  

###  Configuring the firewall  
Enable with `sudo ufw enable`  
Allow Nginx with `sudo ufw allow "Nginx Full"`  
Check the status with `sudo ufw status` to see firewall rules.  
[DO ufw tutorial](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-22-04)  
*Note: don't forget to allow port 22 for ssh. This isn't auto-setup `sudo ufw allow 22/tcp`*  

### Creating a pipeline with Github actions  
Create a pipeline by using ssh-keys and yml files.  
In the Github repo use secrets to give Github a private key, hostname, password and/or more arguments to use in the yml file.  

Example YAML file for logging in with SSH and executing a script on the VM:
```yml
name: <any>

on: 
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-22.04
    steps:
      - name: <any>
        uses: appleboy/ssh-action@v1.0.0
        with:
          host: ${{ secrets.SSH_HOST }}
          username: ${{ secrets.SSH_USERNAME }}
          key: ${{ secrets.SSH_KEY }}
          script: bash <any>.sh
```  
On the VM make sure the script is set-up correct and the SSH user has rights to execute the file.  
A specific file execution right can be set in `/etc/sudoers.d/90-cloud-init-users`.  
With a line such as: `<user> ALL=NOPASSWD: /bin/systemctl <action> <service>`.  
*Note: please keep in mind that this can have security implications*  


## Configuring the DNS  
Buy a domain at "Google Domains" for example.  
Follow the steps in this [tutorial](https://docs.digitalocean.com/tutorials/dns-registrars/).  
*Note: don't forget to make the adjusted nameservers active*  
Add the domain name to Digital Ocean's **networking** tab. [video1](https://www.youtube.com/watch?v=x7535H895o4) [video2](https://www.youtube.com/watch?v=d8TRPMI8lVk)  
Enter the domain name and select the project folder. In the next window fill in "@" for the host and select the droplet(IP) and click "Create Record".  

In your VM make sure the `server_name` of the Nginx config file is named the same as your domain.  
Get a SSL certificate with "[certbot](https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal&tab=standard)" for example.  
Follow the instructions on the site and in the video. [Tutorial](https://www.youtube.com/watch?v=ghZXFyIyK1o)  
