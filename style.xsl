<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">

    <xsl:variable name="title" select="document(/root/@posts)/posts/title"/>
    <html>
        <head>
            <title>
                <xsl:value-of select="$title"/>
            </title>
            <link rel="stylesheet" href="style.css"/>
            <script src="lib/modernizr-2.5.3.js"></script>
            <script src="lib/jquery-1.7.2.min.js" type="text/javascript"></script>
            <script src="lib/jquery.bgiframe.js" type="text/javascript"></script>
            <script src="lib/jquery.dimensions.js" type="text/javascript"></script>
            <script src="lib/jquery.tooltip.pack.js" type="text/javascript"></script>
            <script src="lib/jquery.dump.js" type="text/javascript"></script>
            <script src="script.js" type="text/javascript"></script>
            <script type="text/javascript">
                //window.onload=init(); 
            </script>
        </head>
        <body>
            <div id="container">
                <header>
                    <h1>
                        <span>
                            <xsl:attribute name="class">
                                <xsl:text>h1_tags</xsl:text>
                            </xsl:attribute>
                            <xsl:text>&lt; </xsl:text>
                        </span>
                        <xsl:value-of select="$title"/>
                        <span>
                            <xsl:attribute name="class">
                                <xsl:text>h1_tags</xsl:text>
                            </xsl:attribute>
                            <xsl:text> &gt;</xsl:text>
                        </span>
                    </h1>
                    <h5>
                        A blog made with XML
                    </h5>
                </header>

                <nav>
                    <ul>
                        <xsl:for-each select="document(/root/@posts)/posts/post">
                            <xsl:variable name="post_title" select="@title"/>
                            <xsl:variable name="filename" select="substring-after(@filename,'/')"/>

                            <!-- JQuery apparently has issues with id's containing periods and commas, so remove them.-->
                            <!-- The generated anchors will have id's of the form: -->
                            <!-- <a id="post_01_anchor"> -->
                                <xsl:variable name="id" select="concat(
                                    translate( 
                                    substring($filename, 0, string-length($filename)-3), '.,','_'),
                                    '_anchor'
                                    )"/>
                                <li>
                                    <a>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="$id"/>
                                        </xsl:attribute>

                                        <!-- adding a tooltip removes the 'title' attribute, so use a different name-->
                                        <xsl:attribute name="my_title">
                                            <xsl:value-of select="$post_title"/>
                                        </xsl:attribute>

                                        <xsl:attribute name="filename">
                                            <xsl:value-of select="$filename"/>
                                        </xsl:attribute>

                                        <xsl:attribute name="href">
                                            <xsl:text>#</xsl:text>
                                        </xsl:attribute>

                                        <xsl:value-of select="$post_title"/>
                                    </a>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </nav>
                    <div id="content">
                    </div>

                    <footer>
                    </footer>
                </div>
        <script type="text/javascript">
            window.onload=init; 
        </script>
        </body>
    </html>

    </xsl:template>
</xsl:stylesheet>
