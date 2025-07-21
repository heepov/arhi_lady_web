# Настройка SSL сертификата для arhi-lady.ru

## 📋 Текущий статус

✅ **Сайт развернут и работает** на сервере 5.35.125.78
✅ **Nginx настроен** и запущен
❌ **SSL сертификат не настроен** (нужен домен)

## 🔧 Для получения SSL сертификата нужно:

### 1. Настроить DNS записи

В панели управления доменом arhi-lady.ru измените DNS записи:

```
A    @     5.35.125.78
A    www   5.35.125.78
```

### 2. Подождать распространения DNS

DNS изменения могут занять до 24 часов, но обычно 15-30 минут.

### 3. Проверить DNS

```bash
nslookup arhi-lady.ru
```

Должен показать IP: 5.35.125.78

### 4. Получить SSL сертификат

После настройки DNS выполните:

```bash
ssh root@5.35.125.78 "certbot --nginx -d arhi-lady.ru -d www.arhi-lady.ru --non-interactive --agree-tos --email admin@arhi-lady.ru --redirect"
```

### 5. Настроить автообновление

```bash
ssh root@5.35.125.78 "(crontab -l 2>/dev/null; echo '0 12 * * * /usr/bin/certbot renew --quiet') | crontab -"
```

## 🎯 Результат

После настройки SSL ваш сайт будет доступен по адресу:
- **https://arhi-lady.ru** (с зеленым замком)
- **https://www.arhi-lady.ru** (с www)

## 🔄 Обновление сайта

Для обновления сайта используйте:

```bash
chmod +x update-site.sh
./update-site.sh
```

## 📞 Поддержка

При проблемах проверьте:
- DNS записи: `nslookup arhi-lady.ru`
- Статус Nginx: `ssh root@5.35.125.78 "systemctl status nginx"`
- Логи Nginx: `ssh root@5.35.125.78 "tail -f /var/log/nginx/error.log"` 