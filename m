From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 18/19] Code clean-up for sound/arm/omap/omap-alsa-tsc2102.h
Date: Tue, 15 Apr 2008 10:02:22 -0400
Message-ID: <1208268143-8789-19-git-send-email-edubezval@gmail.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48094 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759961AbYDOOCk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:40 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE2PF0018691
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 17:02:37 +0300
In-Reply-To: <1208268143-8789-18-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-tsc2102.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-tsc2102.h b/sound/arm/omap/omap-alsa-tsc2102.h
index cee2839..0e0c097 100644
--- a/sound/arm/omap/omap-alsa-tsc2102.h
+++ b/sound/arm/omap/omap-alsa-tsc2102.h
@@ -1,6 +1,6 @@
 /*
  * sound/arm/omap/omap-alsa-tsc2102.h
- * 
+ *
  * Alsa codec driver for TSC2102 chip for OMAP platforms.
  *
  * Copyright (c) 2006 Andrzej Zaborowski  <balrog@zabor.org>
-- 
1.5.5-rc3.GIT

