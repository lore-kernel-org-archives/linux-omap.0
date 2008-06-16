From: Purushotam Kumar <a0876542@india.ti.com>
Subject: [PATCH] OMAP3:devices.c: Enabling 4-bit for SD card
Date: Mon, 16 Jun 2008 18:32:33 +0530
Message-ID: <200806161302.m5GD2Xg4007641@india.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54705 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbYFPNC6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jun 2008 09:02:58 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5GD2ZOK011296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2008 08:02:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: anantgole@ti.com

OMAP3:devices.c:Enabling 4-bit for SD card

SD card was working in 1-bit mode.This patch will configure SD card in 
4-bit mode and hence performance  will increase.

Signed-off-by: Purushotam Kumar <purushotam@ti.com>
Acked-by: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
---
 arch/arm/plat-omap/devices.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/plat-omap/devices.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/devices.c
+++ linux-omap-2.6/arch/arm/plat-omap/devices.c
@@ -292,8 +292,10 @@ static void __init omap_init_mmc(void)
 	mmc = &mmc_conf->mmc[0];
 
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
-		if (mmc->enabled)
+		if (mmc->enabled) {
+			mmc1_data.conf = *mmc;
 			(void) platform_device_register(&mmc_omap_device1);
+		}
 
 #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
 		mmc = &mmc_conf->mmc[1];
