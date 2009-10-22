From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH]Omap3630: Add hsmmc related checks
Date: Thu, 22 Oct 2009 23:08:52 +0530 (IST)
Message-ID: <62121.192.168.10.89.1256233132.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45399 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287AbZJVRix (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Oct 2009 13:38:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org

>From 661b13474a7af62c54f7df7a33a818c5e782cc59 Mon Sep 17 00:00:00 2001
From: Madhu <madhu.cr@ti.com>
Date: Wed, 21 Oct 2009 16:16:31 -0400
Subject: [PATCH] Omap3630: Add HSMMC related checks.

Add omap3630 conditional checks to devices.c to allow HSMMC3 addition and
mux configuration for HSMMC1/2.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 arch/arm/mach-omap2/devices.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7d4513b..1fdfc7f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -575,7 +575,7 @@ static inline void omap2_mmc_mux(struct
omap_mmc_platform_data *mmc_controller,
 		}
 	}

-	if (cpu_is_omap3430()) {
+	if (cpu_is_omap3430() || cpu_is_omap3630()) {
 		if (controller_nr == 0) {
 			omap_cfg_reg(N28_3430_MMC1_CLK);
 			omap_cfg_reg(M27_3430_MMC1_CMD);
@@ -642,7 +642,8 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data
**mmc_data,
 			irq = INT_24XX_MMC2_IRQ;
 			break;
 		case 2:
-			if (!cpu_is_omap44xx() && !cpu_is_omap34xx())
+			if (!cpu_is_omap44xx() && !cpu_is_omap34xx()
+				&& !cpu_is_omap3630())
 				return;
 			base = OMAP3_MMC3_BASE;
 			irq = INT_34XX_MMC3_IRQ;
-- 
1.6.0.4



