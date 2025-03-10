import http from "http";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url"; // Import for __dirname
import { dirname } from "path"; // Import for __dirname

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const port = 3000; // You can change this

const serveAt = "uoehw.github.io";

const server = http.createServer((req, res) => {
  let filePath = "." + "/" + serveAt + req.url;
  if (filePath === "./" + serveAt + "/") {
    filePath = "./" + serveAt + "/index.html"; // Default to index.html
  }

  try {
    const stats = fs.statSync(filePath);
    if (stats.isDirectory()) {
      filePath = filePath + "/index.html";
    }
  } catch {
    // do nothing
  }

  console.log(filePath);

  const extname = path.extname(filePath);
  let contentType = "text/html";

  switch (extname) {
    case ".js":
      contentType = "application/javascript";
      break;
    case ".css":
      contentType = "text/css";
      break;
    case ".json":
      contentType = "application/json";
      break;
    case ".png":
      contentType = "image/png";
      break;
    case ".jpg":
    case ".jpeg":
      contentType = "image/jpeg";
      break;
  }

  fs.readFile(filePath, (err, content) => {
    if (err) {
      if (err.code === "ENOENT") {
        // 404: File Not Found
        fs.readFile("./404.html", (err, content) => {
          // Serve a custom 404 page (optional)
          res.writeHead(404, { "Content-Type": "text/html" });
          res.end(content, "utf8");
        });
      } else {
        // 500: Some other error
        res.writeHead(500);
        res.end(`Server Error: ${err.code}`);
      }
    } else {
      // 200: Success
      res.writeHead(200, { "Content-Type": contentType });
      res.end(content, "utf8");
    }
  });
});

server.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
