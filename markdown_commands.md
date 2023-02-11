# Markdown commands & helpful tips <!-- omit from toc -->  
---
[Markdown docs](https://www.markdownguide.org/)  
[VSCode Markdown docs](https://code.visualstudio.com/docs/languages/markdown)  
[Daring Fireball Markdown guide](https://daringfireball.net/projects/markdown/)  
<!-- https://github.com/yzhang-gh/vscode-markdown --> # TODO keyboard shortcuts  
A short guide to Markdown commands, tips, tricks and other helpful information.  

&nbsp;
## Contents <!-- omit from toc -->  
---
- [Basic syntax](#basic-syntax)
- [Tricks](#tricks)
  - [- Adding a `Table of contents` (toc):](#--adding-a-table-of-contents-toc)
  - [- Images:](#--images)
  - [- Image with link:](#--image-with-link)
- [Creating tables](#creating-tables)
- [Keyboard shortcuts](#keyboard-shortcuts)
  
&nbsp;
## Basic syntax  
---
| Name               | Markdown Syntax   | HTML Syntax                        | Description                                              |
| ------------------ | ----------------- | ---------------------------------- | -------------------------------------------------------- |
| Header             | \# Heading lv1    | \<h1\>Heading\</h1\>               | Header levels up to 6, e.g. 6\# is lv6                   |
| Paragraph          | Extra space       | \<p\>\</p\>                        | Puts a space inbetween paragraphs                        |
| Line break         | 2 spaces + return | \<br\>                             | Puts a return to the next line                           |
| Italic             | \*text\*          | \<em\>\</em\>                      | Italic text                                              |
| Bold               | \*\*text\*\*      | \<strong\>text\</strong\>          | Bold text                                                |
| Bold and Italic    | \*\*\*text\*\*\*  | \<em\>\<strong\>\</strong\>\</em\> | Bold and italic text                                     |
| Block quote        | \>                |                                    | Can be used for multiblock quotes with paragraphs        |
| Nested block quote | \>\>              |                                    | Nested block in block quote                              |
| Unordered list     | -                 | \<ul\>\<li\>\</ul\>\</li\>         | Unordered list                                           |
| Code               | \`code\`          | \<code\>\</code\>                  | Show code in the `nano` type                             |
| Codeblock          | \`\`\`python      |                                    | First 3 backticks + language, end block with 3 backticks |
| Horizontal rule    | \---              |                                    | Puts a line between paragraphs                           |

[Markdown extended syntax](https://www.markdownguide.org/extended-syntax/#disabling-automatic-url-linking)  

&nbsp;
## Tricks  
---
To put a comment use: `<!-- test comment in these lines -->`.  
&nbsp;

To put extra room between paragraphs use `&nbsp;` or `<br>`.  
You can use `<br>` at the end of a line as well.  
&nbsp;

Add links use `[text to show as link](https://www.actual-link.com)`.  
The text in parantheses will not be show, only the link.  
&nbsp;

You can use color text with HTML tags.  
Example: `<span style="color:blue">some *blue* text</span>`.  
<span style="color:red">**Some *red* text.**</span>  
This does not work on all platforms. Does work in VSCode.  

### - Adding a `Table of contents` (toc):  
Start with a `- [Name of first header](#name-of-first-header)`.  
Table of contents will update automatically in VSCode.  
To omit a header from the toc use: `<!-- omit from toc -->`.  
URL and addresses: `<link.com>` and `<fake@example.com>`.  
&nbsp;

### - Images:  
`![The San Juan Mountains are beautiful!](/assets/images/san-juan-mountains.jpg "San Juan Mountains")`  
`![The San Juan Mountains are beautiful!]` = Unclear, name in markdown?  
`(/assets/images/san-juan-mountains.jpg` = Link to the image.  
`"San Juan Mountains")` = Name of the image on mouse-over and save.  
![The San Juan Mountains are beautiful!](/assets/images/san-juan-mountains.jpg "San Juan Mountains")
&nbsp;

### - Image with link:  
`[![An old rock in the desert](/assets/images/shiprock.jpg "Shiprock, New Mexico by Beau Rogers")](https://www.flickr.com/photos/beaurogers/31833779864/in/photolist-Qv3rFw-34mt9F-a9Cmfy-5Ha3Zi-9msKdv-o3hgjr-hWpUte-4WMsJ1-KUQ8N-deshUb-vssBD-6CQci6-8AFCiD-zsJWT-nNfsgB-dPDwZJ-bn9JGn-5HtSXY-6CUhAL-a4UTXB-ugPum-KUPSo-fBLNm-6CUmpy-4WMsc9-8a7D3T-83KJev-6CQ2bK-nNusHJ-a78rQH-nw3NvT-7aq2qf-8wwBso-3nNceh-ugSKP-4mh4kh-bbeeqH-a7biME-q3PtTf-brFpgb-cg38zw-bXMZc-nJPELD-f58Lmo-bXMYG-bz8AAi-bxNtNT-bXMYi-bXMY6-bXMYv)`  
[![An old rock in the desert](/assets/images/shiprock.jpg "Shiprock, New Mexico by Beau Rogers")](https://www.flickr.com/photos/beaurogers/31833779864/in/photolist-Qv3rFw-34mt9F-a9Cmfy-5Ha3Zi-9msKdv-o3hgjr-hWpUte-4WMsJ1-KUQ8N-deshUb-vssBD-6CQci6-8AFCiD-zsJWT-nNfsgB-dPDwZJ-bn9JGn-5HtSXY-6CUhAL-a4UTXB-ugPum-KUPSo-fBLNm-6CUmpy-4WMsc9-8a7D3T-83KJev-6CQ2bK-nNusHJ-a78rQH-nw3NvT-7aq2qf-8wwBso-3nNceh-ugSKP-4mh4kh-bbeeqH-a7biME-q3PtTf-brFpgb-cg38zw-bXMZc-nJPELD-f58Lmo-bXMYG-bz8AAi-bxNtNT-bXMYi-bXMY6-bXMYv)  
&nbsp;

## Creating tables  
---
To create tables use the syntax as shown below.  
Markdown automatically fills up the tables with whitespace on save.  
```
| column1 | column2 | column3 |
| ------- | :-----: | ------: |
| column1 |  left   | aligned |
| column2 | center  | aligned |
| column3 |  right  | aligned |
```
&nbsp;

## Keyboard shortcuts  
---
| Shortcut             | Effect                                        |
| -------------------- | --------------------------------------------- |
| Ctrl+B               | Bold text                                     |
| Ctrl+I               | Italic text                                   |
| Alt+S (Windows)      | Strikethrough                                 |
| Ctrl+Shift+]         | Heading lvl up                                |
| Ctrl+Shift+[         | Heading lvl down                              |
| Ctrl+M               | Toggle math environment                       |
| Ctrl+Shift+V         | Toggle preview                                |
| Ctrl+space           | Trigger suggestions                           |
| Ctrl+Shift+O         | Jump to header in file                        |
| Ctrl+T               | Search through headers of all MD files in cwd |
| Shift+Alt+RightArrow | Expand selection                              |
| Shift+Alt+LeftArrow  | Shrink selection                              |
| Ctrl+D               | Multiline edit                                |
