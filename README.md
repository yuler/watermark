# watermark

> 显示图片水印

详情请查看: https://yuler.dev/posts/create-watermark-for-web/

## How it works

- Run `ffmpeg -i input.png -vf "curves=psfile=watermark.acv:interp=pchip" -update 1 output.png` to display the watermark.

## Build docker image & Run it locally

```bash
docker build -t watermark .
docker run -d -p 3000:3000 -p 443:443 -v ~/watermark/storage:/rails/storage --name watermark -e RAILS_MASTER_KEY=$(cat config/master.key) watermark
ngrok http 3000
docker exec -it watermark bash
```
