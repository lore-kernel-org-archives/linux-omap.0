From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH 09/11] OMAP: DMA: Implement generic errata handling
Date: Thu, 29 Jul 2010 15:29:03 +0530
Message-ID: <1280397545-27323-10-git-send-email-manjugk@ti.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59300 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756418Ab0G2KBE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jul 2010 06:01:04 -0400
In-Reply-To: <1280397545-27323-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Anand Sawant <sawant@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Basak Partha <p-basak2@ti.com>, Charulatha V <charu@ti.com>

This patch introduces generic way of handling all OMAP DMA
errata's which are applicable for OMAP1 and OMAP2PLUS processors.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/mach-omap1/dma.c             |    6 ++++
 arch/arm/mach-omap2/dma.c             |   34 +++++++++++++++++++++++
 arch/arm/plat-omap/dma.c              |   48 ++++++++++++++++++--------------
 arch/arm/plat-omap/include/plat/dma.h |    9 ++++++
 4 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 0df2b82..00ef40f 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -170,6 +170,12 @@ static int __init omap1_system_dma_init(void)
 		goto exit_device_put;
 	}
 
+	/* Errata handling for all omap1 plus processors */
+	pdata->errata			= 0;
+
+	if (cpu_class_is_omap1() && !cpu_is_omap15xx())
+		pdata->errata		|= OMAP3_3_ERRATUM;
+
 	d = pdata->dma_attr;
 
 	/* Valid attributes for omap1 plus processors */
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index da76c34..72abfec 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -80,6 +80,40 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *user)
 
 	pdata->dma_attr		= (struct omap_dma_dev_attr *)oh->dev_attr;
 
+	/* Handling Errata's for all OMAP2PLUS processors */
+	pdata->errata			= 0;
+
+	if (cpu_is_omap242x() ||
+		(cpu_is_omap243x() &&  omap_type() <= OMAP2430_REV_ES1_0))
+		pdata->errata		= DMA_CHAINING_ERRATA;
+
+	/*
+	 * Errata: On ES2.0 BUFFERING disable must be set.
+	 * This will always fail on ES1.0
+	 */
+	if (cpu_is_omap24xx())
+		pdata->errata		|= DMA_BUFF_DISABLE_ERRATA;
+
+	/*
+	 * Errata: OMAP2: sDMA Channel is not disabled
+	 * after a transaction error. So we explicitely
+	 * disable the channel
+	 */
+	if (cpu_class_is_omap2())
+		pdata->errata		|= DMA_CH_DISABLE_ERRATA;
+
+	/* Errata: OMAP3 :
+	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
+	 * after secure sram context save and restore. Hence we need to
+	 * manually clear those IRQs to avoid spurious interrupts. This
+	 * affects only secure devices.
+	 */
+	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
+		pdata->errata		|= DMA_IRQ_STATUS_ERRATA;
+
+	/* Errata3.3: Applicable for all omap2 plus */
+	pdata->errata			|= OMAP3_3_ERRATUM;
+
 	od = omap_device_build(name, 0, oh, pdata, sizeof(*pdata),
 			omap2_dma_latency, ARRAY_SIZE(omap2_dma_latency), 0);
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 4627e84..b31c88f 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -182,6 +182,25 @@ static inline void set_gdma_dev(int req, int dev)
 #define set_gdma_dev(req, dev)	do {} while (0)
 #endif
 
+static void dma_ocpsysconfig_errata(u32 *sys_cf, bool flag)
+{
+	u32 l;
+
+	/*
+	 * DMA Errata:
+	 * Special programming model needed to disable DMA before end of block
+	 */
+	if (!flag) {
+		*sys_cf = dma_read(OCP_SYSCONFIG);
+		l = *sys_cf;
+		/* Middle mode reg set no Standby */
+		l &= ~((1 << 12)|(1 << 13));
+		dma_write(l, OCP_SYSCONFIG);
+	} else
+		/* put back old value */
+		dma_write(*sys_cf, OCP_SYSCONFIG);
+}
+
 /* Omap1 only */
 static void clear_lch_regs(int lch)
 {
@@ -958,22 +977,16 @@ void omap_start_dma(int lch)
 
 			cur_lch = next_lch;
 		} while (next_lch != -1);
-	} else if (cpu_is_omap242x() ||
-		(cpu_is_omap243x() &&  omap_type() <= OMAP2430_REV_ES1_0)) {
+	}
 
-		/* Errata: Need to write lch even if not using chaining */
+	if (p->errata & DMA_CHAINING_ERRATA)
 		dma_write(lch, CLNK_CTRL(lch));
-	}
 
 	omap_enable_channel_irq(lch);
 
 	l = dma_read(CCR(lch));
 
-	/*
-	 * Errata: On ES2.0 BUFFERING disable must be set.
-	 * This will always fail on ES1.0
-	 */
-	if (cpu_is_omap24xx())
+	if (p->errata & DMA_BUFF_DISABLE_ERRATA)
 		l |= OMAP_DMA_CCR_EN;
 
 	l |= OMAP_DMA_CCR_EN;
@@ -1647,7 +1660,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 {
 	int *channels;
 	u32 l, i;
-	u32 sys_cf;
+	u32 get_sysconfig;
 
 	/* Check for input params */
 	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
@@ -1662,15 +1675,8 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	}
 	channels = dma_linked_lch[chain_id].linked_dmach_q;
 
-	/*
-	 * DMA Errata:
-	 * Special programming model needed to disable DMA before end of block
-	 */
-	sys_cf = dma_read(OCP_SYSCONFIG);
-	l = sys_cf;
-	/* Middle mode reg set no Standby */
-	l &= ~((1 << 12)|(1 << 13));
-	dma_write(l, OCP_SYSCONFIG);
+	if (p->errata & DMA_SYSCONFIG_ERRATA)
+		dma_ocpsysconfig_errata(&get_sysconfig, false);
 
 	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
 
@@ -1689,8 +1695,8 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	/* Reset the Queue pointers */
 	OMAP_DMA_CHAIN_QINIT(chain_id);
 
-	/* Errata - put in the old value */
-	dma_write(sys_cf, OCP_SYSCONFIG);
+	if (p->errata & DMA_SYSCONFIG_ERRATA)
+		dma_ocpsysconfig_errata(&get_sysconfig, true);
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 92c348f..6d1fee0 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -268,6 +268,14 @@
 #define IS_WORD_16			(8 << 9)
 #define IS_RW_PRIORIY			(8 << 0xA)
 
+/* Errata Definitions */
+#define	DMA_CHAINING_ERRATA		(1 << 0)
+#define	DMA_BUFF_DISABLE_ERRATA		(1 << 1)
+#define	OMAP3_3_ERRATUM			(1 << 2)
+#define	DMA_SYSCONFIG_ERRATA		(1 << 3)
+#define	DMA_CH_DISABLE_ERRATA		(1 << 4)
+#define	DMA_IRQ_STATUS_ERRATA		(1 << 5)
+
 enum omap_dma_burst_mode {
 	OMAP_DMA_DATA_BURST_DIS = 0,
 	OMAP_DMA_DATA_BURST_4,
@@ -345,6 +353,7 @@ struct omap_dma_dev_attr {
 struct omap_system_dma_plat_info {
 	struct omap_dma_dev_attr *dma_attr;
 	void __iomem *omap_dma_base;
+	u32 errata;
 };
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
-- 
1.7.0.4

