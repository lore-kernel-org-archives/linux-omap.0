From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v4 2/4] OMAP: DMA: Introduce errata handling variable, and macro
Date: Mon,  4 Oct 2010 11:18:12 +0300
Message-ID: <1286180294-32618-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:58231 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab0JDISX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 04:18:23 -0400
In-Reply-To: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>, linux-arm-kernel@lists.infradead.org

Use flags for errata handling.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/plat-omap/dma.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 6914ccf..ae0ff64 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -146,6 +146,10 @@ static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
 	INT_1610_DMA_CH14, INT_1610_DMA_CH15, INT_DMA_LCD
 };
 
+/* Errata handling */
+static u16 dma_errata;
+#define IS_DMA_ERRATA(id)	(dma_errata & (id))
+
 static inline void disable_lnk(int lch);
 static void omap_disable_channel_irq(int lch);
 static inline void omap_enable_channel_irq(int lch);
@@ -2042,6 +2046,10 @@ void omap_dma_global_context_restore(void)
 
 /*----------------------------------------------------------------------------*/
 
+static void dma_errata_configure(void)
+{
+}
+
 static int __init omap_init_dma(void)
 {
 	unsigned long base;
@@ -2064,6 +2072,8 @@ static int __init omap_init_dma(void)
 		return -ENODEV;
 	}
 
+	dma_errata_configure();
+
 	omap_dma_base = ioremap(base, SZ_4K);
 	BUG_ON(!omap_dma_base);
 
-- 
1.7.3

