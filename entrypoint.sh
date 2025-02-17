#!/bin/sh

# Apply database migrations
python manage.py makemigrations
python manage.py migrate

# Create a superuser if not exists
if [ -n "$DJANGO_SUPERUSER_USERNAME" ] && [ -n "$DJANGO_SUPERUSER_PASSWORD" ]; then
    python manage.py createsuperuser --no-input
fi
exec "$@"