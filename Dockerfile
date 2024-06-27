# Start with a base image containing Maven and JDK for building
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app

# Copy the source code
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Start with a new image containing only the JRE
FROM openjdk:17-alpine

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/WP-LABS2-0.0.1-SNAPSHOT.jar ./WP-LABS2.jar

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "./WP-LABS2.jar"]
