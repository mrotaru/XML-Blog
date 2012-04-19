var xml_posts;
var init_run=false;

// from: http://www.szajkowski.com/ajaxsample.html
function xmlhttpPost( strURL ) 
{
    var xmlHttpReq = false;
    console.info("requesting: " + strURL );
    
    if( window.XMLHttpRequest ) // Mozilla/Safari 
    {
        xmlHttpReq = new XMLHttpRequest();
        if( xmlHttpReq.overrideMimeType )
        {
            xmlHttpReq.overrideMimeType('text/xml');
            // See note below about this line
        }
    
    } 
    else if( window.ActiveXObject ) // IE
    {
        try {
            xmlHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {}
        }
    }
    
    if( !xmlHttpReq )
    {
        alert('ERROR AJAX:( Cannot create an XMLHTTP instance');
        return false;
    }   

    xmlHttpReq.open('GET', strURL, true);
    xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');        
    xmlHttpReq.onreadystatechange = function() { 
        callBackFunction( xmlHttpReq ); 
    };
    xmlHttpReq.send("");
}

function callBackFunction( http_request ) 
{
    if (http_request.readyState == 4)
    {
        if (http_request.status == 200)
        {
            console.info("returning: " + http_request );
            return http_request.responseXML;
        } 
        else 
        {
            alert('ERROR: AJAX request status = ' + http_request.status);
        }
    }
}

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

// return a div for a blog post which contains items such as a
// link do download the pdf
function get_post_footer( post_number )
{
    var pdf_folder = "build/pdf";
    var ret_html = '<div class="post_footer">';
    ret_html += '<a class="download_pdf" href=' + pdf_folder + "/post_" + zeroFill( post_number, 2 ) + ".pdf>";
    ret_html += 'Download PDF</a></div>';
    return ret_html;
}

function load_blog_post( filename )
{
    var posts_folder = "posts";
    var number_match = filename.match( /(^.+_)(\d+)(\.xml)/i );
    var number = ( number_match[2] == '08' ? 8 : number_match[2] );
    var post_number = zeroFill( number, 2);
    var post_id = '#post_' + post_number + '_anchor';

    $(".current").removeClass( "current" );
    $( post_id ).addClass( "current" );
    
    filename = posts_folder + "/" + filename;
    console.info("loading: " + filename );
    xml = loadXMLDoc( filename );
    xsl = loadXMLDoc( "transform.xsl" );

    // code for IE
    if( window.ActiveXObject )
    {
        ex = xml.transformNode( xsl );
        $("#content").html = ex;
        $("#content").append( get_post_footer( post_number ));
    }
    // code for Mozilla, Firefox, Opera, etc.
    else if( document.implementation && document.implementation.createDocument )
    {
        xsltProcessor=new XSLTProcessor();
        xsltProcessor.importStylesheet( xsl );
        resultDocument = xsltProcessor.transformToFragment( xml,document );
        console.log( resultDocument );
        $("#content").html( resultDocument );
        $("#content").append( get_post_footer( post_number ));
    }
}

function type(obj){
    return Object.prototype.toString.call(obj).match(/^\[object (.*)\]$/)[1]
}

function eval_xpath( xml_fragment, xpath_expression, result_type )
{
    if( window.XMLHttpRequest ) 
    {
        xml_fragment.setProperty("SelectionNamespaces",    "xmlns:xsl='http://www.w3.org/1999/XSL/Transform'");
        xml_fragment.setProperty("SelectionLanguage", "XPath");
        console.info( "evaluating: " + xpath_expression );
        var nodes = xml_fragment.documentElement.selectNodes( xpath_expression );
        console.info( nodes.length );
        return nodes;
    }
    else // IE
    {
        result_type = ( typeof result_type == "undefined" ) ? XPathResult.STRING_TYPE : XPathResult.ANY_TYPE;
    }
}

function get_tooltip_html( filename )
{
    console.info("loading: " + filename );
    // load xml file
    xml_meta=loadXMLDoc( filename );

    if( window.XMLHttpRequest )
    {
        // extract info
        var author_name = xml_meta.evaluate( "head/author/name", xml_meta, null, XPathResult.STRING_TYPE, null );
        var author_surname = xml_meta.evaluate( "head/author/surname", xml_meta, null, XPathResult.STRING_TYPE, null );
        var author = author_name.stringValue + " " + author_surname.stringValue.charAt(0) + ".";
        var date = xml_meta.evaluate( "head/date", xml_meta, null, XPathResult.STRING_TYPE, null );
        var tags = xml_meta.evaluate( "head/tags", xml_meta, null, XPathResult.ANY_TYPE, null );
        return "<p>Author: " + author + "</p>" + "<p>Date: " + date.stringValue + "</p>";
    }
    else // IE
    {
        eval_xpath( xml_meta, "head/author/name" );
    }
}

function generate_tooltips()
{
    var meta_folder = "build/meta";

    // for each anchor in a list item in a nav
    var i=0;
    $('nav li a').each( function() {
        var filename = $(this).attr("filename");
        var number_match = filename.match( /(^.+_)(\d+)(\.xml)/i );
        var post_number = parseInt( number_match[2] );
        var post_id = '#post_' + post_number + '_anchor';

        // add a tooltip
        $(this).tooltip({
            bodyHandler: function() {
                return '<h3>' + $(this).attr("my_title") + '</h3>' +
                get_tooltip_html( meta_folder + "/post_" + zeroFill( post_number, 2 ) + "_meta.xml" );
            },
            track: true,
            delay: 200,
            showURL: false,
            showBody: " - ",
            fade: 150
        });

        // set click action
        $(this).click( function(e) {
            load_blog_post( filename );
        });
        i++;
    });
}

function init()
{
    if(!init_run)
    {
        xml_posts=loadXMLDoc("posts_with_titles.xml");
        console.info( "posts: " + xml_posts );
        generate_tooltips();
        init_run=true;
    }
}
