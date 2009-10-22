From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH V2]Omap3630: Add hsmmc related checks
Date: Fri, 23 Oct 2009 01:33:55 +0530 (IST)
Message-ID: <37946.192.168.10.89.1256241835.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60994 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756522AbZJVUDx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 16:03:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org

>From 102c97677b6a30b7741e1612c8fc03d60921f4e8 Mon Sep 17 00:00:00 2001
From: Madhu <madhu.cr@ti.com>
Date: Wed, 21 Oct 2009 16:16:31 -0400
Subject: [PATCH] Omap3630: Add HSMMC related checks.

Change the cpu_is_omap3430() check to cpu_is_omap34xx() to allow HSMMC1/2
mux configuration for omap3630.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 arch/arm/mach-omap2/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7d4513b..8d23e1f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -575,7 +575,7 @@ static inline void omap2_mmc_mux(struct
omap_mmc_platform_data *mmc_controller,
 		}
 	}

-	if (cpu_is_omap3430()) {
+	if (cpu_is_omap34xx()) {
 		if (controller_nr == 0) {
 			omap_cfg_reg(N28_3430_MMC1_CLK);
 			omap_cfg_reg(M27_3430_MMC1_CMD);
-- 
1.6.0.4



