<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml"/>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="post">
        <xsl:copy>
            <xsl:apply-templates  select="node()|@*"/>
            <xsl:attribute name="title">
                <xsl:value-of select="document(@filename)/blog_post/head/title" />
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
