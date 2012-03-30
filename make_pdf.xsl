<?xml version="1.0" encoding="utf-8"?> 
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"> 
    <xsl:output method="xml" indent="yes"/> 

    <xsl:param name="img_path" select="'img/'"/>

    <!--==========================================-->
    <!--  ROOT                                    -->
    <!--==========================================-->
    <xsl:template match="/"> 
        <fo:root> 
            <fo:layout-master-set> 
                <fo:simple-page-master master-name="A4-portrait" page-height="29.7cm" 
                    page-width="21.0cm" margin="2cm" > 
                    <fo:region-body/> 
                </fo:simple-page-master> 
            </fo:layout-master-set> 

            <fo:page-sequence master-reference="A4-portrait" background-color="#F6F5EE">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select="blog_post"/>
                </fo:flow> 
            </fo:page-sequence> 
        </fo:root> 
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
        <fo:block 
            line-height="22pt"
            font-size="18pt" 
            text-align="left"
            font-family="Yanone Kaffeesatz"
            font-weight="bold"
            font-variant="small-caps">
            <xsl:value-of select="title"/>
        </fo:block>
        <fo:block line-height="18pt" font-size="12pt" text-align="left" font-family="Yanone Kaffeesatz Light">
            <xsl:text>Author: </xsl:text>
            <xsl:value-of select="author/name"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="author/surname"/>
        </fo:block>
        <fo:block line-height="18pt" font-size="12pt" text-align="left" space-after="20pt" font-family="Yanone Kaffeesatz Light">
            <xsl:text>Date: </xsl:text>
            <xsl:value-of select="date"/>
        </fo:block>
    </xsl:template>

    <!--==========================================-->
    <!--  BODY                                    -->
    <!--==========================================-->
    <xsl:template match="body">
        <xsl:for-each select="node()">
            <xsl:choose>
                <xsl:when test="name()='code'">
                    <fo:block line-height="14pt" 
                        font-size="10pt" 
                        text-align="left" 
                        font-family="monospace"
                        linefeed-treatment="preserve"
                        start-indent="0.5in" end-indent="0.5in"
                        border-color="black" border-style="solid" border-width="1px"
                        padding="0.5cm"
                        space-after="18pt"
                        background-color="#EAEAEA">
                        <xsl:value-of select="."/>
                    </fo:block>
                </xsl:when>

                <xsl:when test="name()='img'">
                    <fo:block>
                        <fo:external-graphic>
                            <xsl:attribute name="src">
                                <xsl:value-of select="concat($img_path,substring-after(@src,'/'))"/>
                            </xsl:attribute>
                        </fo:external-graphic>
                    </fo:block>
                </xsl:when>

                <xsl:when test="name()='ul'">
                    <xsl:apply-templates select="."/>
                </xsl:when>

                <xsl:when test="name()='question'">
                    <xsl:text>--skipping question--</xsl:text>
                </xsl:when>

                <xsl:when test="name()='p'">
                    <xsl:apply-templates select="."/>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:text>WARNING: unknown element in body</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            
        </xsl:for-each>
    </xsl:template>

    <!--==========================================-->
    <!--  P                                       -->
    <!--==========================================-->
    <xsl:template match="p">
        <fo:block line-height="16pt" 
            font-size="13pt" 
            font-family="Yanone Kaffeesatz Regular"
            text-align="left"
            space-after="15pt">
            <xsl:for-each select="node()">

                <xsl:choose>
                    
                    <!-- 'em' tags -->
                    <xsl:when test="name() = 'em'">
                        <fo:inline font-style="italic">
                            <xsl:value-of select="."/>
                        </fo:inline>
                    </xsl:when>

                    <!-- 'var' tags -->
                    <xsl:when test="name() = 'var'">
                        <fo:inline
                            font-family="monospaced"
                            background-color="#EAEAEA">
                            <xsl:value-of select="."/>
                        </fo:inline>
                    </xsl:when>

                    <!--  list -->
                    <xsl:when test="name() = 'ul'">
                        <xsl:apply-templates select="."/>
                    </xsl:when>
                    
                    <!--  text -->
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>

                </xsl:choose>

            </xsl:for-each>
        </fo:block>
    </xsl:template>

    <!--==========================================-->
    <!--  LIST                                    -->
    <!--==========================================-->
    <xsl:template match="ul">
        <fo:list-block start-indent="20pt">
            <xsl:for-each select="li">
                <fo:list-item>
                    <fo:list-item-label end-indent="label-end()">
                        <fo:block font-weight="bold">
                            <fo:character character="&#x2022;"/>
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block><xsl:value-of select="."/></fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

</xsl:stylesheet>
