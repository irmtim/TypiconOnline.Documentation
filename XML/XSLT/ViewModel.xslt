<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="file:///E:/Programming/Documentation/TypiconOnline.Documentation/XML/ViewModelSchema.xsd">
	<xsl:template match="/">
		<html>
			<head>
				<title>Последовательность богослужения</title>
			</head>
			<body>
				<xsl:for-each select="viewmodel/worship">
					<xsl:for-each select="items/item">
						<xsl:for-each select="paragraphs/p">
							<xsl:choose>
								<xsl:when test="style/header = 'h1'">
									<xsl:element name="h1">
										<xsl:attribute name="class">
											<xsl:if test="style/bold = 'true'">bold </xsl:if>
											<xsl:if test="style/red = 'true'">red </xsl:if>
										</xsl:attribute>
										<xsl:value-of select="text"/>
									</xsl:element>
								</xsl:when>
								<xsl:when test="style/header = 'h2'">
									<xsl:element name="h2">
										<xsl:attribute name="class">
											<xsl:if test="style/bold = 'true'">bold </xsl:if>
											<xsl:if test="style/red = 'true'">red </xsl:if>
										</xsl:attribute>
										<xsl:value-of select="text"/>
									</xsl:element>
								</xsl:when>
								<xsl:when test="style/header = 'h3'">
									<xsl:element name="h3">
										<xsl:attribute name="class">
											<xsl:if test="style/bold = 'true'">bold </xsl:if>
											<xsl:if test="style/red = 'true'">red </xsl:if>
										</xsl:attribute>
										<xsl:value-of select="text"/>
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:element name="p">
										<xsl:attribute name="class">
											<xsl:if test="style/bold = 'true'">bold </xsl:if>
											<xsl:if test="style/red = 'true'">red </xsl:if>
										</xsl:attribute>
										<xsl:value-of select="text"/>
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
