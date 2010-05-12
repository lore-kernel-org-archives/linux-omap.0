From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH v3 1/2] ARM: McBSP: Fix request for irq in OMAP4
Date: Wed, 12 May 2010 12:18:39 -0500
Message-ID: <1273684720-16619-2-git-send-email-jorge.candelaria@ti.com>
References: <1273684720-16619-1-git-send-email-jorge.candelaria@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44862 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756775Ab0ELRa0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 13:30:26 -0400
In-Reply-To: <1273684720-16619-1-git-send-email-jorge.candelaria@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

In OMAP4, there is only one irq line for TX and RX paths. Use
the correct irq line to avoid errors at runtime.

Also, request irq line only once (instead of requesting for TX
and RX).

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/mcbsp.c |   12 ++++--------
 arch/arm/plat-omap/mcbsp.c  |   20 ++++++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 2f3cad6..c293370 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -187,32 +187,28 @@ static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] = {
 		.phys_base      = OMAP44XX_MCBSP1_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP1_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP1_TX,
-		.rx_irq         = INT_24XX_MCBSP1_IRQ_RX,
-		.tx_irq         = INT_24XX_MCBSP1_IRQ_TX,
+		.tx_irq         = OMAP44XX_IRQ_MCBSP1,
 		.ops            = &omap2_mcbsp_ops,
 	},
 	{
 		.phys_base      = OMAP44XX_MCBSP2_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP2_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP2_TX,
-		.rx_irq         = INT_24XX_MCBSP2_IRQ_RX,
-		.tx_irq         = INT_24XX_MCBSP2_IRQ_TX,
+		.tx_irq         = OMAP44XX_IRQ_MCBSP2,
 		.ops            = &omap2_mcbsp_ops,
 	},
 	{
 		.phys_base      = OMAP44XX_MCBSP3_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP3_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP3_TX,
-		.rx_irq         = INT_24XX_MCBSP3_IRQ_RX,
-		.tx_irq         = INT_24XX_MCBSP3_IRQ_TX,
+		.tx_irq         = OMAP44XX_IRQ_MCBSP3,
 		.ops            = &omap2_mcbsp_ops,
 	},
 	{
 		.phys_base      = OMAP44XX_MCBSP4_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP4_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP4_TX,
-		.rx_irq         = INT_24XX_MCBSP4_IRQ_RX,
-		.tx_irq         = INT_24XX_MCBSP4_IRQ_TX,
+		.tx_irq         = OMAP44XX_IRQ_MCBSP4,
 		.ops            = &omap2_mcbsp_ops,
 	},
 };
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e1d0440..6696eb6 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -724,14 +724,17 @@ int omap_mcbsp_request(unsigned int id)
 			goto err_clk_disable;
 		}
 
-		init_completion(&mcbsp->rx_irq_completion);
-		err = request_irq(mcbsp->rx_irq, omap_mcbsp_rx_irq_handler,
+		if (mcbsp->rx_irq) {
+			init_completion(&mcbsp->rx_irq_completion);
+			err = request_irq(mcbsp->rx_irq,
+					omap_mcbsp_rx_irq_handler,
 					0, "McBSP", (void *)mcbsp);
-		if (err != 0) {
-			dev_err(mcbsp->dev, "Unable to request RX IRQ %d "
-					"for McBSP%d\n", mcbsp->rx_irq,
-					mcbsp->id);
-			goto err_free_irq;
+			if (err != 0) {
+				dev_err(mcbsp->dev, "Unable to request RX IRQ %d "
+						"for McBSP%d\n", mcbsp->rx_irq,
+						mcbsp->id);
+				goto err_free_irq;
+			}
 		}
 	}
 
@@ -781,7 +784,8 @@ void omap_mcbsp_free(unsigned int id)
 
 	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
 		/* Free IRQs */
-		free_irq(mcbsp->rx_irq, (void *)mcbsp);
+		if (mcbsp->rx_irq)
+			free_irq(mcbsp->rx_irq, (void *)mcbsp);
 		free_irq(mcbsp->tx_irq, (void *)mcbsp);
 	}
 
-- 
1.6.3.3

