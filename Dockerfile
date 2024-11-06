FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src /app/src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/target/GithubActions-0.0.1-SNAPSHOT.jar GithubActions.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "GithubActions.jar"]





