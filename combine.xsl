<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="transform.xsl"/>
<xsl:output method="html"/>

<xsl:template match="/">
    <html>
        <title><xsl:value-of select="/posts/title"/></title>
        <xsl:for-each select="/posts/post">
            <xsl:apply-templates
                select="document(@filename)/blog_post"/>
        </xsl:for-each>
    </html>
</xsl:template>

</xsl:stylesheet>
