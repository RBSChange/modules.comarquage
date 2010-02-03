<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="xsl-params.xsl"/>
<xsl:output method="html" encoding="UTF-8" cdata-section-elements="script" indent="yes"/>
  <xsl:template name="header">
  	<div class="comarq-breadcrumb">
    	<ul>
        <xsl:choose>
          <xsl:when test="//Navigation">
            <xsl:for-each select="//Navigation/*">
              <xsl:if test="position()>1">
                <xsl:text> &gt; </xsl:text>
              </xsl:if>
              <li>
              	<a>
                	<xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="@href"/><xsl:text>.xml&#x26;xsl=Noeud.xsl</xsl:text><xsl:call-template name="navigationparams"><xsl:with-param name="pos" select="position()"/></xsl:call-template></xsl:attribute>
                	<xsl:value-of select="."/>
              	</a>
              	<xsl:text> &gt; </xsl:text>
              </li>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
          	<li>
          		<a>
          			<xsl:attribute name="href"><xsl:value-of select="$REFERER"/></xsl:attribute>
          			<xsl:text>Liste des thèmes</xsl:text>
          		</a>
          		<xsl:text> &gt; </xsl:text>
          	</li>
            <xsl:for-each select="//CheminPréf/*">
              <li>
              	<a>
                  <xsl:attribute name="href"><xsl:value-of select="$REFERER"/>?xml=<xsl:value-of select="@ID"/><xsl:text>.xml&#x26;xsl=Noeud.xsl</xsl:text></xsl:attribute>
                	<xsl:value-of select="."/>
              	</a>
              	<xsl:if test="//CheminPréf/*">
              		<xsl:text> &gt; </xsl:text>
            		</xsl:if>
              </li>
            </xsl:for-each>
         	</xsl:otherwise>
        </xsl:choose>
        <li class="comarq-current">
        	<strong>
          	<xsl:value-of select="//TitreLong"/>
          </strong>
        </li>
      </ul>
    </div>
  </xsl:template>
  <!-- Pour le passage de paramètres -->
  <xsl:template name="parametres">
    <xsl:for-each select="//Navigation/*">
      <xsl:text>&amp;n=</xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>&amp;l=</xsl:text>
      <xsl:value-of select="@href"/>
    </xsl:for-each>
    <xsl:text>&amp;n=</xsl:text>
    <xsl:value-of select="//TitreLong"/>
    <xsl:text>&amp;l=</xsl:text>
    <xsl:value-of select="/*/@ID"/>
  </xsl:template>
  <xsl:template name="navigationparams">
    <xsl:param name="pos"/>
    <xsl:for-each select="//Navigation/*">
      <xsl:if test="position() &lt; $pos">&amp;n=<xsl:value-of select="."/>&amp;l=<xsl:value-of select="@href"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
