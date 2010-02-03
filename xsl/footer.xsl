<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" cdata-section-elements="script" indent="yes"/>
  <xsl:template name="footer">
    <p class="comarq-footer">© <!-- preserve space -->
	    <xsl:choose>
	      <xsl:when test="//Coproducteur">
	        <xsl:value-of select="//Coproducteur"/>
	      </xsl:when>
	      <xsl:otherwise>
	        La Documentation française / CIRA
	      </xsl:otherwise>
	    </xsl:choose>
    </p>
    <xsl:if test="contains(/Fiche/Type/Nom, 'Question-réponse')">
	  	<h5 class="comarq-subtitle comarq-content">Les informations fournies dans cette fiche ne sauraient préjuger de l'examen individuel de votre situation par l'administration compétente.</h5>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
