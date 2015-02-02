From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2] ASoC: tlv320aic3x: Add support for tlv320aic3104
Date: Mon, 2 Feb 2015 16:48:05 +0200
Message-ID: <1422888485-13626-1-git-send-email-jsarha@ti.com>
References: <54CF2CDA.3060607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47450 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbbBBOsT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Feb 2015 09:48:19 -0500
In-Reply-To: <54CF2CDA.3060607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, benoit.thebaudeau.dev@gmail.com, wlear@appliedlogix.com, Jyri Sarha <jsarha@ti.com>

Disables GPIO support and LINE2 input and renames Mic3 input to Mic2,
if tlv320aic3104 mode is seleced. Devicetree binding document is
updated accordingly.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
Changes since the first version of the patch
 - Added "ti,tlv320aic3104" to tlv320aic3x_of_match table
 What surprises me is how come the code worked even before this change?

 .../devicetree/bindings/sound/tlv320aic3x.txt      |  10 +-
 sound/soc/codecs/tlv320aic3x.c                     | 345 +++++++++++++++------
 2 files changed, 253 insertions(+), 102 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
index 5e6040c..47a213c 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -9,6 +9,7 @@ Required properties:
     "ti,tlv320aic33" - TLV320AIC33
     "ti,tlv320aic3007" - TLV320AIC3007
     "ti,tlv320aic3106" - TLV320AIC3106
+    "ti,tlv320aic3104" - TLV320AIC3104
 
 
 - reg - <int> -  I2C slave address
@@ -18,6 +19,7 @@ Optional properties:
 
 - gpio-reset - gpio pin number used for codec reset
 - ai3x-gpio-func - <array of 2 int> - AIC3X_GPIO1 & AIC3X_GPIO2 Functionality
+				    - Not supported on tlv320aic3104
 - ai3x-micbias-vg - MicBias Voltage required.
 	1 - MICBIAS output is powered to 2.0V,
 	2 - MICBIAS output is powered to 2.5V,
@@ -36,7 +38,13 @@ CODEC output pins:
   * HPLCOM
   * HPRCOM
 
