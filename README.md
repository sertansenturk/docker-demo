# docker_demo

Docker is a lightweight service, which use OS-level virtualization to deliver software in packages called containers. It allows consistency and convenience on running software with reliable behaviour.

## Installing docker

To run Docker, you need to setup the Docker engine. Please refer to the [documentation](https://docs.docker.com/install/) to how to install the free, community version.

## Running docker images from Docker hub

One of the biggest advantages of Docker is the size of the community and the amount offically supported images. 

For example, **Python Software Foundation** maintains their own official images. If you would like to run an interactive Python 3.7 shell, all you have to do is running the command below in your terminal:

```bash
docker run -it python:3.7
```

Above `-it` means **interactive**.

Likewise, you can run one of the official images of Jupyter notebooks. 

```bash
docker run -p 8888:8888 -it -v "$PWD":/home/jovyan/work -e JUPYTER_ENABLE_LAB=yes jupyter/scipy-notebook:1386e2046833
```

Above we run the `scipy-notebook` with the tag "1386e2046833" (latest as of 17 September 2019). This image comes with most of the Python scientific computing libraries (e.g. _numpy, scipy, pandas_) pre-installed. We open the `8888` ports open for communication and we mount the current working directory into the folder `/home/jovyan/work` (**Note:** [jovyan](https://github.com/jupyter/docker-stacks/issues/358) is the default username in Jupyter stacks) so that our work would not be lost after we stop the container. We also enable `Jupyterlab`, by assigning the `JUPYTER_ENABLE_LAB` environment variable. 

Then, all you need to do is to go to `http://127.0.0.1:8888/` with the token given in the terminal. 

Please refer to the [Jupyter Docker stacks documentation](https://jupyter-docker-stacks.readthedocs.io/en/latest/) for detailed usage and other official images.

## Extending Docker images

Docker images are very easy to build on top. You should simply create a file named `Dockerfile`. 

```docker
FROM <user>/<docker-image>:<tag>

# docker commands are written below
```

In this repo, we have created a simple `Dockerfile`, which extends the **Jupyter scipy stack** with [Essentia](https://essentia.upf.edu/documentation/) and [Jupyter extensions](https://github.com/ipython-contrib/jupyter_contrib_nbextensions).

We can build the image by running the command:

```bash
docker build . -t sertansenturk/docker-demo:latest -t sertansenturk/docker-demo:0.1
```

Above we name the image as `sertansenturk/docker-demo` and tag it both as `0.1` and `latest`. To make sure that the image is created properly, we can run `docker images`. You should see something similar:

```
REPOSITORY                       TAG                 IMAGE ID            CREATED             SIZE
sertansenturk/docker-demo        0.1                 69e780b1d4a9        14 seconds ago      3.48GB
sertansenturk/docker-demo        latest              69e780b1d4a9        14 seconds ago      3.48GB
python                           3.7                 02d2bb146b3b        4 days ago          918MB
jupyter/scipy-notebook           1386e2046833        9595623cae9f        5 days ago          3.46GB
```

Notice that the previously run images are still stored. In addition, the `docker-demo` image is shown twice with the tags we attached. To run the image, use the command below:

```bash
docker run -it -v `pwd`:/home/jovyan/ -p 8888:8888 sertansenturk/docker-demo
```

## docker-compose

TODO

## Further reading

- [Get Started with Docker](https://www.docker.com/get-started)
- Best practices for [writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/) and [Docker development](https://docs.docker.com/develop/dev-best-practices/)
