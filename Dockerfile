# ---- Dependencies ----
FROM node:16-alpine AS build

WORKDIR /app

# 先复制依赖文件
COPY package.json yarn.lock ./
RUN yarn install

# 然后复制其余的应用代码
COPY . .

# 构建应用
RUN yarn build

# ---- Production ----
FROM nginx:1.24-alpine

# 复制构建产物
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

