FROM node:14

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y \
    libpango1.0-dev

RUN npm ci --production

# 跳过 LFS 相关的步骤
# RUN curl -sLO https://github.com/github/git-lfs/releases/download/v2.0.1/git-lfs-linux-amd64-2.0.1.tar.gz
# RUN tar xf git-lfs-linux-amd64-2.0.1.tar.gz && mv git-lfs-2.0.1/git-lfs /usr/bin/ && rm -rf git-lfs-2.0.1 git-lfs-linux-amd64-2.0.1.tar.gz
# RUN git lfs install && git lfs fetch && git lfs pull

# 如果 npx gulp sprites 命令不依赖 LFS 对象,你可以保留这一行
RUN npx gulp sprites

RUN npm i -g pm2

CMD ["pm2-runtime", "start", "ecosystem.config.js"]