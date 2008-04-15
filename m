From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 19/19] Code clean-up for sound/arm/omap/omap-alsa.c
Date: Tue, 15 Apr 2008 10:02:23 -0400
Message-ID: <1208268143-8789-20-git-send-email-edubezval@gmail.com>
References: <1208268143-8789-1-git-send-email-edubezval@gmail.com>
 <1208268143-8789-2-git-send-email-edubezval@gmail.com>
 <1208268143-8789-3-git-send-email-edubezval@gmail.com>
 <1208268143-8789-4-git-send-email-edubezval@gmail.com>
 <1208268143-8789-5-git-send-email-edubezval@gmail.com>
 <1208268143-8789-6-git-send-email-edubezval@gmail.com>
 <1208268143-8789-7-git-send-email-edubezval@gmail.com>
 <1208268143-8789-8-git-send-email-edubezval@gmail.com>
 <1208268143-8789-9-git-send-email-edubezval@gmail.com>
 <1208268143-8789-10-git-send-email-edubezval@gmail.com>
 <1208268143-8789-11-git-send-email-edubezval@gmail.com>
 <1208268143-8789-12-git-send-email-edubezval@gmail.com>
 <1208268143-8789-13-git-send-email-edubezval@gmail.com>
 <1208268143-8789-14-git-send-email-edubezval@gmail.com>
 <1208268143-8789-15-git-send-email-edubezval@gmail.com>
 <1208268143-8789-16-git-send-email-edubezval@gmail.com>
 <1208268143-8789-17-git-send-email-edubezval@gmail.com>
 <1208268143-8789-18-git-send-email-edubezval@gmail.com>
 <1208268143-8789-19-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64790 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106AbYDOODo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:03:44 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE2VHH031028
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 09:05:02 -0500
In-Reply-To: <1208268143-8789-19-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa.c |  163 +++++++++++++++++++++++---------------------
 1 files changed, 86 insertions(+), 77 deletions(-)

diff --git a/sound/arm/omap/omap-alsa.c b/sound/arm/omap/omap-alsa.c
index 8d0f394..056ae92 100644
--- a/sound/arm/omap/omap-alsa.c
+++ b/sound/arm/omap/omap-alsa.c
@@ -1,6 +1,6 @@
 /*
  * sound/arm/omap-alsa.c
- * 
+ *
  * Alsa Driver for OMAP
  *
  * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
@@ -9,7 +9,7 @@
  *
  * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
  *
- * Based on sa11xx-uda1341.c, 
+ * Based on sa11xx-uda1341.c,
  * Copyright (C) 2002 Tomas Kasparek <tomas.kasparek@seznam.cz>
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -34,10 +34,10 @@
  *
  * History:
  *
- * 2005-07-29   INdT Kernel Team - Alsa driver for omap osk. Creation of new 
+ * 2005-07-29   INdT Kernel Team - Alsa driver for omap osk. Creation of new
  *                                 file omap-aic23.c
- * 
- * 2005-12-18   Dirk Behme       - Added L/R Channel Interchange fix as proposed 
+ *
+ * 2005-12-18   Dirk Behme       - Added L/R Channel Interchange fix as proposed
  *                                 by Ajaya Babu
  *
  */
@@ -53,14 +53,18 @@
 #include <asm/arch/omap-alsa.h>
 #include "omap-alsa-dma.h"
 
-MODULE_AUTHOR("Mika Laitio, Daniel Petrini, David Cohen, Anderson Briglia - INdT");
+MODULE_AUTHOR("Mika Laitio");
+MODULE_AUTHOR("Daniel Petrini");
+MODULE_AUTHOR("David Cohen");
+MODULE_AUTHOR("Anderson Briglia");
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("OMAP driver for ALSA");
 MODULE_ALIAS("omap_alsa_mcbsp.1");
 
-static char *id	= NULL;	
-static struct snd_card_omap_codec 	*alsa_codec		= NULL;
-static struct omap_alsa_codec_config	*alsa_codec_config	= NULL;
+static char *id;
+static struct snd_card_omap_codec 	*alsa_codec;
+static struct omap_alsa_codec_config	*alsa_codec_config;
 
 /*
  * HW interface start and stop helper functions
@@ -101,10 +105,9 @@ static void omap_alsa_audio_init(struct snd_card_omap_codec *omap_alsa)
 	    audio_ifc_stop;
 }
 
-/* 
- * DMA functions 
+/*
+ * DMA functions
  * Depends on omap-alsa-dma.c functions and (omap) dma.c
- * 
  */
 static int audio_dma_request(struct audio_stream *s,
 			     void (*callback) (void *))
