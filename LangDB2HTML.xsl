<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" omit-xml-declaration="yes" indent="yes" />

	<xsl:param name="id" select="'1000'" />
	<xsl:param name="myOrder" select="4000" />
	<xsl:param name="LangID" select="'Ewe'" />


	<!-- TEST VARIABLE FOR DEBUD COMMENT FOR WORK WITH JAVASCRIPT <xsl:variable 
		name="LangID" select="'Ewe'"></xsl:variable> -->


	<xsl:template match="/LanguageData">
		<!-- This language is used if NO PARAMETER PASSED IN -->

		<xsl:if test="$LangID=''">
			<!-- <xsl:variable name="LangID" select="'Ewe'"></xsl:variable> -->
			<xsl:apply-templates select="Language[GeneralInfo/LangID='Yucatec Maya']" />

		</xsl:if>
		<div>
			<xsl:apply-templates select="Language[GeneralInfo/LangID=$LangID]" />
		</div>

	</xsl:template>

	<!-- <xsl:template match="LanguageData/Language[$id]"> -->
	<xsl:template match="Language/GeneralInfo">
		<!-- <xsl:if test=""></xsl:if> -->

		<table id="genInfoTable">
			<tr>
				<th id="genInfo" colspan="2">
					Language:
					<xsl:value-of select="LangID" />
				</th>
			</tr>

			<tr>
				<td class="tag">ISO639-3</td>
				<td>
					<xsl:value-of select="ISO639-3" />
				</td>
			</tr>
			<tr>
				<td class="tag">Location</td>
				<td>
					<xsl:value-of select="Location" />
				</td>
			</tr>


			<tr>
				<td class="tag">Country(ies)</td>
				<td>
					<xsl:apply-templates select="Country"></xsl:apply-templates>
				</td>
			</tr>
			<tr>
				<td class="tag">GeneticRelation</td>
				<td>
					<xsl:value-of select="GeneticRelation" />
				</td>
			</tr>
			<tr>
				<td class="tag">WordOrder</td>
				<td>
					<xsl:value-of select="WordOrder" />
				</td>
			</tr>
			<tr>
				<td class="tag">CaseSystem</td>
				<td>
					<xsl:value-of select="CaseSystem" />
				</td>
			</tr>
			<tr>
				<td class="tag">NominalPhrase</td>
				<td>
					<xsl:value-of select="NominalPhrase" />
				</td>
			</tr>
			<tr>
				<td class="tag">InterchangeaStrategies</td>
				<td>
					<xsl:value-of select="InterchangeaStrategies" />
				</td>
			</tr>
			<tr>
				<td class="tag">RelStrategies</td>
				<td>
					<xsl:value-of select="RelStrategies" />
				</td>
			</tr>


		</table>
		<br />
	</xsl:template>

	<xsl:template match="Language/Possession/PronominalPossession">
	<xsl:variable name="StrategiesSet" select="StrategyPronom | StrategyPronomNonCanonical"></xsl:variable>
	
		<div class="pronPossHeader">
			<table class="possTable">
				<tr>
					<th>
						PronominalPossession
						<input type="button" value="Show/Hide Strategies"
							onclick="clickShowStrat('StrategyPronomTable')" />
					</th>
				</tr>
			</table>

			<table id="StrategyPronomTable">
				<tr class="StrategyPronomHeaderRow">
					<th rowspan="2"></th>
					<xsl:for-each select="$StrategiesSet">

						<th class="stratTH" style="">
							<span class="attrNameValue">Strategy:
							<xsl:value-of select="position()" />
							
							, ID:
							<xsl:value-of select="@StrategyID" />
							</span>
							<br />
							<xsl:if test="self::StrategyPronomNonCanonical">
								<span>NonCanonical</span>
							</xsl:if>


						</th>
					</xsl:for-each>
					<!-- <xsl:for-each select="StrategyPronomNonCanonical"> <th class="stratTH" 
						style=""> Strategy: <xsl:value-of select="position()" /> <br />NonCanonical 
						<xsl:if test="self::StrategyPronomNonCanonical"> TRUE </xsl:if> </th> </xsl:for-each> -->
				</tr>
				<tr class="StrategyPronomHeaderRow">
					<xsl:for-each select="$StrategiesSet">
						<xsl:variable name="columMaxLength"
							select="string-length(SyntEnvironment/Adnominal/Text)" />

						<td>
							<span class="attrNameValue">
								Complexity=
								<span class="attrValue">
									<xsl:value-of select="@Complexity" />
								</span>
							</span>
							<!-- Text Length: <xsl:value-of select="string-length(SyntEnvironment/Adnominal/Text)" 
								/> or <xsl:value-of select="$columMaxLength" /> -->
						</td>

					</xsl:for-each>

				</tr>


				<tr class="MorphRow">
					<td>
						Morphology
						<br />
						Pronoun
					</td>
					<xsl:for-each
						select="$StrategiesSet/Morphology">

						<td>

							<xsl:if test="Pronoun">
								<span class="stratTag">
									Pronoun
								</span>
								<br />
								<span class="attrNameValue">
									<span>
										Dedication=
									</span>
									<span class="attrValue">
										<xsl:value-of select="Pronoun/@Dedication" />
									</span>
								</span>
								<br />
								<span class="attrNameValue">
									SharedwithNominal=
									<span class="attrValue">
										<xsl:value-of select="Pronoun/@SharedwithNominal" />
									</span>
								</span>
								<br />
								<span class="attrNameValue">
									AttachmentSite=
									<span class="attrValue">

										<xsl:value-of select="Pronoun/@AttachmentSite" />
									</span>
								</span>

							</xsl:if>

						</td>
					</xsl:for-each>
				</tr>

				<tr class="MorphRow">
					<td>
						Morphology
						<br />
						Morpheme
					</td>
					<xsl:for-each
						select="$StrategiesSet/Morphology">

						<td>
							<xsl:apply-templates select="Morpheme" />
							<!-- <xsl:if test="Morpheme"> <span class="stratTag"> Morpheme </span> 
								<br /> <span> Placement= <xsl:value-of select="Morpheme/@Placement" /> </span> 
								<br /> <xsl:if test="Morpheme/@SharedWithNominal"> <span> SharedWithNominal= 
								<xsl:value-of select="Morpheme/@SharedWithNominal" /> </span> <br /> </xsl:if> 
								<xsl:if test="Morpheme/@pronoun"> <span> P???ronoun= <xsl:value-of select="Morpheme/@pronoun" 
								/> </span> </xsl:if> </xsl:if> -->
						</td>
					</xsl:for-each>
				</tr>

				<tr class="SyntEnvRow">
					<td>
						<span>
							SyntEnvironment
						</span>
						<br />
						<span class="stratTag">
							Adnominal
						</span>
					</td>
					<xsl:for-each
						select="$StrategiesSet/SyntEnvironment">

						<td>
							<span class="examplesTD">
								<xsl:apply-templates select="Adnominal[1]/Text" />
							</span>
							<br />
							<span class="examplesTD">
								<xsl:value-of select="Adnominal/Gloss" />
							</span>
							<br />
							<span class="examplesTD">
								<xsl:value-of select="Adnominal/Translation" />
							</span>
						</td>
					</xsl:for-each>
				</tr>

