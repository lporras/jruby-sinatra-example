# Sinatra Hello World with JRuby on Jetty

A proof of concept demonstrating a Sinatra application running on Jetty using JRuby and Warbler.

## Prerequisites

- JRuby 9.4.8.0 (or compatible version)
- Java 21
- Docker and Docker Compose (optional)

## Project Structure

- `app.rb` - Sinatra application with two routes
- `config.ru` - Rack configuration file
- `Gemfile` - Ruby dependencies
- `config/warble.rb` - Warbler configuration for WAR generation
- `Dockerfile` - Multi-stage Docker build
- `docker-compose.yml` - Docker Compose configuration

## Running Locally with JRuby

### Option 1: Build and Deploy WAR File

1. Install dependencies:
```bash
jruby -S gem install bundler
jruby -S bundle install
```

2. Build the WAR file:
```bash
jruby -S warble
```

3. Deploy the generated `sinatra-hello-world.war` to any Jetty server, or use Jetty Runner:
```bash
# Download Jetty Runner if you don't have it
curl -o jetty-runner.jar https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-runner/11.0.15/jetty-runner-11.0.15.jar

# Run the WAR file
java -jar jetty-runner.jar sinatra-hello-world.war
```

Access the application at http://localhost:8080

## Running with Docker

### Using Docker Compose (Recommended)

```bash
docker-compose up --build
```

Access the application at http://localhost:8080

### Using Docker directly

```bash
# Build the image
docker build -t sinatra-jruby-jetty .

# Run the container
docker run -p 8080:8080 sinatra-jruby-jetty
```

## Available Endpoints

- `GET /` - Returns "Hello World from Sinatra running on JRuby with Jetty!"
- `GET /time` - Returns the current server time

## How It Works

1. **Warbler** packages the Sinatra application into a WAR (Web Application Archive) file
2. The WAR file includes JRuby runtime and all gem dependencies
3. **Jetty** (Java web server) deploys and runs the WAR file natively
4. The Docker build uses a multi-stage approach:
   - Stage 1: Uses JRuby to build the WAR file
   - Stage 2: Uses official Jetty image to deploy the WAR

## Environment Versions

- JRuby: 9.4.8.0
- Java: 21
- Jetty: 11 (in Docker)
- Ruby compatibility: 3.1.4
