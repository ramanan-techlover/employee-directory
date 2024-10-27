# Use the official Python image as a base
FROM python:3.10-slim

# Set environment variables to avoid Python buffering and to define working directory
ENV PYTHONUNBUFFERED=1
ENV APP_HOME=/app

# Create and set the working directory
WORKDIR $APP_HOME

# Copy the current directory contents into the container at /app
COPY . $APP_HOME

# Install dependencies
RUN pip install --upgrade pip && \
    pip install django gunicorn && \
    pip install -r requirements.txt

# Expose port 8000 for Django
EXPOSE 8000

# Run migrations and start the Django application with Gunicorn
CMD ["sh", "-c", "python manage.py migrate && gunicorn office_emp_mgmt_proj.wsgi:application --bind 0.0.0.0:8000"]
