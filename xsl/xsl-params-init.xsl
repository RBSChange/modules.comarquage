<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" cdata-section-elements="script" indent="yes"/>
  <xsl:param name="HOMEPAGE">/</xsl:param>
  <xsl:param name="CSSBASE">../css</xsl:param>
  <xsl:param name="JSBASE">../js</xsl:param>
  <xsl:param name="LETTRE"></xsl:param>
  <xsl:param name="MOTCLE"></xsl:param>
  <xsl:param name="PREVIEW">no</xsl:param>
  <xsl:param name="MAIL">no</xsl:param>
  <xsl:param name="PRINT">no</xsl:param>
  <xsl:param name="insee"><xsl:value-of select="//Commune/@insee" /></xsl:param>
  <xsl:param name="commune"><xsl:value-of select="//Commune" /></xsl:param>
  <xsl:param name="departement"><xsl:value-of select="//Commune/@dep" /></xsl:param>
  <xsl:param name="typepublication"><xsl:value-of select="/*/Type/Nom" /></xsl:param>
  <xsl:param name="REFERER"></xsl:param>
  <xsl:param name="CACHEPATH"></xsl:param>
  <xsl:param name="ADRESSESLOCALES">no</xsl:param>
  <xsl:param name="IMAGESURL"/>
</xsl:stylesheet>