#!/bin/bash

# Простой скрипт для обновления сайта
SERVER_IP="5.35.125.78"
SERVER_USER="root"
SITE_DIR="/opt/projects/arhi-lady.ru"

echo "🚀 Обновление сайта на сервере $SERVER_IP..."

# Копируем файлы
echo "📤 Копирование файлов..."
scp -r ./* $SERVER_USER@$SERVER_IP:$SITE_DIR/

# Настраиваем права доступа
echo "🔐 Настройка прав доступа..."
ssh $SERVER_USER@$SERVER_IP "
    chown -R www-data:www-data $SITE_DIR
    chmod -R 755 $SITE_DIR
    find $SITE_DIR -type f -exec chmod 644 {} \;
"

echo "✅ Сайт обновлен!"
echo "🌐 Доступен по адресу: http://$SERVER_IP"
echo "📝 Для получения SSL сертификата настройте DNS записи домена на IP: $SERVER_IP" 