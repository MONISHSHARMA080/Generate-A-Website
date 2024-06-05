#!/bin/sh

# cd dj
ls -la
ls
pwd
pip3 --version
pip3 install -r requirements.txt --no-cache-dir
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
