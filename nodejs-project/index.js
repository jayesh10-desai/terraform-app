let x = {
"foo": "bar",
"built_at": "1616337212",
"deployed_at": "1222037111"
}

const http = require('http');

const hostname = '0.0.0.0';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/json');
  res.end(JSON.stringify(x));
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
