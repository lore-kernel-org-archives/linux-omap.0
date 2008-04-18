From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 04/19] Code clean-up for sound/arm/omap/omap-alsa-aic23.h
Date: Fri, 18 Apr 2008 04:00:51 -0400
Message-ID: <1208505666-13744-5-git-send-email-edubezval@gmail.com>
References: <1208505666-13744-1-git-send-email-edubezval@gmail.com>
 <1208505666-13744-2-git-send-email-edubezval@gmail.com>
 <1208505666-13744-3-git-send-email-edubezval@gmail.com>
 <1208505666-13744-4-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18772 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287AbYDRIBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:20 -0400
In-Reply-To: <1208505666-13744-4-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-aic23.h |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-aic23.h b/sound/arm/omap/omap-alsa-aic23.h
index 8b11a69..66dc56b 100644
--- a/sound/arm/omap/omap-alsa-aic23.h
+++ b/sound/arm/omap/omap-alsa-aic23.h
@@ -1,6 +1,6 @@
 /*
  * sound/arm/omap-alsa-aic23.h
- * 
+ *
  * Alsa Driver for AIC23 codec on OSK5912 platform board
  *
  * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
@@ -59,7 +59,8 @@
 #define SIDETONE_12			0x080
 #define SIDETONE_18			0x0c0
 
-#define DEFAULT_ANALOG_AUDIO_CONTROL  DAC_SELECTED | STE_ENABLED | BYPASS_ON | INSEL_MIC | MICB_20DB
+#define DEFAULT_ANALOG_AUDIO_CONTROL  (DAC_SELECTED | STE_ENABLED | \
+					BYPASS_ON | INSEL_MIC | MICB_20DB)
 
 struct aic23_samplerate_reg_info {
 	u32 sample_rate;
@@ -70,8 +71,8 @@ struct aic23_samplerate_reg_info {
 extern int aic23_write_value(u8 reg, u16 value);
 
 /*
- * Defines codec specific functions pointers that can be used from the 
- * common omap-alse base driver for all omap codecs. (tsc2101 and aic23)
+ * Defines codec specific function pointers that can be used from the
+ * common omap-alsa base driver for all omap codecs. (tsc2101 and aic23)
  */
 void define_codec_functions(struct omap_alsa_codec_config *codec_config);
 inline void aic23_configure(void);
-- 
1.5.5-rc3.GIT

