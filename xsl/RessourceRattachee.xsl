<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="xsl-params.xsl"/>
<xsl:output method="html" encoding="UTF-8" cdata-section-elements="script" indent="yes"/>
  <!-- Ressource-->
  <xsl:template match="Ressource" mode="Ressource_Avertissement">
    <div class="comarq-block comarq-gris">
    	<h2 class="comarq-title">
      	<xsl:value-of select="TitreLong"/>
      </h2>
     	<xsl:apply-templates select="Texte/Chapitre" mode="Ressource_Avertissement"/>
		</div>
  </xsl:template>
  <!-- Ressource-->
  <xsl:template match="Ressource" mode="Ressource_Organisme_local_SPL">
    <xsl:param name="commentaire"/>
    <xsl:apply-templates select="LienWeb" mode="Ressource"/>
    <xsl:choose>
      <xsl:when test="IDExterne1 and $ADRESSESLOCALES = 'yes'">
        <xsl:apply-templates select="IDExterne1" mode="Ressource_Organisme_local_Web">
          <xsl:with-param name="commentaire" select="$commentaire"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="AppelApplication" mode="Ressource_Organisme_local_Web">
          <xsl:with-param name="commentaire" select="$commentaire"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="//Description">
    	<xsl:value-of select="//Description" />
    </xsl:if>
  </xsl:template>
  <!-- Ressource-->
  <xsl:template match="Ressource" mode="Ressource_Organisme_local_Web">
    <xsl:param name="commentaire"/>
    <xsl:apply-templates select="LienWeb" mode="Ressource"/>
    <xsl:choose>
      <xsl:when test="IDExterne1 and $ADRESSESLOCALES = 'yes'">
        <xsl:apply-templates select="IDExterne1" mode="Ressource_Organisme_local_Web">
          <xsl:with-param name="commentaire" select="$commentaire"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="AppelApplication" mode="Ressource_Organisme_local_Web">
          <xsl:with-param name="commentaire" select="$commentaire"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="//Description">
	    <xsl:value-of select="//Description" />
    </xsl:if>
  </xsl:template>
  <!-- Ressource-->
  <xsl:template match="Ressource" mode="Ressource_Organisme_national">
    <div class="comarq-block comarq-bleu">
      Cet organisme est compétent pour toute la France :
      <p>
        <strong>
          <xsl:value-of select="TitreLong"/>
        </strong>
        <xsl:if test="$commentaire">
          <xsl:text> (</xsl:text>
          <xsl:value-of select="$commentaire"/>
					<xsl:text>)</xsl:text>
        </xsl:if>
    	</p>
    	<xsl:apply-templates select="Texte" mode="Ressource"/>
	    <xsl:choose>
	      <xsl:when test="EditeurSource">
	      	<xsl:value-of select="EditeurSource"/>
	      </xsl:when>
	      <xsl:otherwise>
        	service-public.fr - adresses nationales
	      </xsl:otherwise>
	    </xsl:choose>
	  </div>
  </xsl:template>
  <!-- Ressource-->
  <xsl:template match="Ressource" mode="Ressource_Web">
  	<li>
    	<xsl:apply-templates select="LienWeb" mode="Ressource"/>
    </li>
  	<xsl:call-template name="source"/>
  </xsl:template>
  <!-- Ressource-->
  <xsl:template match="Ressource" mode="Ressource_Teleservice">
  	<li>
    	<xsl:apply-templates select="LienWeb" mode="Ressource"/>
    </li>
    <xsl:if test="IDExterne1">
	   	<xsl:apply-templates select="IDExterne1" mode="Ressource_Teleservice_Formulaire"/>
    </xsl:if>
    <xsl:call-template name="source"/>
  </xsl:template>
  <!-- Ressource-->
  <xsl:template match="Ressource" mode="Ressource_Formulaire">
  	<li>
    	<xsl:apply-templates select="LienWeb" mode="Ressource"/>
    </li>
    <xsl:if test="IDExterne1">
    	<xsl:apply-templates select="IDExterne1" mode="Ressource_Teleservice_Formulaire"/>
    </xsl:if>
    <xsl:call-template name="source"/>
  </xsl:template>
  <!-- Ressource-->
  <xsl:template match="Ressource" mode="Ressource_Texte_Reference">
    <xsl:if test="not(contains($typepublication, 'Question-réponse')) and not(contains($typepublication, 'Noeud')) and count(LienWeb) > 1">
    	<xsl:apply-templates select="//TitreLong" mode="Ressource" />
    	<xsl:apply-templates select="//Paragraphe" mode="Ressource_Lettre_type"/>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="Texte/Chapitre/Paragraphe or Texte/Chapitre/SousChapitre/Paragraphe">
       	<xsl:apply-templates select="Texte/Chapitre/Paragraphe | Texte/Chapitre/SousChapitre/Paragraphe" mode="Ressource_Texte_Reference"/>
      </xsl:when>
      <xsl:otherwise>
      	<li>
        	<xsl:apply-templates select="LienWeb" mode="Ressource"/>
        </li>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="source"/>
  </xsl:template>
  <!-- Ressource-->
  <xsl:template match="Ressource" mode="Ressource_Lettre_type">
    <li>
    	<strong><xsl:value-of select="TitreLong"/></strong>
    </li>
    <xsl:apply-templates select="//Paragraphe" mode="Ressource_Lettre_type"/>
  </xsl:template>
  <!-- Ressource-->
  <xsl:template match="Ressource" mode="Ressource_Definition_glossaire">
    <xsl:if test="Type/Nom ='Définition de glossaire'">
      <xsl:apply-templates mode="Ressource"/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="Ressource" mode="RessourceInterne">
    <xsl:param name="libelle"/>
    <a target="_blank">
    	<xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="@ID"/><xsl:text>.xml&#x26;xsl=Ressource.xsl</xsl:text></xsl:attribute>
    	<xsl:attribute name="title"><xsl:value-of select="$libelle"/><xsl:text> (nouvelle fenêtre)</xsl:text></xsl:attribute>
      <xsl:value-of select="$libelle"/>
    </a>
  </xsl:template>
  <!-- Ressource-->
  <xsl:template match="Ressource" mode="Ressource">
    <xsl:apply-templates mode="Ressource"/>
  </xsl:template>
  <!-- Ressource-->
  <xsl:template match="Ressource">
    <xsl:apply-templates mode="Ressource"/>
  </xsl:template>
  <!-- TitreLong-->
  <xsl:template match="TitreLong" mode="Ressource">
 	  <xsl:choose>
	    <xsl:when test="/*/Type/Nom = 'Définition de glossaire' or /*/Type/Nom = 'Organisme national'"><!-- or /*/Type/Nom = 'Texte de référence' -->
     		<p class="comarq-block">
  				<xsl:value-of select="."/>
  			</p>
    	</xsl:when>
    	<xsl:otherwise>
    		<li>
      		<xsl:value-of select="."/>
      	</li>
      </xsl:otherwise>
	  </xsl:choose>
  </xsl:template>
  <!-- TypeCatégorie -->
  <xsl:template match="TypeCatégorie"/>
  <!-- CouvertureGéographique -->
  <xsl:template match="CouvertureGéographique"/>
  <!-- Indexation -->
  <xsl:template match="Indexation"/>
  <!-- CheminPrèf -->
  <xsl:template match="CheminPréf"/>
  <!-- Chapitre-->
  <xsl:template match="Chapitre" mode="Ressource_Avertissement">
    <xsl:apply-templates mode="Ressource"/>
  </xsl:template>
  <!-- Chapitre-->
  <xsl:template match="Chapitre" mode="Ressource">
    <xsl:apply-templates mode="Ressource"/>
  </xsl:template>
  <!-- Titre de Chapitre-->
  <xsl:template match="Chapitre/Titre" mode="Ressource">
    <xsl:choose>
      <xsl:when test="/Ressource/Type/Nom='Texte de référence'">
	      <strong>
        	<xsl:apply-templates mode="Ressource"/>
        </strong>
      </xsl:when>
      <xsl:when test="/Ressource/Type/Nom='Définition de glossaire'">
        <a>
          <xsl:attribute name="name"><xsl:value-of select="/Ressource/@ID"/><xsl:text>.xml</xsl:text></xsl:attribute>
          <strong>
            <xsl:apply-templates mode="Ressource"/>
          </strong>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="Ressource"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- SousChapitre -->
  <xsl:template match="SousChapitre" mode="Ressource">
		<xsl:apply-templates mode="Ressource"/>
  </xsl:template>
  <!-- Titre de SousChapitre-->
  <xsl:template match="SousChapitre/Titre" mode="Ressource">
    <h4 class="comarq-subtitle comarq-content">
			<xsl:apply-templates mode="Ressource"/>
    </h4>
  </xsl:template>
  <!-- Paragraphe -->
  <xsl:template match="Paragraphe" mode="Ressource">
  	<p class="comarq-block">
	    <xsl:choose>
	      <xsl:when test="../../Chapitre or ../../SousChapitre">
		      <xsl:apply-templates/>
	      </xsl:when>
	      <xsl:otherwise>
		      <xsl:apply-templates/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </p>
  </xsl:template>
  <!-- Paragraphe -->
  <xsl:template match="Paragraphe" mode="Ressource_Lettre_type">
		<xsl:if test="text()">
  		<li>
  			<xsl:apply-templates/>
  		</li>
		</xsl:if>
  </xsl:template>
  <!-- Paragraphe -->
  <xsl:template match="Paragraphe" mode="Ressource_Texte_Reference">
    <xsl:if test="text()">
			<li>
    		<xsl:apply-templates />
      </li>
    </xsl:if>
  </xsl:template>
  <!-- Liste -->
  <xsl:template match="Liste" mode="Ressource">
  	<ul>
    	<xsl:apply-templates mode="Ressource"/>
   	</ul>
  </xsl:template>
  <!-- Item -->
  <xsl:template match="Item" mode="Ressource">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  <!-- IDExterne1 -->
  <xsl:template match="IDExterne1" mode="Ressource"/>
  <xsl:template match="IDExterne1" mode="Ressource_Teleservice_Formulaire">
  	<li>
  		<xsl:text>Cerfa n°</xsl:text><xsl:value-of select="."/>
  	</li>
  </xsl:template>
  <xsl:template match="IDExterne1" mode="Ressource_Organisme_local_Web">
   <xsl:param name="commentaire"/>
     <a target="_blank">
       <xsl:attribute name="href"><xsl:value-of select="."/><xsl:text>.html</xsl:text></xsl:attribute>
       <xsl:attribute name="title"><xsl:value-of select="$commentaire"/><xsl:text> (nouvelle fenêtre)</xsl:text></xsl:attribute>
       <xsl:apply-templates select="//TitreLong"/>
       <xsl:if test="$commentaire">
         <xsl:text> (</xsl:text><xsl:value-of select="$commentaire"/><xsl:text>)</xsl:text>
       </xsl:if>
     </a>
  </xsl:template>
  <!-- IDExterne2 -->
  <xsl:template match="IDExterne2" mode="Ressource"/>
  <!-- EditeurSource -->
  <xsl:template match="EditeurSource" mode="Ressource">
  	<xsl:value-of select="."/>
  </xsl:template>
  <!-- LienWeb -->
  <xsl:template match="LienWeb" mode="Ressource">
    <xsl:choose>
      <xsl:when test="@Lien != ''">
    		<a>
        	<xsl:attribute name="href"><xsl:value-of select="@Lien"/></xsl:attribute>
        	<xsl:if test="@Commentaire">
          	<xsl:attribute name="title"><xsl:value-of select="@Commentaire"/></xsl:attribute>
        	</xsl:if>
        	<xsl:value-of select="@Libellé"/>
    		</a>
      </xsl:when>
      <xsl:otherwise>
      	<strong>
          <xsl:value-of select="@Libellé"/>
      	</strong>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="Tableau" mode="Ressource">
    <table class="comarq-table" summary="" cellpadding="0" cellspacing="0">
      <tbody>
        <xsl:apply-templates mode="Ressource"/>
      </tbody>
    </table>
  </xsl:template>
  <!-- Rangée -->
  <xsl:template match="Rangée" mode="Ressource">
    <tr>
      <xsl:apply-templates mode="Ressource"/>
    </tr>
  </xsl:template>
  <!-- Cellule -->
  <xsl:template match="Cellule" mode="Ressource">
    <xsl:choose>
      <xsl:when test="../@type='header'">
        <th>
          <xsl:apply-templates mode="Ressource"/>
        </th>
      </xsl:when>
      <xsl:otherwise>
        <td>
          <xsl:apply-templates mode="Ressource"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- Contact -->
  <xsl:template match="Contact" mode="Ressource"/>
  <!-- Photo -->
  <xsl:template match="Photo" mode="Ressource"/>
  <!-- TypeDeDémarche -->
  <xsl:template match="TypeDeDémarche" mode="Ressource"/>
  <!-- AppelApplication -->
  <xsl:template match="AppelApplication" mode="Ressource_Organisme_local_Web">
    <xsl:param name="commentaire"/>
    <a class="choix" target="_blank">
	    <xsl:attribute name="href"><xsl:value-of select="@ID"/>?<xsl:apply-templates select="Paramètre" mode="Ressource"/></xsl:attribute>
      <xsl:attribute name="title"><xsl:value-of select="$commentaire"/><xsl:text> (nouvelle fenêtre)</xsl:text></xsl:attribute>
      <xsl:apply-templates select="//TitreLong"/>
    </a>
    <xsl:if test="$commentaire">
    	<xsl:text> (</xsl:text><xsl:value-of select="$commentaire"/><xsl:text>)</xsl:text>
    </xsl:if>
    <xsl:value-of select="@Nom"/><xsl:text>, </xsl:text><xsl:value-of select="//EditeurSource"/>
  </xsl:template>
  <!-- Rattachements -->
  <xsl:template match="Rattachements" mode="Ressource"/>
  <!-- RessourceLiée -->
  <xsl:template match="RessourcesLiées" mode="Ressource"/>
  <!-- LienRessource -->
  <xsl:template match="LienRessource" mode="Ressource">
    <xsl:value-of select="@lien"/>
  </xsl:template>
  <!-- Paramètre -->
  <xsl:template match="Paramètre" mode="Ressource">
    <xsl:if test="position()!=1">
      <xsl:text>&amp;</xsl:text>
    </xsl:if>
    <xsl:value-of select="Nom"/>
    <xsl:text>=</xsl:text>
    <xsl:value-of select="Valeur"/>
  </xsl:template>
  <xsl:template name="source">
		<xsl:choose>
      <xsl:when test="count(//RessourcesLiées/LienRessource[starts-with(@type, 'Organisme')]) > 0">
        <xsl:variable name="lien">
         <xsl:value-of select="$CACHEPATH"/>
         <xsl:apply-templates select="//RessourcesLiées/LienRessource[starts-with(@type, 'Organisme')]" mode="Ressource"/>
         <xsl:text>.xml</xsl:text>
        </xsl:variable>
        <li>
   				<xsl:value-of select="document($lien)/Ressource/TitreLong"/>
   			</li>
      </xsl:when>
      <xsl:otherwise>
      	<xsl:if test="//EditeurSource">
      		<li>
    				<xsl:apply-templates select="//EditeurSource" mode="Ressource"/>
    			</li>
    		</xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
