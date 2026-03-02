@echo off
chcp 65001 >nul
echo ==========================================
echo  ORGANIZANDO PROJETO THAYS MOREIRA
echo ==========================================
echo.

cd /d C:\site-thaysmoreira

:: Verifica se já foi executado antes
if exist "modelo-a\" (
    echo [ERRO] Pastas modelo-a ja existem!
    echo Se quiser recomeçar, apague as pastas modelo-a e modelo-b primeiro.
    pause
    exit
)

echo [1/6] Criando pastas...
mkdir modelo-a
mkdir modelo-b
echo OK

echo [2/6] Movendo Modelo A (atual)...
move index.html modelo-a\ >nul 2>&1
move assets modelo-a\ >nul 2>&1
echo OK

echo [3/6] Copiando Modelo B (de ANTIGRAVITY\frontend)...
xcopy "C:\ANTIGRAVITY-PROJETOS\PROJETO-1\frontend\index.html" modelo-b\ /Y >nul
xcopy "C:\ANTIGRAVITY-PROJETOS\PROJETO-1\frontend\assets\*" modelo-b\assets\ /E /I /Y >nul 2>&1
echo OK

echo [4/6] Criando vercel.json...
(
echo {
echo   "routes": [
echo     { "src": "/modelo-a/(.*)", "dest": "/modelo-a/$1" },
echo     { "src": "/modelo-b/(.*)", "dest": "/modelo-b/$1" },
echo     { "src": "/", "dest": "/index.html" }
echo   ]
echo }
) > vercel.json
echo OK

echo [5/6] Criando pagina de escolha...
(
echo ^<!DOCTYPE html^>
echo ^<html lang="pt-BR"^>
echo ^<head^>
echo   ^<meta charset="UTF-8"^>
echo   ^<title^>Thays Moreira — Escolha o Layout^</title^>
echo   ^<style^>
echo     * { margin: 0; padding: 0; box-sizing: border-box; }
echo     body {
echo       font-family: 'Montserrat', sans-serif;
echo       background: #0d0d0d;
echo       color: #f8f5f0;
echo       min-height: 100vh;
echo       display: flex;
echo       flex-direction: column;
echo       align-items: center;
echo       justify-content: center;
echo       gap: 50px;
echo       padding: 40px;
echo     }
echo     h1 {
echo       font-family: 'Cormorant Garamond', serif;
echo       font-size: 42px;
echo       font-weight: 300;
echo       color: #c9a96e;
echo       text-align: center;
echo     }
echo     h1 em { font-style: italic; color: #f8f5f0; }
echo     .sub {
echo       font-size: 12px;
echo       letter-spacing: 4px;
echo       text-transform: uppercase;
echo       color: #a09080;
echo     }
echo     .botoes {
echo       display: flex;
echo       gap: 40px;
echo       flex-wrap: wrap;
echo       justify-content: center;
echo     }
echo     a {
echo       width: 320px;
echo       height: 220px;
echo       border: 1px solid rgba(201,169,110,.3);
echo       text-decoration: none;
echo       display: flex;
echo       flex-direction: column;
echo       align-items: center;
echo       justify-content: center;
echo       gap: 20px;
echo       transition: all .4s;
echo     }
echo     a:hover {
echo       border-color: #c9a96e;
echo       background: rgba(201,169,110,.05);
echo       transform: translateY(-5px);
echo     }
echo     .label {
echo       font-size: 11px;
echo       letter-spacing: 3px;
echo       text-transform: uppercase;
echo       color: #c9a96e;
echo     }
echo     .nome {
echo       font-family: 'Cormorant Garamond', serif;
echo       font-size: 32px;
echo       font-weight: 300;
echo       color: #f8f5f0;
echo     }
echo   ^</style^>
echo ^</head^>
echo ^<body^>
echo   ^<div^>
echo     ^<p class="sub"^>Thays Moreira — Bijoux ^& Design^</p^>
echo     ^<h1^>Escolha o ^<em^>layout^</em^>^</h1^>
echo   ^</div^>
echo   ^<div class="botoes"^>
echo     ^<a href="/modelo-a/"^>
echo       ^<span class="label"^>Opção 1^</span^>
echo       ^<span class="nome"^>Modelo Original^</span^>
echo     ^</a^>
echo     ^<a href="/modelo-b/"^>
echo       ^<span class="label"^>Opção 2^</span^>
echo       ^<span class="nome"^>Novo Modelo^</span^>
echo     ^</a^>
echo   ^</div^>
echo ^</body^>
echo ^</html^>
) > index.html
echo OK

echo [6/6] Enviando para GitHub...
git add .
git commit -m "Reorganizado: modelo A e B na mesma pasta"
git push origin main
echo OK

echo.
echo ==========================================
echo  PRONTO!
echo ==========================================
echo.
echo URLs disponiveis:
echo   - seu-site.vercel.app           (pagina de escolha)
echo   - seu-site.vercel.app/modelo-a/ (original)
echo   - seu-site.vercel.app/modelo-b/ (novo)
echo.
pause