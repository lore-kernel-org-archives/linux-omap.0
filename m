From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 03/19] Code clean-up for sound/arm/omap/omap-alsa-aic23.c
Date: Tue, 15 Apr 2008 10:02:07 -0400
Message-ID: <1208268143-8789-4-git-send-email-edubezval@gmail.com>
References: <1208268143-8789-1-git-send-email-edubezval@gmail.com>
 <1208268143-8789-2-git-send-email-edubezval@gmail.com>
 <1208268143-8789-3-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40396 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbYDOOCc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:32 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE2OtF008356
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 17:02:29 +0300
In-Reply-To: <1208268143-8789-3-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-aic23.c |   59 ++++++++++++++++++++------------------
 sound/arm/omap/omap-alsa-aic23.h |    2 +
 2 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-aic23.c b/sound/arm/omap/omap-alsa-aic23.c
index 1e8a101..1fc13bb 100644
--- a/sound/arm/omap/omap-alsa-aic23.c
+++ b/sound/arm/omap/omap-alsa-aic23.c
@@ -1,6 +1,6 @@
 /*
  * arch/arm/mach-omap1/omap-alsa-aic23.c
- * 
+ *
  * Alsa codec Driver for AIC23 chip on OSK5912 platform board
  *
  * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
@@ -8,7 +8,7 @@
  *            {daniel.petrini, david.cohen, anderson.briglia}@indt.org.br
  *
  * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
- * 
+ *
  * Based in former alsa driver for osk and oss driver
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -29,7 +29,7 @@
 #include <asm/arch/omap-alsa.h>
 #include "omap-alsa-aic23.h"
 
-static struct clk *aic23_mclk = 0;
+static struct clk *aic23_mclk;
 
 /* aic23 related */
 static const struct aic23_samplerate_reg_info
@@ -49,7 +49,7 @@ static const struct aic23_samplerate_reg_info
 /*
  * Hardware capabilities
  */
- 
+
  /*
  * DAC USB-mode sampling rates (MCLK = 12 MHz)
  * The rates and rate_reg_into MUST be in the same order
@@ -68,7 +68,7 @@ static struct snd_pcm_hw_constraint_list aic23_hw_constraints_rates = {
 
 static struct snd_pcm_hardware aic23_snd_omap_alsa_playback = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),	
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
 	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
 	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
 		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
@@ -113,8 +113,6 @@ static struct snd_pcm_hardware aic23_snd_omap_alsa_capture = {
  * codec dependent code.
  */
 
-extern int aic23_write_value(u8 reg, u16 value);
-
 /* TLV320AIC23 is a write only device */
 void audio_aic23_write(u8 address, u16 data)
 {
@@ -173,8 +171,12 @@ inline void aic23_configure(void)
 
 	/* Initialize the AIC23 internal state */
 
-	/* Analog audio path control, DAC selected, delete INSEL_MIC for line in */
-	audio_aic23_write(ANALOG_AUDIO_CONTROL_ADDR, DEFAULT_ANALOG_AUDIO_CONTROL);
+	/*
+	 * Analog audio path control, DAC selected,
+	 * delete INSEL_MIC for line-in
+	 */
+	audio_aic23_write(ANALOG_AUDIO_CONTROL_ADDR,
+				DEFAULT_ANALOG_AUDIO_CONTROL);
 
 	/* Digital audio path control, de-emphasis control 44.1kHz */
 	audio_aic23_write(DIGITAL_AUDIO_CONTROL_ADDR, DEEMP_44K);
@@ -192,11 +194,11 @@ inline void aic23_configure(void)
 }
 
 /*
- *  Omap MCBSP clock configuration and Power Management
- *  
- *  Here we have some functions that allows clock to be enabled and
- *   disabled only when needed. Besides doing clock configuration 
- *   it allows turn on/turn off audio when necessary. 
+ *  OMAP MCBSP clock configuration and Power Management
+ *
+ *  Here we have some functions that allow clock to be enabled and
+ *   disabled only when needed. Besides doing clock configuration
+ *   it allows turn on/turn off audio when necessary.
  */
 /*
  * Do clock framework mclk search
@@ -208,7 +210,7 @@ void aic23_clock_setup(void)
 
 /*
  * Do some sanity check, set clock rate, starts it and
- *  turn codec audio on 
+ *  turn codec audio on
  */
 int aic23_clock_on(void)
 {
@@ -237,9 +239,9 @@ int aic23_clock_on(void)
 	       clk_get_usecount(aic23_mclk));
 
 	/* Now turn the audio on */
