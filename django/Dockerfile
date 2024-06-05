FROM python:3.10  as python-build
WORKDIR /app
COPY . ./app/d/.
# RUN rm db.sqlite3

# COPY ./dj ./dj
# RUN cd dj
RUN pip3 install -r requirements.txt --no-cache-dir
# COPY . .
# ENTRYPOINT ["python3"] 
EXPOSE 8002
RUN chmod +x a.sh
# ENTRYPOINT ["python3"]
CMD ["/app/a.sh"]