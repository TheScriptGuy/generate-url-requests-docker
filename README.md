# Build and Configure Docker Image :whale:

Welcome to the `generate-url-requests` Docker image building guide. This documentation will help you get started with building and configuring your Docker image with ease and precision. :sparkles:

## Building the Docker Image :hammer_and_wrench:

To build the Docker image, execute the `build-image.sh` script. Before running the script, you can tweak a few variables to customize your Docker image.

### Customizing Image Tag Variables :label:

- **`$REPOSITORY`**: Set this variable if you have a Docker repository where you want to push the image. Leave it blank if you don’t have one.
- **`$IMAGE_TAG_NAME`**: The name of your image. Default is `generate-url-requests`.
- **`$IMAGE_TAG_VERSION`**: The version of your image. Default is `1.0`.

Example:

```bash
REPOSITORY=""
IMAGE_TAG_NAME="generate-url-requests"
IMAGE_TAG_VERSION="1.0"
```

It's important to note that the `$IMAGE_TAG` is derived from `$REPOSITORY/$IMAGE_TAG_NAME:$IMAGE_TAG_VERSION`

### Certificates :closed_lock_with_key:

For a successful build, Root CA certificates need to be installed into the `certs` directory. Make sure that the necessary `*.crt` files are present in this directory.

## Dockerfile Configuration :page_with_curl:

The Dockerfile comes with several pre-configured settings that you can modify according to your requirements.

### Environment Variables :gear:

- **`$NUM_CONNECTIONS`**: Set the number of connections. Default is `10000`.
- **`$NUM_WORKERS`**: Set the number of workers. Default is `100`.

To override these values at runtime, use the Docker run command with the `-e` option.

Example:

```bash
docker run -e NUM_CONNECTIONS=5000 -e NUM_WORKERS=50 <image-name>
```

## Image Build Execution :rocket:

Navigate to the directory containing the Dockerfile and `build-image.sh` script and execute the script.

```bash
chmod +x build-image.sh
./build-image.sh
```

Upon successful execution, the Docker image will be built with the specified configurations.


## Troubleshooting :warning:

- Ensure the `certs` directory exists and contains the necessary `*.crt` files.
- Make sure the Dockerfile exists in the directory where you are running the `build-image.sh` script.

Embrace the power of Docker and happy coding! :tada:

## Warnings :warning:
- Make sure that you are using some security device to filter traffic.
- Your ISP might think you're infected based off the requests that are coming from home/corporate network.

## Docker Container Run :rocket: :whale:
To create a sample docker container based off the image:
Take note the `$IMAGE_TAG` that's defined above.


```bash
docker run --rm <image-name>
```
