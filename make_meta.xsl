<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"/>

<xsl:template match="blog_post">
    <xsl:copy-of select="./head"/>
</xsl:template>

</xsl:stylesheet>
