FROM maven:3.8.1-jdk-11 as maven
COPY ./pom.xml ./pom.xml
RUN mvn dependency:go-offline -B
COPY ./src ./src

# build step
RUN mvn package -DskipTests

FROM openjdk:11-jre-slim
WORKDIR /app

# Copy the built artifact to current working dir
COPY --from=maven target/sbtrip-1.0.jar ./

# Run the binary
CMD ["java", "-jar", "./sbtrip-1.0.jar"]
