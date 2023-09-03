# flutter-build

Build flutter web apps with Docker.

## Getting Started

### Using this as base for your own Dockerfile

```Dockerfile
FROM ghcr.io/vergissberlin/flutter-build:main as builder

# Copy your code to the container
COPY . /app

# Build the web app
RUN flutter build web --release

# Start a new stage with nginx
FROM nginx:alpine-slim as webserver

# Copy the build from the builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html
```

### Use it directly

```bash
docker run --rm -v $(pwd):/app -w /app ghcr.io/vergissberlin/flutter-build:main flutter build web --release
```

### Use it within a gitlab-ci pipeline

```yaml
stages:
  - build
  
build:
    stage: build
    image: ghcr.io/vergissberlin/flutter-build:main
    script:
        - flutter build web --release
    artifacts:
        paths:
        - build/web
```    