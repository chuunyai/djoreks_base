<div align="center">
  <img src="./banner.svg" width="100%" alt="DJOREKS BASE" />
  
  ![Status](https://img.shields.io/badge/STATUS-ONLINE-8E44AD?style=for-the-badge)
  ![Access](https://img.shields.io/badge/ACCESS-PRIVATE-D883FF?style=for-the-badge)
  ![Storage](https://img.shields.io/badge/CONTENT-UNFILTERED-4A1A70?style=for-the-badge)
</div>

---

> [!IMPORTANT]
> Содержимое репозитория предназначено исключительно для участников. Распространение за пределы круга запрещено. Все совпадения случайны.

### Регламент

1. **Именование файлов.** Запрещено заливать файлы с дефолтными именами (`IMG_1234.jpg`, `video_2026.mp4`). Формат имени: `ГГГГ-ММ-ДД_краткое_описание.расширение` (например: `2026-11-16_discord_incident.mp4`).
2. **Лимит по весу.** Файлы тяжелее **25 МБ** не заливать в основную ветку — использовать вкладку **Releases**.
3. **Формат коммитов.** Писать кратко и по сути:
   * `add:` — добавление нового файла (`add: screenshot from voice chat`)
   * `fix:` — замазывание личных данных или замена файла (`fix: blur sensitive info`)
   * `docs:` — обновление текста и правил

---

### Инструкция по загрузке

#### Способ 1: Через браузер (быстрый)
1. В правом верхнем углу списка файлов нажать **Add file** → **Upload files**.
2. Перетащить подготовленные (и переименованные) файлы в окно.
3. Внизу в поле **Commit changes** написать сообщение по регламенту (например: `add: new clip`).
4. Нажать зеленую кнопку **Commit changes**.

#### Способ 2: Через Git (для пачки файлов)
```bash
# 1. Скачать актуальную версию базы (если репо уже склонирован)
git pull origin main

# 2. Закинуть новые файлы в папку репозитория и добавить их в индекс
git add .

# 3. Зафиксировать изменения
git commit -m "add: описание того, что залил"

# 4. Отправить на сервер
git push origin main
```
<div align="center">
  <sub>EST. 2026 • NO EXTERNAL ACCESS</sub>
</div>
