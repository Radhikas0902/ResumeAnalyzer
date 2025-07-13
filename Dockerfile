FROM tomcat:10.1-jdk17

# Remove default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR as ROOT.war
COPY target/ResumeAnalyze.war /usr/local/tomcat/webapps/ROOT.war

# Change Tomcat port from 8080 to 10000 for Render
RUN sed -i 's/port="8080"/port="10000"/' /usr/local/tomcat/conf/server.xml

# Expose the correct port
EXPOSE 10000

# Start Tomcat
CMD ["catalina.sh", "run"]
