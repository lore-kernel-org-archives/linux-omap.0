From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 15/19] Code clean-up for sound/arm/omap/omap-alsa-tsc2101.h
Date: Fri, 18 Apr 2008 04:01:02 -0400
Message-ID: <1208505666-13744-16-git-send-email-edubezval@gmail.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34478 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180AbYDRIBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:23 -0400
In-Reply-To: <1208505666-13744-15-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-tsc2101.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-tsc2101.h b/sound/arm/omap/omap-alsa-tsc2101.h
index 73999a0..fb03801 100644
--- a/sound/arm/omap/omap-alsa-tsc2101.h
+++ b/sound/arm/omap/omap-alsa-tsc2101.h
@@ -1,6 +1,6 @@
 /*
  * sound/arm/omap/omap-alsa-tsc2101.h
- * 
+ *
  * Alsa Driver for TSC2101 codec for OMAP platform boards.
  *
  * Based on former omap-aic23.h and tsc2101 OSS drivers.
@@ -9,7 +9,7 @@
  *
  * Copyright (C) 2006 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
  *          Alsa modularization by Daniel Petrini (d.pensator@gmail.com)
- * 
+ *
  * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -54,7 +54,7 @@ struct tsc2101_samplerate_reg_info {
 };
 
 /*
- * Defines codec specific functions pointers that can be used from the 
+ * Defines codec specific function pointers that can be used from the
  * common omap-alse base driver for all omap codecs. (tsc2101 and aic23)
  */
 inline void tsc2101_configure(void);
-- 
1.5.5-rc3.GIT

