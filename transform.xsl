<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:strip-space elements="*"/>
<!--<xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes"/>-->
<xsl:output method="html" encoding="utf-8" indent="yes"/>

    <!--==========================================-->
    <!--  MAIN                                    -->
    <!--==========================================-->
    <xsl:template match="/">
        <html>
        <xsl:apply-templates select="blog_post"/>
        </html>
    </xsl:template>

    <!--==========================================-->
    <!--  BLOG POST                               -->
    <!--==========================================-->
    <xsl:template match="blog_post">
        <xsl:apply-templates select="head"/>
        <xsl:apply-templates select="body"/>
    </xsl:template>

    <!--==========================================-->
    <!--  HEAD                                    -->
    <!--==========================================-->
    <xsl:template match="head">
        <head>
            <title><xsl:value-of select="title"/></title>
            <link rel="stylesheet" type="text/css" href="style.css" />
        </head>
    </xsl:template>

    <!--==========================================-->
    <!--  BODY                                    -->
    <!--==========================================-->
    <xsl:template match="body">
        <body>
            <div id="container">
                <div id="content">
                    <h1>
                        <xsl:value-of select="../head/title"/>
                    </h1>
                    <hr/>
                    <xsl:apply-templates select="question"/>
                    <xsl:apply-templates select="p"/>
                </div>
            </div>
        </body>
    </xsl:template>

    <!--==========================================-->
    <!--  QUESTION                                -->
    <!--==========================================-->
    <xsl:template match="question">
        <p>
            <xsl:value-of select="body"/>
        </p>
        <p>
            <xsl:value-of select="answer"/>
        </p>
        <hr/>
    </xsl:template> 

    <!--==========================================-->
    <!--  P                                       -->
    <!--==========================================-->
    <xsl:template match="p">
        <p>
            <xsl:for-each select="node()">

                <xsl:choose>
                    
                    <!-- 'em' tags-->
                    <xsl:when test="name() = 'em'">
                        <em><xsl:value-of select="."/></em>
                    </xsl:when>
                    
                    <!--  text-->
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>

                </xsl:choose>

            </xsl:for-each>
        </p>
    </xsl:template>

    <!--==========================================-->
    <!--  em                                      -->
    <!--==========================================-->
    <xsl:template match="em">
        <em><xsl:value-of select="."/></em>
    </xsl:template>


</xsl:stylesheet>
