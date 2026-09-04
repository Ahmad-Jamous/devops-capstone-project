FROM python:3.9-slim

# Working Dir and installing dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the service package
COPY service/ ./service/

#Switch user to non-root user / create + change ownership + switch
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

#Running the service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]