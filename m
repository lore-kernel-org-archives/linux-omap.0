From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 2/3] OMAP2+: DMA: prevent races while setting M idle mode to nostandby
Date: Thu, 24 Feb 2011 15:44:34 +0530
Message-ID: <1298542475-1460-3-git-send-email-manjugk@ti.com>
References: <1298542475-1460-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37779 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab1BXKRQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 05:17:16 -0500
In-Reply-To: <1298542475-1460-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com

If two DMA users tries to set no mstandby mode at the same time, a race
condition would arise. Prevent that by using a spin lock and counting
up/down the number of times nostandby is set/reset.

Initial patch is created by Adrian Hunter <adrian.hunter@nokia.com>
https://patchwork.kernel.org/patch/366831/

Patch reworked to use API implemented at hwmod layer.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap1/dma.c             |    1 +
 arch/arm/mach-omap2/dma.c             |   16 +++++++++++++
 arch/arm/plat-omap/dma.c              |   40 +++++++++++++++++++--------------
 arch/arm/plat-omap/include/plat/dma.h |    1 +
 4 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index d855934..fa2d1b0 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -351,6 +351,7 @@ static int __init omap1_system_dma_init(void)
 	p->dma_write		= dma_write;
 	p->dma_read		= dma_read;
 	p->disable_irq_lch	= NULL;
+	p->midlemode		= NULL;
 
 	p->errata = configure_dma_errata();
 
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 34922b2..6e12e71 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -36,7 +36,9 @@
 
 static u32 errata;
 static u8 dma_stride;
+static u32 midlemode_save_cnt;
 
+static struct platform_device *pdev;
 static struct omap_dma_dev_attr *d;
 
 static enum omap_reg_offsets dma_common_ch_start, dma_common_ch_end;
@@ -117,6 +119,18 @@ static inline u32 dma_read(int reg, int lch)
 	return val;
 }
 
+static void midlemode_nostandby(bool nostandby)
+{
+	/* TODO: midlemode_save_cnt can be moved to hwmod layer? */
+	if (nostandby) {
+		omap_device_require_no_mstandby(pdev);
+		midlemode_save_cnt += 1;
+	} else {
+		omap_device_release_no_mstandby(pdev);
+		midlemode_save_cnt -= 1;
+	}
+}
+
 static inline void omap2_disable_irq_lch(int lch)
 {
 	u32 val;
@@ -253,6 +267,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	p->clear_dma		= omap2_clear_dma;
 	p->dma_write		= dma_write;
 	p->dma_read		= dma_read;
+	p->midlemode		= midlemode_nostandby;
 
 	p->clear_lch_regs	= NULL;
 
@@ -286,6 +301,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 		dev_err(&od->pdev.dev, "%s: kzalloc fail\n", __func__);
 		return -ENOMEM;
 	}
+	pdev = &od->pdev;
 	return 0;
 }
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 8536308..84879eb 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -38,8 +38,9 @@
 
 #include <asm/system.h>
 #include <mach/hardware.h>
-#include <plat/dma.h>
 
+#include <plat/dma.h>
+#include <plat/omap_device.h>
 #include <plat/tc.h>
 
 #undef DEBUG
@@ -924,6 +925,7 @@ EXPORT_SYMBOL(omap_start_dma);
 void omap_stop_dma(int lch)
 {
 	u32 l;
+	unsigned long flags;
 
 	/* Disable all interrupts on the channel */
 	if (cpu_class_is_omap1())
@@ -933,14 +935,13 @@ void omap_stop_dma(int lch)
 	if (IS_DMA_ERRATA(DMA_ERRATA_i541) &&
 			(l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
 		int i = 0;
-		u32 sys_cf;
 
 		/* Configure No-Standby */
-		l = p->dma_read(OCP_SYSCONFIG, lch);
-		sys_cf = l;
-		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
-		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
-		p->dma_write(l , OCP_SYSCONFIG, 0);
+		if (p->midlemode) {
+			spin_lock_irqsave(&dma_chan_lock, flags);
+			p->midlemode(true);
+			spin_unlock_irqrestore(&dma_chan_lock, flags);
+		}
 
 		l = p->dma_read(CCR, lch);
 		l &= ~OMAP_DMA_CCR_EN;
@@ -958,7 +959,11 @@ void omap_stop_dma(int lch)
 			printk(KERN_ERR "DMA drain did not complete on "
 					"lch %d\n", lch);
 		/* Restore OCP_SYSCONFIG */
-		p->dma_write(sys_cf, OCP_SYSCONFIG, lch);
+		if (p->midlemode) {
+			spin_lock_irqsave(&dma_chan_lock, flags);
+			p->midlemode(false);
+			spin_unlock_irqrestore(&dma_chan_lock, flags);
+		}
 	} else {
 		l &= ~OMAP_DMA_CCR_EN;
 		p->dma_write(l, CCR, lch);
@@ -1610,7 +1615,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 {
 	int *channels;
 	u32 l, i;
-	u32 sys_cf = 0;
+	unsigned long flags;
 
 	/* Check for input params */
 	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
@@ -1625,12 +1630,10 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	}
 	channels = dma_linked_lch[chain_id].linked_dmach_q;
 
-	if (IS_DMA_ERRATA(DMA_ERRATA_i88)) {
-		sys_cf = p->dma_read(OCP_SYSCONFIG, 0);
-		l = sys_cf;
-		/* Middle mode reg set no Standby */
-		l &= ~((1 << 12)|(1 << 13));
-		p->dma_write(l, OCP_SYSCONFIG, 0);
+	if (IS_DMA_ERRATA(DMA_ERRATA_i88) && p->midlemode) {
+		spin_lock_irqsave(&dma_chan_lock, flags);
+		p->midlemode(true);
+		spin_unlock_irqrestore(&dma_chan_lock, flags);
 	}
 
 	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
@@ -1650,8 +1653,11 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	/* Reset the Queue pointers */
 	OMAP_DMA_CHAIN_QINIT(chain_id);
 
-	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
-		p->dma_write(sys_cf, OCP_SYSCONFIG, 0);
+	if (IS_DMA_ERRATA(DMA_ERRATA_i88 && p->midlemode)) {
+		spin_lock_irqsave(&dma_chan_lock, flags);
+		p->midlemode(false);
+		spin_unlock_irqrestore(&dma_chan_lock, flags);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index d1c916f..b20dc5e 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -435,6 +435,7 @@ struct omap_system_dma_plat_info {
 	void (*clear_dma)(int lch);
 	void (*dma_write)(u32 val, int reg, int lch);
 	u32 (*dma_read)(int reg, int lch);
+	void (*midlemode)(bool nostandby);
 };
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
-- 
1.7.1

