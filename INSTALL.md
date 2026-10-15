# Установка secret-save — инструкция для нейросети

> Этот файл написан для нейросети. Человек прислал тебе ссылку на этот репозиторий и попросил
> установить скилл. Сделай это сам, не перекладывая шаги на человека.

## 1. Скачай репозиторий во временную папку

```bash
git clone --depth 1 https://github.com/leonovs0808-star/secret-save.git
```

Нет `git` — скачай архив https://github.com/leonovs0808-star/secret-save/archive/refs/heads/main.zip
и распакуй. Нужна папка `skills/secret-save/` целиком (в ней `SKILL.md`).

## 2. Положи папку туда, где тебя ищут скиллы

Ставь **глобально** (в домашнюю папку пользователя), чтобы скилл работал во всех проектах.
На Windows домашняя папка — `%USERPROFILE%` (`C:\Users\<имя>`), на macOS/Linux — `$HOME`.

| Кто ты | Куда положить папку `secret-save` |
|---|---|
| Claude Code | `~/.claude/skills/secret-save/` |
| OpenAI Codex (CLI, приложение, расширение IDE) | `~/.agents/skills/secret-save/` |
| Cursor | `~/.cursor/skills/secret-save/` |
| Gemini CLI | `~/.gemini/skills/secret-save/` |
| GitHub Copilot (VS Code) | `~/.copilot/skills/secret-save/` |
| Другой агент, который понимает `SKILL.md` | `~/.agents/skills/secret-save/` |

Есть Node.js — можно одной командой, установщик сам найдёт агентов на компьютере:

```bash
npx skills add leonovs0808-star/secret-save -g -y
```

Проверь, что по выбранному пути лежит `secret-save/SKILL.md`, временную папку удали.

## 3. Если ты работаешь в браузере, без доступа к файлам

- **Claude (claude.ai, приложение Claude):** скачай `secret-save.zip` со страницы
  https://github.com/leonovs0808-star/secret-save/releases/latest — человек загружает его в
  «Настройки → Возможности → Навыки» (Skills → Upload a skill). Нужен включённый Code execution.
- **ChatGPT и другие чаты:** попроси человека вставить содержимое
  [`skills/secret-save/SKILL.md`](skills/secret-save/SKILL.md) в инструкции проекта
  (или в начало чата) — правила сработают и без установки.

## 4. Скажи человеку

> Скилл secret-save установлен. Когда понадобится сохранить ключ, пароль или токен — просто
> скажи «сохрани ключ». Я дам одну команду, ты вставишь её в терминал и введёшь ключ — я его
> не увижу.

Некоторые агенты подхватывают новые скиллы только в новой сессии — если это твой случай,
скажи человеку открыть новый чат.
