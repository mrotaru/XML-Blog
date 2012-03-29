<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">

    <xsl:variable name="title" select="document(/root/@posts)/posts/title"/>
    <html>
        <head>
            <link rel="stylesheet" href="style.css"/>
            <script src="lib/jquery.js" type="text/javascript"></script>
            <script src="lib/jquery.bgiframe.js" type="text/javascript"></script>
            <script src="lib/jquery.dimensions.js" type="text/javascript"></script>
            <script src="lib/jquery.tooltip.pack.js" type="text/javascript"></script>
            <script src="script.js" type="text/javascript"></script>
            <script>
                window.onload=init(); 
            </script>
            <title>
                <xsl:value-of select="$title"/>
            </title>
        </head>
        <body>
            <header>
                <h1>
                    <xsl:value-of select="$title"/>
                </h1>
            </header>

            <div id="container">
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

                                    <xsl:attribute name="href">
                                        <xsl:value-of select="$filename"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$post_title"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </nav>
                <div id="content">
                </div>
            </div>

            <footer>
            </footer>
        </body>
    </html>

    </xsl:template>
</xsl:stylesheet>
