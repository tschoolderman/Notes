# Dockercommands  
[Tutorial Docker/Kubernetes](https://dockerdoc.carpago.nl/)


&nbsp;
## Contents 
- [Dockercommands](#dockercommands)
  - [Contents](#contents)
- [Creating an image](#creating-an-image)
  - [Build an image](#build-an-image)
  - [Build a container](#build-a-container)
- [Kubernetes training](#kubernetes-training)
  - [Network objects](#network-objects)
    - [Services](#services)
  - [Services praktijk](#services-praktijk)
    - [Ingress](#ingress)

# Creating an image  
Find your image on the Dockerhub and create an image of your program with it.  
Example:  

```Dockerfile
FROM tiangolo/uwsgi-nginx:python3.11

COPY ./requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

COPY . /app
```  

**FROM** defines the used Dockerhub image  
**COPY** specifies where you want to copy from and to  
**RUN** defines a specific command  

## Build an image  
`docker build -t portfolio .`
This command tells Docker to build an image named (-t) "portfolio" from the current folder of your terminal.  

## Build a container  
`docker run -d -it --name portfolio_flask -p 888:80 portfiolo`  
This command tells Docker to create a container detached (-d) so your console is not occupied by the container.  
It runs interactive (-it) with a self specified name (--name) "portfolio_flask".  
Container port is set to "888" and the outside port is set to "80", you can reach the container through port 80.  


# Kubernetes training  

## Network objects  

### Services  

Daar zijn er vier van. We behandelen er twee.  

ClusterIP ::= Dat ik mijn pods in het cluster beschikbaar stel via een IP / DNS name.  
NodePort ::= Dat is dat ik een ClusterIP ben + een open poort naar buiten op ALLE nodes in het cluster waarop ik van buiten direct naar binnen kan  
        Dat poortnummer is 30000 tot 32767  (2^15-1)  

LoadBalancer ::= Dat is een NodePort (dus ook een ClusterIP) die ervoor zorgt dat de commerciele provider zoals Azure jou een IP-address geeft 
waarop je rechtstreeks het cluster kunt binnenkomen. Dat is overigens wel een betaalde Service.  

--
ExternalName ::= Dat je een buiten-de-deur-van-je-bedrijf-zelfs een DNS name IN je cluster kunt registeren.  
Bijvoorbeeld: ik heb nu cars-test.deadcafe.mysqldatabase.azure.com en die wil ik intern in het cluster kunnnen benaderen zonder die naam te gebruiken, want  
- dan hoef ik niet die naam te veranderen als hij verandert in al mijn client  
- dan kan ik mijn eigen interne naam aanhouden zoals: cars.db.website.nl  

## Services praktijk  

1. Je hebt al een draaiende deployment en wil die exposen.  
`kubectl expose deployment mynginx --target-port=80 --port=8080 --dry-run=client -o yaml`  

2. Je maakt een service van het type clusterip aan (onverlet of die deplooyment er al is)  
`kubectl create service clusterip mynginx --tcp=8080:80 --dry-run=client -o yaml`  

En da je via kubectl describe service mynginx ziet dat hij 3 endpoints heeft  
Ook is het altijd een idee om soms te kijken of die service uberhaupt endpoints heeft.  

path to hosts file voor IP adressen C:\Windows\System32\drivers\etc  

### Ingress  

Ingress ::= Het via een hostname  beschikbaar stellen van een service in het cluster. Een cluster ip service is voldoende.  
Een Ingress bestaat uit twee onderdelen  
- Ingress - Resource ::= de mapping van de hostname naar de service.  
- ingress - Controller ::= Een in het cluster aanwezig zijnde NGINX-controller die de Ingress - Resource(s) beschikbaar stelt.  

Stap 1:  
Enable the minikube ingress add on via => minikube addons enable ingress  

Stap 2:  
Maak een Ingress resource in je controller via: voorbeeld:  
`kubectl create ingress ingress-mynginx --rule="mynginx.web.local/*=mynginx:8080" --dry-run=client -o yaml | grep -Ev "{}|null|status" > ingress-mynginx.yaml`  

`kubectl apply -f ./ingress-mynginx.yaml`  
