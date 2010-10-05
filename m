From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v5 3/3] OMAP: DMA: Use flags for errata handling
Date: Tue,  5 Oct 2010 09:45:41 +0300
Message-ID: <1286261141-1039-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.ext.nokia.com ([147.243.1.48]:20528 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757579Ab0JEGps (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 02:45:48 -0400
In-Reply-To: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

Change the errata handling to use flags instead of cpu_is_*
cpu_class_* in the code.
The errata flags are initialized at init time.
In runtime we are using the dma_errata variable (via the
IS_DMA_ERRATA macro) to execute the required errata workaround.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/plat-omap/dma.c |   44 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index f5c5b8d..2f7fba0 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -147,6 +147,20 @@ static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
 	INT_1610_DMA_CH14, INT_1610_DMA_CH15, INT_DMA_LCD
 };
 
+/* Errata handling */
+u32 dma_errata;
+#define IS_DMA_ERRATA(id)		(dma_errata & (id))
+#define SET_DMA_ERRATA(id)		(dma_errata | (id))
+
+/* Errata: Inter Frame DMA buffering issue */
+#define DMA_ERRATA_IFRAME_BUFFERING	(1 << 0)
+/* Errata: DMA may hang when several channels are used in parallel */
+#define DMA_ERRATA_PARALLEL_CHANNELS	(1 << 1)
+/* Errata i378: sDMA Channel is not disabled after a transaction error */
+#define DMA_ERRATA_i378			(1 << 2)
+/* Errata i541: sDMA FIFO draining does not finish */
+#define DMA_ERRATA_i541			(1 << 3)
+
 static inline void disable_lnk(int lch);
 static void omap_disable_channel_irq(int lch);
 static inline void omap_enable_channel_irq(int lch);
@@ -985,9 +999,7 @@ void omap_start_dma(int lch)
 
 			cur_lch = next_lch;
 		} while (next_lch != -1);
-	} else if (cpu_is_omap242x() ||
-		(cpu_is_omap243x() &&  omap_type() <= OMAP2430_REV_ES1_0)) {
-
+	} else if (IS_DMA_ERRATA(DMA_ERRATA_PARALLEL_CHANNELS)) {
 		/* Errata: Need to write lch even if not using chaining */
 		dma_write(lch, CLNK_CTRL(lch));
 	}
@@ -1005,8 +1017,7 @@ void omap_start_dma(int lch)
 	 * guarantee no data will stay in the DMA FIFO in case inter frame
 	 * buffering occurs.
 	 */
-	if (cpu_is_omap2420() ||
-	    (cpu_is_omap2430() && (omap_type() == OMAP2430_REV_ES1_0)))
+	if (IS_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING))
 		l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
 
 	l |= OMAP_DMA_CCR_EN;
@@ -1026,7 +1037,8 @@ void omap_stop_dma(int lch)
 
 	l = dma_read(CCR(lch));
 	/* OMAP3 Errata i541: sDMA FIFO draining does not finish */
-	if (cpu_is_omap34xx() && (l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
+	if (IS_DMA_ERRATA(DMA_ERRATA_i541) &&
+	    (l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
 		int i = 0;
 		u32 sys_cf;
 
@@ -1960,7 +1972,7 @@ static int omap2_dma_handle_ch(int ch)
 	if (unlikely(status & OMAP2_DMA_TRANS_ERR_IRQ)) {
 		printk(KERN_INFO "DMA transaction error with device %d\n",
 		       dma_chan[ch].dev_id);
-		if (cpu_class_is_omap2()) {
+		if (IS_DMA_ERRATA(DMA_ERRATA_i378)) {
 			/*
 			 * Errata: sDMA Channel is not disabled
 			 * after a transaction error. So we explicitely
@@ -2079,6 +2091,22 @@ void omap_dma_global_context_restore(void)
 
 /*----------------------------------------------------------------------------*/
 
+/* Initialize sDMA errata flags */
+static void dma_errata_configure(void)
+{
+	if (cpu_is_omap242x() ||
+	    (cpu_is_omap243x() && (omap_type() == OMAP2430_REV_ES1_0))) {
+		SET_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING);
+		SET_DMA_ERRATA(DMA_ERRATA_PARALLEL_CHANNELS);
+	}
+
+	if (cpu_class_is_omap2())
+		SET_DMA_ERRATA(DMA_ERRATA_i378);
+
+	if (cpu_is_omap34xx())
+		SET_DMA_ERRATA(DMA_ERRATA_i541);
+}
+
 static int __init omap_init_dma(void)
 {
 	unsigned long base;
@@ -2101,6 +2129,8 @@ static int __init omap_init_dma(void)
 		return -ENODEV;
 	}
 
+	dma_errata_configure();
+
 	omap_dma_base = ioremap(base, SZ_4K);
 	BUG_ON(!omap_dma_base);
 
-- 
1.7.3.1

