FROM eclipse-temurin:21-jre-alpine
WORKDIR /server
RUN apk add --no-cache curl jq

# Descargar Velocity
RUN curl -fL -o velocity.jar https://papermc.io

RUN mkdir -p plugins

# Descargar EaglerXServer y ViaVersion
RUN curl -fL -o plugins/EaglerXServer.jar https://github.com
RUN curl -fL -o plugins/ViaVersion.jar https://papermc.io

# Copiar configuracion y generar clave automaticamente
COPY velocity.toml /server/velocity.toml
RUN echo "miclave12345" > /server/forwarding.secret

EXPOSE 8080
CMD ["java", "-Xms256M", "-Xmx450M", "-jar", "velocity.jar"]
