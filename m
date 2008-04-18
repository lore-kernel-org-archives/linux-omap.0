From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 09/19] Code clean-up for sound/arm/omap/omap-alsa-sx1-mixer.h
Date: Fri, 18 Apr 2008 04:00:56 -0400
Message-ID: <1208505666-13744-10-git-send-email-edubezval@gmail.com>
References: <1208505666-13744-1-git-send-email-edubezval@gmail.com>
 <1208505666-13744-2-git-send-email-edubezval@gmail.com>
 <1208505666-13744-3-git-send-email-edubezval@gmail.com>
 <1208505666-13744-4-git-send-email-edubezval@gmail.com>
 <1208505666-13744-5-git-send-email-edubezval@gmail.com>
 <1208505666-13744-6-git-send-email-edubezval@gmail.com>
 <1208505666-13744-7-git-send-email-edubezval@gmail.com>
 <1208505666-13744-8-git-send-email-edubezval@gmail.com>
 <1208505666-13744-9-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34538 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756183AbYDRIBl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:41 -0400
In-Reply-To: <1208505666-13744-9-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-sx1-mixer.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-sx1-mixer.h b/sound/arm/omap/omap-alsa-sx1-mixer.h
index 686b81c..7d55388 100644
--- a/sound/arm/omap/omap-alsa-sx1-mixer.h
+++ b/sound/arm/omap/omap-alsa-sx1-mixer.h
@@ -31,8 +31,10 @@
 /* following are used for register 03h Mixer PGA control bits
    D7-D5 for selecting record source */
 #define REC_SRC_TARGET_COUNT		0x08
-#define REC_SRC_SINGLE_ENDED_MICIN_HED	0x00 /* oss code referred to MIXER_LINE */
-#define REC_SRC_SINGLE_ENDED_MICIN_HND	0x01 /* oss code referred to MIXER_MIC */
+/* OSS code referred to MIXER_LINE */
+#define REC_SRC_SINGLE_ENDED_MICIN_HED	0x00
+/* OSS code referred to MIXER_MIC */
+#define REC_SRC_SINGLE_ENDED_MICIN_HND	0x01
 #define REC_SRC_SINGLE_ENDED_AUX1	0x02
 #define REC_SRC_SINGLE_ENDED_AUX2	0x03
 #define REC_SRC_MICIN_HED_AND_AUX1	0x04
-- 
1.5.5-rc3.GIT