<!-- 
				<xsl:if
					test="$StrategiesSet/SyntEnvironment/Predicative/Gloss[string-length(normalize-space(.)) > 0] ">

					<tr class="SyntEnvRow">
						<td>
							<span>
								SyntEnvironment from IF
							</span>
							<br />
							<span class="stratTag">
								Predicative
							</span>
						</td>
						<xsl:for-each
							select="StrategyPronom/SyntEnvironment | StrategyPronomNonCanonical/SyntEnvironment">

							<td>
								<span class="examplesTD">
									<xsl:apply-templates select="Predicative[1]/Text" />
								</span>
								<br />
								<span class="examplesTD">
									<xsl:value-of select="Predicative/Gloss" />
								</span>
								<br />
								<span class="examplesTD">
									<xsl:value-of select="Predicative/Translation" />
								</span>
							</td>
						</xsl:for-each>
					</tr>
				</xsl:if>
 -->
 				
				<xsl:call-template name="SyntEnvTemplate">
					<xsl:with-param name="ExampleType" select="'Predicative'" />
				</xsl:call-template>


				<xsl:call-template name="SyntEnvTemplate">
					<xsl:with-param name="ExampleType" select="'EllidedPossessed'" />
				</xsl:call-template>


				<tr class="SemantRow">
					<td>Semantics</td>
					<xsl:for-each select="$StrategiesSet">
						<td>
							<xsl:if test="Semantics">
								<span class="attrNameValue">
									<span class="stratTag">Posessor: </span>


									<xsl:call-template name="elemMixedProc">
										<xsl:with-param name="node2Proc" select="Semantics/Posessor" />
									</xsl:call-template>
								</span>
								<br />

								<span class="stratTag">Possessed:</span>
								<span class="attrNameValue">
									ObligatoryPossessed=
									<span class="attrValue">
										"
										<xsl:value-of select="Semantics/Possessed/@ObligatoryPossessed" />
										"
									</span>
									<br />
								</span>
								<xsl:if test="Semantics/Possessed/@BodyParts">
									<span class="attrNameValue">
										BodyParts=
										<span class="attrValue">
											"
											<xsl:value-of select="Semantics/Possessed/@BodyParts" />
											"
										</span>
									</span>
								</xsl:if>

								<xsl:if test="Semantics/Possessed/@Clothes">
									<span class="attrNameValue">
										Clothes=
										<span class="attrValue">
											"
											<xsl:value-of select="Semantics/Possessed/@Clothes" />
											"
										</span>
									</span>
									<br />
								</xsl:if>
								<xsl:if test="Semantics/Possessed/@Kinship">
									<span class="attrNameValue">
										Kinship=
										<span class="attrValue">
											"
											<xsl:value-of select="Semantics/Possessed/@Kinship" />
											"
										</span>
									</span>
								</xsl:if>

								<xsl:if test="Semantics/Possessed/@PlantParts">
									<span class="attrNameValue">
										PlantParts=
										<span class="attrValue">
											"
											<xsl:value-of select="Semantics/Possessed/@PlantParts" />
											"
										</span>
									</span>
									<br />
								</xsl:if>

								<xsl:if test="Semantics/Possessed/@Others">
									<span class="attrNameValue">
										Others=
										<span class="attrValue">
											"
											<xsl:value-of select="Semantics/Possessed/@Others" />
											"
										</span>
									</span>
								</xsl:if>

								<p>
									<xsl:call-template name="elemMixedProc">
										<xsl:with-param name="node2Proc" select="Semantics/Possessed" />
									</xsl:call-template>
								</p>
							</xsl:if>
						</td>

					</xsl:for-each>
				</tr>

			</table>
		</div>

	</xsl:template>

	<xsl:template name="SyntEnvTemplate">
		<xsl:param name="ExampleType" />
