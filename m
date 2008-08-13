From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data
Date: Wed, 13 Aug 2008 11:43:30 +0530 (IST)
Message-ID: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42014 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbYHMGNh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Aug 2008 02:13:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

From: Madhusudhan Chikkature<madhu.cr@ti.com>

ARM: OMAP3: Enable 4-bit support for HSMMC.

This patch provides the fix to enable 4-bit support for HSMMC.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
Signed-off-by: purushotam<purushotam@ti.com>
---
 arch/arm/plat-omap/devices.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/arch/arm/plat-omap/devices.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/devices.c	2008-08-07
15:56:52.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/devices.c	2008-08-11 10:57:37.000000000
+0530
@@ -289,13 +289,17 @@ static void __init omap_init_mmc(void)
 	mmc = &mmc_conf->mmc[0];

 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
-		if (mmc->enabled)
+		if (mmc->enabled) {
+			mmc1_data.conf = *mmc;
 			(void) platform_device_register(&mmc_omap_device1);
+		}

 #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
 		mmc = &mmc_conf->mmc[1];
-		if (mmc->enabled)
+		if (mmc->enabled) {
+			mmc2_data.conf = *mmc;
 			(void) platform_device_register(&mmc_omap_device2);
+		}
 #endif

 		return;


