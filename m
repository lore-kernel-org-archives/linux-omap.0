From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 14/19] Code clean-up for sound/arm/omap/omap-alsa-tsc2101.c
Date: Tue, 15 Apr 2008 10:02:18 -0400
Message-ID: <1208268143-8789-15-git-send-email-edubezval@gmail.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48084 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759933AbYDOOCi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:38 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE2PEu018691
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 17:02:35 +0300
In-Reply-To: <1208268143-8789-14-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-tsc2101.c |  296 +++++++++++++++++++++++-------------
 1 files changed, 192 insertions(+), 104 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-tsc2101.c b/sound/arm/omap/omap-alsa-tsc2101.c
index 9d056ad..8a7e770 100644
--- a/sound/arm/omap/omap-alsa-tsc2101.c
+++ b/sound/arm/omap/omap-alsa-tsc2101.c
@@ -1,15 +1,15 @@
 /*
  * sound/arm/omap/omap-alsa-tsc2101.c
- * 
- * Alsa codec Driver for TSC2101 chip for OMAP platform boards. 
+ *
+ * Alsa codec Driver for TSC2101 chip for OMAP platform boards.
  * Code obtained from oss omap drivers
  *
  * Copyright (C) 2004 Texas Instruments, Inc.
  * 	Written by Nishanth Menon and Sriram Kannan
- * 	
+ *
  * Copyright (C) 2006 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
  * 	Alsa modularization by Daniel Petrini (d.pensator@gmail.com)
- * 
+ *
  * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -23,31 +23,30 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/spi/tsc2101.h>
-#include <asm/io.h>
-#include <asm/arch/mcbsp.h>
-
+#include <linux/io.h>
 #include <linux/slab.h>
 #ifdef CONFIG_PM
 #include <linux/pm.h>
 #endif
+
 #include <asm/mach-types.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/clock.h>
-
+#include <asm/arch/mcbsp.h>
 #include <asm/hardware/tsc2101.h>
-
 #include <asm/arch/omap-alsa.h>
+
 #include "omap-alsa-tsc2101.h"
 
 struct mcbsp_dev_info mcbsp_dev;
 
-static struct clk *tsc2101_mclk = 0;
+static struct clk *tsc2101_mclk;
 
-//#define DUMP_TSC2101_AUDIO_REGISTERS
+/* #define DUMP_TSC2101_AUDIO_REGISTERS */
 #undef DUMP_TSC2101_AUDIO_REGISTERS
 
 /*
- * Hardware capabilities 
+ * Hardware capabilities
  */
 
 /*
@@ -77,7 +76,7 @@ static const struct tsc2101_samplerate_reg_info
 	{8727, 6, 0},
 	/* Div 5 */
 	{8820, 5, 1},
-	{9600, 5, 0},	
+	{9600, 5, 0},
 	/* Div 4 */
 	{11025, 4, 1},
 	{12000, 4, 0},
@@ -92,22 +91,22 @@ static const struct tsc2101_samplerate_reg_info
 	{32000, 1, 0},
 	/* Div 1 */
 	{44100, 0, 1},
-	{48000, 0, 0},		
+	{48000, 0, 0},
 };
 
 static struct snd_pcm_hardware tsc2101_snd_omap_alsa_playback = {
-	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),	
+	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID,
 #ifdef CONFIG_MACH_OMAP_H6300
-	.formats = (SNDRV_PCM_FMTBIT_S8),
+	.formats = SNDRV_PCM_FMTBIT_S8,
 #else
- 	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.formats = SNDRV_PCM_FMTBIT_S16_LE,
 #endif
-	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
+	.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
 		  SNDRV_PCM_RATE_16000 |
 		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
 		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-		  SNDRV_PCM_RATE_KNOT),
+		  SNDRV_PCM_RATE_KNOT,
 	.rate_min = 7350,
 	.rate_max = 48000,
 	.channels_min = 2,
@@ -121,14 +120,14 @@ static struct snd_pcm_hardware tsc2101_snd_omap_alsa_playback = {
 };
 
 static struct snd_pcm_hardware tsc2101_snd_omap_alsa_capture = {
-	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
-	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
-	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
+	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
 		  SNDRV_PCM_RATE_16000 |
 		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
 		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-		  SNDRV_PCM_RATE_KNOT),
