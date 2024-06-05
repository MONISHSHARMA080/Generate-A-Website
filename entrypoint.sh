#!/bin/sh

# Start the Go server
./go_server &

# Start the Django server
cd django
python3 manage.py runserver 0.0.0.0:8000 &

# Start the Svelte app (dev mode)
cd ..
npm run dev &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?