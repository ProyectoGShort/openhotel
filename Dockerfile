FROM denoland/deno:ubuntu

RUN apt update && apt install -y \
    curl \
    unzip \
    gettext \
    libglib2.0-0 \
    libnss3 \
    libdbus-1-3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2

RUN useradd -m openhotel
USER openhotel
WORKDIR /home/openhotel

COPY --chown=openhotel:openhotel init.sh .
COPY --chown=openhotel:openhotel config.yml .
RUN chmod +x init.sh

EXPOSE 1994
CMD ["./init.sh"] 