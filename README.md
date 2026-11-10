# Wheeking 🐾

Ти друкуй. Я фир-фир, якщо щось не так.

Автоматичний перемикач розкладки UA⇄EN для macOS: виправляє слова, набрані не в тій розкладці
(`ghbdsn` → «привіт», `руддщ` → «hello»), і перемикає розкладку сам. Живе в рядку меню.

## Встановлення

Відкрийте **Термінал** (Cmd+Пробіл → «Terminal»), вставте рядок і натисніть Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/SubzeroQ/wheeking-releases/main/install.sh | bash
```

Команда завантажить останню версію в «Програми» (Applications) і запустить її. Акаунт GitHub не потрібен.
Далі Wheeking попросить дозвіл «Універсальний доступ» (Accessibility) — він потрібен, щоб стерти слово
й надрукувати його в правильній розкладці. Текст нікуди не надсилається і не зберігається.

Оновлення — та сама команда.

Потрібна macOS 14 або новіша.

### Без Терміналу

Завантажте `Wheeking-*.dmg` з [Releases](https://github.com/SubzeroQ/wheeking-releases/releases/latest)
і перетягніть Wheeking у Applications. Застосунок не нотаризований Apple, тож при першому запуску
відкрийте System Settings → Privacy & Security → **Open Anyway**.
