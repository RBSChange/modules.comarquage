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
      	<a name="DebutGroupe"></a>
        <h2 class="comarq-title">VOS DROITS ET DÉMARCHES :
           <xsl:choose>
              <xsl:when test="/Fiche/Navigation/*[1]">
                <xsl:value-of select="/Fiche/Navigation/*[1]"/>
              </xsl:when>
              <xsl:when test="//ListeRacines/RacinePréf">
                <xsl:apply-templates select="//ListeRacines/RacinePréf" mode="Noeud"/>
              </xsl:when>
              <xsl:when test="/Fiche/CheminPréf/*[1]">
                <xsl:value-of select="/Fiche/CheminPréf/*[1]"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="//TitreLong"/>
              </xsl:otherwise>
            </xsl:choose>
          </h2>
				</div>
        <xsl:choose>
          <xsl:when test="contains(Fiche/Type/Nom, 'actualité')">
            <xsl:apply-templates select="Fiche/TitreLong" mode="Fiche"/>
            <xsl:apply-templates select="Fiche/RessourcesRattachées/RessourceRattachée[@type='Avertissement']" mode="Ressource_Avertissement"/>
            <xsl:apply-templates select="Fiche/Texte" mode="Fiche_Actualite"/>
          </xsl:when>
          <xsl:when test="contains(Fiche/Type/Nom, 'sommaire')">
            <xsl:apply-templates select="Fiche/TitreLong" mode="Fiche"/>
            <xsl:apply-templates select="Fiche/RessourcesRattachées/RessourceRattachée[@type='Avertissement']" mode="Ressource_Avertissement"/>
            <ul>
              <xsl:apply-templates select="Fiche/Texte/Chapitre/Titre" mode="Sommaire"/>
            </ul>
            <xsl:apply-templates select="Fiche/Texte" mode="Fiche"/>
          </xsl:when>
          <xsl:when test="contains(Fiche/Type/Nom, 'Question-réponse')">
            <xsl:apply-templates select="Fiche/TitreLong" mode="FicheQR"/>
            <xsl:apply-templates select="Fiche/RessourcesRattachées/RessourceRattachée[@type='Avertissement']" mode="Ressource_Avertissement"/>
            <xsl:apply-templates select="Fiche/Texte" mode="Fiche"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="Fiche/TitreLong" mode="Fiche"/>
            <xsl:apply-templates select="Fiche/RessourcesRattachées/RessourceRattachée[@type='Avertissement']" mode="Ressource_Avertissement"/>
            <xsl:apply-templates select="Fiche/Texte" mode="Fiche"/>
          </xsl:otherwise>
        </xsl:choose>
      <xsl:apply-templates select="Fiche/RessourcesRattachées" mode="OrganismesLies"/>
      <xsl:apply-templates select="Fiche/RessourcesRattachées/RessourceRattachée[@type='Lettre type']" mode="Ressource_Lettre_type"/>
      <xsl:apply-templates select="Fiche/RessourcesRattachées" mode="RessourcesRattachees"/>
	    <xsl:apply-templates select="Fiche/DateValidité"/>
	    <xsl:call-template name="footer"/>
	  </div>
  </xsl:template>
  <!-- Sommaire -->
  <xsl:template match="Titre" mode="Sommaire">
    <li>
    	<a>
      	<xsl:attribute name="href"><xsl:text>#titre</xsl:text><xsl:value-of select="generate-id()"/></xsl:attribute>
        <xsl:apply-templates mode="Sommaire"/>
      </a>
    </li>
  </xsl:template>
  <xsl:template match="Paragraphe" mode="Sommaire">
    <xsl:apply-templates/>
  </xsl:template>
  <!-- Texte -->
  <xsl:template match="Texte" mode="Fiche_Actualite">
    <p class="comarq-block">
      <xsl:apply-templates  mode="Fiche"/>
    </p>
    <xsl:apply-templates select="/Fiche/FichesLiées" mode="FichesLiees"/>
  </xsl:template>
  <!-- TitreLong pour Fiche-->
  <xsl:template match="TitreLong" mode="Fiche">
    <xsl:choose>
      <xsl:when test="//Navigation">
        <a>
          <xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="/Fiche/Navigation/*[last()]/@href"/><xsl:text>.xml&#x26;xsl=Noeud.xsl</xsl:text><xsl:call-template name="navigationparams"><xsl:with-param name="pos" select="count(/Fiche/Navigation/*)"/></xsl:call-template></xsl:attribute>
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a>
          <xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="/Fiche/CheminPréf/*[last()]/@ID"/><xsl:text>.xml&#x26;xsl=Noeud.xsl</xsl:text></xsl:attribute>
          <xsl:value-of select="."/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- TitreLong pour Fiche QR-->
  <xsl:template match="TitreLong" mode="FicheQR">
		<h2 class="comarq-subtitle comarq-content">
    	<xsl:value-of select="."/>
		</h2>
  </xsl:template>
  <!-- Texte -->
  <xsl:template match="Texte" mode="Fiche">
    <xsl:apply-templates mode="Fiche"/>
    <xsl:apply-templates select="/Fiche/FichesLiées" mode="FichesLiees"/>
  </xsl:template>
  <!-- Chapitre -->
  <xsl:template match="Chapitre" mode="Fiche">
    <xsl:apply-templates mode="Fiche"/>
  </xsl:template>
  <!-- SousChapitre -->
  <xsl:template match="SousChapitre" mode="Fiche">
    <xsl:apply-templates mode="Fiche"/>
  </xsl:template>
  <!-- Titre de Chapitre-->
  <xsl:template match="Chapitre/Titre" mode="Fiche">
    <a>
      <xsl:attribute name="name"><xsl:text>titre</xsl:text><xsl:value-of select="generate-id()"/></xsl:attribute>
    </a>
    <h3 class="comarq-subtitle comarq-content">
    	<xsl:apply-templates/>
    	<xsl:if test="contains(/Fiche/Type/Nom, 'sommaire')">
    		<span class="comarq-haut-de-page">
       		[<a href="#DebutGroupe">Haut de la page</a>]
        </span>
    	</xsl:if>
    </h3>
  </xsl:template>
  <!-- Titre de SousChapitre -->
  <xsl:template match="SousChapitre/Titre" mode="Fiche">
    <h4 class="comarq-subtitle comarq-content">
      <xsl:apply-templates/>
    </h4>
  </xsl:template>
  <!-- Paragraphe -->
  <xsl:template match="Paragraphe" mode="Fiche">
    <p class="comarq-block">
  		<xsl:apply-templates/>
  	</p>
  </xsl:template>
  <!-- Liste -->
  <xsl:template match="Liste" mode="Fiche">
    <ul>
      <xsl:apply-templates mode="Fiche"/>
    </ul>
  </xsl:template>
  <!-- Item -->
  <xsl:template match="Item" mode="Fiche">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  <xsl:template match="Tableau" mode="Fiche">
    <table class="comarq-table" summary="" cellpadding="0" cellspacing="0">
    	<tbody>
        <xsl:apply-templates mode="Fiche"/>
   	 	</tbody>
    </table>
  </xsl:template>
  <!-- Rangée -->
  <xsl:template match="Rangée" mode="Fiche">
    <tr>
      <xsl:apply-templates mode="Fiche"/>
    </tr>
  </xsl:template>
  <!-- Cellule -->
  <xsl:template match="Cellule" mode="Fiche">
    <xsl:choose>
      <xsl:when test="../@type='header'">
        <th>
          <xsl:apply-templates/>
        </th>
      </xsl:when>
      <xsl:otherwise>
        <td>
          <xsl:apply-templates/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- FichesLiées-->
  <xsl:template match="FichesLiées" mode="FichesLiees">
    <h4 class="comarq-subtitle comarq-content">
      <strong>Voir aussi :</strong>
    </h4>
    <ul>
    	<xsl:apply-templates mode="FichesLiees"/>
    </ul>
 	</xsl:template>
 	<xsl:template match="LienFiche" mode="FichesLiees">
 		<li>
  		<a>
    		<xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="@lien"/><xsl:text>.xml&#x26;xsl=Fiche.xsl</xsl:text></xsl:attribute>
      	<xsl:value-of select="Titre"/>
    	</a>
    </li>
 	</xsl:template>
</xsl:stylesheet>
