# =============================================
# Etapa 1: Construcción (El Taller del Rider)
# =============================================
FROM eclipse-temurin:21-jdk-jammy as builder
WORKDIR /app

# 1. Copia solo los archivos de dependencias para aprovechar el caché de Docker
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# 2. Descarga todas las dependencias en una capa separada
# Si solo cambias el código, Docker reutilizará esta capa y el build será casi instantáneo.
RUN ./mvnw dependency:go-offline

# 3. Copia el resto del código fuente de tu aplicación
COPY src ./src

# 4. Empaqueta la aplicación (sin descargar dependencias de nuevo)
RUN ./mvnw package -DskipTests


# =============================================
# Etapa 2: Ejecución (La Armadura Final)
# =============================================
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

# Crea un usuario específico para la aplicación por seguridad
RUN useradd -m -d /app -s /bin/bash appuser
USER appuser

# Copia solo el .jar construido desde la etapa anterior
COPY --from=builder /app/target/*.jar app.jar

# Spring Boot reconoce SERVER_PORT automáticamente. Es más estándar que -Dserver.port.
ENV SERVER_PORT=8080

# EXPOSE documenta que el contenedor escucha en este puerto
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]