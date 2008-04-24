From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4/5] OMAP3xx: Add DMA and IRQ definition for McBSP 1 and 2
Date: Thu, 24 Apr 2008 11:54:24 -0400
Message-ID: <1209052465-13210-5-git-send-email-edubezval@gmail.com>
References: <1209052465-13210-1-git-send-email-edubezval@gmail.com>
 <1209052465-13210-2-git-send-email-edubezval@gmail.com>
 <1209052465-13210-3-git-send-email-edubezval@gmail.com>
 <1209052465-13210-4-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40736 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759333AbYDXPyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 11:54:36 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3OFs5DO014311
	for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2008 18:54:33 +0300
In-Reply-To: <1209052465-13210-4-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

This patch adds DMA and IRQ definition for McBSP 1 and 2
devices for omap34xx based systems.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 include/asm-arm/arch-omap/dma.h  |    4 ++++
 include/asm-arm/arch-omap/irqs.h |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/asm-arm/arch-omap/dma.h b/include/asm-arm/arch-omap/dma.h
index be0431e..270e158 100644
--- a/include/asm-arm/arch-omap/dma.h
+++ b/include/asm-arm/arch-omap/dma.h
@@ -273,6 +273,10 @@
 #define OMAP24XX_DMA_MS			63	/* S_DMA_62 */
 #define OMAP242X_DMA_EXT_DMAREQ5	64	/* S_DMA_63 */
 #define OMAP243X_DMA_EXT_DMAREQ6	64	/* S_DMA_63 */
+#define OMAP34XX_DMA_MCBSP1_TX		31	/* S_DMA_30 */
+#define OMAP34XX_DMA_MCBSP1_RX		32	/* S_DMA_31 */
+#define OMAP34XX_DMA_MCBSP2_TX		33	/* S_DMA_32 */
+#define OMAP34XX_DMA_MCBSP2_RX		34	/* S_DMA_33 */
 #define OMAP34XX_DMA_EXT_DMAREQ3	64	/* S_DMA_63 */
 #define OMAP34XX_DMA_AES2_TX		65	/* S_DMA_64 */
 #define OMAP34XX_DMA_AES2_RX		66	/* S_DMA_65 */
diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-omap/irqs.h
index 15446fd..4e185a8 100644
--- a/include/asm-arm/arch-omap/irqs.h
+++ b/include/asm-arm/arch-omap/irqs.h
@@ -316,7 +316,11 @@
 #define INT_34XX_USIM_IRQ	35
 #define INT_34XX_WDT3_IRQ	36
 #define INT_34XX_SPI4_IRQ	48
+#define INT_34XX_MCBSP1_IRQ_TX	59
+#define INT_34XX_MCBSP1_IRQ_RX	60
 #define INT_34XX_I2C3_IRQ	61
+#define INT_34XX_MCBSP2_IRQ_TX	62
+#define INT_34XX_MCBSP2_IRQ_RX	63
 #define INT_34XX_PBIAS_IRQ	75
 #define INT_34XX_OHCI_IRQ	76
 #define INT_34XX_EHCI_IRQ	77
-- 
1.5.5.1.67.gbdb8.dirty