@@ -152,7 +155,8 @@ static u_int audio_get_dma_pos(struct audio_stream *s)
 	spin_unlock_irqrestore(&s->dma_lock, flags);
 
 	/* Now, the position related to the end of that period */
-	offset = bytes_to_frames(runtime, s->offset) - bytes_to_frames(runtime, count);
+	offset = bytes_to_frames(runtime, s->offset) -
+			bytes_to_frames(runtime, count);
 
 	if (offset >= runtime->buffer_size)
 		offset = 0;
@@ -191,29 +195,28 @@ static void audio_process_dma(struct audio_stream *s)
 	unsigned int dma_size;
 	unsigned int offset;
 	int ret;
-	
+
 	ADEBUG();
 	runtime = substream->runtime;
 	if (s->active) {
 		dma_size = frames_to_bytes(runtime, runtime->period_size);
 		offset = dma_size * s->period;
-		snd_assert(dma_size <= DMA_BUF_SIZE,);
+		snd_assert(dma_size <= DMA_BUF_SIZE, return);
 		/*
 		 * On omap1510 based devices, we need to call the stop_dma
 		 * before calling the start_dma or we will not receive the
 		 * irq from DMA after the first transfered/played buffer.
 		 * (invocation of callback_omap_alsa_sound_dma() method).
 		 */
-		if (cpu_is_omap1510()) {
+		if (cpu_is_omap1510())
 			omap_stop_alsa_sound_dma(s);
-		}
+
 		ret = omap_start_alsa_sound_dma(s,
 				(dma_addr_t)runtime->dma_area + offset,
 				dma_size);
 		if (ret) {
-			printk(KERN_ERR
-			       "audio_process_dma: cannot queue DMA buffer (%i)\n",
-			       ret);
+			printk(KERN_ERR "audio_process_dma: cannot"
+					" queue DMA buffer (%i)\n", ret);
 			return;
 		}
 
@@ -224,15 +227,15 @@ static void audio_process_dma(struct audio_stream *s)
 	}
 }
 
-/* 
+/*
  *  This is called when dma IRQ occurs at the end of each transmited block
  */
 void callback_omap_alsa_sound_dma(void *data)
 {
 	struct audio_stream *s = data;
-	
+
 	ADEBUG();
-	/* 
+	/*
 	 * If we are getting a callback for an active stream then we inform
 	 * the PCM middle layer we've finished a period
 	 */
@@ -240,25 +243,25 @@ void callback_omap_alsa_sound_dma(void *data)
 		snd_pcm_period_elapsed(s->stream);
 
 	spin_lock(&s->dma_lock);
-	if (s->periods > 0) 
+	if (s->periods > 0)
 		s->periods--;
-	
+
 	audio_process_dma(s);
 	spin_unlock(&s->dma_lock);
 }
 
-/* 
+/*
  * Alsa section
  * PCM settings and callbacks
  */
-static int snd_omap_alsa_trigger(struct snd_pcm_substream * substream, int cmd)
+static int snd_omap_alsa_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_card_omap_codec *chip =
 	    snd_pcm_substream_chip(substream);
 	int stream_id = substream->pstr->stream;
 	struct audio_stream *s = &chip->s[stream_id];
 	int err = 0;
-	
+
 	ADEBUG();
 	/* note local interrupts are already disabled in the midlevel code */
 	spin_lock(&s->dma_lock);
@@ -277,16 +280,16 @@ static int snd_omap_alsa_trigger(struct snd_pcm_substream * substream, int cmd)
 		break;
 	}
 	spin_unlock(&s->dma_lock);
-	
+
 	return err;
 }
 
-static int snd_omap_alsa_prepare(struct snd_pcm_substream * substream)
+static int snd_omap_alsa_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_stream *s = &chip->s[substream->pstr->stream];
-	
+
 	ADEBUG();
 	/* set requested samplerate */
 	alsa_codec_config->codec_set_samplerate(runtime->rate);
@@ -298,63 +301,64 @@ static int snd_omap_alsa_prepare(struct snd_pcm_substream * substream)
 	return 0;
 }
 
-static snd_pcm_uframes_t snd_omap_alsa_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t
+snd_omap_alsa_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
 
