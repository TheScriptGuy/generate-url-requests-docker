# Use Alpine Linux as the base image
FROM alpine:latest

# Set maintainer label
LABEL maintainer="TheScriptGuy"

# Set environment variables to non-interactive (this prevents some prompts)
ENV PYTHONUNBUFFERED=1

# Set Environment variables for python script.
ENV NUM_CONNECTIONS=10000
ENV NUM_WORKERS=100

# Install Python3 and pip
# Also install other dependencies such as gcc and musl-dev to ensure certain Python packages like 'requests' can be installed
RUN apk update && apk --no-cache add git python3 py3-pip tzdata ca-certificates && rm -rf /var/cache/apk/*

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN python3 -m pip install requests --use-pep517

# Set the timezone
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set work directory
WORKDIR /app

RUN git clone https://github.com/TheScriptGuy/generate-url-requests /app


# Copy the certificates required for TLS decryption to a temporary directory
COPY certs/ /tmp/certs/

# Append the custom certificates to the certifi cacert.pem
RUN cat /tmp/certs/* >> $(python3 -c "import certifi; print(certifi.where())")

# Remove the temporary directory as it is no longer needed
RUN rm -r /tmp/certs/

# Command to run the script
# You can override these values at runtime using the docker run command with the -e option
CMD ["sh", "-c", "python3 generate-requests.py $NUM_CONNECTIONS $NUM_WORKERS"]
