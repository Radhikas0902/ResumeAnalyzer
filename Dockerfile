# Use official Tomcat 10.1 with JDK 17
FROM tomcat:10.1-jdk17

# Clean the default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR file as ROOT.war
COPY target/ResumeAnalyze.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