-	ADEBUG();	
+	ADEBUG();
 	return audio_get_dma_pos(&chip->s[substream->pstr->stream]);
 }
 
-static int snd_card_omap_alsa_open(struct snd_pcm_substream * substream)
+static int snd_card_omap_alsa_open(struct snd_pcm_substream *substream)
 {
 	struct snd_card_omap_codec *chip =
 	    snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int stream_id = substream->pstr->stream;
 	int err;
-	
+
 	ADEBUG();
 	chip->s[stream_id].stream = substream;
 	alsa_codec_config->codec_clock_on();
-	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK) 
+	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK)
 		runtime->hw = *(alsa_codec_config->snd_omap_alsa_playback);
-	else 
+	else
 		runtime->hw = *(alsa_codec_config->snd_omap_alsa_capture);
-	
-	if ((err = snd_pcm_hw_constraint_integer(runtime,
-					   SNDRV_PCM_HW_PARAM_PERIODS)) < 0) 
+
+	err = snd_pcm_hw_constraint_integer(runtime,
+						SNDRV_PCM_HW_PARAM_PERIODS);
+	if (err < 0)
 		return err;
-	
-	if ((err = snd_pcm_hw_constraint_list(runtime,
-					0,
-					SNDRV_PCM_HW_PARAM_RATE,
-					alsa_codec_config->hw_constraints_rates)) < 0) 
+
+	err = snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				alsa_codec_config->hw_constraints_rates);
+	if (err < 0)
 		return err;
-	
+
 	return 0;
 }
 
-static int snd_card_omap_alsa_close(struct snd_pcm_substream * substream)
+static int snd_card_omap_alsa_close(struct snd_pcm_substream *substream)
 {
 	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
-	
+
 	ADEBUG();
 	alsa_codec_config->codec_clock_off();
 	chip->s[substream->pstr->stream].stream = NULL;
-	
+
 	return 0;
 }
 
 /* HW params & free */
-static int snd_omap_alsa_hw_params(struct snd_pcm_substream * substream,
-				   struct snd_pcm_hw_params * hw_params)
+static int snd_omap_alsa_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *hw_params)
 {
 	return snd_pcm_lib_malloc_pages(substream,
 					params_buffer_bytes(hw_params));
 }
 
-static int snd_omap_alsa_hw_free(struct snd_pcm_substream * substream)
+static int snd_omap_alsa_hw_free(struct snd_pcm_substream *substream)
 {
 	return snd_pcm_lib_free_pages(substream);
 }
