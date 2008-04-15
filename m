From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 05/19] Code clean-up for sound/arm/omap/omap-alsa-aic23-mixer.c
Date: Tue, 15 Apr 2008 10:02:09 -0400
Message-ID: <1208268143-8789-6-git-send-email-edubezval@gmail.com>
References: <1208268143-8789-1-git-send-email-edubezval@gmail.com>
 <1208268143-8789-2-git-send-email-edubezval@gmail.com>
 <1208268143-8789-3-git-send-email-edubezval@gmail.com>
 <1208268143-8789-4-git-send-email-edubezval@gmail.com>
 <1208268143-8789-5-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48074 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759961AbYDOOCf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:35 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE2PD6018693
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 17:02:32 +0300
In-Reply-To: <1208268143-8789-5-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-aic23-mixer.c |  138 ++++++++++++++++++-------------
 sound/arm/omap/omap-alsa-aic23.h       |    1 +
 2 files changed, 81 insertions(+), 58 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-aic23-mixer.c b/sound/arm/omap/omap-alsa-aic23-mixer.c
index 38be650..58eeaed 100644
--- a/sound/arm/omap/omap-alsa-aic23-mixer.c
+++ b/sound/arm/omap/omap-alsa-aic23-mixer.c
@@ -47,7 +47,9 @@
 #include <sound/initval.h>
 #include <sound/control.h>
 
-MODULE_AUTHOR("David Cohen, Daniel Petrini - INdT");
+MODULE_AUTHOR("David Cohen");
+MODULE_AUTHOR("Daniel Petrini");
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("OMAP Alsa mixer driver for ALSA");
 
@@ -56,9 +58,8 @@ MODULE_DESCRIPTION("OMAP Alsa mixer driver for ALSA");
  */
 
 /* Codec AIC23 */
-#if defined(CONFIG_SENSORS_TLV320AIC23) || defined (CONFIG_SENSORS_TLV320AIC23_MODULE)
-
-extern void audio_aic23_write(u8, u16);
+#if defined(CONFIG_SENSORS_TLV320AIC23) || \
+	defined(CONFIG_SENSORS_TLV320AIC23_MODULE)
 
 #define MIXER_NAME		     "Mixer AIC23"
 #define SND_OMAP_WRITE(reg, val)     audio_aic23_write(reg, val)
@@ -74,7 +75,8 @@ extern void audio_aic23_write(u8, u16);
 	.info = snd_omap_info_bool, \
 	.get = snd_omap_get_bool, \
 	.put = snd_omap_put_bool, \
-	.private_value = reg | (reg_index << 8) | (invert << 10) | (mask << 12) \
+	.private_value = reg | (reg_index << 8) | (invert << 10) \
+				| (mask << 12) \
 }
 
 #define OMAP_MUX(xname, reg, reg_index, mask) \
@@ -95,7 +97,8 @@ extern void audio_aic23_write(u8, u16);
 	.info = snd_omap_info_single, \
 	.get = snd_omap_get_single, \
 	.put = snd_omap_put_single, \
-	.private_value = reg | (reg_val << 8) | (reg_index << 16) | (mask << 18) \
+	.private_value = reg | (reg_val << 8) | (reg_index << 16) \
+				| (mask << 18) \
 }
 
 #define OMAP_DOUBLE(xname, xindex, left_reg, right_reg, reg_index, mask) \
@@ -106,7 +109,8 @@ extern void audio_aic23_write(u8, u16);
 	.info = snd_omap_info_double, \
 	.get = snd_omap_get_double, \
 	.put = snd_omap_put_double, \
-	.private_value = left_reg | (right_reg << 8) | (reg_index << 16) | (mask << 18) \
+	.private_value = left_reg | (right_reg << 8) | (reg_index << 16) \
+				| (mask << 18) \
 }
 
 /* Local Registers */