-CODEC input pins:
+CODEC input pins for TLV320AIC3104:
+  * MIC2L
+  * MIC2R
+  * LINE1L
+  * LINE1R
+
+CODEC input pins for other compatible codecs:
   * MIC3L
   * MIC3R
   * LINE1L
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index b7ebce0..cb92cdb 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -87,6 +87,7 @@ struct aic3x_priv {
 #define AIC3X_MODEL_3X 0
 #define AIC3X_MODEL_33 1
 #define AIC3X_MODEL_3007 2
+#define AIC3X_MODEL_3104 3
 	u16 model;
 
 	/* Selects the micbias voltage */
@@ -316,52 +317,37 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	 * only for swapped L-to-R and R-to-L routes. See below stereo controls
 	 * for direct L-to-L and R-to-R routes.
 	 */
-	SOC_SINGLE_TLV("Left Line Mixer Line2R Bypass Volume",
-		       LINE2R_2_LLOPM_VOL, 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE_TLV("Left Line Mixer PGAR Bypass Volume",
 		       PGAR_2_LLOPM_VOL, 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE_TLV("Left Line Mixer DACR1 Playback Volume",
 		       DACR1_2_LLOPM_VOL, 0, 118, 1, output_stage_tlv),
 
-	SOC_SINGLE_TLV("Right Line Mixer Line2L Bypass Volume",
-		       LINE2L_2_RLOPM_VOL, 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE_TLV("Right Line Mixer PGAL Bypass Volume",
 		       PGAL_2_RLOPM_VOL, 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE_TLV("Right Line Mixer DACL1 Playback Volume",
 		       DACL1_2_RLOPM_VOL, 0, 118, 1, output_stage_tlv),
 
-	SOC_SINGLE_TLV("Left HP Mixer Line2R Bypass Volume",
-		       LINE2R_2_HPLOUT_VOL, 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE_TLV("Left HP Mixer PGAR Bypass Volume",
 		       PGAR_2_HPLOUT_VOL, 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE_TLV("Left HP Mixer DACR1 Playback Volume",
 		       DACR1_2_HPLOUT_VOL, 0, 118, 1, output_stage_tlv),
 
-	SOC_SINGLE_TLV("Right HP Mixer Line2L Bypass Volume",
-		       LINE2L_2_HPROUT_VOL, 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE_TLV("Right HP Mixer PGAL Bypass Volume",
 		       PGAL_2_HPROUT_VOL, 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE_TLV("Right HP Mixer DACL1 Playback Volume",
 		       DACL1_2_HPROUT_VOL, 0, 118, 1, output_stage_tlv),
 
-	SOC_SINGLE_TLV("Left HPCOM Mixer Line2R Bypass Volume",
-		       LINE2R_2_HPLCOM_VOL, 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE_TLV("Left HPCOM Mixer PGAR Bypass Volume",
 		       PGAR_2_HPLCOM_VOL, 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE_TLV("Left HPCOM Mixer DACR1 Playback Volume",
 		       DACR1_2_HPLCOM_VOL, 0, 118, 1, output_stage_tlv),
 
-	SOC_SINGLE_TLV("Right HPCOM Mixer Line2L Bypass Volume",
-		       LINE2L_2_HPRCOM_VOL, 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE_TLV("Right HPCOM Mixer PGAL Bypass Volume",
 		       PGAL_2_HPRCOM_VOL, 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE_TLV("Right HPCOM Mixer DACL1 Playback Volume",
 		       DACL1_2_HPRCOM_VOL, 0, 118, 1, output_stage_tlv),
 
 	/* Stereo output controls for direct L-to-L and R-to-R routes */
-	SOC_DOUBLE_R_TLV("Line Line2 Bypass Volume",
-			 LINE2L_2_LLOPM_VOL, LINE2R_2_RLOPM_VOL,
-			 0, 118, 1, output_stage_tlv),
 	SOC_DOUBLE_R_TLV("Line PGA Bypass Volume",
 			 PGAL_2_LLOPM_VOL, PGAR_2_RLOPM_VOL,
 			 0, 118, 1, output_stage_tlv),
@@ -369,9 +355,6 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 			 DACL1_2_LLOPM_VOL, DACR1_2_RLOPM_VOL,
 			 0, 118, 1, output_stage_tlv),
 
-	SOC_DOUBLE_R_TLV("HP Line2 Bypass Volume",
-			 LINE2L_2_HPLOUT_VOL, LINE2R_2_HPROUT_VOL,
-			 0, 118, 1, output_stage_tlv),
 	SOC_DOUBLE_R_TLV("HP PGA Bypass Volume",
 			 PGAL_2_HPLOUT_VOL, PGAR_2_HPROUT_VOL,
 			 0, 118, 1, output_stage_tlv),
@@ -379,9 +362,6 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 			 DACL1_2_HPLOUT_VOL, DACR1_2_HPROUT_VOL,
 			 0, 118, 1, output_stage_tlv),
 
-	SOC_DOUBLE_R_TLV("HPCOM Line2 Bypass Volume",
-			 LINE2L_2_HPLCOM_VOL, LINE2R_2_HPRCOM_VOL,
-			 0, 118, 1, output_stage_tlv),
 	SOC_DOUBLE_R_TLV("HPCOM PGA Bypass Volume",
 			 PGAL_2_HPLCOM_VOL, PGAR_2_HPRCOM_VOL,
 			 0, 118, 1, output_stage_tlv),
@@ -424,6 +404,45 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_ENUM("Output Driver Ramp-up step", aic3x_rampup_step_enum),
 };
 
+/* For other than tlv320aic3104 */
+static const struct snd_kcontrol_new aic3x_extra_snd_controls[] = {
+	/*
+	 * Output controls that map to output mixer switches. Note these are
+	 * only for swapped L-to-R and R-to-L routes. See below stereo controls
+	 * for direct L-to-L and R-to-R routes.
+	 */
+	SOC_SINGLE_TLV("Left Line Mixer Line2R Bypass Volume",
+		       LINE2R_2_LLOPM_VOL, 0, 118, 1, output_stage_tlv),
+
+	SOC_SINGLE_TLV("Right Line Mixer Line2L Bypass Volume",
+		       LINE2L_2_RLOPM_VOL, 0, 118, 1, output_stage_tlv),
+
+	SOC_SINGLE_TLV("Left HP Mixer Line2R Bypass Volume",
+		       LINE2R_2_HPLOUT_VOL, 0, 118, 1, output_stage_tlv),
+
+	SOC_SINGLE_TLV("Right HP Mixer Line2L Bypass Volume",
+		       LINE2L_2_HPROUT_VOL, 0, 118, 1, output_stage_tlv),
+
+	SOC_SINGLE_TLV("Left HPCOM Mixer Line2R Bypass Volume",
+		       LINE2R_2_HPLCOM_VOL, 0, 118, 1, output_stage_tlv),
+
+	SOC_SINGLE_TLV("Right HPCOM Mixer Line2L Bypass Volume",
+		       LINE2L_2_HPRCOM_VOL, 0, 118, 1, output_stage_tlv),
+
+	/* Stereo output controls for direct L-to-L and R-to-R routes */
+	SOC_DOUBLE_R_TLV("Line Line2 Bypass Volume",
+			 LINE2L_2_LLOPM_VOL, LINE2R_2_RLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
+
+	SOC_DOUBLE_R_TLV("HP Line2 Bypass Volume",
+			 LINE2L_2_HPLOUT_VOL, LINE2R_2_HPROUT_VOL,
+			 0, 118, 1, output_stage_tlv),
+
+	SOC_DOUBLE_R_TLV("HPCOM Line2 Bypass Volume",
+			 LINE2L_2_HPLCOM_VOL, LINE2R_2_HPRCOM_VOL,
+			 0, 118, 1, output_stage_tlv),
+};
+
 static const struct snd_kcontrol_new aic3x_mono_controls[] = {
 	SOC_DOUBLE_R_TLV("Mono Line2 Bypass Volume",
 			 LINE2L_2_MONOLOPM_VOL, LINE2R_2_MONOLOPM_VOL,
@@ -464,22 +483,24 @@ SOC_DAPM_ENUM("Route", aic3x_right_hpcom_enum);
 
 /* Left Line Mixer */
 static const struct snd_kcontrol_new aic3x_left_line_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_LLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_LLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_LLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_LLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_LLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_LLOPM_VOL, 7, 1, 0),
+	/* Not on tlv320aic3104 */
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_LLOPM_VOL, 7, 1, 0),
 };
 
 /* Right Line Mixer */
 static const struct snd_kcontrol_new aic3x_right_line_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_RLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_RLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_RLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_RLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_RLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_RLOPM_VOL, 7, 1, 0),
+	/* Not on tlv320aic3104 */
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_RLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_RLOPM_VOL, 7, 1, 0),
 };
 
 /* Mono Mixer */
@@ -494,42 +515,46 @@ static const struct snd_kcontrol_new aic3x_mono_mixer_controls[] = {
 
 /* Left HP Mixer */
 static const struct snd_kcontrol_new aic3x_left_hp_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_HPLOUT_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_HPLOUT_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_HPLOUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_HPLOUT_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_HPLOUT_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_HPLOUT_VOL, 7, 1, 0),
+	/* Not on tlv320aic3104 */
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_HPLOUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_HPLOUT_VOL, 7, 1, 0),
 };
 
 /* Right HP Mixer */
 static const struct snd_kcontrol_new aic3x_right_hp_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_HPROUT_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_HPROUT_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_HPROUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_HPROUT_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_HPROUT_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_HPROUT_VOL, 7, 1, 0),
+	/* Not on tlv320aic3104 */
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_HPROUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_HPROUT_VOL, 7, 1, 0),
 };
 
 /* Left HPCOM Mixer */
 static const struct snd_kcontrol_new aic3x_left_hpcom_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_HPLCOM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_HPLCOM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_HPLCOM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_HPLCOM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_HPLCOM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_HPLCOM_VOL, 7, 1, 0),
+	/* Not on tlv320aic3104 */
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_HPLCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_HPLCOM_VOL, 7, 1, 0),
 };
 
 /* Right HPCOM Mixer */
 static const struct snd_kcontrol_new aic3x_right_hpcom_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_HPRCOM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_HPRCOM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_HPRCOM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_HPRCOM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_HPRCOM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_HPRCOM_VOL, 7, 1, 0),