@@ -384,17 +388,17 @@ static struct snd_pcm_ops snd_card_omap_alsa_capture_ops = {
 
 /*
  *  Alsa init and exit section
- *  
  *  Inits pcm alsa structures, allocate the alsa buffer, suspend, resume
  */
-static int __init snd_card_omap_alsa_pcm(struct snd_card_omap_codec *omap_alsa, 
+static int __init snd_card_omap_alsa_pcm(struct snd_card_omap_codec *omap_alsa,
 					int device)
 {
 	struct snd_pcm *pcm;
 	int err;
-	
+
 	ADEBUG();
-	if ((err = snd_pcm_new(omap_alsa->card, "OMAP PCM", device, 1, 1, &pcm)) < 0)
+	err = snd_pcm_new(omap_alsa->card, "OMAP PCM", device, 1, 1, &pcm);
+	if (err < 0)
 		return err;
 
 	/* sets up initial buffer with continuous allocation */
@@ -434,11 +438,12 @@ int snd_omap_alsa_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct snd_card_omap_codec *chip;
 	struct snd_card *card = platform_get_drvdata(pdev);
-	
+
 	if (card->power_state != SNDRV_CTL_POWER_D3hot) {
 		chip = card->private_data;
 		if (chip->card->power_state != SNDRV_CTL_POWER_D3hot) {
-			snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
+			snd_power_change_state(chip->card,
+						SNDRV_CTL_POWER_D3hot);
 			snd_pcm_suspend_all(chip->pcm);
 			/* Mutes and turn clock off */
 			alsa_codec_config->codec_clock_off();
@@ -453,7 +458,7 @@ int snd_omap_alsa_resume(struct platform_device *pdev)
 	struct snd_card_omap_codec *chip;
 	struct snd_card *card = platform_get_drvdata(pdev);
 
-	if (card->power_state != SNDRV_CTL_POWER_D0) {				
+	if (card->power_state != SNDRV_CTL_POWER_D0) {
 		chip = card->private_data;
 		if (chip->card->power_state != SNDRV_CTL_POWER_D0) {
 			snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
@@ -466,11 +471,11 @@ int snd_omap_alsa_resume(struct platform_device *pdev)
 
 #endif	/* CONFIG_PM */
 
-void snd_omap_alsa_free(struct snd_card * card)
+void snd_omap_alsa_free(struct snd_card *card)
 {
 	struct snd_card_omap_codec *chip = card->private_data;
 	ADEBUG();
-	
+
 	/*
 	 * Turn off codec after it is done.
 	 * Can't do it immediately, since it may still have
@@ -487,27 +492,28 @@ void snd_omap_alsa_free(struct snd_card * card)
 
 /* module init & exit */
 
-/* 
+/*
  * Inits alsa soudcard structure.
  * Called by the probe method in codec after function pointers has been set.
  */
-int snd_omap_alsa_post_probe(struct platform_device *pdev, struct omap_alsa_codec_config *config)
+int snd_omap_alsa_post_probe(struct platform_device *pdev,
+				struct omap_alsa_codec_config *config)
 {
 	int err = 0;
 	int def_rate;
 	struct snd_card *card;
-	
+
 	ADEBUG();
 	alsa_codec_config	= config;
 
 	alsa_codec_config->codec_clock_setup();
-	alsa_codec_config->codec_clock_on(); 
+	alsa_codec_config->codec_clock_on();
 
 	omap_mcbsp_request(AUDIO_MCBSP);
 	omap_mcbsp_stop(AUDIO_MCBSP);
 	omap_mcbsp_config(AUDIO_MCBSP, alsa_codec_config->mcbsp_regs_alsa);
 	omap_mcbsp_start(AUDIO_MCBSP);
-	
+
 	if (alsa_codec_config && alsa_codec_config->codec_configure_dev)
 		alsa_codec_config->codec_configure_dev();
 
@@ -526,18 +532,20 @@ int snd_omap_alsa_post_probe(struct platform_device *pdev, struct omap_alsa_code
 	card->private_free = snd_omap_alsa_free;
 
 	alsa_codec->card	= card;
-	def_rate		= alsa_codec_config->get_default_samplerate(); 
+	def_rate		= alsa_codec_config->get_default_samplerate();
 	alsa_codec->samplerate	= def_rate;
 
 	spin_lock_init(&alsa_codec->s[0].dma_lock);
 	spin_lock_init(&alsa_codec->s[1].dma_lock);
 
 	/* mixer */
-	if ((err = snd_omap_mixer(alsa_codec)) < 0)
+	err = snd_omap_mixer(alsa_codec);
+	if (err < 0)
 		goto nodev3;
 
 	/* PCM */
-	if ((err = snd_card_omap_alsa_pcm(alsa_codec, 0)) < 0)
+	err = snd_card_omap_alsa_pcm(alsa_codec, 0);
+	if (err < 0)
 		goto nodev3;
 
 	strcpy(card->driver, "OMAP_ALSA");
@@ -546,16 +554,17 @@ int snd_omap_alsa_post_probe(struct platform_device *pdev, struct omap_alsa_code
 
 	snd_omap_init_mixer();
 	snd_card_set_dev(card, &pdev->dev);
-	
-	if ((err = snd_card_register(card)) == 0) {
+
+	err = snd_card_register(card);
+	if (err == 0) {
 		printk(KERN_INFO "audio support initialized\n");
 		platform_set_drvdata(pdev, card);
 		return 0;
 	}
-	
+
 nodev3:
-	kfree(alsa_codec);	
-nodev2:	
+	kfree(alsa_codec);
+nodev2:
 	snd_card_free(card);
 nodev1:
 	omap_mcbsp_stop(AUDIO_MCBSP);
@@ -568,14 +577,14 @@ int snd_omap_alsa_remove(struct platform_device *pdev)
 {
 	struct snd_card *card = platform_get_drvdata(pdev);
 	struct snd_card_omap_codec *chip = card->private_data;
-	
+
 	snd_card_free(card);
 
 	alsa_codec = NULL;
 	card->private_data = NULL;
 	kfree(chip);
-	
+
 	platform_set_drvdata(pdev, NULL);
-	
+
 	return 0;
 }
-- 
1.5.5-rc3.GIT

