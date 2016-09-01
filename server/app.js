var app = require('http').createServer(handler)
var io = require('socket.io')(app);
var fs = require('fs');

app.listen(8080);

function handler (req, res) {
  fs.readFile(__dirname + '/index.htm',
  function (err, data) {
    if (err) {
      res.writeHead(500);
      return res.end('Error loading index.htm');
    }

    res.writeHead(200);
    res.end(data);
  });
}

io.on('connection', function (socket) {
  socket.emit('startgame', 'hi isobar' );
  socket.on('msg', function (data) {
    console.log(data);
    socket.emit('msg', data );
  });
});
