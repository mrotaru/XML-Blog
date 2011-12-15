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
                    
                    <xsl:for-each select="node()">
                        
                        <xsl:choose>
                            <xsl:when test="name()='code'">
                                <pre>
                                    <xsl:value-of select="."/>
                                </pre>
                            </xsl:when>
                            
                            <xsl:when test="name()='img'">
                                <xsl:copy-of select="." />
                            </xsl:when>
                            
                            <xsl:when test="name()='ul'">
                                <xsl:copy-of select="." />
                            </xsl:when>
                            
                            <xsl:when test="name()='question'">
                                <xsl:apply-templates select="."/>
                            </xsl:when>
                            
                            <xsl:when test="name()='p'">
                                <xsl:apply-templates select="."/>
                            </xsl:when>
                            
                            <xsl:otherwise>
                                <xsl:value-of select="."/>
                            </xsl:otherwise>
                        </xsl:choose>

                    </xsl:for-each>

                </div>
            </div>
        </body>
    </xsl:template>

    <!--==========================================-->
    <!--  QUESTION                                -->
    <!--==========================================-->
    <xsl:template match="question">
        <p>
            <xsl:value-of select="body/text()"/>
            <xsl:text> [ </xsl:text>
            <xsl:value-of select="selectedanswer"/>
            <xsl:text> ] </xsl:text>
        </p>
        <xsl:apply-templates select="body/code"/>
        <xsl:apply-templates select="options"/>
        <p>
            <xsl:value-of select="answer"/>
        </p>
        <hr/>
    </xsl:template> 

    <!--==========================================-->
    <!--  code                                    -->
    <!--==========================================-->
    <xsl:template match="body/code">
        <pre>
            <xsl:value-of select="."/>
        </pre>
    </xsl:template>

    <!--==========================================-->
    <!--  options                                 -->
    <!--==========================================-->
    <xsl:template match="options">
        <ul>
            <xsl:for-each select="./option">
                <li>
                    <xsl:number format="a. " />
                    <xsl:value-of select="."/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>    


    <!--==========================================-->
    <!--  P                                       -->
    <!--==========================================-->
    <xsl:template match="p">
        <p>
            <xsl:for-each select="node()">

                <xsl:choose>
                    
                    <!-- 'em' tags -->
                    <xsl:when test="name() = 'em'">
                        <em><xsl:value-of select="."/></em>
                    </xsl:when>

                    <!--  list -->
                    <xsl:when test="name() = 'ul'">
                        <xsl:copy-of select="." />
                    </xsl:when>
                    
                    <!--  text -->
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
