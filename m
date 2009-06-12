From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP3: DMA: Enable idlemodes for DMA OCP
Date: Fri, 12 Jun 2009 15:11:33 -0700
Message-ID: <1244844693-24126-3-git-send-email-khilman@ti.deeprootsystems.com>
References: <1244844693-24126-1-git-send-email-khilman@ti.deeprootsystems.com>
 <1244844693-24126-2-git-send-email-khilman@ti.deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:4647 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934454AbZFLWLi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 18:11:38 -0400
Received: by wf-out-1314.google.com with SMTP id 26so943798wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 15:11:40 -0700 (PDT)
In-Reply-To: <1244844693-24126-2-git-send-email-khilman@ti.deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.deeprootsystems.com>

From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

This patch enables MStandby smart-idle mode, autoidle smartidle mode,
and the autoidle bit for DMA4_OCP_SYSCONFIG.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.deeprootsystems.com>
---
 arch/arm/plat-omap/dma.c              |   13 +++++++++++++
 arch/arm/plat-omap/include/mach/dma.h |   15 +++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index def14ec..7677a4a 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2457,6 +2457,19 @@ static int __init omap_init_dma(void)
 		setup_irq(irq, &omap24xx_dma_irq);
 	}
 
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
index 8c1eae8..7b939cc 100644
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -389,6 +389,21 @@
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
1.6.2.2

