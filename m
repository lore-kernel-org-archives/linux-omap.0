From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/9] omap: sdma: Limit the secure reserve channel fix for omap3
Date: Thu, 18 Feb 2010 14:29:09 +0530
Message-ID: <1266483554-15044-4-git-send-email-santosh.shilimkar@ti.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-2-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60072 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753949Ab0BRI7k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 03:59:40 -0500
In-Reply-To: <1266483554-15044-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Kevin Hilman <khilman@deeprootsystems.com>

The commit 'ba50ea7e' reserves DMA channels 0 and 1 on high
security devices, in order to avoid collision between kernel
dma transfers and ROM code dma transfers.

This fix is applicable only for OMAP3 so add an appropriate
check.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/dma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 5ec96db..049165c 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2149,7 +2149,8 @@ static int __init omap_init_dma(void)
 			DMA_SYSCONFIG_AUTOIDLE);
 		dma_write(v , OCP_SYSCONFIG);
 		/* reserve dma channels 0 and 1 in high security devices */
-		if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+		if (cpu_is_omap34xx() &&
+			(omap_type() != OMAP2_DEVICE_TYPE_GP)) {
 			printk(KERN_INFO "Reserving DMA channels 0 and 1 for "
 					"HS ROM code\n");
 			dma_chan[0].dev_id = 0;
-- 
1.6.0.4

