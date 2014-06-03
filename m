From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: DMA: remove requirement of irq for platform-dma driver
Date: Tue, 3 Jun 2014 14:35:00 +0530
Message-ID: <1401786301-5638-2-git-send-email-r.sricharan@ti.com>
References: <1401786301-5638-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40625 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbaFCJHL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jun 2014 05:07:11 -0400
In-Reply-To: <1401786301-5638-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, r.sricharan@ti.com

From: Nishanth Menon <nm@ti.com>

we have currently 2 DMA drivers that try to co-exist.
drivers/dma/omap-dma.c which registers it's own IRQ and is device tree
aware and uses arch/arm/plat-omap/dma.c instance created by
arch/arm/mach-omap2/dma.c to maintain channel usage (omap_request_dma).

Currently both try to register interrupts and mach-omap2/plat-omap dma.c
attempts to use the IRQ number registered by hwmod to register it's own
interrupt handler.

Now, there is no reasonable way of static allocating DMA irq in GIC
SPI when we use crossbar. However, since the dma_chan structure is
freed as a result of IRQ not being present due to devm allocation,
maintaining information of channel by platform code fails at a later
point in time when that region of memory is reused.

So, if hwmod does not indicate an IRQ number, then, assume that
dma-engine will take care of the interrupt handling.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/dma.c |    3 +++
 arch/arm/plat-omap/dma.c  |    5 +++--
 include/linux/omap-dma.h  |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index a6d2cf1..e1a56d8 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -259,6 +259,9 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
 		d->dev_caps |= HS_CHANNELS_RESERVED;
 
+	if (platform_get_irq_byname(pdev, "0") < 0)
+		d->dev_caps |= DMA_ENGINE_HANDLE_IRQ;
+
 	/* Check the capabilities register for descriptor loading feature */
 	if (dma_read(CAPS_0, 0) & DMA_HAS_DESCRIPTOR_CAPS)
 		dma_common_ch_end = CCDN;
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index b5608b1..7aae0e5 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2100,7 +2100,7 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
 				DMA_DEFAULT_FIFO_DEPTH, 0);
 
-	if (dma_omap2plus()) {
+	if (dma_omap2plus() && !(d->dev_caps & DMA_ENGINE_HANDLE_IRQ)) {
 		strcpy(irq_name, "0");
 		dma_irq = platform_get_irq_byname(pdev, irq_name);
 		if (dma_irq < 0) {
@@ -2145,7 +2145,8 @@ static int omap_system_dma_remove(struct platform_device *pdev)
 		char irq_name[4];
 		strcpy(irq_name, "0");
 		dma_irq = platform_get_irq_byname(pdev, irq_name);
-		remove_irq(dma_irq, &omap24xx_dma_irq);
+		if (dma_irq >= 0)
+			remove_irq(dma_irq, &omap24xx_dma_irq);
 	} else {
 		int irq_rel = 0;
 		for ( ; irq_rel < dma_chan_count; irq_rel++) {
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index c29a6de..8b2b46d 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -147,6 +147,7 @@ static inline bool omap_dma_filter_fn(struct dma_chan *c, void *d)
 #define IS_WORD_16			BIT(0xd)
 #define ENABLE_16XX_MODE		BIT(0xe)
 #define HS_CHANNELS_RESERVED		BIT(0xf)
+#define DMA_ENGINE_HANDLE_IRQ		BIT(0x10)
 
 /* Defines for DMA Capabilities */
 #define DMA_HAS_TRANSPARENT_CAPS	(0x1 << 18)
-- 
1.7.9.5

