FROM python:3.8-bullseye

ENV APP_DIR=/usr/src/snappass

RUN groupadd -r snappass && \
    useradd -r -g snappass snappass && \
    mkdir -p $APP_DIR

WORKDIR $APP_DIR

COPY ["setup.py", "requirements.txt", "MANIFEST.in", "README.rst", "AUTHORS.rst", "$APP_DIR/"]
COPY ["./snappass", "$APP_DIR/snappass"]

COPY ["postie/static", "$APP_DIR/snappass/static/postie"]
COPY ["postie/base.html", "$APP_DIR/snappass/templates"]

RUN python setup.py install && \
    chown -R snappass $APP_DIR && \
    chgrp -R snappass $APP_DIR
RUN pip install -r requirements.txt

USER snappass

# Default Flask port
EXPOSE 5000

CMD ["snappass"]
