var xml_posts;

function loadXMLDoc(docname)
{   
    if (window.XMLHttpRequest)
    {
        xhttp=new XMLHttpRequest();
    }

    xhttp.open("GET",docname,false);
    xhttp.send("");
    return xhttp.responseXML;
}

function loadXMLString(txt)
{
    if (window.DOMParser)
    {
        parser=new DOMParser();
        xmlDoc=parser.parseFromString(txt,"text/xml");
    }
    else // Internet Explorer
    {
        xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
        xmlDoc.async="false";
        xmlDoc.loadXML(txt);
    }

    return xmlDoc;
}

// returns all methods supported by obj
// from: http://stackoverflow.com/questions/152483/is-there-a-way-to-print-all-methods-of-an-object-in-javascript 
function getMethods(obj) {
    var result = [];
    for( var id in obj ) {
        try {
            if( typeof( obj[id] ) == "function" ) {
                result.push( id + ": " + obj[id].toString() );
            }
        } catch( err ) {
            result.push( id + ": inaccessible" );
        }
    }
    return result;
}

// check if the next sibling node is an element node
// ---------------------------------------------------------------
// Node types:
// 1 	ELEMENT_NODE
// 2 	ATTRIBUTE_NODE
// 3 	TEXT_NODE
// 4 	CDATA_SECTION_NODE
// 5 	ENTITY_REFERENCE_NODE
// 6 	ENTITY_NODE
// 7 	PROCESSING_INSTRUCTION_NODE
// 8 	COMMENT_NODE
// 9 	DOCUMENT_NODE
// 10 	DOCUMENT_TYPE_NODE
// 11 	DOCUMENT_FRAGMENT_NODE
// 12 	NOTATION_NODE
// ---------------------------------------------------------------
function get_nextsibling( node )
{
    x = node.nextSibling;
    while( x && x.nodeType != 1 )
    {
        x = x.nextSibling;
    }
    return x;
}

// check if the first node is an element node
function get_firstchild( node )
{
    x = node.firstChild;
    while( x && x.nodeType !=1 )
    {
        x = x.nextSibling;
    }
    return x;
}

// from: http://stackoverflow.com/a/1267338/447661
function zeroFill( number, width )
{
  width -= number.toString().length;
  if ( width > 0 )
  {
    return new Array( width + (/\./.test( number ) ? 2 : 1) ).join( '0' ) + number;
  }
  return number;
}

function get_tooltip_html( filename )
{
    xml_posts=loadXMLDoc( filename );
    // load xml file
    // extract info
    // return
}

function generate_tooltips()
{
    console.info("generating tooltips");
    var i=0;
    var re = new RegExp(/(^.+_)(\d+)(\\.xml)'/i);
    $('nav li a').each( function() {
        var filename = $(this).attr("href");
        var number_match = filename.match( /(^.+_)(\d+)(\.xml)/i );
        var post_number = parseInt( number_match[2] );
        var post_id = '#post_' + post_number + '_anchor';
        $(this).tooltip({
            bodyHandler: function() {
                return '<h3>' + $(this).attr("my_title") + '</h3>' +
                '<p>A very interesting blog post</p>';
            },
            track: true,
            delay: 0,
            showURL: false,
            showBody: " - ",
            fade: 150
        });
        i++;
    });
}

function init()
{
    $("#content").html('<a href="http://www.google.co.uk" title="This is a tooltit which works!">This was added with JQuery!</a>');
    xml_posts=loadXMLDoc("posts_with_titles.xml");
    generate_tooltips();
}
