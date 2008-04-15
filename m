From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 15/19] Code clean-up for sound/arm/omap/omap-alsa-tsc2101.h
Date: Tue, 15 Apr 2008 10:02:19 -0400
Message-ID: <1208268143-8789-16-git-send-email-edubezval@gmail.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64758 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759961AbYDOOC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:59 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE3V1w031841
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 09:05:13 -0500
In-Reply-To: <1208268143-8789-15-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

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

