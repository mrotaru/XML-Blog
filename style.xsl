<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">

    <html>
        <head>
            <title>
                <xsl:value-of select="document(/root/@posts)/posts/title"/>
            </title>
        </head>
        <body>
            <h1>
                <xsl:value-of select="document(/root/@posts)/posts/title"/>
            </h1>
            <ul>
                <xsl:for-each select="document(/root/@posts)/posts/post">
                    <li>
                        <xsl:value-of select="@title"/>
                    </li>
                </xsl:for-each>
            </ul>
        </body>
    </html>

    </xsl:template>
</xsl:stylesheet>