<!-- 		<xsl:param name="StrategyNode" />
 -->
		<xsl:if
			test="*/SyntEnvironment/node()[name()=$ExampleType]/Gloss[string-length(normalize-space(.))>0] ">
			<tr class="SyntEnvRow">
				<td>
					<span>
						SyntEnvironment
					</span>
					<br />
					<span class="stratTag">
						<xsl:value-of select="$ExampleType"></xsl:value-of>
					</span>
				</td>
				<xsl:for-each
					select="*/SyntEnvironment ">

					<td>
						<span class="examplesTD">
							<xsl:apply-templates select="node()[name()=$ExampleType][1]/Text" />
						</span>
						<br />
						<span class="examplesTD">
							<xsl:value-of select="node()[name()=$ExampleType]/Gloss" />
						</span>
						<br />
						<span class="examplesTD">
							<xsl:value-of select="node()[name()=$ExampleType]/Translation" />
						</span>
					</td>
				</xsl:for-each>
			</tr>
		</xsl:if>
	</xsl:template>



	<xsl:template match="Text">
		<xsl:for-each select="node()">
			<xsl:if test="self::pPron">
				<span class="pPron" title="Pronoun">
					<xsl:value-of select="self::pPron" />
				</span>
			</xsl:if>
			<xsl:if test="self::pPosed">
				<span class="pPosed" title="Possessed">
					<xsl:value-of select="self::pPosed" />
				</span>
			</xsl:if>
			<xsl:if test="self::pPosor">
				<span class="pPosor" title="Possessor">
					<xsl:value-of select="self::pPosor" />
				</span>
			</xsl:if>
			<xsl:if test="self::pMorp">
				<span class="pMorp" title="Morpheme">
					<xsl:value-of select="self::pMorp" />
				</span>
			</xsl:if>

			<xsl:if test="self::text()">
				<span class="pText">
					<xsl:value-of select="self::text()" />
				</span>
				<!-- THIS IF REMOVES EMPTY TEXTS BUT ALSO SPACES BETWEEN pELEMs<xsl:if 
					test="string-length(normalize-space(.)) > 0"> <span class="pText"> <xsl:value-of 
					select="self::text()" /> </span> </xsl:if> -->
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- <xsl:template match="Adnominal/Text"> <span> Example Text with MarkUp 
		</span> <br /> <xsl:for-each select="node()"> <span> Posit: <xsl:value-of 
		select="position()" /> </span> <xsl:if test="self::pPron"> pPron= <span class="pPron"> 
		<xsl:value-of select="self::pPron" /> </span> </xsl:if> <xsl:if test="self::pPosed"> 
		pPosed= <span class="pPosed"> <xsl:value-of select="self::pPosed" /> </span> 
		</xsl:if> <xsl:if test="self::pPosor"> pPosor= <span class="pPosor"> <xsl:value-of 
		select="self::pPosor" /> </span> </xsl:if> <xsl:if test="self::pMorp"> pMorp= 
		<span class="pMorp"> <xsl:value-of select="self::pMorp" /> </span> </xsl:if> 
		<xsl:if test="self::text()"> <xsl:if test="string-length(normalize-space(.)) 
		> 0"> pText(N_char>0)= <span class="pText"> <xsl:value-of select="self::text()" 
		/> </span> </xsl:if> </xsl:if> <br /> </xsl:for-each> </xsl:template> -->

	<xsl:template match="Morpheme">
		<span class="attrNameValue">
			<span class="stratTag">
				<xsl:value-of select="position()" />
				. Morpheme:
			</span>
			<span class="attrValue">
				<xsl:value-of select="@Label"></xsl:value-of>
			</span>
		</span>
		<br />
		<span class="attrNameValue">
			AttachmentSite=
			<span class="attrValue">
				<xsl:value-of select="@AttachmentSite" />
			</span>
		</span>
		<br />
		<xsl:if test="@SharedWithNominal">
			<span class="attrNameValue">
				SharedWithNominal=
				<span class="attrValue">
					<xsl:value-of select="@SharedWithNominal" />
				</span>
			</span>
			<br />
		</xsl:if>
		<xsl:if test="Morpheme/@Pronoun">
			<span class="attrNameValue">
				Pronoun=
				<span class="attrValue">
					<xsl:value-of select="Morpheme/@Pronoun" />
				</span>
			</span>
		</xsl:if>


	</xsl:template>

	<xsl:template match="Language/Possession/NominalPossession">

		<div class="nominPossHeader">
			<br />
			<table class="possTable">
				<tr>
					<th>
						Nominal Possession
						<input type="button" value="Show/Hide Strategies"
							onclick="clickShowStrat('stratTableNomPoss')" />
					</th>
				</tr>
				<!-- <tr class='nominPoss'> <td>Strategy</td> </tr> <tr class='nominPoss'> 
					<td>values</td> </tr> -->
			</table>
		</div>
		<div id="stratTableNomPoss">
			<xsl:apply-templates select="../NominalPossession/Strategy" />

		</div>
	</xsl:template>

	<!-- STRATEGY TEMPLATE FOR PronominalPossession -->
	<xsl:template match="NominalPossession/Strategy">
		<table>
			<tr>
				<th>
					Strategy:
					<xsl:value-of select="position()" />
				</th>
			</tr>
			<tr>
				<td>
					<xsl:if test="@BasedOnPronominal">
						<span>
							BasedOnPronominal=
							<xsl:value-of select="@BasedOnPronominal" />
						</span>
						<br />
						<span>
							<xsl:apply-templates select="PronStrategy" />
						</span>

					</xsl:if>
					<xsl:if test="@Complexity">
						<span>
							Complexity=
							<xsl:value-of select="@Complexity" />
						</span>
					</xsl:if>
					<xsl:if test="@Complexity and @Replaceable">
						<span>,
						</span>
					</xsl:if>
					<xsl:if test="@Replaceable">
						<span>
							Replaceable=
							<xsl:value-of select="@Replaceable" />
						</span>
					</xsl:if>
				</td>
			</tr>


			<xsl:if test="Morphology">
				<tr>
					<td>
						<span class="langTag">Morphology</span>

					</td>
				</tr>
				<xsl:if test="Morphology/Morpheme">
					<tr>
						<td>
							<span class="stratTag">
								Morpheme
							</span>
							<br />
							<span>
								Placement=
								<xsl:value-of select="Morphology/Morpheme/@Placement" />
							</span>
							<br />
							<xsl:if test="Morphology/Morpheme/@UsedinPronominal">
								<span>
									UsedinPronominal=
									<xsl:value-of select="Morphology/Morpheme/@UsedinPronominal" />
								</span>
								<br />
							</xsl:if>
							<xsl:if test="Morphology/Morpheme/@pronoun">
								<span>
									P???ronoun=
									<xsl:value-of select="Morphology/Morpheme/@pronoun" />
								</span>
							</xsl:if>

						</td>
					</tr>
				</xsl:if>


			</xsl:if>

			<xsl:if test="Juxtaposition">
				<tr>
					<td>
						<span class="langTag">Juxtaposition</span>


					</td>
				</tr>

			</xsl:if>


			<tr>
				<td>
					<span class="langTag"> SyntEnvironment</span>
					<br />
				</td>
			</tr>
			<tr>
				<td>
					<span class="stratTag">
						Example Adnominal
					</span>
					<br />
					<span class="examplesTD">
						<xsl:value-of select="SyntEnvironment/Adnominal/Text" />
						<br />
					</span>
					<span class="examplesTD">
						<xsl:value-of select="SyntEnvironment/Adnominal/Gloss" />
						<br />
					</span>
					<span class="examplesTD">
						<xsl:value-of select="SyntEnvironment/Adnominal/Translation" />
					</span>


				</td>
			</tr>

		</table>

	</xsl:template>

 
	<xsl:template match="Country">

		<span>
			<xsl:value-of select="self::Country" />
		</span>
		<xsl:if test="following-sibling::Country">

			<span>, </span>
		</xsl:if>
		<!-- <xsl:value-of select="."></xsl:value-of> -->

	</xsl:template>


	<xsl:template name="elemMixedProc">
		<xsl:param name="node2Proc" />

		<xsl:for-each select="$node2Proc/child::text()">

			<xsl:variable name="textContent" select="."></xsl:variable>
			<xsl:if test="string-length(normalize-space($textContent)) > 0">
				<span>
					<!-- For tests From NTempl NotEmpt: -->
					<xsl:value-of select="$textContent"></xsl:value-of>
				</span>
			</xsl:if>

		</xsl:for-each>

		<xsl:variable name="text_node" select="$node2Proc" />

	</xsl:template>


	<xsl:template match="text()" />


</xsl:stylesheet>