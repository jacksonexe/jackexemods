var http = require('http');
var fs = require('fs');
var path = require('path');
const { stringify } = require('querystring');
const { table } = require('console');

var basePath = "/manga";
var manga = fs.readdirSync(basePath);
console.log(manga)
const mangaStatus = JSON.parse(fs.readFileSync("./readingStatus.json"));
var allManga = {};
for(let m of manga){
    if(m.indexOf("hakuneko") >= 0){
        continue; //skip tools
    }
    var rootPath = path.join(basePath,m);
    var baseMangaPath = fs.readdirSync(rootPath);
    for(let mp of baseMangaPath){
        var mangaInfo = {
            "chapters" : {},
            "folder" : path.join(rootPath,mp)
        };
        allManga[mp] = mangaInfo;
        if(mangaStatus[mp] == undefined){
            mangaStatus[mp] = {
                "chapters" : {},
                "lastRead" : ""
            }
        }
    }
}
//console.log(allManga);

function queryForChapters(manga){
    var mangaInfo = allManga[manga];
    if(mangaInfo.chapters.length > 0){
        return;
    }
    var newPath = fs.readdirSync(mangaInfo.folder);
    for(let chaps of newPath){
        if(mangaStatus[manga].chapters[chaps] == undefined){
            mangaStatus[manga].chapters[chaps] = false;
        }
        var chapterInfo = {
            "files" : []
        };
        var files = fs.readdirSync(path.join(mangaInfo.folder,chaps));
        for(let f of files){
            var fp = path.join(rootPath,manga,chaps,f);
            fp = fp.substring(basePath.length);
            chapterInfo.files.push(fp);
        }
        mangaInfo.chapters[chaps] = chapterInfo;
    }
    var sortedKeys = Object.keys(mangaInfo.chapters).sort((a, b) =>{
        /*var chapANum = a.substring(a.toLowerCase().indexOf("chapter ") + "chapter ".length);
        if(chapANum.length > 0){
            chapANum = chapANum.substring(0, chapANum.indexOf(" "));
        }

        var chapBNum = b.substring(b.toLowerCase().indexOf("chapter ") + "chapter ".length);
        if(chapBNum.length > 0){
            chapBNum = chapBNum.substring(0, chapBNum.indexOf(" "));
        }
        try {
            var aNum = parseFloat(chapANum);
            var bNum = parseFloat(chapBNum);
            return aNum - bNum;
        }
        catch(e){
            console.error("Unable to compare " + a + " " + b, e);
        }*/
        if(a.startsWith("Volume") && b.startsWith("Volume")){
            var volA = a.substring(a.indexOf("Volume "));
            volA = volA.substring(0, volA.indexOf("\s"));
            var volB = b.substring(b.indexOf("Volume "));
            volB = volB.substring(0, volB.indexOf("\s"));
            if(volA != volB){
                return volA.localeCompare(volB, undefined, {numeric: true, sensitivity: 'base'});
            }
        }
        if(a.startsWith("Vol.") && b.startsWith("Vol.")){
            var volA = a.substring(a.indexOf("Vol."));
            volA = volA.substring(0, volA.indexOf("\s"));
            var volB = b.substring(b.indexOf("Vol."));
            volB = volB.substring(0, volB.indexOf("\s"));
            if(volA != volB){
                return volA.localeCompare(volB, undefined, {numeric: true, sensitivity: 'base'});
            }
        }
        return a.localeCompare(b, undefined, {numeric: true, sensitivity: 'base'});
    });
    //console.log(sortedKeys);
    mangaInfo.chapters = sortedKeys.reduce(
        (obj, key) => { 
          obj[key] = mangaInfo.chapters[key]; 
          return obj;
        }, 
        {}
    );
}

function saveStatus(){
    fs.writeFileSync("./readingStatus.json", JSON.stringify(mangaStatus, undefined, 4))
}

function updateMangaStatus(manga, currentChapter, previousChapter){
    if(mangaStatus[manga] == undefined){
        mangaStatus[manga] = {
            "chapters" : {},
            "lastRead" : ""
        }
    }

    if(currentChapter && mangaStatus[manga].chapters[currentChapter] == undefined){
        mangaStatus[manga].chapters[currentChapter] = false;
    }

    if(previousChapter && mangaStatus[manga].chapters[previousChapter] == undefined){
        mangaStatus[manga].chapters[previousChapter] = false;
    }
    if(previousChapter != undefined){
        mangaStatus[manga].chapters[previousChapter] = true;
    }
    if(currentChapter != undefined && !mangaStatus[manga].chapters[currentChapter]){
        mangaStatus[manga].lastRead = currentChapter;
    }
    saveStatus();
}