+		  SNDRV_PCM_RATE_KNOT,
 	.rate_min = 7350,
 	.rate_max = 48000,
 	.channels_min = 2,
@@ -141,7 +140,7 @@ static struct snd_pcm_hardware tsc2101_snd_omap_alsa_capture = {
 	.fifo_size = 0,
 };
 
-/* 
+/*
  * Simplified write for tsc2101 audio registers.
  */
 inline void tsc2101_audio_write(u8 address, u16 data)
@@ -150,59 +149,140 @@ inline void tsc2101_audio_write(u8 address, u16 data)
 				address, data);
 }
 
-/* 
+/*
  * Simplified read for tsc2101 audio registers.
  */
 inline u16 tsc2101_audio_read(u8 address)
 {
-	return (tsc2101_read_sync(mcbsp_dev.tsc2101_dev, PAGE2_AUDIO_CODEC_REGISTERS,
-					address));
+	return (tsc2101_read_sync(mcbsp_dev.tsc2101_dev,
+					PAGE2_AUDIO_CODEC_REGISTERS, address));
 }
 
 #ifdef DUMP_TSC2101_AUDIO_REGISTERS
-void dump_tsc2101_audio_reg(void) {
-	printk("TSC2101_AUDIO_CTRL_1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_1));
-	printk("TSC2101_HEADSET_GAIN_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_HEADSET_GAIN_CTRL));
-	printk("TSC2101_DAC_GAIN_CTRL = 0x%04x\n", tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL));
-	printk("TSC2101_MIXER_PGA_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_MIXER_PGA_CTRL));
-	printk("TSC2101_AUDIO_CTRL_2 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_2));
-	printk("TSC2101_CODEC_POWER_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_CODEC_POWER_CTRL));
-	printk("TSC2101_AUDIO_CTRL_3 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_3));
-	printk("TSC2101_LCH_BASS_BOOST_N0 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N0));
-	printk("TSC2101_LCH_BASS_BOOST_N1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N1));
-	printk("TSC2101_LCH_BASS_BOOST_N2 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N2));
-	printk("TSC2101_LCH_BASS_BOOST_N3 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N3));
-	printk("TSC2101_LCH_BASS_BOOST_N4 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N4));
-	printk("TSC2101_LCH_BASS_BOOST_N5 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N5));
-	printk("TSC2101_LCH_BASS_BOOST_D1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_D1));
-	printk("TSC2101_LCH_BASS_BOOST_D2 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_D2));
-	printk("TSC2101_LCH_BASS_BOOST_D4 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_D4));
-	printk("TSC2101_LCH_BASS_BOOST_D5 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_D5));
-	
-	printk("TSC2101_RCH_BASS_BOOST_N0 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N0));
-	printk("TSC2101_RCH_BASS_BOOST_N1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N1));
-	printk("TSC2101_RCH_BASS_BOOST_N2 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N2));
-	printk("TSC2101_RCH_BASS_BOOST_N3 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N3));
-	printk("TSC2101_RCH_BASS_BOOST_N4 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N4));
-	printk("TSC2101_RCH_BASS_BOOST_N5 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N5));
-	printk("TSC2101_RCH_BASS_BOOST_D1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_D1));
-	printk("TSC2101_RCH_BASS_BOOST_D2 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_D2));
-	printk("TSC2101_RCH_BASS_BOOST_D4 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_D4));
-	printk("TSC2101_RCH_BASS_BOOST_D5 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_D5));
-					
-	printk("TSC2101_PLL_PROG_1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_PLL_PROG_1));
-	printk("TSC2101_PLL_PROG_1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_PLL_PROG_2));
-	printk("TSC2101_AUDIO_CTRL_4 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_4));
-	printk("TSC2101_HANDSET_GAIN_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL));
-	printk("TSC2101_BUZZER_GAIN_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_BUZZER_GAIN_CTRL));
-	printk("TSC2101_AUDIO_CTRL_5 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_5));
-	printk("TSC2101_AUDIO_CTRL_6 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_6));
-	printk("TSC2101_AUDIO_CTRL_7 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_7));
-	printk("TSC2101_GPIO_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_GPIO_CTRL));
-	printk("TSC2101_AGC_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_AGC_CTRL));
-	printk("TSC2101_POWERDOWN_STS = 0x%04x\n",	tsc2101_audio_read(TSC2101_POWERDOWN_STS));
-	printk("TSC2101_MIC_AGC_CONTROL = 0x%04x\n",	tsc2101_audio_read(TSC2101_MIC_AGC_CONTROL));
-	printk("TSC2101_CELL_AGC_CONTROL = 0x%04x\n",	tsc2101_audio_read(TSC2101_CELL_AGC_CONTROL));
+void dump_tsc2101_audio_reg(void)
+{
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_AUDIO_CTRL_1 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_AUDIO_CTRL_1));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_HEADSET_GAIN_CTRL = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_HEADSET_GAIN_CTRL));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_DAC_GAIN_CTRL = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_MIXER_PGA_CTRL = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_MIXER_PGA_CTRL));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_AUDIO_CTRL_2 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_AUDIO_CTRL_2));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_CODEC_POWER_CTRL = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_CODEC_POWER_CTRL));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_AUDIO_CTRL_3 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_AUDIO_CTRL_3));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_LCH_BASS_BOOST_N0 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N0));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_LCH_BASS_BOOST_N1 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N1));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_LCH_BASS_BOOST_N2 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N2));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_LCH_BASS_BOOST_N3 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N3));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_LCH_BASS_BOOST_N4 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N4));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_LCH_BASS_BOOST_N5 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N5));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_LCH_BASS_BOOST_D1 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_D1));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_LCH_BASS_BOOST_D2 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_D2));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_LCH_BASS_BOOST_D4 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_D4));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_LCH_BASS_BOOST_D5 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_D5));
+
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_RCH_BASS_BOOST_N0 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N0));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_RCH_BASS_BOOST_N1 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N1));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_RCH_BASS_BOOST_N2 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N2));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_RCH_BASS_BOOST_N3 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N3));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_RCH_BASS_BOOST_N4 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N4));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_RCH_BASS_BOOST_N5 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N5));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_RCH_BASS_BOOST_D1 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_D1));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_RCH_BASS_BOOST_D2 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_D2));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_RCH_BASS_BOOST_D4 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_D4));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_RCH_BASS_BOOST_D5 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_D5));
+
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_PLL_PROG_1 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_PLL_PROG_1));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_PLL_PROG_1 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_PLL_PROG_2));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_AUDIO_CTRL_4 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_AUDIO_CTRL_4));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_HANDSET_GAIN_CTRL = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_BUZZER_GAIN_CTRL = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_BUZZER_GAIN_CTRL));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_AUDIO_CTRL_5 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_AUDIO_CTRL_5));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_AUDIO_CTRL_6 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_AUDIO_CTRL_6));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_AUDIO_CTRL_7 = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_AUDIO_CTRL_7));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_GPIO_CTRL = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_GPIO_CTRL));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_AGC_CTRL = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_AGC_CTRL));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_POWERDOWN_STS = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_POWERDOWN_STS));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_MIC_AGC_CONTROL = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_MIC_AGC_CONTROL));
+	dev_dbg(&mcbsp_dev.mcbsp_dev->dev,
+		"TSC2101_CELL_AGC_CONTROL = 0x%04x\n",
+		tsc2101_audio_read(TSC2101_CELL_AGC_CONTROL));
 }
 #endif
 
