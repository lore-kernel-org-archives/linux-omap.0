From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH v2] dma: fix scope of errata i88 upto 3430ES1.0
Date: Mon, 5 Apr 2010 21:06:41 +0530
Message-ID: <o2h618f0c911004050836ge9222b05i6520c8c7de9336ed@mail.gmail.com>
References: <w2g618f0c911004020435qd281c5deoc3e0ade84cc2d0b1@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C4C33347@dbde02.ent.ti.com>
	 <p2i618f0c911004050819u9af37b57ob399a52006f40017@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:57797 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab0DEPgl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Apr 2010 11:36:41 -0400
Received: by pzk31 with SMTP id 31so585163pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 05 Apr 2010 08:36:41 -0700 (PDT)
In-Reply-To: <p2i618f0c911004050819u9af37b57ob399a52006f40017@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

>From 2799506180649cbb61d24cf2b4171425b2e1fa80 Mon Sep 17 00:00:00 2001
From: Venkatraman S <svenkatr@ti.com>
Date: Mon, 5 Apr 2010 20:56:27 +0530
Subject: [PATCH] dma: fix scope of errata i88 upto 3430ES1.0

DMA errata for special end of block programming is applicable
only for OMAP2430 & OMAP3430 ES1.0.
This patch does the necessary checks before the workaround
is applied. Tested on 3430 SDP

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Reviewed-by: Shilimkar Santosh <santosh.shilimkar@ti.com>
---
>From v1, removed the redundant omap3430() check

 arch/arm/plat-omap/dma.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 2ab224c..a9b480a 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1663,14 +1663,17 @@ int omap_stop_dma_chain_transfers(int chain_id)
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
+	if (cpu_is_omap2430() || (omap_rev() == OMAP3430_REV_ES1_0)) {
+		l = sys_cf;
+		/* Middle mode reg set no Standby */
+		l &= ~((1 << 12)|(1 << 13));
+		dma_write(l, OCP_SYSCONFIG);
+	}

 	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {

@@ -1689,8 +1692,9 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	/* Reset the Queue pointers */
 	OMAP_DMA_CHAIN_QINIT(chain_id);

-	/* Errata - put in the old value */
-	dma_write(sys_cf, OCP_SYSCONFIG);
+	/* Errata: put back the old value */
+	if (cpu_is_omap2430() || (omap_rev() == OMAP3430_REV_ES1_0))
+		dma_write(sys_cf, OCP_SYSCONFIG);

 	return 0;
 }
-- 
1.6.3.3
