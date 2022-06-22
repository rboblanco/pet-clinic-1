FROM openjdk:11-jre

EXPOSE 8085

ADD build/libs/pet-clinic-2.6.0.jar /app/pet-clinic-2.6.0.jar

WORKDIR /app

CMD java -jar pet-clinic-2.6.0.jar
