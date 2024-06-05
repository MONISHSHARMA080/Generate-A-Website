#!/bin/sh

# Start the Go server
./go_server &

# Start the Svelte app (dev mode)
npm run dev &

# Start the Django server
cd django
ls
pwd
python3 manage.py runserver 0.0.0.0:8000 &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
