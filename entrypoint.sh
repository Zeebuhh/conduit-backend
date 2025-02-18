#!/bin/sh
set -e

# Apply database migrations
python manage.py makemigrations
python manage.py migrate

# Create a superuser if not exists
if [ -n "$DJANGO_SUPERUSER_USERNAME" ] && [ -n "$DJANGO_SUPERUSER_PASSWORD" ]; then
    EMAIL=${DJANGO_SUPERUSER_EMAIL:-"admin@example.com"}
    python manage.py shell -c "from django.contrib.auth import get_user_model; \
User = get_user_model(); \
if not User.objects.filter(username='$DJANGO_SUPERUSER_USERNAME').exists(): \
    User.objects.create_superuser('$DJANGO_SUPERUSER_USERNAME', '$EMAIL', '$DJANGO_SUPERUSER_PASSWORD')"
fi

exec "$@"
