From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 1/2] OMAP: DMA: prevent races while setting M idle mode to nostandby
Date: Tue, 30 Nov 2010 15:23:47 +0200
Message-ID: <20101130132347.13286.40388.sendpatchset@ahunter-work.research.nokia.com>
References: <20101130132341.13286.25157.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:39215 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab0K3NYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 08:24:20 -0500
In-Reply-To: <20101130132341.13286.25157.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Manjunatha GK <manjugk@ti.com>, Santosh Shilimkar <Santosh.shilimkar@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

>From 8c0f4490d93b67326ff24f6ce1c7e925b08d96b3 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Mon, 22 Nov 2010 11:32:48 +0200
Subject: [PATCH 1/2] OMAP: DMA: prevent races while setting M idle mode to nostandby

In a couple of OMAP errata cases, sDMA M idle mode must be
set temporarily to nostandby.  If two DMA users were to do
that at the same time, a race condition would arise.
Prevent that by using a spin lock and counting up/down the
number of times nostandby is set/reset.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/plat-omap/dma.c |   59 ++++++++++++++++++++++++++++++++++-----------
 1 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index a863f55..6158c99 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -139,6 +139,9 @@ static spinlock_t dma_chan_lock;
 static struct omap_dma_lch *dma_chan;
 static void __iomem *omap_dma_base;
 
+static u32 midlemode_saved;
+static int midlemode_save_cnt;
+
 static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
 	INT_DMA_CH0_6, INT_DMA_CH1_7, INT_DMA_CH2_8, INT_DMA_CH3,
 	INT_DMA_CH4, INT_DMA_CH5, INT_1610_DMA_CH6, INT_1610_DMA_CH7,
@@ -1016,6 +1019,41 @@ void omap_start_dma(int lch)
 }
 EXPORT_SYMBOL(omap_start_dma);
 
+static void midlemode_nostandby(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dma_chan_lock, flags);
+	if (!midlemode_save_cnt) {
+		u32 l;
+
+		midlemode_saved = dma_read(OCP_SYSCONFIG);
+		l = midlemode_saved;
+		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
+		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
+		dma_write(l, OCP_SYSCONFIG);
+	}
+	midlemode_save_cnt += 1;
+	spin_unlock_irqrestore(&dma_chan_lock, flags);
+}
+
+static void midlemode_restore(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dma_chan_lock, flags);
+	midlemode_save_cnt -= 1;
+	if (!midlemode_save_cnt) {
+		u32 l;
+
+		l = dma_read(OCP_SYSCONFIG);
+		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
+		l |= midlemode_saved & DMA_SYSCONFIG_MIDLEMODE_MASK;
+		dma_write(l, OCP_SYSCONFIG);
+	}
+	spin_unlock_irqrestore(&dma_chan_lock, flags);
+}
+
 void omap_stop_dma(int lch)
 {
 	u32 l;
@@ -1028,16 +1066,10 @@ void omap_stop_dma(int lch)
 	/* OMAP3 Errata i541: sDMA FIFO draining does not finish */
 	if (cpu_is_omap34xx() && (l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
 		int i = 0;
-		u32 sys_cf;
 
 		/* Configure No-Standby */
-		l = dma_read(OCP_SYSCONFIG);
-		sys_cf = l;
-		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
-		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
-		dma_write(l , OCP_SYSCONFIG);
+		midlemode_nostandby();
 
-		l = dma_read(CCR(lch));
 		l &= ~OMAP_DMA_CCR_EN;
 		dma_write(l, CCR(lch));
 
@@ -1053,7 +1085,7 @@ void omap_stop_dma(int lch)
 			printk(KERN_ERR "DMA drain did not complete on "
 					"lch %d\n", lch);
 		/* Restore OCP_SYSCONFIG */
-		dma_write(sys_cf, OCP_SYSCONFIG);
+		midlemode_restore();
 	} else {
 		l &= ~OMAP_DMA_CCR_EN;
 		dma_write(l, CCR(lch));
@@ -1711,7 +1743,6 @@ int omap_stop_dma_chain_transfers(int chain_id)
 {
 	int *channels;
 	u32 l, i;
-	u32 sys_cf;
 
 	/* Check for input params */
 	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
@@ -1730,11 +1761,9 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	 * DMA Errata:
 	 * Special programming model needed to disable DMA before end of block
 	 */
-	sys_cf = dma_read(OCP_SYSCONFIG);
-	l = sys_cf;
-	/* Middle mode reg set no Standby */
-	l &= ~((1 << 12)|(1 << 13));
-	dma_write(l, OCP_SYSCONFIG);
+
+	/* M idle mode reg set no Standby */
+	midlemode_nostandby();
 
 	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
 
@@ -1754,7 +1783,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	OMAP_DMA_CHAIN_QINIT(chain_id);
 
 	/* Errata - put in the old value */
-	dma_write(sys_cf, OCP_SYSCONFIG);
+	midlemode_restore();
 
 	return 0;
 }
-- 
1.7.0.4

