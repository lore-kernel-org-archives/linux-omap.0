From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 05/19] Code clean-up for sound/arm/omap/omap-alsa-aic23-mixer.c
Date: Fri, 18 Apr 2008 04:00:52 -0400
Message-ID: <1208505666-13744-6-git-send-email-edubezval@gmail.com>
References: <1208505666-13744-1-git-send-email-edubezval@gmail.com>
 <1208505666-13744-2-git-send-email-edubezval@gmail.com>
 <1208505666-13744-3-git-send-email-edubezval@gmail.com>
 <1208505666-13744-4-git-send-email-edubezval@gmail.com>
 <1208505666-13744-5-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18877 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090AbYDRIBj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:39 -0400
In-Reply-To: <1208505666-13744-5-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-aic23-mixer.c |  144 ++++++++++++++++++-------------
 sound/arm/omap/omap-alsa-aic23.h       |    1 +
 2 files changed, 85 insertions(+), 60 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-aic23-mixer.c b/sound/arm/omap/omap-alsa-aic23-mixer.c
index ce55824..7f06582 100644
--- a/sound/arm/omap/omap-alsa-aic23-mixer.c
+++ b/sound/arm/omap/omap-alsa-aic23-mixer.c
@@ -46,7 +46,9 @@
 #include <sound/initval.h>
 #include <sound/control.h>
 
-MODULE_AUTHOR("David Cohen, Daniel Petrini - INdT");
+MODULE_AUTHOR("David Cohen");
+MODULE_AUTHOR("Daniel Petrini");
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("OMAP Alsa mixer driver for ALSA");
 
@@ -55,9 +57,8 @@ MODULE_DESCRIPTION("OMAP Alsa mixer driver for ALSA");
  */
 
 /* Codec AIC23 */
-#if defined(CONFIG_SENSORS_TLV320AIC23) || defined (CONFIG_SENSORS_TLV320AIC23_MODULE)
-
-extern void audio_aic23_write(u8, u16);
+#if defined(CONFIG_SENSORS_TLV320AIC23) || \
+	defined(CONFIG_SENSORS_TLV320AIC23_MODULE)
 
 #define MIXER_NAME		     "Mixer AIC23"
 #define SND_OMAP_WRITE(reg, val)     audio_aic23_write(reg, val)
@@ -73,7 +74,8 @@ extern void audio_aic23_write(u8, u16);
 	.info = snd_omap_info_bool, \
 	.get = snd_omap_get_bool, \
 	.put = snd_omap_put_bool, \
-	.private_value = reg | (reg_index << 8) | (invert << 10) | (mask << 12) \
+	.private_value = reg | (reg_index << 8) | (invert << 10) | \
+				(mask << 12) \
 }
 
 #define OMAP_MUX(xname, reg, reg_index, mask) \
@@ -94,7 +96,8 @@ extern void audio_aic23_write(u8, u16);
 	.info = snd_omap_info_single, \
 	.get = snd_omap_get_single, \
 	.put = snd_omap_put_single, \
-	.private_value = reg | (reg_val << 8) | (reg_index << 16) | (mask << 18) \
+	.private_value = reg | (reg_val << 8) | (reg_index << 16) |\
+				(mask << 18) \
 }
 
 #define OMAP_DOUBLE(xname, xindex, left_reg, right_reg, reg_index, mask) \
@@ -105,7 +108,8 @@ extern void audio_aic23_write(u8, u16);
 	.info = snd_omap_info_double, \
 	.get = snd_omap_get_double, \
 	.put = snd_omap_put_double, \
-	.private_value = left_reg | (right_reg << 8) | (reg_index << 16) | (mask << 18) \
+	.private_value = left_reg | (right_reg << 8) | (reg_index << 16) | \
+				(mask << 18) \
 }
 
 /* Local Registers */
