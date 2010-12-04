From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v1 2/9] OMAP: DMA: Introduce errata handling feature
Date: Sat,  4 Dec 2010 09:13:59 +0530
Message-ID: <1291434246-30716-3-git-send-email-manjugk@ti.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59638 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754283Ab0LDDnw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 22:43:52 -0500
In-Reply-To: <1291434246-30716-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, "G, Manjunath Kondaiah" <manjugk@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Implement errata handling to use flags instead of cpu_is_* and
cpu_class_* in the code.

The errata flags are initialized at init time and during runtime we are
using the errata variable (via the IS_DMA_ERRATA macro) to execute the
required errata workaround.

Reused errata handling patch from: Peter Ujfalusi
<peter.ujfalusi@nokia.com>
https://patchwork.kernel.org/patch/231191/

Changes to above patch:
1. Changes are done for converting all the existing errata work arounds
to use this feature.
2. Detailed description for each errata is added.
3. Fixed bug in SET_DMA_ERRATA macro
4. Bit shifting in macro definitions are replaced with BIT() macro

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dma.c              |  152 ++++++++++++++++++++++-----------
 arch/arm/plat-omap/include/plat/dma.h |   12 +++
 2 files changed, 114 insertions(+), 50 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 49a7cd4..6f51bf3 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -144,6 +144,7 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
 
 static int enable_1510_mode;
+static u32 errata;
 
 static struct omap_dma_global_context_registers {
 	u32 dma_irqenable_l0;
@@ -1088,31 +1089,17 @@ void omap_start_dma(int lch)
 
 			cur_lch = next_lch;
 		} while (next_lch != -1);
-	} else if (cpu_is_omap242x() ||
-		(cpu_is_omap243x() &&  omap_type() <= OMAP2430_REV_ES1_0)) {
-
-		/* Errata: Need to write lch even if not using chaining */
+	} else if (IS_DMA_ERRATA(DMA_ERRATA_PARALLEL_CHANNELS))
 		dma_write(lch, CLNK_CTRL, lch);
-	}
 
 	omap_enable_channel_irq(lch);
 
 	l = dma_read(CCR, lch);
 
-	/*
-	 * Errata: Inter Frame DMA buffering issue (All OMAP2420 and
-	 * OMAP2430ES1.0): DMA will wrongly buffer elements if packing and
-	 * bursting is enabled. This might result in data gets stalled in
-	 * FIFO at the end of the block.
-	 * Workaround: DMA channels must have BUFFERING_DISABLED bit set to
-	 * guarantee no data will stay in the DMA FIFO in case inter frame
-	 * buffering occurs.
-	 */
-	if (cpu_is_omap2420() ||
-	    (cpu_is_omap2430() && (omap_type() == OMAP2430_REV_ES1_0)))
-		l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
-
+	if (IS_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING))
+			l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
 	l |= OMAP_DMA_CCR_EN;
+
 	dma_write(l, CCR, lch);
 
 	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
@@ -1128,8 +1115,8 @@ void omap_stop_dma(int lch)
 		dma_write(0, CICR, lch);
 
 	l = dma_read(CCR, lch);
