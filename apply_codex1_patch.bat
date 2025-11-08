@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ==============================================
echo Применение патча codex1.patch
echo ==============================================

if not exist "codex1.patch" (
  echo Файл codex1.patch не найден в этой папке.
  pause
  exit /b
)

:: Проверка применимости патча
echo Проверка применимости...
git apply --check codex1.patch
if errorlevel 1 (
  echo Ошибка: патч не может быть применён к текущему состоянию репозитория.
  echo Убедитесь, что локальная копия обновлена: git pull
  pause
  exit /b
)

:: Применение патча
echo Применяю патч...
git apply codex1.patch
if errorlevel 1 (
  echo Ошибка при применении патча.
  pause
  exit /b
)

:: Коммит и пуш
echo Фиксирую изменения...
git add -A
git commit -m "Применён патч codex1.patch"
if errorlevel 1 (
  echo Ошибка при создании коммита.
  pause
  exit /b
)

echo Отправка на GitHub...
git push
if errorlevel 1 (
  echo Ошибка при push.
  pause
  exit /b
)

echo ==============================================
echo Патч успешно применён и отправлен в репозиторий.
echo ==============================================
pause