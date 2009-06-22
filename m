From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/12] OMAP3: DMA: Enable idlemodes for DMA OCP
Date: Mon, 22 Jun 2009 14:47:41 +0300
Message-ID: <20090622114741.28477.50965.stgit@localhost>
References: <20090622113422.28477.27052.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53091 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbZFVLrr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:47:47 -0400
In-Reply-To: <20090622113422.28477.27052.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.deeprootsystems.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

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

