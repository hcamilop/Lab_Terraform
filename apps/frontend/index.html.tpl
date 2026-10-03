<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Ambiente ${env_name} - Frontend</title>
  <style>
    body { font-family: sans-serif; margin: 40px; background: #111; color: #eee; }
    h1 { color: #4caf50; }
    pre { background: #222; padding: 15px; border-radius: 8px; }
  </style>
</head>
<body>
  <h1>Ambiente: ${env_name}</h1>
  <p>Respuesta del backend:</p>
  <pre id="resp">Cargando...</pre>

  <script>
    fetch('/api/')
      .then(r => r.json())
      .then(d => {
        document.getElementById('resp').textContent = JSON.stringify(d, null, 2);
      })
      .catch(e => {
        document.getElementById('resp').textContent = 'Error: ' + e;
      });
  </script>
</body>
</html>