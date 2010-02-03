<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="xsl-params.xsl"/>
<xsl:output method="html" encoding="UTF-8" cdata-section-elements="script" indent="yes"/>
  <!-- RessourcesRattachées -->
  <xsl:template match="RessourcesRattachées" mode="RessourcesRattachees">
    <xsl:comment><xsl:value-of select="RessourceRattachée/@lien"/></xsl:comment>
    <xsl:if test="count(RessourceRattachée[@type='Définition de glossaire'])>0">
      <div class="comarq-bloc comarq-bleu-pastel">
      	<h2 class="comarq-bloc-entete comarq-bleu-pastel">Définitions</h2>
        <xsl:apply-templates select="RessourceRattachée[@type='Définition de glossaire']" mode="Ressource_Definition_glossaire">
         <xsl:sort select="@positionPrésentation" data-type="number" order="ascending"/>
        </xsl:apply-templates>
      </div>
    </xsl:if>
    <xsl:if test="count(RessourceRattachée[@type='Site Web'])>0">
      <div class="comarq-bloc comarq-jaune">
        <h2 class="comarq-bloc-entete comarq-jaune">Pour en savoir plus</h2>
        <h3 class="comarq-subtitle">Sites internet publics</h3>
        <ul>
        	<xsl:apply-templates select="RessourceRattachée[@type='Site Web']" mode="Ressource_Web">
        		<xsl:sort select="@positionPrésentation" data-type="number" order="ascending"/>
        	</xsl:apply-templates>
       	</ul>
      </div>
    </xsl:if>
    <xsl:if test="count(RessourceRattachée[@type='Téléservice'])>0">
      <div class="comarq-bloc comarq-bleu">
      	<h2 class="comarq-bloc-entete comarq-bleu">Démarches en ligne</h2>
        <ul>
					<xsl:apply-templates select="RessourceRattachée[@type='Téléservice']" mode="Ressource_Teleservice">
          	<xsl:sort select="@positionPrésentation" data-type="number" order="ascending"/>
          </xsl:apply-templates>
        </ul>
      </div>
    </xsl:if>
    <xsl:if test="count(RessourceRattachée[@type='Formulaire'])>0">
      <div class="comarq-bloc comarq-bleu">
      	<h2 class="comarq-bloc-entete comarq-bleu">Formulaires</h2>
        <ul>
          <xsl:apply-templates select="RessourceRattachée[@type='Formulaire']" mode="Ressource_Formulaire">
            <xsl:sort select="@positionPrésentation" data-type="number" order="ascending"/>
          </xsl:apply-templates>
      	</ul>
      </div>
    </xsl:if>
    <xsl:if test="count(RessourceRattachée[@type='Texte de référence'])>0">
      <div class="comarq-bloc comarq-bleu">
      	<h2 class="comarq-bloc-entete comarq-bleu">Textes de référence</h2>
        <ul>
          <xsl:apply-templates select="RessourceRattachée[@type='Texte de référence']" mode="Ressource_Texte_Reference">
            <xsl:sort select="@positionPrésentation" data-type="number" order="ascending"/>
          </xsl:apply-templates>
        </ul>
      </div>
   </xsl:if>
  </xsl:template>
  <xsl:template match="RessourcesRattachées" mode="OrganismesLies">
    <xsl:if test="count(RessourceRattachée[@type='Organisme national'])>0 or count(RessourceRattachée[@type='Organisme local Web'])>0 or count(RessourceRattachée[@type='Organisme local SPL'])>0">
      <xsl:if test="count(RessourceRattachée[starts-with(@type, 'Organisme') and contains(@typologieDémarche, 'démarche')])>0">
        <p class="comarq-block">
        	<strong>Pour accomplir la démarche, les coordonnées utiles : </strong>
        </p>
        <xsl:apply-templates select="RessourceRattachée[starts-with(@type, 'Organisme') and contains(@typologieDémarche, 'démarche') and not(boolean(CommentaireDiffusion))]" mode="Ressource_Organismes">
          <xsl:sort select="@type" order="descending"/>
          <xsl:sort select="@positionPrésentation" data-type="number" order="ascending"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="RessourceRattachée[starts-with(@type, 'Organisme') and contains(@typologieDémarche, 'démarche') and boolean(CommentaireDiffusion)]" mode="Ressource_Organismes">
          <xsl:sort select="@type" order="descending"/>
          <xsl:sort select="@positionPrésentation" data-type="number" order="ascending"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:if test="count(RessourceRattachée[starts-with(@type, 'Organisme') and contains(@typologieDémarche, 'informer')])>0">
        <p class="comarq-block">
        	<strong>Pour plus d'information, les services à contacter : </strong>
        </p>
        <xsl:apply-templates select="RessourceRattachée[starts-with(@type, 'Organisme') and contains(@typologieDémarche, 'informer') and not(boolean(CommentaireDiffusion))]" mode="Ressource_Organismes">
          <xsl:sort select="@type" order="descending"/>
          <xsl:sort select="@positionPrésentation" data-type="number" order="ascending"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="RessourceRattachée[starts-with(@type, 'Organisme') and contains(@typologieDémarche, 'informer') and boolean(CommentaireDiffusion)]" mode="Ressource_Organismes">
          <xsl:sort select="@type" order="descending"/>
          <xsl:sort select="@positionPrésentation" data-type="number" order="ascending"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:if test="count(RessourceRattachée[starts-with(@type, 'Organisme') and not(boolean(@typologieDémarche))])>0">
	      <xsl:if test="count(RessourceRattachée[starts-with(@type, 'Organisme') and contains(@typologieDémarche, 'informer')])=0">
	        <p class="comarq-block">
	    			<strong>Pour plus d'information, les services à contacter : </strong>
	    		</p>
	      </xsl:if>
	    	<xsl:apply-templates select="RessourceRattachée[starts-with(@type, 'Organisme') and not(boolean(@typologieDémarche)) and not(boolean(CommentaireDiffusion))]" mode="Ressource_Organismes">
	        <xsl:sort select="@type" order="descending"/>
	        <xsl:sort select="@positionPrésentation" data-type="number" order="ascending"/>
	      </xsl:apply-templates>
	      <xsl:apply-templates select="RessourceRattachée[starts-with(@type, 'Organisme') and not(boolean(@typologieDémarche)) and boolean(CommentaireDiffusion)]" mode="Ressource_Organismes">
	        <xsl:sort select="@type" order="descending"/>
	        <xsl:sort select="@positionPrésentation" data-type="number" order="ascending"/>
	      </xsl:apply-templates>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <!-- RessourceRattachée-->
  <xsl:template match="RessourceRattachée" mode="Ressource_Avertissement">
    <xsl:variable name="lien">
      <xsl:value-of select="$CACHEPATH"/>
      <xsl:value-of select="@lien"/>
      <xsl:text>.xml</xsl:text>
    </xsl:variable>
    <xsl:apply-templates select="document($lien)/Ressource" mode="Ressource_Avertissement"/>
  </xsl:template>
  <!-- RessourceRattachée-->
  <xsl:template match="RessourceRattachée" mode="Ressource_Web">
    <xsl:variable name="lien">
      <xsl:value-of select="$CACHEPATH"/>
      <xsl:value-of select="@lien"/>
      <xsl:text>.xml</xsl:text>
    </xsl:variable>
    <xsl:apply-templates select="document($lien)/Ressource" mode="Ressource_Web"/>
  </xsl:template>
  <!-- RessourceRattachée-->
  <xsl:template match="RessourceRattachée" mode="Ressource_Teleservice">
    <xsl:variable name="lien">
      <xsl:value-of select="$CACHEPATH"/>
      <xsl:value-of select="@lien"/>
      <xsl:text>.xml</xsl:text>
    </xsl:variable>
    <xsl:apply-templates select="document($lien)/Ressource" mode="Ressource_Teleservice"/>
  </xsl:template>
  <!-- RessourceRattachée-->
  <xsl:template match="RessourceRattachée" mode="Ressource_Formulaire">
    <xsl:variable name="lien">
      <xsl:value-of select="$CACHEPATH"/>
      <xsl:value-of select="@lien"/>
      <xsl:text>.xml</xsl:text>
    </xsl:variable>
    <xsl:apply-templates select="document($lien)/Ressource" mode="Ressource_Formulaire"/>
  </xsl:template>
  <!-- RessourceRattachée-->
  <xsl:template match="RessourceRattachée" mode="Ressource_Texte_Reference">
    <xsl:variable name="lien">
      <xsl:value-of select="$CACHEPATH"/>
      <xsl:value-of select="@lien"/>
      <xsl:text>.xml</xsl:text>
    </xsl:variable>
    <xsl:apply-templates select="document($lien)/Ressource" mode="Ressource_Texte_Reference"/>
  </xsl:template>
  <!-- RessourceRattachée-->
  <xsl:template match="RessourceRattachée" mode="Ressource_Organismes">
    <xsl:variable name="lien">
      <xsl:value-of select="$CACHEPATH"/>
      <xsl:value-of select="@lien"/>
      <xsl:text>.xml</xsl:text>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="@type='Organisme local SPL'">
      	<p class="comarq-block comarq-bleu">
	        <xsl:apply-templates select="document($lien)/Ressource" mode="Ressource_Organisme_local_SPL">
	          <xsl:with-param name="commentaire" select="CommentaireDiffusion"></xsl:with-param>
	        </xsl:apply-templates>
        </p>
      </xsl:when>
      <xsl:when test="@type='Organisme local Web'">
      	<p class="comarq-block comarq-bleu">
	        <xsl:apply-templates select="document($lien)/Ressource" mode="Ressource_Organisme_local_Web">
	          <xsl:with-param name="commentaire" select="CommentaireDiffusion"></xsl:with-param>
	        </xsl:apply-templates>
        </p>
      </xsl:when>
      <xsl:when test="@type='Organisme national'">
        <xsl:apply-templates select="document($lien)/Ressource" mode="Ressource_Organisme_national">
          <xsl:with-param name="commentaire" select="CommentaireDiffusion"></xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="document($lien)/Ressource" mode="Ressource">
          <xsl:with-param name="commentaire" select="CommentaireDiffusion"></xsl:with-param>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- RessourceRattachée-->
  <xsl:template match="RessourceRattachée" mode="Ressource_Lettre_type">
    <xsl:variable name="lien">
      <xsl:value-of select="$CACHEPATH"/>
      <xsl:value-of select="@lien"/>
      <xsl:text>.xml</xsl:text>
    </xsl:variable>
    <div class="comarq-bloc comarq-jaune-pastel">
      <h2 class="comarq-bloc-entete comarq-jaune-pastel">
				<xsl:value-of select="@type"/>
      </h2>
      <ul>
      	<xsl:apply-templates select="document($lien)/Ressource" mode="Ressource_Lettre_type"/>
      </ul>
    </div>
  </xsl:template>
  <!-- RessourceRattachée-->
  <xsl:template match="RessourceRattachée" mode="Ressource_Definition_glossaire">
    <xsl:variable name="lien">
      <xsl:value-of select="$CACHEPATH"/>
      <xsl:value-of select="@lien"/>
      <xsl:text>.xml</xsl:text>
    </xsl:variable>
   	<xsl:apply-templates select="document($lien)/Ressource" mode="Ressource"/>
  </xsl:template>
  <!-- RessourceRattachée-->
  <xsl:template match="RessourceRattachée" mode="Ressource">
    <xsl:variable name="lien">
      <xsl:value-of select="$CACHEPATH"/>
      <xsl:value-of select="@lien"/>
      <xsl:text>.xml</xsl:text>
    </xsl:variable>
    <xsl:apply-templates select="document($lien)/Ressource" mode="Ressource"/>
  </xsl:template>
  <!-- RessourceRattachée-->
  <xsl:template match="RessourceRattachée" mode="Fiche">
    <xsl:variable name="lien">
      <xsl:value-of select="$CACHEPATH"/>
      <xsl:value-of select="@lien"/>
      <xsl:text>.xml</xsl:text>
    </xsl:variable>
    <h4 class="comarq-bloc-entete comarq-jaune-pastel">
      <xsl:value-of select="@type"/>
    </h4>
    <xsl:apply-templates select="document($lien)/Ressource/Texte" mode="Fiche"/>
  </xsl:template>
</xsl:stylesheet>