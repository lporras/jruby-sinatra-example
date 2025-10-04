FROM openjdk:21-slim as builder

# Install JRuby
ENV JRUBY_VERSION=9.4.8.0
RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://repo1.maven.org/maven2/org/jruby/jruby-dist/${JRUBY_VERSION}/jruby-dist-${JRUBY_VERSION}-bin.tar.gz | tar xz -C /opt && \
    ln -s /opt/jruby-${JRUBY_VERSION} /opt/jruby

ENV PATH="/opt/jruby/bin:${PATH}"

WORKDIR /build

# Copy application files
COPY Gemfile app.rb config.ru ./
COPY config/ ./config/

# Install dependencies and build WAR
RUN jruby -S gem install bundler && \
    jruby -S bundle install && \
    jruby -S warble

# Runtime stage with Jetty
FROM jetty:11-jre21-alpine

# Copy WAR file from builder
COPY --from=builder /build/*.war /var/lib/jetty/webapps/ROOT.war

EXPOSE 8080
