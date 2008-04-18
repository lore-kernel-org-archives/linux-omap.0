From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 18/19] Code clean-up for sound/arm/omap/omap-alsa-tsc2102.h
Date: Fri, 18 Apr 2008 04:01:05 -0400
Message-ID: <1208505666-13744-19-git-send-email-edubezval@gmail.com>
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
 <1208505666-13744-18-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18811 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbYDRIBY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:24 -0400
In-Reply-To: <1208505666-13744-18-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

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