@@ -233,14 +313,14 @@ void tsc2101_set_samplerate(long sample_rate)
 	if (count == NUMBER_SAMPLE_RATES_SUPPORTED) {
 		printk(KERN_ERR "Invalid Sample Rate %d requested\n",
 		       (int) sample_rate);
-		return;		// -EPERM;
+		return;
 	}
 
 	/* Set AC1 */
 	data	= tsc2101_audio_read(TSC2101_AUDIO_CTRL_1);
 	/* Clear prev settings */
 	data	&= ~(AC1_DACFS(0x07) | AC1_ADCFS(0x07));
-	data	|= AC1_DACFS(rate_reg_info[count].divisor) | 
+	data	|= AC1_DACFS(rate_reg_info[count].divisor) |
 			AC1_ADCFS(rate_reg_info[count].divisor);
 	tsc2101_audio_write(TSC2101_AUDIO_CTRL_1, data);
 
@@ -254,20 +334,25 @@ void tsc2101_set_samplerate(long sample_rate)
 #endif				/* #ifdef TSC_MASTER */
 	tsc2101_audio_write(TSC2101_AUDIO_CTRL_3, data);
 
-	/* Program the PLLs. This code assumes that the 12 Mhz MCLK is in use.
-         * If MCLK rate is something else, these values must be changed.
+	/*
+	 * Program the PLLs. This code assumes that the 12 Mhz MCLK is in use.
+	 * If MCLK rate is something else, these values must be changed.
 	 * See the tsc2101 specification for the details.
 	 */
 	if (rate_reg_info[count].fs_44kHz) {
 		/* samplerate = (44.1kHZ / x), where x is int. */
 		tsc2101_audio_write(TSC2101_PLL_PROG_1, PLL1_PLLSEL |
-				PLL1_PVAL(1) | PLL1_I_VAL(7));	/* PVAL 1; I_VAL 7 */
-		tsc2101_audio_write(TSC2101_PLL_PROG_2, PLL2_D_VAL(0x1490));	/* D_VAL 5264 */
+				/* PVAL 1; I_VAL 7 */
+				PLL1_PVAL(1) | PLL1_I_VAL(7));
+		/* D_VAL 5264 */
+		tsc2101_audio_write(TSC2101_PLL_PROG_2, PLL2_D_VAL(0x1490));
 	} else {
 		/* samplerate = (48.kHZ / x), where x is int. */
 		tsc2101_audio_write(TSC2101_PLL_PROG_1, PLL1_PLLSEL |
-			       PLL1_PVAL(1) | PLL1_I_VAL(8));	/* PVAL 1; I_VAL 8 */
-		tsc2101_audio_write(TSC2101_PLL_PROG_2, PLL2_D_VAL(0x780));	/* D_VAL 1920 */
+				/* PVAL 1; I_VAL 8 */
+			       PLL1_PVAL(1) | PLL1_I_VAL(8));
+		/* D_VAL 1920 */
+		tsc2101_audio_write(TSC2101_PLL_PROG_2, PLL2_D_VAL(0x780));
 	}
 
 	/* Set the sample rate */
