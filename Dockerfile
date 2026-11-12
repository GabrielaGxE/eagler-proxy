FROM eclipse-temurin:21-jre-alpine
WORKDIR /server
RUN apk add --no-cache curl jq

# Descargar Velocity
RUN curl -L -o velocity.jar https://papermc.io

RUN mkdir -p plugins

# Descargar EaglerXServer y ViaVersion
RUN curl -L -o plugins/EaglerXServer.jar https://github.com
RUN curl -L -o plugins/ViaVersion.jar https://papermc.io

COPY velocity.toml /server/velocity.toml
COPY forwarding.secret /server/forwarding.secret

EXPOSE 8080
CMD ["java", "-Xms256M", "-Xmx450M", "-jar", "velocity.jar"]
