From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 17/19] Code clean-up for sound/arm/omap/omap-alsa-tsc2102.c
Date: Fri, 18 Apr 2008 04:01:04 -0400
Message-ID: <1208505666-13744-18-git-send-email-edubezval@gmail.com>
References: <1208505666-13744-1-git-send-email-edubezval@gmail.com>
 <1208505666-13744-2-git-send-email-edubezval@gmail.com>
 <1208505666-13744-3-git-send-email-edubezval@gmail.com>
 <1208505666-13744-4-git-send-email-edubezval@gmail.com>
 <1208505666-13744-5-git-send-email-edubezval@gmail.com>
 <1208505666-13744-6-git-send-email-edubezval@gmail.com>
 <1208505666-13744-7-git-send-email-edubezval@gmail.com>
 <1208505666-13744-8-git-send-email-edubezval@gmail.com>
 <1208505666-13744-9-git-send-email-edubezval@gmail.com>
 <1208505666-13744-10-git-send-email-edubezval@gmail.com>
 <1208505666-13744-11-git-send-email-edubezval@gmail.com>
 <1208505666-13744-12-git-send-email-edubezval@gmail.com>
 <1208505666-13744-13-git-send-email-edubezval@gmail.com>
 <1208505666-13744-14-git-send-email-edubezval@gmail.com>
 <1208505666-13744-15-git-send-email-edubezval@gmail.com>
 <1208505666-13744-16-git-send-email-edubezval@gmail.com>
 <1208505666-13744-17-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33514 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756507AbYDRIB0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:26 -0400
