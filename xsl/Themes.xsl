<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="xsl-params.xsl"/>
  <xsl:include href="footer.xsl"/>
  <xsl:output method="html"/>
  <xsl:template match="/">
    <div id="Comarq">
      <div class="comarq-breadcrumb">
	      <ul>
					<li class="comarq-current">
						<strong>
	          	<xsl:value-of select="Noeud/TitreLong"/>
	          </strong>
	        </li>
	      </ul>
      </div>
      <div class="comarq-themes-container">
    		<ul class="comarq-liste-themes">
        	<xsl:apply-templates select="/Noeud/Descendance/Fils" mode="colonne">
            <xsl:sort select="Noeud/Descendance/Fils/@positionPrésentation" data-type="number" order="ascending"/>
        	</xsl:apply-templates>
        </ul>
			</div>
			<xsl:call-template name="footer"/>
		</div>
	</xsl:template>
  <xsl:template match="Fils" mode="colonne">
    <li>
      <a>
        <xsl:choose>
          <xsl:when test="@nature='Noeud'">
            <xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="@lien"/><xsl:text>.xml</xsl:text>&#x26;xsl=Noeud.xsl</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="@lien"/><xsl:text>.xml</xsl:text>&#x26;xsl=Fiche.xsl</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="TitreContextuel"/>
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>
