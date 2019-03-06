#!/usr/bin/env bash
export FLASK_APP=app.py

if [ "$FLASK_ENV" = 'production' ] 
then
	gunicorn -b 0.0.0.0:8000 app:app 
else
	export FLASK_ENV=development
	python -m flask run --host=0.0.0.0 -p 8000
fi