In-Reply-To: <1208505666-13744-17-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-tsc2102.c |   70 ++++++++++++++++++------------------
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-tsc2102.c b/sound/arm/omap/omap-alsa-tsc2102.c
index 1ca5ba9..911e776 100644
--- a/sound/arm/omap/omap-alsa-tsc2102.c
+++ b/sound/arm/omap/omap-alsa-tsc2102.c
@@ -1,6 +1,6 @@
 /*
  * sound/arm/omap/omap-alsa-tsc2102.c
- * 
+ *
  * Alsa codec driver for TSC2102 chip for OMAP platforms.
  *
  * Copyright (c) 2006 Andrzej Zaborowski  <balrog@zabor.org>
@@ -17,17 +17,16 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <linux/spi/tsc2102.h>
 
-#include <asm/io.h>
-
 #include <asm/arch/dma.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/omap-alsa.h>
 
 #include "omap-alsa-tsc2102.h"
 
-static struct clk *tsc2102_bclk = 0;
+static struct clk *tsc2102_bclk;
 
 /*
  * Hardware capabilities
@@ -67,62 +66,63 @@ static struct snd_pcm_hardware tsc2102_snd_omap_alsa_playback = {
 };
 
 #ifdef DUMP_TSC2102_AUDIO_REGISTERS
-static void dump_tsc2102_audio_regs(void) {
-	printk("TSC2102_AUDIO1_CTRL = 0x%04x\n",
+static void dump_tsc2102_audio_regs(void)
+{
+	printk(KERN_INFO "TSC2102_AUDIO1_CTRL = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_AUDIO1_CTRL));
-	printk("TSC2102_DAC_GAIN_CTRL = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_DAC_GAIN_CTRL = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_DAC_GAIN_CTRL));
-	printk("TSC2102_AUDIO2_CTRL = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_AUDIO2_CTRL = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_AUDIO2_CTRL));
-	printk("TSC2102_DAC_POWER_CTRL = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_DAC_POWER_CTRL = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_DAC_POWER_CTRL));
-	printk("TSC2102_AUDIO3_CTRL = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_AUDIO3_CTRL = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_AUDIO_CTRL_3));
-	printk("TSC2102_LCH_BASS_BOOST_N0 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_LCH_BASS_BOOST_N0 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_LCH_BASS_BOOST_N0));
-	printk("TSC2102_LCH_BASS_BOOST_N1 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_LCH_BASS_BOOST_N1 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_LCH_BASS_BOOST_N1));
-	printk("TSC2102_LCH_BASS_BOOST_N2 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_LCH_BASS_BOOST_N2 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_LCH_BASS_BOOST_N2));
-	printk("TSC2102_LCH_BASS_BOOST_N3 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_LCH_BASS_BOOST_N3 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_LCH_BASS_BOOST_N3));
-	printk("TSC2102_LCH_BASS_BOOST_N4 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_LCH_BASS_BOOST_N4 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_LCH_BASS_BOOST_N4));
-	printk("TSC2102_LCH_BASS_BOOST_N5 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_LCH_BASS_BOOST_N5 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_LCH_BASS_BOOST_N5));
-	printk("TSC2102_LCH_BASS_BOOST_D1 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_LCH_BASS_BOOST_D1 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_LCH_BASS_BOOST_D1));
-	printk("TSC2102_LCH_BASS_BOOST_D2 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_LCH_BASS_BOOST_D2 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_LCH_BASS_BOOST_D2));
-	printk("TSC2102_LCH_BASS_BOOST_D4 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_LCH_BASS_BOOST_D4 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_LCH_BASS_BOOST_D4));
-	printk("TSC2102_LCH_BASS_BOOST_D5 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_LCH_BASS_BOOST_D5 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_LCH_BASS_BOOST_D5));
-	printk("TSC2102_RCH_BASS_BOOST_N0 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_RCH_BASS_BOOST_N0 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_RCH_BASS_BOOST_N0));
-	printk("TSC2102_RCH_BASS_BOOST_N1 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_RCH_BASS_BOOST_N1 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_RCH_BASS_BOOST_N1));
-	printk("TSC2102_RCH_BASS_BOOST_N2 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_RCH_BASS_BOOST_N2 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_RCH_BASS_BOOST_N2));
-	printk("TSC2102_RCH_BASS_BOOST_N3 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_RCH_BASS_BOOST_N3 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_RCH_BASS_BOOST_N3));
-	printk("TSC2102_RCH_BASS_BOOST_N4 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_RCH_BASS_BOOST_N4 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_RCH_BASS_BOOST_N4));
-	printk("TSC2102_RCH_BASS_BOOST_N5 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_RCH_BASS_BOOST_N5 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_RCH_BASS_BOOST_N5));
-	printk("TSC2102_RCH_BASS_BOOST_D1 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_RCH_BASS_BOOST_D1 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_RCH_BASS_BOOST_D1));
-	printk("TSC2102_RCH_BASS_BOOST_D2 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_RCH_BASS_BOOST_D2 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_RCH_BASS_BOOST_D2));
-	printk("TSC2102_RCH_BASS_BOOST_D4 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_RCH_BASS_BOOST_D4 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_RCH_BASS_BOOST_D4));
-	printk("TSC2102_RCH_BASS_BOOST_D5 = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_RCH_BASS_BOOST_D5 = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_RCH_BASS_BOOST_D5));
-	printk("TSC2102_PLL1_CTRL = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_PLL1_CTRL = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_PLL1_CTRL));
-	printk("TSC2102_PLL2_CTRL = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_PLL2_CTRL = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_PLL2_CTRL));
-	printk("TSC2102_AUDIO4_CTRL = 0x%04x\n",
+	printk(KERN_INFO "TSC2102_AUDIO4_CTRL = 0x%04x\n",
 			tsc2102_read_sync(TSC2102_AUDIO4_CTRL));
 }
 #endif
@@ -131,7 +131,7 @@ static void dump_tsc2102_audio_regs(void) {
  * ALSA operations according to board file
  */
 
-static long current_rate = 0;
+static long current_rate;
 
 /*
  * Sample rate changing
@@ -180,7 +180,7 @@ static void tsc2102_configure(void)
 
 /*
  * Omap McBSP clock and Power Management configuration
- *  
+ *
  * Here we have some functions that allow clock to be enabled and
  * disabled only when needed.  Besides doing clock configuration
  * they allow turn audio on and off when necessary.
-- 
1.5.5-rc3.GIT

