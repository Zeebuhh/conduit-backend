#!/bin/sh

# Apply database migrations
python manage.py makemigrations
python manage.py migrate

# Create a superuser if not exists
if [ -n "$DJANGO_SUPERUSER_USERNAME" ] && [ -n "$DJANGO_SUPERUSER_PASSWORD" ]; then
    EMAIL=${DJANGO_SUPERUSER_EMAIL:-"admin@example.com"}
    python manage.py createsuperuser --no-input --username "$DJANGO_SUPERUSER_USERNAME" --email "$EMAIL"
fi
exec "$@"