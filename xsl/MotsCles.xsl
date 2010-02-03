<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="xsl-params.xsl"/>
  <xsl:include href="footer.xsl"/>
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <!--<xsl:text disable-output-escaping="yes">&lt;html xmlns="http://www.w3.org/1999/xhtml" lang="fr" xml:lang="en"&gt;</xsl:text>-->
    <!--xsl:element name="html">
			<xsl:attribute name="xmlns">http://www.w3.org/1999/xhtml</xsl:attribute-->
    <!--html xmlns="http://www.w3.org/1999/xhtml" lang="fr" xml:lang="en"-->
        <xsl:call-template name="header"/>
        <br/>
        <xsl:choose>
          <xsl:when test="$MOTCLE">
            <xsl:apply-templates mode="publications"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates mode="motscles"/>
          </xsl:otherwise>
        </xsl:choose>
        <br/>
        <xsl:call-template name="footer"/>
  </xsl:template>
  <xsl:template match="MotsClés" mode="motscles">
    <h4>
      <a name="haut"/>
      <font color="#cc3333">
        <b> VOS DROITS ET DEMARCHES : MOTS-CLÉS</b>
      </font>
    </h4>
    <br/>
    <table border="0" cellPadding="0" cellSpacing="0" width="100%">
      <tbody>
        <tr>
          <td rowSpan="2" vAlign="bottom" width="16">
            <img align="absBottom" height="64" width="20">
              <xsl:attribute name="src"><xsl:value-of select="$IMAGESURL"/><xsl:text>/e-vert_grad.gif</xsl:text></xsl:attribute>
            </img>
          </td>
        </tr>
        <tr>
          <td align="left" vAlign="top" width="100%" height="282">
            <table border="0" width="100%">
              <tbody>
                <tr>
                  <td colSpan="3">
                    <xsl:call-template name="abecedaire"/>
                  </td>
                </tr>
                <tr>
                  <td colSpan="3">&#xA0;</td>
                </tr>
                <tr>
                  <td colSpan="3">
                    <table width="100%" border="0" cellspacing="3" cellpadding="0">
                      <tr>
                        <td width="50%">
                          <xsl:apply-templates select="MotClé" mode="colonne1"/>
                        </td>
                        <td width="50%">
                          <xsl:apply-templates select="MotClé" mode="colonne2"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
        <tr>
          <td width="20">
            <img height="14" width="20">
              <xsl:attribute name="src"><xsl:value-of select="$IMAGESURL"/><xsl:text>/e_basg.gif</xsl:text></xsl:attribute>
            </img>
          </td>
          <td align="left">
            <img height="14" width="120">
              <xsl:attribute name="src"><xsl:value-of select="$IMAGESURL"/><xsl:text>/e_hori.gif</xsl:text></xsl:attribute>
            </img>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="MotsClés" mode="publications">
    <h4>
      <a name="haut"/>
      <font color="#cc3333">
        <b> VOS DROITS ET DEMARCHES : MOTS-CLÉS</b>
      </font>
    </h4>
    <p>&#xA0;</p>
    <p>
      <xsl:text>Votre sélection</xsl:text>
      <b>
        <xsl:text> : </xsl:text>
        <xsl:value-of select="$MOTCLE"/>
      </b>
    </p>
    <p>
      <img width="400" height="14">
        <xsl:attribute name="src"><xsl:value-of select="$IMAGESURL"/><xsl:text>/e_hori2.gif</xsl:text></xsl:attribute>
      </img>
    </p>
    <br/>
    <table border="0" cellPadding="0" cellSpacing="0" width="100%">
      <tbody>
        <tr>
          <td rowSpan="2" vAlign="bottom" width="16">
            <img align="absBottom" height="64" width="20">
              <xsl:attribute name="src"><xsl:value-of select="$IMAGESURL"/><xsl:text>/e-vert_grad.gif</xsl:text></xsl:attribute>
            </img>
          </td>
        </tr>
        <tr>
          <td align="left" vAlign="top" width="100%" height="282">
            <table border="0" width="100%">
              <tbody>
                <tr>
                  <td colSpan="2">&#xA0;</td>
                </tr>
                <xsl:apply-templates select="MotClé[@libellé = $MOTCLE]/Publication[@type != 'Fiche Question-réponse']" mode="VD">
                  <xsl:sort select="Titre" order="ascending"/>
                </xsl:apply-templates>
                <xsl:apply-templates select="MotClé[@libellé = $MOTCLE]/Publication[@type = 'Fiche Question-réponse']" mode="QR">
                  <xsl:sort select="Titre" order="ascending"/>
                </xsl:apply-templates>
                <tr>
                  <td width="19" valign="baseline">&#xA0;</td>
                  <td width="714">
                    <div align="right">
                      <a href="#haut">
                        <img width="27" height="16" border="0">
                          <xsl:attribute name="src"><xsl:value-of select="$IMAGESURL"/><xsl:text>/fleche_haut.gif</xsl:text></xsl:attribute>
                        </img>
                      </a>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
        <tr>
          <td width="20">
            <img height="14" width="20">
              <xsl:attribute name="src"><xsl:value-of select="$IMAGESURL"/><xsl:text>/e_basg.gif</xsl:text></xsl:attribute>
            </img>
          </td>
          <td align="left">
            <img height="14" width="120">
              <xsl:attribute name="src"><xsl:value-of select="$IMAGESURL"/><xsl:text>/e_hori.gif</xsl:text></xsl:attribute>
            </img>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="MotClé" mode="colonne1">
    <xsl:if test="position() &lt;= (count(//MotsClés/MotClé) div 2) + (count(//MotsClés/MotClé) mod 2)">
      <p>
        <img width="7" height="7">
          <xsl:attribute name="src"><xsl:value-of select="$IMAGESURL"/><xsl:text>/puce_r.gif</xsl:text></xsl:attribute>
        </img>&#xA0;
        <a>
          <xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsCles</xsl:text><xsl:value-of select="$LETTRE"/><xsl:text>.xml&#x26;xsl=MotsCles.xsl&#x26;motcle=</xsl:text><xsl:value-of select="@libellé"/><xsl:text>&#x26;lettre=</xsl:text><xsl:value-of select="$LETTRE"/></xsl:attribute>
          <xsl:value-of select="@libellé"/>
        </a>
      </p>
    </xsl:if>
  </xsl:template>
  <xsl:template match="MotClé" mode="colonne2">
    <xsl:if test="position() &gt; (count(//MotsClés/MotClé) div 2) + (count(//MotsClés/MotClé) mod 2)">
      <p>
        <img width="7" height="7">
          <xsl:attribute name="src"><xsl:value-of select="$IMAGESURL"/><xsl:text>/puce_r.gif</xsl:text></xsl:attribute>
        </img>&#xA0;
        <a>
          <xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsCles</xsl:text><xsl:value-of select="$LETTRE"/><xsl:text>.xml&#x26;xsl=MotsCles.xsl&#x26;motcle=</xsl:text><xsl:value-of select="@libellé"/><xsl:text>&#x26;lettre=</xsl:text><xsl:value-of select="$LETTRE"/></xsl:attribute>
          <xsl:value-of select="@libellé"/>
        </a>
      </p>
    </xsl:if>
  </xsl:template>
  <xsl:template match="Publication" mode="VD">
    <tr>
      <td width="19" valign="baseline">
        <img width="18" height="18">
          <xsl:attribute name="src"><xsl:value-of select="$IMAGESURL"/><xsl:text>/chapitre_ferme.gif</xsl:text></xsl:attribute>
        </img>
      </td>
      <td width="714" align="left">
        <a>
          <xsl:choose>
            <xsl:when test="@nature='Noeud'">
              <xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=</xsl:text><xsl:value-of select="@ID"/><xsl:text>.xml&#x26;xsl=Noeud.xsl</xsl:text></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=</xsl:text><xsl:value-of select="@ID"/><xsl:text>.xml&#x26;xsl=Fiche.xsl</xsl:text></xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:value-of select="Titre"/>
        </a>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="Publication" mode="QR">
    <tr>
      <td width="19" valign="baseline">
        <img width="18" height="18">
          <xsl:attribute name="src"><xsl:value-of select="$IMAGESURL"/><xsl:text>/puce_rouge2.gif</xsl:text></xsl:attribute>
        </img>
      </td>
      <td width="714" align="left">
        <a>
          <xsl:choose>
            <xsl:when test="@nature='Noeud'">
              <xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=</xsl:text><xsl:value-of select="@ID"/><xsl:text>.xml&#x26;xsl=Noeud.xsl</xsl:text></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=</xsl:text><xsl:value-of select="@ID"/><xsl:text>.xml&#x26;xsl=Fiche.xsl</xsl:text></xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:value-of select="Titre"/>
        </a>
      </td>
    </tr>
  </xsl:template>
  <xsl:template name="header">
    <table cellSpacing="0" cellPadding="0" width="100%" border="0">
      <tr>
        <td colSpan="3">
          <xsl:choose>
            <xsl:when test="$PREVIEW='yes'">
              <xsl:for-each select="//CheminPréf/*">
                <xsl:if test="position()>1">
                  <xsl:text>&#xA0;&gt;&#xA0;</xsl:text>
                </xsl:if>
                <a>
                  <xsl:attribute name="href"><xsl:value-of select="@ID"/><xsl:text>.xml</xsl:text></xsl:attribute>
                  <xsl:value-of select="."/>
                </a>
              </xsl:for-each>
              <xsl:if test="//CheminPréf/*">
                <xsl:text>&#xA0;&gt;&#xA0;</xsl:text>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:for-each select="//CheminPréf/*">
                <xsl:if test="position()>1">
                  <xsl:text>&#xA0;&gt;&#xA0;</xsl:text>
                </xsl:if>
                <a>
                  <xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=</xsl:text><xsl:value-of select="@ID"/><xsl:text>.xml&#x26;xsl=MotsCles.xsl&#x26;lettre=</xsl:text><xsl:value-of select="$LETTRE"/></xsl:attribute>
                  <xsl:value-of select="."/>
                </a>
              </xsl:for-each>
              <xsl:if test="//CheminPréf/*">
                <xsl:text>&#xA0;&gt;&#xA0;</xsl:text>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="$MOTCLE">
              <a>
                <xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsCles</xsl:text><xsl:value-of select="$LETTRE"/><xsl:text>.xml&#x26;xsl=MotsCles.xsl&#x26;lettre=</xsl:text><xsl:value-of select="$LETTRE"/></xsl:attribute>
                <xsl:text>Mots-clés</xsl:text>
              </a>
              <font color="#000000"> &gt; </font>
              <font color="#CC3333">
                <xsl:value-of select="$MOTCLE"/>
              </font>
            </xsl:when>
            <xsl:otherwise>
	            <a>
            		<xsl:attribute name="href"><xsl:value-of select="$REFERER"/></xsl:attribute>
            		<xsl:text>Liste des thèmes</xsl:text>
            	</a>
            	<xsl:text>&#xA0;&gt;&#xA0;</xsl:text>
              <font color="#CC3333">
                <xsl:text>Mots-clés</xsl:text>
              </font>
            </xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>
    </table>
  </xsl:template>
  <xsl:template name="abecedaire">
    <xsl:choose>
      <xsl:when test="$LETTRE='A'">
        <FONT color="#cc3333">
          <b> A </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesA.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesA.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> A </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> A </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='B'">
        <FONT color="#cc3333">
          <b> B </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesB.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesB.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> B </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> B </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='C'">
        <FONT color="#cc3333">
          <b> C </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesC.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesC.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> C </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> C </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='D'">
        <FONT color="#cc3333">
          <b> D </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesD.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesD.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> D </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> D </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='E'">
        <FONT color="#cc3333">
          <b> E </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesE.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesE.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> E </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> E </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='F'">
        <FONT color="#cc3333">
          <b> F </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesF.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesF.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> F </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> F </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='G'">
        <FONT color="#cc3333">
          <b> G </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesG.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesG.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> G </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> G </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='H'">
        <FONT color="#cc3333">
          <b> H </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesH.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesH.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> H </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> H </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='I'">
        <FONT color="#cc3333">
          <b> I </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesI.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesI.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> I </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> I </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='J'">
        <FONT color="#cc3333">
          <b> J </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesJ.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesJ.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> J </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> J </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='K'">
        <FONT color="#cc3333">
          <b> K </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesK.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesK.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> K </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> K </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='L'">
        <FONT color="#cc3333">
          <b> L </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesL.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesL.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> L </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> L </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='M'">
        <FONT color="#cc3333">
          <b> M </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesM.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesM.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> M </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> M </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='N'">
        <FONT color="#cc3333">
          <b> N </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesN.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesN.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> N </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> N </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='O'">
        <FONT color="#cc3333">
          <b> O </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesO.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesO.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> O </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> O </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='P'">
        <FONT color="#cc3333">
          <b> P </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesP.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesP.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> P </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> P </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='Q'">
        <FONT color="#cc3333">
          <b> Q </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesQ.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesQ.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> Q </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> Q </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='R'">
        <FONT color="#cc3333">
          <b> R </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesR.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesR.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> R </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> R </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='S'">
        <FONT color="#cc3333">
          <b> S </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesS.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesS.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> S </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> S </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='T'">
        <FONT color="#cc3333">
          <b> T </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesT.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesT.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> T </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> T </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='U'">
        <FONT color="#cc3333">
          <b> U </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesU.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesU.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> U </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> U </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='V'">
        <FONT color="#cc3333">
          <b> V </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesV.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesV.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> V </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> V </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='W'">
        <FONT color="#cc3333">
          <b> W </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesW.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesW.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> W </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> W </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <!--<xsl:choose>
      <xsl:when test="$LETTRE='X'">
        <FONT color="#cc3333">
          <b> X </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesX.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesX.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> X </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> X </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='Y'">
        <FONT color="#cc3333">
          <b> Y </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesY.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesY.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> Y </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> Y </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$LETTRE='Z'">
        <FONT color="#cc3333">
          <b> Z </b>
        </FONT> |
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="document(concat($CACHEPATH,'MotsClesZ.xml'))">
            <a><xsl:attribute name="href"><xsl:value-of select="$REFERER"/><xsl:text>?xml=MotsClesZ.xml&amp;xsl=MotsCles.xsl</xsl:text></xsl:attribute> Z </a> |
          </xsl:when>
          <xsl:otherwise>
            <b> Z </b> |
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>-->
  </xsl:template>
</xsl:stylesheet>
