<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">

    <xsl:variable name="title" select="document(/root/@posts)/posts/title"/>
    <html>
        <head>
            <link rel="stylesheet" href="style.css"/>
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
                            <xsl:variable name="filename" select="@filename"/>
                            <a>
                                <li>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="$filename"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$post_title"/>
                                </li>
                            </a>
                        </xsl:for-each>
                    </ul>
                </nav>
            </div>

            <footer>
            </footer>
        </body>
    </html>

    </xsl:template>
</xsl:stylesheet>
