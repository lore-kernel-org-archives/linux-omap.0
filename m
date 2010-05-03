From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH] OMAP2/3/4: DMA: reset controller during init
Date: Mon,  3 May 2010 15:55:57 +0300
Message-ID: <1272891357-27400-1-git-send-email-ext-mika.1.westerberg@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:16693 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758771Ab0ECM5K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 08:57:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, "\\\"Mika Westerberg\\\"" <ext-mika.1.westerberg@nokia.com>

If we are softbooting another kernel using kexec, DMA controller state is not
known when we are performing omap_init_dma(). It is possible that some DMA
channels are already active. For example after kexec we get:

<4>IRQ 0020 for non-allocated DMAchannel 5
<4>IRQ 0020 for non-allocated DMAchannel 5
<4>IRQ 0020 for non-allocated DMAchannel 5
<4>IRQ 0020 for non-allocated DMAchannel 5
<4>IRQ 0020 for non-allocated DMAchannel 5

To prevent any weird things happening, we perform soft reset for the controller
and disable all per channel interrupts.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/plat-omap/dma.c              |   32 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/dma.h |    4 ++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 1d95996..24cbb97 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2024,6 +2024,31 @@ void omap_dma_global_context_restore(void)
 
 /*----------------------------------------------------------------------------*/
 
+/**
+ * omap_dma_reset() - perform software reset for the DMA controller
+ */
+static void omap_dma_reset(void)
+{
+	u32 v;
+
+	if (cpu_class_is_omap1())
+		return;
+
+	v = dma_read(OCP_SYSCONFIG);
+	v |= 0x2; /* software reset */
+	dma_write(v, OCP_SYSCONFIG);
+
+	/* wait until reset is complete */
+	while ((dma_read(SYSSTATUS) & 0x1) == 0)
+		cpu_relax();
+
+	/* disable per channel interrupts */
+	dma_write(0, IRQENABLE_L0);
+	dma_write(0, IRQENABLE_L1);
+	dma_write(0, IRQENABLE_L2);
+	dma_write(0, IRQENABLE_L3);
+}
+
 static int __init omap_init_dma(void)
 {
 	unsigned long base;
@@ -2069,6 +2094,13 @@ static int __init omap_init_dma(void)
 		}
 	}
 
+	/*
+	 * Make sure that DMA is in reset state before doing anything else. If
+	 * we are coming from softboot (e.g kexec) DMA is probably configured so
+	 * we explicitly reset it here to get into known state.
+	 */
+	omap_dma_reset();
+
 	if (cpu_is_omap15xx()) {
 		printk(KERN_INFO "DMA support for OMAP15xx initialized\n");
 		dma_chan_count = 9;
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 02232ca..9a55504 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -134,6 +134,10 @@
 #define OMAP1_DMA_REVISION		0
 #define OMAP1_DMA_IRQSTATUS_L0		0
 #define OMAP1_DMA_IRQENABLE_L0		0
+#define OMAP1_DMA_IRQENABLE_L1		0
+#define OMAP1_DMA_IRQENABLE_L2		0
+#define OMAP1_DMA_IRQENABLE_L3		0
+#define OMAP1_DMA_SYSSTATUS		0
 #define OMAP1_DMA_OCP_SYSCONFIG		0
 #define OMAP_DMA4_HW_ID			0
 #define OMAP_DMA4_CAPS_0_L		0
-- 
1.5.6.5

