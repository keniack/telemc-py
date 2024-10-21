# Use a base image with Python installed
FROM python:3.12-slim

# Set environment variables for Redis host and port
ENV REDIS_HOST=localhost
ENV REDIS_PORT=6379

# Set environment variables for the virtual environment and the app module
ENV VENV_DIR=/opt/venv
ENV MODULE_DIR=telemc
ENV VENV_ACTIVATE=". ${VENV_DIR}/bin/activate"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment directory
RUN python3 -m venv ${VENV_DIR}

# Ensure that the virtual environment is used
ENV PATH="${VENV_DIR}/bin:$PATH"

# Set the working directory inside the container
WORKDIR /app

# Copy project files into the container
COPY . /app

# Install dependencies inside the virtual environment and setup telemc
RUN pip install --upgrade pip \
    && pip install -Ur requirements.txt \
    && pip install -Ur requirements-dev.txt \
    && make install

# Use the exec form of ENTRYPOINT to correctly pass arguments
ENTRYPOINT ["sh", "-c", "telemc --redis-host $REDIS_HOST --redis-port $REDIS_PORT \"$@\"", "--"]

# CMD serves as a default argument but can be overridden
CMD ["--help"]
