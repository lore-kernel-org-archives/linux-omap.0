From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 13/19] Code clean-up for sound/arm/omap/omap-alsa-tsc2101-mixer.h
Date: Fri, 18 Apr 2008 04:01:00 -0400
Message-ID: <1208505666-13744-14-git-send-email-edubezval@gmail.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18790 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340AbYDRIBV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:21 -0400
In-Reply-To: <1208505666-13744-13-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-tsc2101-mixer.h |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.h b/sound/arm/omap/omap-alsa-tsc2101-mixer.h
index b110b36..c0d9b23 100644
--- a/sound/arm/omap/omap-alsa-tsc2101-mixer.h
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.h
@@ -1,9 +1,9 @@
 /*
  * sound/arm/omap/omap-alsa-tsc2101-mixer.h
- * 
+ *
  * Alsa Driver for TSC2101 codec for OMAP platform boards.
  *
- * Copyright (C) 2005 Mika Laitio <lamikr@cc.jyu.fi> and 
+ * Copyright (C) 2005 Mika Laitio <lamikr@cc.jyu.fi> and
  * 		     Everett Coleman II <gcc80x86@fuzzyneural.net>
  *
  * Based on the ideas in omap-aic23.c and sa11xx-uda1341.c
@@ -33,9 +33,9 @@
  * History:
  *
  * 2006-03-01   Mika Laitio - Mixer for the tsc2101 driver used in omap boards.
- * 		Can switch between headset and loudspeaker playback, 
+ * 		Can switch between headset and loudspeaker playback,
  * 		mute and unmute dgc, set dgc volume. Record source switch,
- * 		keyclick, buzzer and headset volume and handset volume control 
+ * 		keyclick, buzzer and headset volume and handset volume control
  * 		are still missing.
  */
 
@@ -46,8 +46,8 @@
 #include "omap-alsa-dma.h"
 
 /* tsc2101 DAC gain control volume specific  */
-#define OUTPUT_VOLUME_MIN		0x7F	// 1111111 = -63.5 DB
-#define OUTPUT_VOLUME_MAX		0x32	// 110010
+#define OUTPUT_VOLUME_MIN		0x7F	/* 1111111 = -63.5 DB */
+#define OUTPUT_VOLUME_MAX		0x32	/* 110010 */
 #define OUTPUT_VOLUME_RANGE		(OUTPUT_VOLUME_MIN - OUTPUT_VOLUME_MAX)
 
 /* use input vol of 75 for 0dB gain */
@@ -60,10 +60,15 @@
 #define PLAYBACK_TARGET_HEADPHONE	0x01
 #define PLAYBACK_TARGET_CELLPHONE	0x02
 
-/* following are used for register 03h Mixer PGA control bits D7-D5 for selecting record source */
+/*
+ * Following are used for register 03h Mixer PGA control bits D7-D5 for
+ * selecting record source
+ */
 #define REC_SRC_TARGET_COUNT		0x08
-#define REC_SRC_SINGLE_ENDED_MICIN_HED	0x00	// oss code referred to MIXER_LINE
-#define REC_SRC_SINGLE_ENDED_MICIN_HND	0x01	// oss code referred to MIXER_MIC
+/* oss code referred to MIXER_LINE */
+#define REC_SRC_SINGLE_ENDED_MICIN_HED	0x00
+/* oss code referred to MIXER_MIC */
+#define REC_SRC_SINGLE_ENDED_MICIN_HND	0x01
 #define REC_SRC_SINGLE_ENDED_AUX1	0x02
 #define REC_SRC_SINGLE_ENDED_AUX2	0x03
 #define REC_SRC_MICIN_HED_AND_AUX1	0x04
@@ -71,8 +76,10 @@
 #define REC_SRC_MICIN_HND_AND_AUX1	0x06
 #define REC_SRC_MICIN_HND_AND_AUX2	0x07
 
-#define DEFAULT_OUTPUT_VOLUME		90	// default output volume to dac dgc
-#define DEFAULT_INPUT_VOLUME		20	// default record volume
+/* default output volume to dac dgc */
+#define DEFAULT_OUTPUT_VOLUME		90
+/* default record volume */
+#define DEFAULT_INPUT_VOLUME		20
 
 #define TSC2101_AUDIO_CODEC_REGISTERS_PAGE2     (2)
 
-- 
1.5.5-rc3.GIT

