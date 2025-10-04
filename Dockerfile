FROM openjdk:8-slim

# Install JRuby
ENV JRUBY_VERSION=9.3.13.0
RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://repo1.maven.org/maven2/org/jruby/jruby-dist/${JRUBY_VERSION}/jruby-dist-${JRUBY_VERSION}-bin.tar.gz | tar xz -C /opt && \
    ln -s /opt/jruby-${JRUBY_VERSION} /opt/jruby && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/jruby/bin:${PATH}"

WORKDIR /app

# Copy application files
COPY Gemfile* ./
RUN jruby -S gem install bundler && \
    jruby -S bundle install

COPY . .

EXPOSE 3000

CMD ["jruby", "-S", "trinidad", "--config", "trinidad.yml"]
