FROM python:3.8


# 安装必要的工具
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /code 

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --upgrade -r /code/requirements.txt || cat /code/requirements.txt


COPY ./api /code/api

CMD ["uvicorn", "--app-dir=.", "api.main:app", "--host", "0.0.0.0", "--port", "80"]