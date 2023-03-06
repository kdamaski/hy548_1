## Assignment_1 csd3755 HY548

##### 1) Nginx is one of the most popular web servers. Container images are readily available on Docker Hub. Write down the commands needed to:

###### a) Download the images tagged 1.23.3 and 1.23.3-alpine locally.

* docker pull nginx:1.23.3
* docker pull nginx:1.23.3-alpine

###### b) Compare the sizes of the two images.

* docker images. Lists the downloaded images and shows the size as well.
  nginx:1.23.3 &rarr; 142 MB
  nginx:1.23.3-alpine &rarr; 23.4 MB

###### c) Start one of the two images in the background, with the appropriate network settings to forward port 80 locally and use a browser (or curl or wget) to see that calls are answered. What is the answer?

`docker run --rm -d -p 8080:80 nginx:1.21.6-alpine`

`curl 127.0.0.1:8080`

result:

```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

###### d) Confirm that the container is running in Docker.

`docker ps
CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS          PORTS                                   NAMES
bcf814c86116   nginx:1.21.6-alpine   "/docker-entrypoint.…"   32 seconds ago   Up 31 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   practical_hellman`

(Πιστεύω είναι μια απόδειξη)

###### e) Get the logs of the running container.

```bash
docker logs practical_hellman 
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2023/03/04 13:39:06 [notice] 1#1: using the "epoll" event method
2023/03/04 13:39:06 [notice] 1#1: nginx/1.21.6
2023/03/04 13:39:06 [notice] 1#1: built by gcc 10.3.1 20211027 (Alpine 10.3.1_git20211027) 
2023/03/04 13:39:06 [notice] 1#1: OS: Linux 6.2.2-zen1-1-zen
2023/03/04 13:39:06 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1073741816:1073741816
2023/03/04 13:39:06 [notice] 1#1: start worker processes
2023/03/04 13:39:06 [notice] 1#1: start worker process 32
2023/03/04 13:39:06 [notice] 1#1: start worker process 33
2023/03/04 13:39:06 [notice] 1#1: start worker process 34
2023/03/04 13:39:06 [notice] 1#1: start worker process 35
2023/03/04 13:39:06 [notice] 1#1: start worker process 36
2023/03/04 13:39:06 [notice] 1#1: start worker process 37
2023/03/04 13:39:06 [notice] 1#1: start worker process 38
2023/03/04 13:39:06 [notice] 1#1: start worker process 39
```

###### f) Stop the running container.

Με την εντολή: `docker stop strange_curran`

Προϋποθέτει να μην έχει ξεκινήσει το container με flag –rm

###### g) Start the stopped container.

`docker start strange_curran`

###### h) Stop the container and remove it from Docker

`docker stop strange_curran` (ή `docker kill strange_curran`)

`docker rm strange_curran`

##### 2) Following the previous exercise, start an Nginx container again and issue the commands needed to:

###### a) Open a shell session inside the running container and change the first sentence of the default page to "Welcome to MY nginx!". Close the session.

* open session command: `docker exec -it zealous_hawking sh`
* Edit index.html with: `vi /usr/share/nginx/html/index.html` and add "MY" to the title.

###### b) From your computer's terminal (outside the container) download the default page locally and upload another one in its place.

* download: `wget localhost:8080` ή `docker cp zealous_hawking:/usr/share/nginx/html/index.html . `
* Αφού άλλαξα το index.html που κατέβασα, το έκανα upload με την εντολή : `docker cp index.html zealous_hawking://usr/share/nginx/html/` .

###### c ) Close the container, delete it and start another instance. Do you see the changes? Why;

No changes because i didn't save the image. The image stored in my computer is the one i downloaded from the original repo.

##### 3) The code that produces the course's website is available on GitHub (https://github.com/chazapis/hy548). Write down the commands needed to download the repository (and submodules) and hugo (the tool that builds the website), build the website locally, and start an Nginx container to serve the CS-548 website instead of the default page.

Τοπικά έχω εγκατεστημένο το git και το make οπότε θα γράψω τις εντολές που χρειάστηκαν μόνο:

* sudo pacman -S --noconfirm hugo
* git clone https://github.com/chazapis/hy548
* cd hy548; git submodule init; git submodule update;
* make all
* docker cp html/public/index.html pedantic_pike:/usr/share/nginx/html (όπου pedantic_pike το όνομα του container)

##### 4) Following the previous exercise, create your own container image, based on Nginx, that will contain the CS-548 website instead of the default page. Downloading the CS-548 repository (and submodules), hugo and building the site should be done in the Dockerfile. Create a Docker Hub account and upload the image. Provide:

##### a) The Dockerfile.

​	Provided.

##### b) The command needed to upload the image to Docker Hub.

​	(image name= kdamaski/nginx-alpine-hy548:latest where kdamaski is my dockerhub username)

​	docker push kdamaski/nginx-alpine-hy548:latest

##### Explain:

##### c) How much bigger is your own image than the image you were based on. Why;

Initial size : 23.4 MB

Final size :   111 MB

Το τελικό μέγεθος είναι μεγαλύτερο επειδή στο container έχω κατεβάσει το git project, έχω εγκαταστήσει εργαλεία όπως git, hugo, μαζί με τα dependencies τους που κατεβαίνουν αυτόματα (με το hugo -D παράχθηκαν ακόμα μερικά αρχεία που γενικά δεν έσβησα τίποτα στο παράδειγμα αυτό). Κυρίως όμως με το apk update που ήταν αναγκαίο για να μπορώ να εγκαταστήσω εργαλεία μεσα στο container ανέβηκε το μέγεθος κατα πολύ.

##### d) What have you done in the Dockerfile to keep the image as small as possible?

Use a container as builder and then copy only the files i need into the new image.

Final size with builder container: 23.4 MB



##### 5) Upload the Dockerfile from the previous exercise to your GitHub repository. Create a GitHub Action that will automatically build and push the image to your Docker Hub account (the workflow should be initiated by the user). Provide the YAML of the workflow you made.