@@ -295,12 +380,12 @@ void tsc2101_configure(void)
 
 /*
  *  Omap MCBSP clock and Power Management configuration
- *  
+ *
  *  Here we have some functions that allows clock to be enabled and
- *   disabled only when needed. Besides doing clock configuration 
- *   it allows turn on/turn off audio when necessary. 
+ *   disabled only when needed. Besides doing clock configuration
+ *   it allows turn on/turn off audio when necessary.
  */
- 
+
 /*
  * Do clock framework mclk search
  */
@@ -312,7 +397,7 @@ void tsc2101_clock_setup(void)
 /*
  * Do some sanity check, set clock rate, starts it and turn codec audio on
  */
-int tsc2101_clock_on(void) 
+int tsc2101_clock_on(void)
 {
 	int	curUseCount;
 	uint	curRate;
@@ -321,7 +406,7 @@ int tsc2101_clock_on(void)
 	curUseCount	= clk_get_usecount(tsc2101_mclk);
 	DPRINTK("clock use count = %d\n", curUseCount);
 	if (curUseCount > 0) {
-		// MCLK is already in use
+		/* MCLK is already in use */
 		printk(KERN_WARNING
 		       "MCLK already in use at %d Hz. We change it to %d Hz\n",
 		       (uint) clk_get_rate(tsc2101_mclk),
@@ -331,8 +416,8 @@ int tsc2101_clock_on(void)
 	if (curRate != CODEC_CLOCK) {
 		err	= clk_set_rate(tsc2101_mclk, CODEC_CLOCK);
 		if (err) {
-			printk(KERN_WARNING
-			       "Cannot set MCLK clock rate for TSC2101 CODEC, error code = %d\n", err);
+			printk(KERN_WARNING "Cannot set MCLK clock rate for "
+				"TSC2101 CODEC, error code = %d\n", err);
 			return -ECANCELED;
 		}
 	}
@@ -340,22 +425,22 @@ int tsc2101_clock_on(void)
 	curRate		= (uint)clk_get_rate(tsc2101_mclk);
 	curUseCount	= clk_get_usecount(tsc2101_mclk);
 	DPRINTK("MCLK = %d [%d], usecount = %d, clk_enable retval = %d\n",
-	       curRate, 
+	       curRate,
 	       CODEC_CLOCK,
 	       curUseCount,
 	       err);
 
-	// Now turn the audio on
+	/* Now turn the audio on */
 	tsc2101_write_sync(mcbsp_dev.tsc2101_dev, PAGE2_AUDIO_CODEC_REGISTERS,
 				TSC2101_CODEC_POWER_CTRL,
 				0x0000);
-	return 0;	
+	return 0;
 }
 
 /*
  * Do some sanity check, turn clock off and then turn codec audio off
  */
-int tsc2101_clock_off(void) 
+int tsc2101_clock_off(void)
 {
 	int curUseCount;
 	int curRate;
@@ -377,7 +462,7 @@ int tsc2101_clock_off(void)
 	tsc2101_audio_write(TSC2101_CODEC_POWER_CTRL,
 			    ~(CPC_SP1PWDN | CPC_SP2PWDN | CPC_BASSBC));
 	DPRINTK("audio codec off\n");
-	return 0;	
+	return 0;
 }
 
 int tsc2101_get_default_samplerate(void)
@@ -390,7 +475,7 @@ static int __devinit snd_omap_alsa_tsc2101_probe(struct platform_device *pdev)
 	struct spi_device *tsc2101;
 	int	ret;
 	struct	omap_alsa_codec_config *codec_cfg;
-	
+
 	tsc2101 = dev_get_drvdata(&pdev->dev);
 	if (tsc2101 == NULL) {
 		dev_err(&pdev->dev, "no platform data\n");
@@ -405,18 +490,21 @@ static int __devinit snd_omap_alsa_tsc2101_probe(struct platform_device *pdev)
 
 	codec_cfg = pdev->dev.platform_data;
 	if (codec_cfg != NULL) {
-		codec_cfg->hw_constraints_rates	= &tsc2101_hw_constraints_rates;
-		codec_cfg->snd_omap_alsa_playback  = &tsc2101_snd_omap_alsa_playback;
-		codec_cfg->snd_omap_alsa_capture  = &tsc2101_snd_omap_alsa_capture;
+		codec_cfg->hw_constraints_rates	=
+						&tsc2101_hw_constraints_rates;
+		codec_cfg->snd_omap_alsa_playback =
+					&tsc2101_snd_omap_alsa_playback;
+		codec_cfg->snd_omap_alsa_capture =
+						&tsc2101_snd_omap_alsa_capture;
 		codec_cfg->codec_configure_dev	= tsc2101_configure;
 		codec_cfg->codec_set_samplerate	= tsc2101_set_samplerate;
 		codec_cfg->codec_clock_setup	= tsc2101_clock_setup;
 		codec_cfg->codec_clock_on	= tsc2101_clock_on;
 		codec_cfg->codec_clock_off	= tsc2101_clock_off;
-		codec_cfg->get_default_samplerate = tsc2101_get_default_samplerate;
-		ret	= snd_omap_alsa_post_probe(pdev, codec_cfg);
-	}
-	else
+		codec_cfg->get_default_samplerate =
+						tsc2101_get_default_samplerate;
+		ret = snd_omap_alsa_post_probe(pdev, codec_cfg);
+	} else
 		ret = -ENODEV;
 	return ret;
 }
@@ -432,10 +520,10 @@ static struct platform_driver omap_alsa_driver = {
 };
 
 static int __init omap_alsa_tsc2101_init(void)
-{	
+{
 	ADEBUG();
 #ifdef DUMP_TSC2101_AUDIO_REGISTERS
-	printk("omap_alsa_tsc2101_init()\n");
+	printk(KERN_INFO "omap_alsa_tsc2101_init()\n");
 	dump_tsc2101_audio_reg();
 #endif
 	return platform_driver_register(&omap_alsa_driver);
@@ -445,7 +533,7 @@ static void __exit omap_alsa_tsc2101_exit(void)
 {
 	ADEBUG();
 #ifdef DUMP_TSC2101_AUDIO_REGISTERS
-	printk("omap_alsa_tsc2101_exit()\n");
+	printk(KERN_INFO "omap_alsa_tsc2101_exit()\n");
 	dump_tsc2101_audio_reg();
 #endif
 	platform_driver_unregister(&omap_alsa_driver);
-- 
1.5.5-rc3.GIT

