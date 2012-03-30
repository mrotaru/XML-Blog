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
        <xsl:apply-templates select="blog_post/body"/>
    </xsl:template>

    <!--==========================================-->
    <!--  BODY                                    -->
    <!--==========================================-->
    <xsl:template match="body">
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
        <p class="answer">
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

                    <!-- 'var' tags -->
                    <xsl:when test="name() = 'var'">
                        <var><xsl:value-of select="."/></var>
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
