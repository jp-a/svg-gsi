fs = require 'fs'
#{ exec } = require 'child_process'
walk = require 'walk'
Path = require 'path'
files   = []

walker  = walk.walk 'docs', { followLinks: false }

walker.on 'file', ( root, stat, next ) ->
  # Add this file to the list of files
  if stat.name.match /.svg$/
    files.push root + '/' + stat.name
  next()

walker.on 'end', ->
  console.log 'Generating gadget + embended files for', files
  gen_embd()

gen_embd = ->
  for file in files
    console.log '+ Generating', file

    content = fs.readFileSync file, 'utf8'

    content = content.replace /a xlink/g, 'a target="_parent" xlink'

    filename = Path.basename file,  '.svg'
    dirname  = Path.dirname file

    escaped_file = escape content

    gadget = """
        <?xml version="1.0" encoding="UTF-8" ?>
        <Module>
          <ModulePrefs title="svgio_0.1 generated gadget" />
          <Content type="html">
             <![CDATA[
               <script type="text/javascript" src="https://raw.github.com/jp-a/svg-gsi/master/svgpan/jquery.min.js">
               <script type="text/javascript" src="https://raw.github.com/jp-a/svg-gsi/master/svgpan/jquery-svgpan.js"></script>
               <script type="text/javascript" src="https://raw.github.com/jp-a/svg-gsi/master/svgpan/#{ dirname }/#{ filename }.js"></script>
             ]]>
          </Content>
        </Module>
        """

    console.log '  + Writing gadget for', filename
    #console.log gadget
    fs.writeFileSync "./#{ dirname }/#{ filename }.xml", gadget, 'utf8'

    wrap = """
        console.log( "   info - SVG IO generated wrapper #{ filename } v0.1" );
        var svg_escaped = "#{ escaped_file }";
        var svg = unescape( svg_escaped );
        document.write( svg );
        """

    console.log '  + Writing doc for', filename
    #console.log wrap
    fs.writeFileSync "./#{ dirname }/#{ filename }.js", wrap, 'utf8'
