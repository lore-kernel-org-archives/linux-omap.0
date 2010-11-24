From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v5 13/14] OMAP2+: DMA: Replace sysconfig register access with API's
Date: Wed, 24 Nov 2010 18:21:49 +0530
Message-ID: <1290603110-14119-14-git-send-email-manjugk@ti.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44063 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab0KXMxC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 07:53:02 -0500
In-Reply-To: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Few errata in OMAP2+ DMA driver require forcing DMA controller
mstandby mode to 'no standby' mode. Current implementation
directly access sysconfig registers for this operation.

Since there are API's for controlling mstandby mode, cleanup
sysconfig register access and replace the same with API's.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap1/dma.c             |    2 ++
 arch/arm/mach-omap2/dma.c             |   15 ++++++---------
 arch/arm/plat-omap/dma.c              |   13 ++++---------
 arch/arm/plat-omap/include/plat/dma.h |   17 ++---------------
 4 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 80c3380..57f5415 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -642,6 +642,8 @@ static int __init omap1_system_dma_init(void)
 	p->clear_channel_int	= NULL;
 	p->set_global_params	= NULL;
 	p->disable_irq_lch	= NULL;
+	p->require_no_mstandby	= NULL;
+	p->release_no_mstandby	= NULL;
 
 	p->errata = configure_dma_errata();
 
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 86c8d20..b50ecee 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -1156,7 +1156,6 @@ int omap_stop_dma_chain_transfers(int chain_id)
 {
 	int *channels;
 	u32 l, i;
-	u32 sys_cf = 0;
 
 	/* Check for input params */
 	if (unlikely((chain_id < 0 || chain_id >= dma_chan_count))) {
@@ -1171,13 +1170,9 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	}
 	channels = dma_linked_lch[chain_id].linked_dmach_q;
 
-	if (IS_DMA_ERRATA(DMA_ERRATA_i88)) {
-		sys_cf = dma_read(OCP_SYSCONFIG, 0);
-		l = sys_cf;
-		/* Middle mode reg set no Standby */
-		l &= ~((1 << 12)|(1 << 13));
-		dma_write(l, OCP_SYSCONFIG, 0);
-	}
+	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
+		omap_device_require_no_mstandby(pd);
+
 	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
 
 		/* Stop the Channel transmission */
@@ -1196,7 +1191,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	OMAP_DMA_CHAIN_QINIT(chain_id);
 
 	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
-		dma_write(sys_cf, OCP_SYSCONFIG, 0);
+		omap_device_release_no_mstandby(pd);
 
 	return 0;
 }
@@ -1540,6 +1535,8 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	p->dma_write		= dma_write;
 	p->dma_read		= dma_read;
 	p->clear_sglist_mode	= omap2_clear_dma_sglist_mode;
+	p->require_no_mstandby	= omap_device_require_no_mstandby;
+	p->release_no_mstandby	= omap_device_release_no_mstandby;
 
 	p->clear_lch_regs	= NULL;
 	p->get_gdma_dev		= NULL;
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 8563370..a859c70 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -39,6 +39,7 @@
 static struct omap_system_dma_plat_info *p;
 static struct omap_dma_dev_attr *d;
 static struct omap_dma_lch		*dma_chan;
+static struct platform_device		*pd;
 
 static int enable_1510_mode;
 static int dma_lch_count;
@@ -523,14 +524,8 @@ void omap_stop_dma(int lch)
 	if (IS_DMA_ERRATA(DMA_ERRATA_i541) &&
 			(l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
 		int i = 0;
-		u32 sys_cf;
 
-		/* Configure No-Standby */
-		l = p->dma_read(OCP_SYSCONFIG, lch);
-		sys_cf = l;
-		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
-		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
-		p->dma_write(l , OCP_SYSCONFIG, 0);
+		p->require_no_mstandby(pd);
 
 		l = p->dma_read(CCR, lch);
 		l &= ~OMAP_DMA_CCR_EN;
@@ -547,8 +542,7 @@ void omap_stop_dma(int lch)
 		if (i >= 100)
 			printk(KERN_ERR "DMA drain did not complete on "
 					"lch %d\n", lch);
-		/* Restore OCP_SYSCONFIG */
-		p->dma_write(sys_cf, OCP_SYSCONFIG, lch);
+		p->release_no_mstandby(pd);
 	} else {
 		l &= ~OMAP_DMA_CCR_EN;
 		p->dma_write(l, CCR, lch);
@@ -727,6 +721,7 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	pd			= pdev;
 	d			= p->dma_attr;
 	errata			= p->errata;
 
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index e18603d..9cb9fbd 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -253,21 +253,6 @@
 #define DMA_THREAD_FIFO_25		(0x02 << 14)
 #define DMA_THREAD_FIFO_50		(0x03 << 14)
 
-/* DMA4_OCP_SYSCONFIG bits */
-#define DMA_SYSCONFIG_MIDLEMODE_MASK		(3 << 12)
-#define DMA_SYSCONFIG_CLOCKACTIVITY_MASK	(3 << 8)
-#define DMA_SYSCONFIG_EMUFREE			(1 << 5)
-#define DMA_SYSCONFIG_SIDLEMODE_MASK		(3 << 3)
-#define DMA_SYSCONFIG_SOFTRESET			(1 << 2)
-#define DMA_SYSCONFIG_AUTOIDLE			(1 << 0)
-
-#define DMA_SYSCONFIG_MIDLEMODE(n)		((n) << 12)
-#define DMA_SYSCONFIG_SIDLEMODE(n)		((n) << 3)
-
-#define DMA_IDLEMODE_SMARTIDLE			0x2
-#define DMA_IDLEMODE_NO_IDLE			0x1
-#define DMA_IDLEMODE_FORCE_IDLE			0x0
-
 #define DMA_CH_PRIO_HIGH		0x1
 #define DMA_CH_PRIO_LOW			0x0 /* Def */
 
@@ -567,6 +552,8 @@ struct omap_system_dma_plat_info {
 	void (*dma_write)(u32 val, int reg, int lch);
 	u32 (*dma_read)(int reg, int lch);
 	void (*clear_sglist_mode)(int lch);
+	int (*require_no_mstandby)(struct platform_device *pdev);
+	int (*release_no_mstandby)(struct platform_device *pdev);
 };
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
-- 
1.7.1

