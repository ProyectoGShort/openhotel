FROM denoland/deno:alpine-2.2.4

RUN apk add --no-cache curl unzip bash gettext
RUN addgroup openhotel && adduser -D openhotel -G openhotel

USER openhotel
WORKDIR /home/openhotel

COPY --chown=openhotel:openhotel init.sh .
COPY --chown=openhotel:openhotel config.yml .
RUN chmod +x init.sh

EXPOSE 1994
CMD ["./init.sh"] 