function wasMangaRead(manga){
    if(mangaStatus[manga] == undefined){
        mangaStatus[manga] = {
            "chapters" : {},
            "lastRead" : ""
        }
        saveStatus();
    }
    if(Object.keys(mangaStatus[manga].chapters).length == 0){
        return false;
    }
    for(let key in mangaStatus[manga].chapters){
        var chap = mangaStatus[manga].chapters[key]
        if(!chap){
            return false;
        }
    }
    return true;
}

function getMangaStatus(manga){
    var status = wasMangaRead(manga);
    if(!status){
        if(mangaStatus[manga].lastRead == "" || mangaStatus[manga].lastRead == undefined){
            return "<span class=\"badge badge-not-started\">Not Started</span>";
        }
        return "<span class=\"badge badge-primary\">In Progress</span>";
    }
    return "<span class=\"badge badge-completed\">Completed</span>"
}

function wasRead(chapter, manga){
    if(mangaStatus[manga] == undefined){
        mangaStatus[manga] = {
            "chapters" : {},
            "lastRead" : ""
        }
        saveStatus();
    }
    return mangaStatus[manga].chapters[chapter];
}

function getChapterStatus(manga, chapter){
    var status = wasRead(chapter, manga);
    if(!status){
        if(mangaStatus[manga].lastRead == chapter){
            return "<span class=\"badge badge-primary\">In Progress</span>";
        }
        return "<span class=\"badge badge-not-started\">Not Started</span>";
    }
    return "<span class=\"badge badge-completed\">Completed</span>";
}

