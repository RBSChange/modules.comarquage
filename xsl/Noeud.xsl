<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="xsl-params.xsl"/>
  <xsl:include href="header.xsl"/>
  <xsl:include href="footer.xsl"/>
  <xsl:include href="Publication.xsl"/>
  <xsl:include href="RessourcesRattachees.xsl"/>
  <xsl:include href="RessourceRattachee.xsl"/>
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <div id="Comarq">
    	<xsl:call-template name="header"/>
      <div class="comarq-droit-demarches">
        <h2 class="comarq-title">VOS DROITS ET DÉMARCHES :
          <xsl:choose>
          	<xsl:when test="/Noeud/Navigation/*[1]">
            	<xsl:value-of select="/Noeud/Navigation/*[1]"/>
            </xsl:when>
            <xsl:when test="//ListeRacines/RacinePréf">
              <xsl:apply-templates select="//ListeRacines/RacinePréf" mode="Noeud"/>
            </xsl:when>
            <xsl:when test="/Noeud/CheminPréf/*[1]">
              <xsl:value-of select="/Noeud/CheminPréf/*[1]"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="//TitreLong"/>
            </xsl:otherwise>
          </xsl:choose>
        </h2>
        <ul>
          <li>
          	<xsl:apply-templates select="Noeud/TitreLong" mode="Noeud"/>
	          <xsl:apply-templates select="Noeud/RessourcesRattachées/RessourceRattachée[@type='Avertissement']" mode="Ressource_Avertissement"/>
  	        <ul>
    	      	<xsl:apply-templates select="Noeud/Descendance/Fils[@type!='Fiche Question-réponse']" mode="Noeud_VD">
      	      	<xsl:sort select="@positionPrésentation" data-type="number" order="ascending"/>
           		</xsl:apply-templates>
        		</ul>
        	</li>
        </ul>
      </div>
      <div class="comarq-questions-reponses">
      	<xsl:apply-templates select="Noeud/Descendance" mode="Noeud_QR">
        	<xsl:sort select="Fils/@positionPrésentation" data-type="number" order="ascending"/>
       	</xsl:apply-templates>
      </div>
      <xsl:apply-templates select="Noeud/RessourcesRattachées" mode="OrganismesLies"/>
      <xsl:apply-templates select="Noeud/RessourcesRattachées/RessourceRattachée[@type='Lettre type']" mode="Ressource_Lettre_type"/>
      <!-- Deuxième colonne : renvois -->
      <xsl:apply-templates select="Noeud/RessourcesRattachées" mode="RessourcesRattachees"/>
	    <!-- Deuxieme ligne : Fonctionnalité de recherche par mots-clés-->
      <xsl:apply-templates select="Noeud/DateValidité"/>
      <xsl:call-template name="footer"/>
    </div>
  </xsl:template>
  <!-- TitreLong pour Noeud-->
  <xsl:template match="TitreLong" mode="Noeud">
    <xsl:choose>
      <xsl:when test="//Navigation">
        <a>
          <xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="/Noeud/Navigation/*[last()]/@href"/><xsl:text>.xml&#x26;xsl=Noeud.xsl</xsl:text><xsl:call-template name="navigationparams"><xsl:with-param name="pos" select="count(/Noeud/Navigation/*)"/></xsl:call-template></xsl:attribute>
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a>
          <xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="/Noeud/CheminPréf/*[last()]/@ID"/><xsl:text>.xml&#x26;xsl=Noeud.xsl</xsl:text></xsl:attribute>
          <xsl:value-of select="."/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- Fils -->
  <xsl:template match="Fils" mode="Noeud_VD">
		<li>
      <a>
        <xsl:choose>
          <xsl:when test="@nature='Noeud'">
            <xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="@lien"/><xsl:text>.xml&#x26;xsl=Noeud.xsl</xsl:text><xsl:call-template name="parametres"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="@lien"/><xsl:text>.xml&#x26;xsl=Fiche.xsl</xsl:text><xsl:call-template name="parametres"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="TitreContextuel"/>
      </a>
    </li>
  </xsl:template>
  <!-- FichesLiées QR -->
  <xsl:template match="Descendance" mode="Noeud_QR">
    <xsl:if test="Fils[@type='Fiche Question-réponse']">
      <h2 class="comarq-title">Questions-réponses</h2>
      <ul>
        <xsl:apply-templates select="Fils[@type='Fiche Question-réponse']" mode="Noeud_QR"/>
      </ul>
    </xsl:if>
  </xsl:template>
  <!-- LienFiche QR-->
  <xsl:template match="Fils" mode="Noeud_QR">
  	<li>
      <a>
        <xsl:choose>
          <xsl:when test="@nature='Noeud'">
            <xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="@lien"/><xsl:text>.xml&#x26;xsl=Noeud.xsl</xsl:text><xsl:call-template name="parametres"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="@lien"/><xsl:text>.xml&#x26;xsl=Fiche.xsl</xsl:text><xsl:call-template name="parametres"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="TitreContextuel"/>
      </a>
    </li>
  </xsl:template>
  <xsl:template match="ListeRacines/RacinePréf" mode="Noeud">
    <xsl:variable name="theme">
      <xsl:value-of select="$CACHEPATH"/>
      <xsl:value-of select="."/>
      <xsl:text>.xml</xsl:text>
    </xsl:variable>
    <xsl:value-of select="document($theme)/Noeud/TitreLong"/>
  </xsl:template>
  <xsl:template match="Commune">
    <xsl:value-of select="."/>
  </xsl:template>
</xsl:stylesheet>
