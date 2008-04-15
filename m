From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 04/19] Code clean-up for sound/arm/omap/omap-alsa-aic23.h
Date: Tue, 15 Apr 2008 10:02:08 -0400
Message-ID: <1208268143-8789-5-git-send-email-edubezval@gmail.com>
References: <1208268143-8789-1-git-send-email-edubezval@gmail.com>
 <1208268143-8789-2-git-send-email-edubezval@gmail.com>
 <1208268143-8789-3-git-send-email-edubezval@gmail.com>
 <1208268143-8789-4-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40409 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761254AbYDOOCf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:35 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE28Ml008266
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 17:02:33 +0300
In-Reply-To: <1208268143-8789-4-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-aic23.h |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-aic23.h b/sound/arm/omap/omap-alsa-aic23.h
index c15e95a..a5a360e 100644
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
@@ -60,7 +60,8 @@
 #define SIDETONE_12			0x080
 #define SIDETONE_18			0x0c0
 
-#define DEFAULT_ANALOG_AUDIO_CONTROL  DAC_SELECTED | STE_ENABLED | BYPASS_ON | INSEL_MIC | MICB_20DB
+#define DEFAULT_ANALOG_AUDIO_CONTROL  (DAC_SELECTED | STE_ENABLED \
+					| BYPASS_ON | INSEL_MIC | MICB_20DB)
 
 struct aic23_samplerate_reg_info {
 	u32 sample_rate;
@@ -71,8 +72,8 @@ struct aic23_samplerate_reg_info {
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