@@ -142,7 +146,7 @@ u16 snd_sidetone[6] = {
 /* Begin Bool Functions */
 
 static int snd_omap_info_bool(struct snd_kcontrol *kcontrol,
-			      struct snd_ctl_elem_info * uinfo)
+				struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;
@@ -152,8 +156,8 @@ static int snd_omap_info_bool(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_omap_get_bool(struct snd_kcontrol * kcontrol,
-			     struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_get_bool(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	int mic_index = (kcontrol->private_value >> 8) & 0x03;
 	u16 mask = (kcontrol->private_value >> 12) & 0xff;
@@ -169,8 +173,8 @@ static int snd_omap_get_bool(struct snd_kcontrol * kcontrol,
 	return 0;
 }
 
-static int snd_omap_put_bool(struct snd_kcontrol * kcontrol,
-			     struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_put_bool(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	int mic_index = (kcontrol->private_value >> 8) & 0x03;
 	u16 mask = (kcontrol->private_value >> 12) & 0xff;
@@ -200,7 +204,7 @@ static int snd_omap_put_bool(struct snd_kcontrol * kcontrol,
 /* Begin Mux Functions */
 
 static int snd_omap_info_mux(struct snd_kcontrol *kcontrol,
-			     struct snd_ctl_elem_info * uinfo)
+				struct snd_ctl_elem_info *uinfo)
 {
 	/* Mic = 0
 	 * Line = 1 */
@@ -219,20 +223,20 @@ static int snd_omap_info_mux(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_omap_get_mux(struct snd_kcontrol * kcontrol,
-			    struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_get_mux(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	u16 mask = (kcontrol->private_value >> 10) & 0xff;
-	int mux_index = (kcontrol->private_value >> 8) & 0x03;
+	int mux_idx = (kcontrol->private_value >> 8) & 0x03;
 
 	ucontrol->value.enumerated.item[0] =
-		(omap_regs[mux_index].l_reg & mask) ? 0 /* Mic */ : 1 /* Line */;
+		(omap_regs[mux_idx].l_reg & mask) ? 0 /* Mic */ : 1 /* Line */;
 
 	return 0;
 }
 
-static int snd_omap_put_mux(struct snd_kcontrol * kcontrol,
-			    struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_put_mux(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	u16 reg = kcontrol->private_value & 0xff;
 	u16 mask = (kcontrol->private_value >> 10) & 0xff;
@@ -255,7 +259,7 @@ static int snd_omap_put_mux(struct snd_kcontrol * kcontrol,
 /* Begin Single Functions */
 
 static int snd_omap_info_single(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_info * uinfo)
+				struct snd_ctl_elem_info *uinfo)
 {
 	int mask = (kcontrol->private_value >> 18) & 0xff;
 	int reg_val = (kcontrol->private_value >> 8) & 0xff;
@@ -269,8 +273,8 @@ static int snd_omap_info_single(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_omap_get_single(struct snd_kcontrol * kcontrol,
-			       struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_get_single(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	u16 reg_val = (kcontrol->private_value >> 8) & 0xff;
 
@@ -279,8 +283,8 @@ static int snd_omap_get_single(struct snd_kcontrol * kcontrol,
 	return 0;
 }
 
-static int snd_omap_put_single(struct snd_kcontrol * kcontrol,
-			       struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_put_single(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	u16 reg_index = (kcontrol->private_value >> 16) & 0x03;
 	u16 mask = (kcontrol->private_value >> 18) & 0x1ff;
@@ -312,10 +316,11 @@ static int snd_omap_put_single(struct snd_kcontrol * kcontrol,
 /* Begin Double Functions */
 
 static int snd_omap_info_double(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_info * uinfo)
+				struct snd_ctl_elem_info *uinfo)
 {
 	/* mask == 0 : Switch
-	 * mask != 0 : Volume */
+	 * mask != 0 : Volume
+	 */
 	int mask = (kcontrol->private_value >> 18) & 0xff;
 
 	uinfo->type = mask ? SNDRV_CTL_ELEM_TYPE_INTEGER :
@@ -327,11 +332,12 @@ static int snd_omap_info_double(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_omap_get_double(struct snd_kcontrol * kcontrol,
-			       struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_get_double(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	/* mask == 0 : Switch
-	 * mask != 0 : Volume */
+	 * mask != 0 : Volume
+	 */
 	int mask = (kcontrol->private_value >> 18) & 0xff;
 	int vol_index = (kcontrol->private_value >> 16) & 0x03;
 
@@ -347,8 +353,8 @@ static int snd_omap_get_double(struct snd_kcontrol * kcontrol,
 	return 0;
 }
 
-static int snd_omap_put_double(struct snd_kcontrol * kcontrol,
-			       struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_put_double(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	/* mask == 0 : Switch
 	 * mask != 0 : Volume */
@@ -372,8 +378,10 @@ static int snd_omap_put_double(struct snd_kcontrol * kcontrol,
 		omap_regs[vol_index].sw = ucontrol->value.integer.value[0];
 	} else {
 		/* Volume */
-		if ((omap_regs[vol_index].l_reg != (ucontrol->value.integer.value[0] & mask)) ||
-			(omap_regs[vol_index].r_reg != (ucontrol->value.integer.value[1] & mask))) {
+		if ((omap_regs[vol_index].l_reg !=
+				(ucontrol->value.integer.value[0] & mask)) ||
+			(omap_regs[vol_index].r_reg !=
+				(ucontrol->value.integer.value[1] & mask))) {
 			changed = 1;
 
 			omap_regs[vol_index].l_reg &= ~mask;
@@ -384,11 +392,12 @@ static int snd_omap_put_double(struct snd_kcontrol * kcontrol,
 				(ucontrol->value.integer.value[1] & mask);
 			if (omap_regs[vol_index].sw) {
 				/* write to registers only if sw is actived */
-				SND_OMAP_WRITE(left_reg, omap_regs[vol_index].l_reg);
-				SND_OMAP_WRITE(right_reg, omap_regs[vol_index].r_reg);
+				SND_OMAP_WRITE(left_reg,
+						omap_regs[vol_index].l_reg);
+				SND_OMAP_WRITE(right_reg,
+						omap_regs[vol_index].r_reg);
 			}
-		}
-		else {
+		} else {
 			changed = 0;
 		}
 	}
@@ -399,20 +408,27 @@ static int snd_omap_put_double(struct snd_kcontrol * kcontrol,
 /* End Double Functions */
 
 static struct snd_kcontrol_new snd_omap_controls[] = {
-	OMAP_DOUBLE("PCM Playback Switch", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
-		     PCM_INDEX, 0x00),
-	OMAP_DOUBLE("PCM Playback Volume", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
-		     PCM_INDEX, OUTPUT_VOLUME_MASK),
-	OMAP_BOOL("Line Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, BYPASS_ON, 0),
-	OMAP_DOUBLE("Line Capture Switch", 0, LEFT_LINE_VOLUME_ADDR, RIGHT_LINE_VOLUME_ADDR,
-		     LINE_INDEX, 0x00),
-	OMAP_DOUBLE("Line Capture Volume", 0, LEFT_LINE_VOLUME_ADDR, RIGHT_LINE_VOLUME_ADDR,
-			 LINE_INDEX, INPUT_VOLUME_MASK),
-	OMAP_BOOL("Mic Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, STE_ENABLED, 0),
-	OMAP_SINGLE("Mic Playback Volume", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, 5, SIDETONE_MASK),
-	OMAP_BOOL("Mic Capture Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICM_MUTED, 1),
-	OMAP_BOOL("Mic Booster Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICB_20DB, 0),
-	OMAP_MUX("Capture Source", ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, INSEL_MIC),
+	OMAP_DOUBLE("PCM Playback Switch", 0, LEFT_CHANNEL_VOLUME_ADDR,
+			RIGHT_CHANNEL_VOLUME_ADDR, PCM_INDEX, 0x00),
+	OMAP_DOUBLE("PCM Playback Volume", 0, LEFT_CHANNEL_VOLUME_ADDR,
+			RIGHT_CHANNEL_VOLUME_ADDR, PCM_INDEX,
+			OUTPUT_VOLUME_MASK),
+	OMAP_BOOL("Line Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR,
+			AAC_INDEX, BYPASS_ON, 0),
+	OMAP_DOUBLE("Line Capture Switch", 0, LEFT_LINE_VOLUME_ADDR,
+			RIGHT_LINE_VOLUME_ADDR, LINE_INDEX, 0x00),
+	OMAP_DOUBLE("Line Capture Volume", 0, LEFT_LINE_VOLUME_ADDR,
+			RIGHT_LINE_VOLUME_ADDR, LINE_INDEX, INPUT_VOLUME_MASK),
+	OMAP_BOOL("Mic Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR,
+			AAC_INDEX, STE_ENABLED, 0),
+	OMAP_SINGLE("Mic Playback Volume", 0, ANALOG_AUDIO_CONTROL_ADDR,
+			AAC_INDEX, 5, SIDETONE_MASK),
+	OMAP_BOOL("Mic Capture Switch", 0, ANALOG_AUDIO_CONTROL_ADDR,
+			AAC_INDEX, MICM_MUTED, 1),
+	OMAP_BOOL("Mic Booster Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR,
+			AAC_INDEX, MICB_20DB, 0),
+	OMAP_MUX("Capture Source", ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX,
+			INSEL_MIC),
 };
 
 #ifdef CONFIG_PM
@@ -448,8 +464,10 @@ void snd_omap_resume_mixer(void)
 	omap_regs[PCM_INDEX].l_reg = omap_pm_regs[PCM_INDEX].l_reg;
 	omap_regs[PCM_INDEX].r_reg = omap_pm_regs[PCM_INDEX].r_reg;
 	omap_regs[PCM_INDEX].sw = omap_pm_regs[PCM_INDEX].sw;
-	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR, omap_pm_regs[PCM_INDEX].l_reg);
-	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR, omap_pm_regs[PCM_INDEX].r_reg);
+	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR,
+			omap_pm_regs[PCM_INDEX].l_reg);
+	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR,
+			omap_pm_regs[PCM_INDEX].r_reg);
 }
 #endif
 
@@ -461,8 +479,10 @@ void snd_omap_init_mixer(void)
 	omap_regs[LINE_INDEX].l_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
 	omap_regs[LINE_INDEX].r_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
 	omap_regs[LINE_INDEX].sw = 0;
-	SND_OMAP_WRITE(LEFT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
-	SND_OMAP_WRITE(RIGHT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
+	SND_OMAP_WRITE(LEFT_LINE_VOLUME_ADDR,
+			DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
+	SND_OMAP_WRITE(RIGHT_LINE_VOLUME_ADDR,
+			DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
 
 	/* Analog Audio Control's default values */
 	omap_regs[AAC_INDEX].l_reg = DEFAULT_ANALOG_AUDIO_CONTROL;
@@ -491,10 +511,12 @@ int snd_omap_mixer(struct snd_card_omap_codec *chip)
 	strcpy(card->mixername, MIXER_NAME);
 
 	/* Registering alsa mixer controls */
-	for (idx = 0; idx < ARRAY_SIZE(snd_omap_controls); idx++)
-		if ((err = snd_ctl_add(card,
-			snd_ctl_new1(&snd_omap_controls[idx], chip))) < 0)
+	for (idx = 0; idx < ARRAY_SIZE(snd_omap_controls); idx++) {
+		err = snd_ctl_add(card,
+			snd_ctl_new1(&snd_omap_controls[idx], chip));
+		if (err < 0)
 			return err;
+	}
 
 	return 0;
 }
diff --git a/sound/arm/omap/omap-alsa-aic23.h b/sound/arm/omap/omap-alsa-aic23.h
index a5a360e..c3d5fff 100644
--- a/sound/arm/omap/omap-alsa-aic23.h
+++ b/sound/arm/omap/omap-alsa-aic23.h
@@ -75,6 +75,7 @@ extern int aic23_write_value(u8 reg, u16 value);
  * Defines codec specific function pointers that can be used from the
  * common omap-alsa base driver for all omap codecs. (tsc2101 and aic23)
  */
+void audio_aic23_write(u8 address, u16 data);
 void define_codec_functions(struct omap_alsa_codec_config *codec_config);
 inline void aic23_configure(void);
 void aic23_set_samplerate(long rate);
-- 
1.5.5-rc3.GIT