@@ -141,7 +145,7 @@ u16 snd_sidetone[6] = {
 /* Begin Bool Functions */
 
 static int snd_omap_info_bool(struct snd_kcontrol *kcontrol,
-			      struct snd_ctl_elem_info * uinfo)
+				struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;
@@ -151,8 +155,8 @@ static int snd_omap_info_bool(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_omap_get_bool(struct snd_kcontrol * kcontrol,
-			     struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_get_bool(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	int mic_index = (kcontrol->private_value >> 8) & 0x03;
 	u16 mask = (kcontrol->private_value >> 12) & 0xff;
@@ -168,8 +172,8 @@ static int snd_omap_get_bool(struct snd_kcontrol * kcontrol,
 	return 0;
 }
 
-static int snd_omap_put_bool(struct snd_kcontrol * kcontrol,
-			     struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_put_bool(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	int mic_index = (kcontrol->private_value >> 8) & 0x03;
 	u16 mask = (kcontrol->private_value >> 12) & 0xff;
@@ -199,7 +203,7 @@ static int snd_omap_put_bool(struct snd_kcontrol * kcontrol,
 /* Begin Mux Functions */
 
 static int snd_omap_info_mux(struct snd_kcontrol *kcontrol,
-			     struct snd_ctl_elem_info * uinfo)
+				struct snd_ctl_elem_info *uinfo)
 {
 	/* Mic = 0
 	 * Line = 1 */
@@ -218,20 +222,20 @@ static int snd_omap_info_mux(struct snd_kcontrol *kcontrol,
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
@@ -254,7 +258,7 @@ static int snd_omap_put_mux(struct snd_kcontrol * kcontrol,
 /* Begin Single Functions */
 
 static int snd_omap_info_single(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_info * uinfo)
+				struct snd_ctl_elem_info *uinfo)
 {
 	int mask = (kcontrol->private_value >> 18) & 0xff;
 	int reg_val = (kcontrol->private_value >> 8) & 0xff;
@@ -268,8 +272,8 @@ static int snd_omap_info_single(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_omap_get_single(struct snd_kcontrol * kcontrol,
-			       struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_get_single(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	u16 reg_val = (kcontrol->private_value >> 8) & 0xff;
 
@@ -278,8 +282,8 @@ static int snd_omap_get_single(struct snd_kcontrol * kcontrol,
 	return 0;
 }
 
-static int snd_omap_put_single(struct snd_kcontrol * kcontrol,
-			       struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_put_single(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	u16 reg_index = (kcontrol->private_value >> 16) & 0x03;
 	u16 mask = (kcontrol->private_value >> 18) & 0x1ff;
@@ -311,10 +315,12 @@ static int snd_omap_put_single(struct snd_kcontrol * kcontrol,
 /* Begin Double Functions */
 
 static int snd_omap_info_double(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_info * uinfo)
+				struct snd_ctl_elem_info *uinfo)
 {
-	/* mask == 0 : Switch
-	 * mask != 0 : Volume */
+	/*
+	 * mask == 0 : Switch
+	 * mask != 0 : Volume
+	 */
 	int mask = (kcontrol->private_value >> 18) & 0xff;
 
 	uinfo->type = mask ? SNDRV_CTL_ELEM_TYPE_INTEGER :
@@ -326,11 +332,13 @@ static int snd_omap_info_double(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_omap_get_double(struct snd_kcontrol * kcontrol,
-			       struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_get_double(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
-	/* mask == 0 : Switch
-	 * mask != 0 : Volume */
+	/*
+	 * mask == 0 : Switch
+	 * mask != 0 : Volume
+	 */
 	int mask = (kcontrol->private_value >> 18) & 0xff;
 	int vol_index = (kcontrol->private_value >> 16) & 0x03;
 
@@ -346,8 +354,8 @@ static int snd_omap_get_double(struct snd_kcontrol * kcontrol,
 	return 0;
 }
 
-static int snd_omap_put_double(struct snd_kcontrol * kcontrol,
-			       struct snd_ctl_elem_value * ucontrol)
+static int snd_omap_put_double(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	/* mask == 0 : Switch
 	 * mask != 0 : Volume */
@@ -371,8 +379,10 @@ static int snd_omap_put_double(struct snd_kcontrol * kcontrol,
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
@@ -383,11 +393,12 @@ static int snd_omap_put_double(struct snd_kcontrol * kcontrol,
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
@@ -398,20 +409,27 @@ static int snd_omap_put_double(struct snd_kcontrol * kcontrol,
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
@@ -447,8 +465,10 @@ void snd_omap_resume_mixer(void)
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
 
@@ -460,8 +480,10 @@ void snd_omap_init_mixer(void)
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
@@ -490,10 +512,12 @@ int snd_omap_mixer(struct snd_card_omap_codec *chip)
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
index 66dc56b..e7dfc15 100644
--- a/sound/arm/omap/omap-alsa-aic23.h
+++ b/sound/arm/omap/omap-alsa-aic23.h
@@ -74,6 +74,7 @@ extern int aic23_write_value(u8 reg, u16 value);
  * Defines codec specific function pointers that can be used from the
  * common omap-alsa base driver for all omap codecs. (tsc2101 and aic23)
  */
+void audio_aic23_write(u8 address, u16 data);
 void define_codec_functions(struct omap_alsa_codec_config *codec_config);
 inline void aic23_configure(void);
 void aic23_set_samplerate(long rate);
-- 
1.5.5-rc3.GIT

