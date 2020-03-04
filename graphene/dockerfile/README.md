../deploy.sh

Build image:

docker build -f Dockerfile.baseubuntu1804 -t <CONTAINER_NAME> .

Run it:

docker run --device /dev/isgx --device /dev/gsgx -v /var/run/aesmd:/var/run/aesmd -it --rm  <CONTAINER_NAME>