-	/* OMAP3 Errata i541: sDMA FIFO draining does not finish */
-	if (cpu_is_omap34xx() && (l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
+	if (IS_DMA_ERRATA(DMA_ERRATA_i541) &&
+			(l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
 		int i = 0;
 		u32 sys_cf;
 
@@ -1229,11 +1216,7 @@ dma_addr_t omap_get_dma_src_pos(int lch)
 	else
 		offset = dma_read(CSAC, lch);
 
-	/*
-	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
-	 * read before the DMA controller finished disabling the channel.
-	 */
-	if (!cpu_is_omap15xx() && offset == 0)
+	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset == 0)
 		offset = dma_read(CSAC, lch);
 
 	if (cpu_class_is_omap1())
@@ -1814,7 +1797,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 {
 	int *channels;
 	u32 l, i;
-	u32 sys_cf;
+	u32 sys_cf = 0;
 
 	/* Check for input params */
 	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
@@ -1829,15 +1812,13 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	}
 	channels = dma_linked_lch[chain_id].linked_dmach_q;
 
-	/*
-	 * DMA Errata:
-	 * Special programming model needed to disable DMA before end of block
-	 */
-	sys_cf = dma_read(OCP_SYSCONFIG, 0);
-	l = sys_cf;
-	/* Middle mode reg set no Standby */
-	l &= ~((1 << 12)|(1 << 13));
-	dma_write(l, OCP_SYSCONFIG, 0);
+	if (IS_DMA_ERRATA(DMA_ERRATA_i88)) {
+		sys_cf = dma_read(OCP_SYSCONFIG, 0);
+		l = sys_cf;
+		/* Middle mode reg set no Standby */
+		l &= ~((1 << 12)|(1 << 13));
+		dma_write(l, OCP_SYSCONFIG, 0);
+	}
 
 	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
 
@@ -1856,8 +1837,8 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	/* Reset the Queue pointers */
 	OMAP_DMA_CHAIN_QINIT(chain_id);
 
-	/* Errata - put in the old value */
-	dma_write(sys_cf, OCP_SYSCONFIG, 0);
+	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
+		dma_write(sys_cf, OCP_SYSCONFIG, 0);
 
 	return 0;
 }
@@ -2063,12 +2044,7 @@ static int omap2_dma_handle_ch(int ch)
 	if (unlikely(status & OMAP2_DMA_TRANS_ERR_IRQ)) {
 		printk(KERN_INFO "DMA transaction error with device %d\n",
 		       dma_chan[ch].dev_id);
-		if (cpu_class_is_omap2()) {
-			/*
-			 * Errata: sDMA Channel is not disabled
-			 * after a transaction error. So we explicitely
-			 * disable the channel
-			 */
+		if (IS_DMA_ERRATA(DMA_ERRATA_i378)) {
 			u32 ccr;
 
 			ccr = dma_read(CCR, ch);
@@ -2168,13 +2144,7 @@ void omap_dma_global_context_restore(void)
 	dma_write(omap_dma_global_context.dma_irqenable_l0,
 		IRQENABLE_L0, 0);
 
-	/*
-	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
-	 * after secure sram context save and restore. Hence we need to
-	 * manually clear those IRQs to avoid spurious interrupts. This
-	 * affects only secure devices.
-	 */
-	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
+	if (IS_DMA_ERRATA(DMA_ROMCODE_BUG))
 		dma_write(0x3 , IRQSTATUS_L0, 0);
 
 	for (ch = 0; ch < dma_chan_count; ch++)
@@ -2182,6 +2152,87 @@ void omap_dma_global_context_restore(void)
 			omap_clear_dma(ch);
 }
 
+static void configure_dma_errata(void)
+{
+
+	/*
+	 * Errata applicable for OMAP2430ES1.0 and all omap2420
+	 *
+	 * I.
+	 * Erratum ID: Not Available
+	 * Inter Frame DMA buffering issue DMA will wrongly
+	 * buffer elements if packing and bursting is enabled. This might
+	 * result in data gets stalled in FIFO at the end of the block.
+	 * Workaround: DMA channels must have BUFFERING_DISABLED bit set to
+	 * guarantee no data will stay in the DMA FIFO in case inter frame
+	 * buffering occurs
+	 *
+	 * II.
+	 * Erratum ID: Not Available
+	 * DMA may hang when several channels are used in parallel
+	 * In the following configuration, DMA channel hanging can occur:
+	 * a. Channel i, hardware synchronized, is enabled
+	 * b. Another channel (Channel x), software synchronized, is enabled.
+	 * c. Channel i is disabled before end of transfer
+	 * d. Channel i is reenabled.
+	 * e. Steps 1 to 4 are repeated a certain number of times.
+	 * f. A third channel (Channel y), software synchronized, is enabled.
+	 * Channel x and Channel y may hang immediately after step 'f'.
+	 * Workaround:
+	 * For any channel used - make sure NextLCH_ID is set to the value j.
+	 */
+	if (cpu_is_omap2420() || (cpu_is_omap2430() &&
+				(omap_type() == OMAP2430_REV_ES1_0))) {
+		SET_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING);
+		SET_DMA_ERRATA(DMA_ERRATA_PARALLEL_CHANNELS);
+	}
+
+	/*
+	 * Erratum ID: i378: OMAP2plus: sDMA Channel is not disabled
+	 * after a transaction error.
+	 * Workaround: SW should explicitely disable the channel.
+	 */
+	if (cpu_class_is_omap2())
+		SET_DMA_ERRATA(DMA_ERRATA_i378);
+
+	/*
+	 * Erratum ID: i541: sDMA FIFO draining does not finish
+	 * If sDMA channel is disabled on the fly, sDMA enters standby even
+	 * through FIFO Drain is still in progress
+	 * Workaround: Put sDMA in NoStandby more before a logical channel is
+	 * disabled, then put it back to SmartStandby right after the channel
+	 * finishes FIFO draining.
+	 */
+	if (cpu_is_omap34xx())
+		SET_DMA_ERRATA(DMA_ERRATA_i541);
+
+	/*
+	 * Erratum ID: i88 : Special programming model needed to disable DMA
+	 * before end of block.
+	 * Workaround: software must ensure that the DMA is configured in No
+	 * Standby mode(DMAx_OCP_SYSCONFIG.MIDLEMODE = "01")
+	 */
+	if (cpu_is_omap34xx() && (omap_type() == OMAP3430_REV_ES1_0))
+		SET_DMA_ERRATA(DMA_ERRATA_i88);
+
+	/*
+	 * Erratum 3.2/3.3: sometimes 0 is returned if CSAC/CDAC is
+	 * read before the DMA controller finished disabling the channel.
+	 */
+	if (!cpu_is_omap15xx())
+		SET_DMA_ERRATA(DMA_ERRATA_3_3);
+
+	/*
+	 * Erratum ID: Not Available
+	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
+	 * after secure sram context save and restore.
+	 * Work around: Hence we need to manually clear those IRQs to avoid
+	 * spurious interrupts. This affects only secure devices.
+	 */
+	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
+		SET_DMA_ERRATA(DMA_ROMCODE_BUG);
+}
+
 /*----------------------------------------------------------------------------*/
 
 static int __init omap_init_dma(void)
@@ -2342,6 +2393,7 @@ static int __init omap_init_dma(void)
 			dma_chan[1].dev_id = 1;
 		}
 	}
+	configure_dma_errata();
 
 	return 0;
 
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index dfb1b10..2378399 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -283,6 +283,18 @@
 #define DMA_CH_PRIO_HIGH		0x1
 #define DMA_CH_PRIO_LOW			0x0 /* Def */
 
+/* Errata handling */
+#define IS_DMA_ERRATA(id)		(errata & (id))
+#define SET_DMA_ERRATA(id)		(errata |= (id))
+
+#define DMA_ERRATA_IFRAME_BUFFERING	BIT(0x0)
+#define DMA_ERRATA_PARALLEL_CHANNELS	BIT(0x1)
+#define DMA_ERRATA_i378			BIT(0x2)
+#define DMA_ERRATA_i541			BIT(0x3)
+#define DMA_ERRATA_i88			BIT(0x4)
+#define DMA_ERRATA_3_3			BIT(0x5)
+#define DMA_ROMCODE_BUG			BIT(0x6)
+
 enum omap_reg_offsets {
 
 GCR,		GSCR,		GRST1,		HW_ID,
-- 
1.7.1