+	/* Not on tlv320aic3104 */
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_HPRCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_HPRCOM_VOL, 7, 1, 0),
 };
 
 /* Left PGA Mixer */
@@ -550,6 +575,22 @@ static const struct snd_kcontrol_new aic3x_right_pga_mixer_controls[] = {
 	SOC_DAPM_SINGLE_AIC3X("Mic3R Switch", MIC3LR_2_RADC_CTRL, 0, 1, 1),
 };
 
+/* Left PGA Mixer for tlv320aic3104 */
+static const struct snd_kcontrol_new aic3104_left_pga_mixer_controls[] = {
+	SOC_DAPM_SINGLE_AIC3X("Line1L Switch", LINE1L_2_LADC_CTRL, 3, 1, 1),
+	SOC_DAPM_SINGLE_AIC3X("Line1R Switch", LINE1R_2_LADC_CTRL, 3, 1, 1),
+	SOC_DAPM_SINGLE_AIC3X("Mic2L Switch", MIC3LR_2_LADC_CTRL, 4, 1, 1),
+	SOC_DAPM_SINGLE_AIC3X("Mic2R Switch", MIC3LR_2_LADC_CTRL, 0, 1, 1),
+};
+
+/* Right PGA Mixer for tlv320aic3104 */
+static const struct snd_kcontrol_new aic3104_right_pga_mixer_controls[] = {
+	SOC_DAPM_SINGLE_AIC3X("Line1R Switch", LINE1R_2_RADC_CTRL, 3, 1, 1),
+	SOC_DAPM_SINGLE_AIC3X("Line1L Switch", LINE1L_2_RADC_CTRL, 3, 1, 1),
+	SOC_DAPM_SINGLE_AIC3X("Mic2L Switch", MIC3LR_2_RADC_CTRL, 4, 1, 1),
+	SOC_DAPM_SINGLE_AIC3X("Mic2R Switch", MIC3LR_2_RADC_CTRL, 0, 1, 1),
+};
+
 /* Left Line1 Mux */
 static const struct snd_kcontrol_new aic3x_left_line1l_mux_controls =
 SOC_DAPM_ENUM("Route", aic3x_line1l_2_l_enum);