http.createServer(function (request, response) {
    console.log('request starting... ' + request.url);
    const current_url = new URL("http://localhost" +  request.url);
    const search_params = current_url.searchParams;
    if(request.url.indexOf("listFiles") >= 0 || request.url == "/"){
        var template = fs.readFileSync("./template.html");
        var tableData = "";
        for(let key in allManga){
            tableData += "<tr>";
            tableData += "<td>";
            tableData += "<a href=\"\\listChapters?manga=" + key.toString() + "\">" + key.toString() + "</a>";
            tableData += "</td>";
            tableData += "<td>" + getMangaStatus(key) + "</td>"
            tableData += "<td><a target=\"_blank\" href=\"https://myanimelist.net/manga.php?q=" + key.toString() + "&cat=manga\">link</a></td>";
            tableData += "</tr>";
        }
        template = template.toString().replace("%REPLACE%", tableData)
        response.writeHead(200, { 'Content-Type': "text/html" });
        response.end(template, 'utf-8');
    }
    else if(request.url.indexOf("listChapters") >= 0){
        var manga = decodeURIComponent(search_params.get("manga"));
        queryForChapters(manga);
        var template = fs.readFileSync("./chaptersTemplate.html");
        var tableData = "";
        for(let key in allManga[manga].chapters){
            tableData += "<tr>";
            tableData += "<td>";
            tableData += "<a href=\"\\viewChapter?manga=" + manga + "&chapter=" + key.toString() +"\">" + key.toString() + "</a>";
            tableData += "</td>";
            tableData += "<td>" + getChapterStatus(manga, key) + "</td>"
            tableData += "</tr>";
        }
        template = template.toString().replace("%REPLACE%", tableData)
        response.writeHead(200, { 'Content-Type': "text/html" });
        response.end(template, 'utf-8');
    }
    else if(request.url.indexOf("viewChapter") >= 0){
        var manga = decodeURIComponent(search_params.get("manga"));
        queryForChapters(manga);
        var chapter = decodeURIComponent(search_params.get("chapter"));
        var lastChapter = decodeURIComponent(search_params.get("update"));
        updateMangaStatus(manga, chapter, lastChapter);
        var template = fs.readFileSync("./chapterDisplayTempate.html");
        var tableData = "";
        console.log(manga);
        console.log(chapter);
        var index = Object.keys(allManga[manga].chapters).indexOf(chapter);
        tableData = "<div>";
        if(index > 0){
            var prevChapIndex = index - 1;
            var prevChap = Object.keys(allManga[manga].chapters)[prevChapIndex]
            tableData += "<a class=\"button\" href=\"\\viewChapter?manga=" + manga + "&chapter=" + prevChap.toString() +"\">Previous: " + prevChap.toString();
            if(wasRead(prevChap, manga)){
                tableData += " <span>&#10003;</span>";
            }
            tableData += "</a>";
        }
        tableData += "<a class=\"button\" href=\"\\listChapters?manga=" + manga.toString() + "\">Back</a>";
        if(index < Object.keys(allManga[manga].chapters).length){
            var nextChapIndex = index + 1;
            var nextChap = Object.keys(allManga[manga].chapters)[nextChapIndex];
            if(nextChap != undefined){
                tableData += "<a class=\"button\" href=\"\\viewChapter?manga=" + manga + "&chapter=" + nextChap.toString() +"&update=" + chapter + "\">Next: " + nextChap.toString();
                if(wasRead(nextChap, manga)){
                    tableData += " <span>&#10003;</span>";
                }
                tableData += "</a>";
            }
        }
        tableData += "</div>"
        for(let file of allManga[manga].chapters[chapter].files){
            //tableData += "<hr>";
            tableData += "<img src=\"/?manga=" + file + "\"/>";
            //tableData += "<hr>";
        }

        tableData += "<div>"
        if(index > 0){
            var prevChapIndex = index - 1;
            var prevChap = Object.keys(allManga[manga].chapters)[prevChapIndex]
            tableData += "<a class=\"button\" href=\"\\viewChapter?manga=" + manga + "&chapter=" + prevChap.toString() +"\">Previous: " + prevChap.toString();
            if(wasRead(prevChap, manga)){
                tableData += " <span>&#10003;</span>";
            }
            tableData += "</a>";
        }
        tableData += "<a class=\"button\" href=\"\\listChapters?manga=" + manga.toString() + "\">Back</a>";

        if(index < Object.keys(allManga[manga].chapters).length){
            var nextChapIndex = index + 1;
            var nextChap = Object.keys(allManga[manga].chapters)[nextChapIndex];
            if(nextChap != undefined){
                tableData += "<a class=\"button\" href=\"\\viewChapter?manga=" + manga + "&chapter=" + nextChap.toString() +"&update=" + chapter + "\">Next: " + nextChap.toString();
                if(wasRead(nextChap, manga)){
                    tableData += " <span>&#10003;</span>";
                }
                tableData += "</a>";
            }
        }
        tableData += "</div>";
        template = template.toString().replace("%REPLACE%", tableData)
        response.writeHead(200, { 'Content-Type': "text/html" });
        response.end(template, 'utf-8');
    }
    else{
        var filePath = '.' + request.url;
        if (filePath == './')
            filePath = './index.html';
        if(request.url.indexOf("?manga=") >= 0){
            
            var url = decodeURIComponent(search_params.get("manga"));
            filePath = "/manga/" + url
        }
        console.log(filePath);
        var extname = path.extname(filePath);
        var contentType = 'text/html';
        switch (extname) {
            case '.js':
                contentType = 'text/javascript';
                break;
            case '.css':
                contentType = 'text/css';
                break;
            case '.json':
                contentType = 'application/json';
                break;
            case '.png':
                contentType = 'image/png';
                break;
            case '.jpg':
                contentType = 'image/jpg';
                break;
            case '.wav':
                contentType = 'audio/wav';
                break;
        }

        fs.readFile(filePath, function(error, content) {
            if (error) {
                if(error.code == 'ENOENT'){
                    fs.readFile('./404.html', function(error, content) {
                        response.writeHead(200, { 'Content-Type': contentType });
                        response.end(content, 'utf-8');
                    });
                }
                else {
                    response.writeHead(500);
                    response.end('Sorry, check with the site admin for error: '+error.code+' ..\n');
                    response.end(); 
                }
            }
            else {
                response.writeHead(200, { 'Content-Type': contentType });
                response.end(content, 'utf-8');
            }
        });
    }

}).listen(8125, '0.0.0.0');
console.log('Server running at http://0.0.0.0:8125/');