-	audio_aic23_write(POWER_DOWN_CONTROL_ADDR, 
+	audio_aic23_write(POWER_DOWN_CONTROL_ADDR,
 			  ~DEVICE_POWER_OFF & ~OUT_OFF & ~DAC_OFF &
-			  ~ADC_OFF & ~MIC_OFF & ~LINE_OFF);	
+			  ~ADC_OFF & ~MIC_OFF & ~LINE_OFF);
 	return 0;
 }
 
@@ -249,7 +251,7 @@ int aic23_clock_on(void)
  */
 int aic23_clock_off(void)
 {
-	if  (clk_get_usecount(aic23_mclk) > 0) { 
+	if (clk_get_usecount(aic23_mclk) > 0) {
 		if (clk_get_rate(aic23_mclk) != CODEC_CLOCK) {
 			printk(KERN_WARNING
 			       "MCLK for audio should be %d Hz. But is %d Hz\n",
@@ -259,10 +261,10 @@ int aic23_clock_off(void)
 
 		clk_disable(aic23_mclk);
 	}
-	
+
 	audio_aic23_write(POWER_DOWN_CONTROL_ADDR,
 			  DEVICE_POWER_OFF | OUT_OFF | DAC_OFF |
-			  ADC_OFF | MIC_OFF | LINE_OFF);	
+			  ADC_OFF | MIC_OFF | LINE_OFF);
 	return 0;
 }
 
@@ -275,21 +277,22 @@ static int __devinit snd_omap_alsa_aic23_probe(struct platform_device *pdev)
 {
 	int	ret;
 	struct	omap_alsa_codec_config *codec_cfg;
-	
+
 	codec_cfg = pdev->dev.platform_data;
 	if (codec_cfg != NULL) {
 		codec_cfg->hw_constraints_rates	= &aic23_hw_constraints_rates;
-		codec_cfg->snd_omap_alsa_playback  = &aic23_snd_omap_alsa_playback;
-		codec_cfg->snd_omap_alsa_capture  = &aic23_snd_omap_alsa_capture;		
+		codec_cfg->snd_omap_alsa_playback =
+						&aic23_snd_omap_alsa_playback;
+		codec_cfg->snd_omap_alsa_capture = &aic23_snd_omap_alsa_capture;
 		codec_cfg->codec_configure_dev	= aic23_configure;
 		codec_cfg->codec_set_samplerate	= aic23_set_samplerate;
 		codec_cfg->codec_clock_setup	= aic23_clock_setup;
 		codec_cfg->codec_clock_on	= aic23_clock_on;
 		codec_cfg->codec_clock_off	= aic23_clock_off;
-		codec_cfg->get_default_samplerate = aic23_get_default_samplerate;
+		codec_cfg->get_default_samplerate =
+						aic23_get_default_samplerate;
 		ret	= snd_omap_alsa_post_probe(pdev, codec_cfg);
-	}
-	else
+	} else
 		ret = -ENODEV;
 	return ret;
 }
@@ -307,7 +310,7 @@ static struct platform_driver omap_alsa_driver = {
 static int __init omap_alsa_aic23_init(void)
 {
 	int err;
-	
+
 	ADEBUG();
 	err = platform_driver_register(&omap_alsa_driver);
 
@@ -317,7 +320,7 @@ static int __init omap_alsa_aic23_init(void)
 static void __exit omap_alsa_aic23_exit(void)
 {
 	ADEBUG();
-	
+
 	platform_driver_unregister(&omap_alsa_driver);
 }
 
diff --git a/sound/arm/omap/omap-alsa-aic23.h b/sound/arm/omap/omap-alsa-aic23.h
index 63907c4..c15e95a 100644
--- a/sound/arm/omap/omap-alsa-aic23.h
+++ b/sound/arm/omap/omap-alsa-aic23.h
@@ -68,6 +68,8 @@ struct aic23_samplerate_reg_info {
 	u8 divider;		/* if 0 CLKIN = MCLK, if 1 CLKIN = MCLK/2 */
 };
 
+extern int aic23_write_value(u8 reg, u16 value);
+
 /*
  * Defines codec specific functions pointers that can be used from the 
  * common omap-alse base driver for all omap codecs. (tsc2101 and aic23)
-- 
1.5.5-rc3.GIT

