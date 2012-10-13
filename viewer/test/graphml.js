if (!RunPlayer(
        "width", "95%",
        "height", "600",  //Internet Explorer may interpret relative sizes in tables as 0
        "graphURL", "https://raw.github.com/jp-a/svg-gsi/master/viewer/test/ea_framework.graphml",
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