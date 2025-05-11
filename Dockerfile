# Use an official OpenJDK 21 runtime as the base image
FROM openjdk:21-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the pre-built JAR file from the target directory to the container
# Ensure the JAR file path matches your build directory (target/your-app.jar)
COPY target/makemytrip-0.0.1-SNAPSHOT.jar /app/makemytrip-0.0.1-SNAPSHOT.jar

# Expose the port that the application will run on
EXPOSE 9090

# Command to run the application (Java -jar command to start the Spring Boot application)
ENTRYPOINT ["java", "-jar", "/app/makemytrip-0.0.1-SNAPSHOT.jar"]

