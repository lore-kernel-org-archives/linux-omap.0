From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 1/1] OMAP3: DMA: Enable idlemodes for DMA OCP
Date: Mon,  1 Dec 2008 10:55:25 +0200
Message-ID: <1228121725-14062-2-git-send-email-ext-kalle.jokiniemi@nokia.com>
References: <>
 <1228121725-14062-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28075 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbYLAIwp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 03:52:45 -0500
In-Reply-To: <1228121725-14062-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

This patch enables MStandby smart-idle mode, autoidle smartidle mode,
and the autoidle bit for DMA4_OCP_SYSCONFIG.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/plat-omap/dma.c              |   13 +++++++++++++
 arch/arm/plat-omap/include/mach/dma.h |   15 +++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c4e5ba3..9d8d28c 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2420,6 +2420,19 @@ static int __init omap_init_dma(void)
 	if (cpu_class_is_omap2())
 		setup_irq(INT_24XX_SDMA_IRQ0, &omap24xx_dma_irq);
 
+	/* Enable smartidle idlemodes and autoidle */
+	if (cpu_is_omap34xx()) {
+		u32 v = dma_read(OCP_SYSCONFIG);
+		v &= ~(DMA_SYSCONFIG_MIDLEMODE_MASK |
+				DMA_SYSCONFIG_SIDLEMODE_MASK |
+				DMA_SYSCONFIG_AUTOIDLE);
+		v |= (DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
+			DMA_SYSCONFIG_SIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
+			DMA_SYSCONFIG_AUTOIDLE);
+		dma_write(v , OCP_SYSCONFIG);
+	}
+
+
 	/* FIXME: Update LCD DMA to work on 24xx */
 	if (cpu_class_is_omap1()) {
 		r = request_irq(INT_DMA_LCD, lcd_dma_irq_handler, 0,
diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-omap/include/mach/dma.h
index 54fe966..224b077 100644
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -387,6 +387,21 @@
 #define DMA_THREAD_FIFO_25		(0x02 << 14)
 #define DMA_THREAD_FIFO_50		(0x03 << 14)
 
+/* DMA4_OCP_SYSCONFIG bits */
+#define DMA_SYSCONFIG_MIDLEMODE_MASK		(3 << 12)
+#define DMA_SYSCONFIG_CLOCKACTIVITY_MASK	(3 << 8)
+#define DMA_SYSCONFIG_EMUFREE			(1 << 5)
+#define DMA_SYSCONFIG_SIDLEMODE_MASK		(3 << 3)
+#define DMA_SYSCONFIG_SOFTRESET			(1 << 2)
+#define DMA_SYSCONFIG_AUTOIDLE			(1 << 0)
+
+#define DMA_SYSCONFIG_MIDLEMODE(n)		((n) << 12)
+#define DMA_SYSCONFIG_SIDLEMODE(n)		((n) << 3)
+
+#define DMA_IDLEMODE_SMARTIDLE			0x2
+#define DMA_IDLEMODE_NO_IDLE			0x1
+#define DMA_IDLEMODE_FORCE_IDLE			0x0
+
 /* Chaining modes*/
 #ifndef CONFIG_ARCH_OMAP1
 #define OMAP_DMA_STATIC_CHAIN		0x1
-- 
1.5.4.3