@@ -593,26 +634,56 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 
 	/* Inputs to Left ADC */
 	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", LINE1L_2_LADC_CTRL, 2, 0),
-	SND_SOC_DAPM_MIXER("Left PGA Mixer", SND_SOC_NOPM, 0, 0,
-			   &aic3x_left_pga_mixer_controls[0],
-			   ARRAY_SIZE(aic3x_left_pga_mixer_controls)),
 	SND_SOC_DAPM_MUX("Left Line1L Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_left_line1l_mux_controls),
 	SND_SOC_DAPM_MUX("Left Line1R Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_left_line1r_mux_controls),
-	SND_SOC_DAPM_MUX("Left Line2L Mux", SND_SOC_NOPM, 0, 0,
-			 &aic3x_left_line2_mux_controls),
 
 	/* Inputs to Right ADC */
 	SND_SOC_DAPM_ADC("Right ADC", "Right Capture",
 			 LINE1R_2_RADC_CTRL, 2, 0),
-	SND_SOC_DAPM_MIXER("Right PGA Mixer", SND_SOC_NOPM, 0, 0,
-			   &aic3x_right_pga_mixer_controls[0],
-			   ARRAY_SIZE(aic3x_right_pga_mixer_controls)),
 	SND_SOC_DAPM_MUX("Right Line1L Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_right_line1l_mux_controls),
 	SND_SOC_DAPM_MUX("Right Line1R Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_right_line1r_mux_controls),
+
+	/* Mic Bias */
+	SND_SOC_DAPM_SUPPLY("Mic Bias", MICBIAS_CTRL, 6, 0,
+			 mic_bias_event,
+			 SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+
+	SND_SOC_DAPM_OUTPUT("LLOUT"),
+	SND_SOC_DAPM_OUTPUT("RLOUT"),
+	SND_SOC_DAPM_OUTPUT("HPLOUT"),
+	SND_SOC_DAPM_OUTPUT("HPROUT"),
+	SND_SOC_DAPM_OUTPUT("HPLCOM"),
+	SND_SOC_DAPM_OUTPUT("HPRCOM"),
+
+	SND_SOC_DAPM_INPUT("LINE1L"),
+	SND_SOC_DAPM_INPUT("LINE1R"),
+
+	/*
+	 * Virtual output pin to detection block inside codec. This can be
+	 * used to keep codec bias on if gpio or detection features are needed.
+	 * Force pin on or construct a path with an input jack and mic bias
+	 * widgets.
+	 */
+	SND_SOC_DAPM_OUTPUT("Detection"),
+};
+
+/* For other than tlv320aic3104 */
+static const struct snd_soc_dapm_widget aic3x_extra_dapm_widgets[] = {
+	/* Inputs to Left ADC */
+	SND_SOC_DAPM_MIXER("Left PGA Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_left_pga_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_left_pga_mixer_controls)),
+	SND_SOC_DAPM_MUX("Left Line2L Mux", SND_SOC_NOPM, 0, 0,
+			 &aic3x_left_line2_mux_controls),
+
+	/* Inputs to Right ADC */
+	SND_SOC_DAPM_MIXER("Right PGA Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_right_pga_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_right_pga_mixer_controls)),
 	SND_SOC_DAPM_MUX("Right Line2R Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_right_line2_mux_controls),
 
@@ -637,11 +708,6 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "DMic Rate 32",
 			 AIC3X_ASD_INTF_CTRLA, 0, 3, 3, 0),
 
-	/* Mic Bias */
-	SND_SOC_DAPM_SUPPLY("Mic Bias", MICBIAS_CTRL, 6, 0,
-			 mic_bias_event,
-			 SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-
 	/* Output mixers */
 	SND_SOC_DAPM_MIXER("Left Line Mixer", SND_SOC_NOPM, 0, 0,
 			   &aic3x_left_line_mixer_controls[0],
@@ -662,27 +728,46 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 			   &aic3x_right_hpcom_mixer_controls[0],
 			   ARRAY_SIZE(aic3x_right_hpcom_mixer_controls)),
 
-	SND_SOC_DAPM_OUTPUT("LLOUT"),
-	SND_SOC_DAPM_OUTPUT("RLOUT"),
-	SND_SOC_DAPM_OUTPUT("HPLOUT"),
-	SND_SOC_DAPM_OUTPUT("HPROUT"),
-	SND_SOC_DAPM_OUTPUT("HPLCOM"),
-	SND_SOC_DAPM_OUTPUT("HPRCOM"),
-
 	SND_SOC_DAPM_INPUT("MIC3L"),
 	SND_SOC_DAPM_INPUT("MIC3R"),
-	SND_SOC_DAPM_INPUT("LINE1L"),
-	SND_SOC_DAPM_INPUT("LINE1R"),
 	SND_SOC_DAPM_INPUT("LINE2L"),
 	SND_SOC_DAPM_INPUT("LINE2R"),
+};
 
-	/*
-	 * Virtual output pin to detection block inside codec. This can be
-	 * used to keep codec bias on if gpio or detection features are needed.
-	 * Force pin on or construct a path with an input jack and mic bias
-	 * widgets.
-	 */
-	SND_SOC_DAPM_OUTPUT("Detection"),
+/* For tlv320aic3104 */
+static const struct snd_soc_dapm_widget aic3104_extra_dapm_widgets[] = {
+	/* Inputs to Left ADC */
+	SND_SOC_DAPM_MIXER("Left PGA Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3104_left_pga_mixer_controls[0],
+			   ARRAY_SIZE(aic3104_left_pga_mixer_controls)),
+
+	/* Inputs to Right ADC */
+	SND_SOC_DAPM_MIXER("Right PGA Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3104_right_pga_mixer_controls[0],
+			   ARRAY_SIZE(aic3104_right_pga_mixer_controls)),
+
+	/* Output mixers */
+	SND_SOC_DAPM_MIXER("Left Line Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_left_line_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_left_line_mixer_controls) - 2),
+	SND_SOC_DAPM_MIXER("Right Line Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_right_line_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_right_line_mixer_controls) - 2),
+	SND_SOC_DAPM_MIXER("Left HP Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_left_hp_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_left_hp_mixer_controls) - 2),
+	SND_SOC_DAPM_MIXER("Right HP Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_right_hp_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_right_hp_mixer_controls) - 2),
+	SND_SOC_DAPM_MIXER("Left HPCOM Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_left_hpcom_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_left_hpcom_mixer_controls) - 2),
+	SND_SOC_DAPM_MIXER("Right HPCOM Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_right_hpcom_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_right_hpcom_mixer_controls) - 2),
+
+	SND_SOC_DAPM_INPUT("MIC2L"),
+	SND_SOC_DAPM_INPUT("MIC2R"),
 };
 
 static const struct snd_soc_dapm_widget aic3x_dapm_mono_widgets[] = {
@@ -712,17 +797,10 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Left Line1R Mux", "single-ended", "LINE1R"},
 	{"Left Line1R Mux", "differential", "LINE1R"},
 
-	{"Left Line2L Mux", "single-ended", "LINE2L"},
-	{"Left Line2L Mux", "differential", "LINE2L"},
-
 	{"Left PGA Mixer", "Line1L Switch", "Left Line1L Mux"},
 	{"Left PGA Mixer", "Line1R Switch", "Left Line1R Mux"},
-	{"Left PGA Mixer", "Line2L Switch", "Left Line2L Mux"},
-	{"Left PGA Mixer", "Mic3L Switch", "MIC3L"},
-	{"Left PGA Mixer", "Mic3R Switch", "MIC3R"},
 
 	{"Left ADC", NULL, "Left PGA Mixer"},
-	{"Left ADC", NULL, "GPIO1 dmic modclk"},
 
 	/* Right Input */
 	{"Right Line1R Mux", "single-ended", "LINE1R"},
@@ -730,25 +808,10 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Right Line1L Mux", "single-ended", "LINE1L"},
 	{"Right Line1L Mux", "differential", "LINE1L"},
 
-	{"Right Line2R Mux", "single-ended", "LINE2R"},
-	{"Right Line2R Mux", "differential", "LINE2R"},
-
 	{"Right PGA Mixer", "Line1L Switch", "Right Line1L Mux"},
 	{"Right PGA Mixer", "Line1R Switch", "Right Line1R Mux"},
-	{"Right PGA Mixer", "Line2R Switch", "Right Line2R Mux"},
-	{"Right PGA Mixer", "Mic3L Switch", "MIC3L"},
-	{"Right PGA Mixer", "Mic3R Switch", "MIC3R"},
 
 	{"Right ADC", NULL, "Right PGA Mixer"},
-	{"Right ADC", NULL, "GPIO1 dmic modclk"},
-
-	/*
-	 * Logical path between digital mic enable and GPIO1 modulator clock
-	 * output function
-	 */
-	{"GPIO1 dmic modclk", NULL, "DMic Rate 128"},
-	{"GPIO1 dmic modclk", NULL, "DMic Rate 64"},
-	{"GPIO1 dmic modclk", NULL, "DMic Rate 32"},
 
 	/* Left DAC Output */
 	{"Left DAC Mux", "DAC_L1", "Left DAC"},
@@ -761,10 +824,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Right DAC Mux", "DAC_R3", "Right DAC"},
 
 	/* Left Line Output */
-	{"Left Line Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
 	{"Left Line Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
 	{"Left Line Mixer", "DACL1 Switch", "Left DAC Mux"},
-	{"Left Line Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
 	{"Left Line Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
 	{"Left Line Mixer", "DACR1 Switch", "Right DAC Mux"},
 
@@ -773,10 +834,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"LLOUT", NULL, "Left Line Out"},
 
 	/* Right Line Output */
-	{"Right Line Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
 	{"Right Line Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
 	{"Right Line Mixer", "DACL1 Switch", "Left DAC Mux"},
-	{"Right Line Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
 	{"Right Line Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
 	{"Right Line Mixer", "DACR1 Switch", "Right DAC Mux"},
 
@@ -785,10 +844,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"RLOUT", NULL, "Right Line Out"},
 
 	/* Left HP Output */
-	{"Left HP Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
 	{"Left HP Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
 	{"Left HP Mixer", "DACL1 Switch", "Left DAC Mux"},
-	{"Left HP Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
 	{"Left HP Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
 	{"Left HP Mixer", "DACR1 Switch", "Right DAC Mux"},
 
@@ -797,10 +854,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HPLOUT", NULL, "Left HP Out"},
 
 	/* Right HP Output */
-	{"Right HP Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
 	{"Right HP Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
 	{"Right HP Mixer", "DACL1 Switch", "Left DAC Mux"},
-	{"Right HP Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
 	{"Right HP Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
 	{"Right HP Mixer", "DACR1 Switch", "Right DAC Mux"},
 
@@ -809,10 +864,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HPROUT", NULL, "Right HP Out"},
 
 	/* Left HPCOM Output */
-	{"Left HPCOM Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
 	{"Left HPCOM Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
 	{"Left HPCOM Mixer", "DACL1 Switch", "Left DAC Mux"},
-	{"Left HPCOM Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
 	{"Left HPCOM Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
 	{"Left HPCOM Mixer", "DACR1 Switch", "Right DAC Mux"},
 
@@ -823,10 +876,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HPLCOM", NULL, "Left HP Com"},
 
 	/* Right HPCOM Output */
-	{"Right HPCOM Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
 	{"Right HPCOM Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
 	{"Right HPCOM Mixer", "DACL1 Switch", "Left DAC Mux"},
-	{"Right HPCOM Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
 	{"Right HPCOM Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
 	{"Right HPCOM Mixer", "DACR1 Switch", "Right DAC Mux"},
 
@@ -839,6 +890,72 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HPRCOM", NULL, "Right HP Com"},
 };
 
+/* For other than tlv320aic3104 */
+static const struct snd_soc_dapm_route intercon_extra[] = {
+	/* Left Input */
+	{"Left Line2L Mux", "single-ended", "LINE2L"},
+	{"Left Line2L Mux", "differential", "LINE2L"},
+
+	{"Left PGA Mixer", "Line2L Switch", "Left Line2L Mux"},
+	{"Left PGA Mixer", "Mic3L Switch", "MIC3L"},
+	{"Left PGA Mixer", "Mic3R Switch", "MIC3R"},
+
+	{"Left ADC", NULL, "GPIO1 dmic modclk"},
+
+	/* Right Input */
+	{"Right Line2R Mux", "single-ended", "LINE2R"},
+	{"Right Line2R Mux", "differential", "LINE2R"},
+
+	{"Right PGA Mixer", "Line2R Switch", "Right Line2R Mux"},
+	{"Right PGA Mixer", "Mic3L Switch", "MIC3L"},
+	{"Right PGA Mixer", "Mic3R Switch", "MIC3R"},
+
+	{"Right ADC", NULL, "GPIO1 dmic modclk"},
+
+	/*
+	 * Logical path between digital mic enable and GPIO1 modulator clock
+	 * output function
+	 */
+	{"GPIO1 dmic modclk", NULL, "DMic Rate 128"},
+	{"GPIO1 dmic modclk", NULL, "DMic Rate 64"},
+	{"GPIO1 dmic modclk", NULL, "DMic Rate 32"},
+
+	/* Left Line Output */
+	{"Left Line Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Left Line Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+
+	/* Right Line Output */
+	{"Right Line Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Right Line Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+
+	/* Left HP Output */
+	{"Left HP Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Left HP Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+
+	/* Right HP Output */
+	{"Right HP Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Right HP Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+
+	/* Left HPCOM Output */
+	{"Left HPCOM Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Left HPCOM Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+
+	/* Right HPCOM Output */
+	{"Right HPCOM Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Right HPCOM Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+};
+
+/* For other than tlv320aic3104 */
+static const struct snd_soc_dapm_route intercon_extra_3104[] = {
+	/* Left Input */
+	{"Left PGA Mixer", "Mic2L Switch", "MIC2L"},
+	{"Left PGA Mixer", "Mic2R Switch", "MIC2R"},
+
+	/* Right Input */
+	{"Right PGA Mixer", "Mic2L Switch", "MIC2L"},
+	{"Right PGA Mixer", "Mic2R Switch", "MIC2R"},
+};
+
 static const struct snd_soc_dapm_route intercon_mono[] = {
 	/* Mono Output */
 	{"Mono Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
@@ -867,17 +984,31 @@ static int aic3x_add_widgets(struct snd_soc_codec *codec)
 	switch (aic3x->model) {
 	case AIC3X_MODEL_3X:
 	case AIC3X_MODEL_33:
+		snd_soc_dapm_new_controls(dapm, aic3x_extra_dapm_widgets,
+					  ARRAY_SIZE(aic3x_extra_dapm_widgets));
+		snd_soc_dapm_add_routes(dapm, intercon_extra,
+					ARRAY_SIZE(intercon_extra));
 		snd_soc_dapm_new_controls(dapm, aic3x_dapm_mono_widgets,
 			ARRAY_SIZE(aic3x_dapm_mono_widgets));
 		snd_soc_dapm_add_routes(dapm, intercon_mono,
 					ARRAY_SIZE(intercon_mono));
 		break;
 	case AIC3X_MODEL_3007:
+		snd_soc_dapm_new_controls(dapm, aic3x_extra_dapm_widgets,
+					  ARRAY_SIZE(aic3x_extra_dapm_widgets));
+		snd_soc_dapm_add_routes(dapm, intercon_extra,
+					ARRAY_SIZE(intercon_extra));
 		snd_soc_dapm_new_controls(dapm, aic3007_dapm_widgets,
 			ARRAY_SIZE(aic3007_dapm_widgets));
 		snd_soc_dapm_add_routes(dapm, intercon_3007,
 					ARRAY_SIZE(intercon_3007));
 		break;
+	case AIC3X_MODEL_3104:
+		snd_soc_dapm_new_controls(dapm, aic3104_extra_dapm_widgets,
+				ARRAY_SIZE(aic3104_extra_dapm_widgets));
+		snd_soc_dapm_add_routes(dapm, intercon_extra_3104,
+				ARRAY_SIZE(intercon_extra_3104));
+		break;
 	}
 
 	return 0;
@@ -1438,23 +1569,33 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 	aic3x_init(codec);
 
 	if (aic3x->setup) {
-		/* setup GPIO functions */
-		snd_soc_write(codec, AIC3X_GPIO1_REG,
-			      (aic3x->setup->gpio_func[0] & 0xf) << 4);
-		snd_soc_write(codec, AIC3X_GPIO2_REG,
-			      (aic3x->setup->gpio_func[1] & 0xf) << 4);
+		if (aic3x->model != AIC3X_MODEL_3104) {
+			/* setup GPIO functions */
+			snd_soc_write(codec, AIC3X_GPIO1_REG,
+				      (aic3x->setup->gpio_func[0] & 0xf) << 4);
+			snd_soc_write(codec, AIC3X_GPIO2_REG,
+				      (aic3x->setup->gpio_func[1] & 0xf) << 4);
+		} else {
+			dev_warn(codec->dev, "GPIO functionality is not supported on tlv320aic3104\n");
+		}
 	}
 
 	switch (aic3x->model) {
 	case AIC3X_MODEL_3X:
 	case AIC3X_MODEL_33:
+		snd_soc_add_codec_controls(codec, aic3x_extra_snd_controls,
+				ARRAY_SIZE(aic3x_extra_snd_controls));
 		snd_soc_add_codec_controls(codec, aic3x_mono_controls,
 				ARRAY_SIZE(aic3x_mono_controls));
 		break;
 	case AIC3X_MODEL_3007:
+		snd_soc_add_codec_controls(codec, aic3x_extra_snd_controls,
+				ARRAY_SIZE(aic3x_extra_snd_controls));
 		snd_soc_add_codec_controls(codec,
 				&aic3x_classd_amp_gain_ctrl, 1);
 		break;
+	case AIC3X_MODEL_3104:
+		break;
 	}
 
 	/* set mic bias voltage */
@@ -1522,6 +1663,7 @@ static const struct i2c_device_id aic3x_i2c_id[] = {
 	{ "tlv320aic33", AIC3X_MODEL_33 },
 	{ "tlv320aic3007", AIC3X_MODEL_3007 },
 	{ "tlv320aic3106", AIC3X_MODEL_3X },
+	{ "tlv320aic3104", AIC3X_MODEL_3104 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
@@ -1673,6 +1815,7 @@ static const struct of_device_id tlv320aic3x_of_match[] = {
 	{ .compatible = "ti,tlv320aic33" },
 	{ .compatible = "ti,tlv320aic3007" },
 	{ .compatible = "ti,tlv320aic3106" },
+	{ .compatible = "ti,tlv320aic3104" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tlv320aic3x_of_match);
-- 
1.9.1

