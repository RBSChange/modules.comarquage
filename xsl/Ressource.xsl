<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="xsl-params.xsl"/>
  <xsl:include href="Publication.xsl"/>
  <xsl:include href="RessourceRattachee.xsl"/>
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <xsl:comment>
      <xsl:value-of select="Ressource/@ID"/>
    </xsl:comment>
    <xsl:choose>
      <xsl:when test="Ressource/Type/Nom='Définition de glossaire'">
        <div class="comarq-bloc comarq-bleu-pastel">
      		<h2 class="comarq-bloc-entete comarq-bleu-pastel">Définition</h2>
	        <xsl:apply-templates select="Ressource" mode="Ressource"/>
        </div>
      </xsl:when>
      <xsl:when test="Ressource/Type/Nom='Site Web'">
        <div class="comarq-bloc comarq-jaune">
					<h2 class="comarq-bloc-entete comarq-jaune">Pour en savoir plus</h2>
					<h3 class="comarq-subtitle">Site internet public</h3>
          <xsl:apply-templates select="Ressource" mode="Ressource_Web"/>
        </div>
      </xsl:when>
      <xsl:when test="Ressource/Type/Nom='Téléservice'">
        <div class="comarq-bloc comarq-bleu">
       		<h2 class="comarq-bloc-entete comarq-bleu">Démarche en ligne</h2>
          <xsl:apply-templates select="Ressource" mode="Ressource_Teleservice"/>
        </div>
      </xsl:when>
      <xsl:when test="Ressource/Type/Nom='Formulaire'">
        <div class="comarq-bloc comarq-bleu">
        	<h2 class="comarq-bloc-entete comarq-bleu">Formulaire</h2>
          <xsl:apply-templates select="Ressource" mode="Ressource_Formulaire"/>
        </div>
      </xsl:when>
      <xsl:when test="Ressource/Type/Nom='Texte de référence'">
        <div class="comarq-bloc comarq-bleu">
        	<h2 class="comarq-bloc-entete comarq-bleu">Texte de référence</h2>
          <xsl:apply-templates select="Ressource" mode="Ressource_Texte_Reference"/>
        </div>
      </xsl:when>
      <xsl:when test="Ressource/Type/Nom='Avertissement'">
        <div class="comarq-bloc comarq-orange">
          <h2 class="comarq-bloc-entete comarq-orange">Avertissement</h2>
          <xsl:apply-templates select="Ressource" mode="Ressource_Avertissement"/>
        </div>
      </xsl:when>
      <xsl:when test="Ressource/Type/Nom='Organisme national'">
        <div class="comarq-bloc comarq-rouge">
          <h2 class="comarq-bloc-entete comarq-rouge">Organisme national</h2>
          <xsl:apply-templates select="Ressource" mode="Ressource_Organisme_national"/>
        </div>
      </xsl:when>
      <xsl:when test="Ressource/Type/Nom='Organisme local Web'">
        <div class="comarq-bloc comarq-rouge">
          <h2 class="comarq-bloc-entete comarq-rouge">Adresse locale</h2>
          <xsl:apply-templates select="Ressource" mode="Ressource_Organisme_local_Web"/>
        </div>
      </xsl:when>
      <xsl:when test="Ressource/Type/Nom='Organisme local SPL'">
        <div class="comarq-bloc comarq-rouge">
          <h2 class="comarq-bloc-entete comarq-rouge">Adresse locale</h2>
          <xsl:apply-templates select="Ressource" mode="Ressource_Organisme_local_SPL"/>
        </div>
      </xsl:when>
      <xsl:when test="Ressource/Type/Nom='Lettre type'">
        <div class="comarq-bloc comarq-jaune-pastel">
          <h2 class="comarq-bloc-entete comarq-jaune-pastel">Lettre type</h2>
          <xsl:apply-templates select="Ressource" mode="Ressource_Lettre_type"/>
        </div>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
