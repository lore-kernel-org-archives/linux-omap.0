From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH] AM35xx: disable checking for reserved feature bits
Date: Wed,  9 Nov 2011 00:51:38 +0100
Message-ID: <1320796298-7202-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:41972 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab1KHXvm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 18:51:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com
Cc: Ilya Yanok <yanok@emcraft.com>

Bits corresponding to the IVA and ISP features in OMAP_STATUS register
are reserved on AM35xx and checking for them results in wrong results.
So we don't want to check for this features on AM35xx.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/arm/mach-omap2/id.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 7f47092..40bab99 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -181,10 +181,8 @@ static void __init omap3_check_features(void)
 	status = omap_ctrl_readl(OMAP3_CONTROL_OMAP_STATUS);
 
 	OMAP3_CHECK_FEATURE(status, L2CACHE);
-	OMAP3_CHECK_FEATURE(status, IVA);
 	OMAP3_CHECK_FEATURE(status, SGX);
 	OMAP3_CHECK_FEATURE(status, NEON);
-	OMAP3_CHECK_FEATURE(status, ISP);
 	if (cpu_is_omap3630())
 		omap_features |= OMAP3_HAS_192MHZ_CLK;
 	if (cpu_is_omap3430() || cpu_is_omap3630())
@@ -192,6 +190,10 @@ static void __init omap3_check_features(void)
 	if (cpu_is_omap3630() || omap_rev() == OMAP3430_REV_ES3_1 ||
 	    omap_rev() == OMAP3430_REV_ES3_1_2)
 		omap_features |= OMAP3_HAS_IO_CHAIN_CTRL;
+	if (!cpu_is_omap3505() && !cpu_is_omap3517()) {
+		OMAP3_CHECK_FEATURE(status, IVA);
+		OMAP3_CHECK_FEATURE(status, ISP);
+	}
 
 	omap_features |= OMAP3_HAS_SDRC;
 
-- 
1.7.6.4

