FROM python:3.7.5
RUN apt-get update -y
RUN apt-get install -y libspatialindex-dev
WORKDIR /app
COPY requirements.txt .

RUN pip install -r requirements.txt
COPY . .
EXPOSE 8888
#ENTRYPOINT jupyter lab --ip 0.0.0.0 --port 8888 --no-browser --allow-root --NotebookApp.token=''

RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install nodejs -y

RUN jupyter labextension install @jupyterlab/plotly-extension
ENTRYPOINT jupyter lab --ip 0.0.0.0 --port 8888 --no-browser --allow-root --NotebookApp.token=''

#ENTRYPOINT jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root --NotebookApp.token=''