@ECHO OFF

REM Windows Makefile

set /p APP_NAME=<APP_NAME

if "%1" == "" goto help

if "%1" == "help" (
	:help
	echo.Please use `make ^<target^>` where ^<target^> is one of
	echo.  build      to build exe file
  echo.  clean      to remove files and folders generated by build
  echo.  docs       to generate docs with sphynx
	echo.  init       to install required libraries
  echo.  inspect    to inspect security issues in python code
	echo.  run        to run the project with python
  echo.  run-exe    to run exe in build folder
	echo.  test       to test with pytest
  echo.  test-cov   to test with coverage info
	goto end
)

if "%1" == "build" (
  pyinstaller.exe --onefile --name=%APP_NAME% --icon=./icons/%APP_NAME%.ico --version-file=file_version_info.txt --key=%KEY% ./%APP_NAME%/__main__.py
  goto end
)

if "%1" == "clean" (
  del /q /s build\*
  del /q build
  del /q /s dist\*
  del /q dist
	del /q %APP_NAME%.spec
  goto end
)

if "%1" == "docs" (
  echo "not implememted"
  goto end
)

if "%1" == "init" (
  pip install -r requirements.txt
  pip install -r requirements-dev.txt
  goto end
)

if "%1" == "inspect" (
  bandit -r %APP_NAME%
  goto end
)

if "%1" == "run" (
  python -m %APP_NAME%
  goto end
)

if "%1" == "run-exe" (
  dist\%APP_NAME%.exe
  goto end
)

if "%1" == "test" (
  pytest -rA tests/
  goto end
)

if "%1" == "test-cov" (
  pytest -rA --cov=%APP_NAME% tests/
  goto end
)

:end
