if (!RunPlayer(
        "width", "95%",
        "height", "600",  //Internet Explorer may interpret relative sizes in tables as 0
        "graphURL", "http://www.avelto.com/nudge/svgio/GraphMLViewer/GraphMLViewer/examplegraphs/example2.graphml",
        "overview", "true",
        "toolbar", "true",
        "tooltips", "true",
        "movable", "true",
        "links", "true",
        "linksInNewWindow", "false",
        "viewport", "full"
)) {
document.write("Cannot start GraphMLViewer!");
}