From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH] dma: fix scope of errata i88 upto 3430ES1.0
Date: Fri, 2 Apr 2010 17:05:15 +0530
Message-ID: <w2g618f0c911004020435qd281c5deoc3e0ade84cc2d0b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f199.google.com ([209.85.223.199]:60116 "EHLO
	mail-iw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932393Ab0DBLfR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Apr 2010 07:35:17 -0400
Received: by iwn37 with SMTP id 37so1444863iwn.15
        for <linux-omap@vger.kernel.org>; Fri, 02 Apr 2010 04:35:16 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: thara@ti.com, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

DMA errata for special end of block programming is applicable
only for OMAP2430 & OMAP3430 ES1.0.
This patch does the necessary checks before the workaround
is applied. Tested on 3430 SDP

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/plat-omap/dma.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 2ab224c..ef965ac 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1663,14 +1663,18 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	channels = dma_linked_lch[chain_id].linked_dmach_q;

 	/*
-	 * DMA Errata:
-	 * Special programming model needed to disable DMA before end of block
+	 * DMA Errata: i88
+	 * Special programming model needed
+	 * to disable DMA before end of block
 	 */
 	sys_cf = dma_read(OCP_SYSCONFIG);
-	l = sys_cf;
-	/* Middle mode reg set no Standby */
-	l &= ~((1 << 12)|(1 << 13));
-	dma_write(l, OCP_SYSCONFIG);
+	if (cpu_is_omap2430() || (cpu_is_omap3430() &&
+			omap_rev() == OMAP3430_REV_ES1_0)) {
+		l = sys_cf;
+		/* Middle mode reg set no Standby */
+		l &= ~((1 << 12)|(1 << 13));
+		dma_write(l, OCP_SYSCONFIG);
+	}

 	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {

@@ -1689,8 +1693,10 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	/* Reset the Queue pointers */
 	OMAP_DMA_CHAIN_QINIT(chain_id);

-	/* Errata - put in the old value */
-	dma_write(sys_cf, OCP_SYSCONFIG);
+	/* Errata: put back the old value */
+	if (cpu_is_omap2430() || (cpu_is_omap3430() &&
+			omap_rev() == OMAP3430_REV_ES1_0))
+		dma_write(sys_cf, OCP_SYSCONFIG);

 	return 0;
 }
-- 
1.6.3.3
