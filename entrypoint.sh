#!/bin/sh

# Start the Go server
./go_server &

# Start the Svelte app (dev mode)
npm run dev &

# Start the Django server
cd django
ls -la
pwd
python --version
python manage.py makemigrations
python manage.py migrate
# Python 3.12 --version
# python3 -m venv /opt/venv
# ENV PATH="/opt/venv/bin:$PATH"
python manage.py runserver  &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
