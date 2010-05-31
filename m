From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC PATCH 2/5] OMAP3: McBSP: Change the way how the FIFO is handled
Date: Mon, 31 May 2010 11:16:47 +0300
Message-ID: <1275293810-31984-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53163 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460Ab0EaIRb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 04:17:31 -0400
In-Reply-To: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, jhnikula@gmail.com, tony@atomide.com, ext-eero.nurkkala@nokia.com, eduardo.valentin@nokia.com

Use the actual FIFO size in words as buffer_size on OMAP2.
Change the threshold configuration to use 1 based numbering, when
specifying the allowed threshold maximum or the McBSP threshold value.
Set the default maximum threshold to (buffer_size - 0x10) intialy.
>From users of McBSP, now it is expected to use this method.
Asking for threshold 1 means that the value written to threshold registers
are going to be 0, which means 1 word threshold.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/mach-omap2/mcbsp.c |   10 +++++-----
 arch/arm/plat-omap/mcbsp.c  |   10 ++++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 016fe60..9139958 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -132,7 +132,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.buffer_size	= 0x6F,
+		.buffer_size	= 0x80,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP2_BASE,
@@ -142,7 +142,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.buffer_size	= 0x3FF,
+		.buffer_size	= 0x500,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP3_BASE,
@@ -152,7 +152,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.buffer_size	= 0x6F,
+		.buffer_size	= 0x80,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP4_BASE,
@@ -161,7 +161,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.buffer_size	= 0x6F,
+		.buffer_size	= 0x80,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP5_BASE,
@@ -170,7 +170,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.buffer_size	= 0x6F,
+		.buffer_size	= 0x80,
 	},
 };
 #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 51d8abf..6462968 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -497,7 +497,8 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	MCBSP_WRITE(mcbsp, THRSH2, threshold);
+	if (threshold && threshold <= mcbsp->max_tx_thres)
+		MCBSP_WRITE(mcbsp, THRSH2, threshold - 1);
 }
 EXPORT_SYMBOL(omap_mcbsp_set_tx_threshold);
 
@@ -519,7 +520,8 @@ void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	MCBSP_WRITE(mcbsp, THRSH1, threshold);
+	if (threshold && threshold <= mcbsp->max_rx_thres)
+		MCBSP_WRITE(mcbsp, THRSH1, threshold - 1);
 }
 EXPORT_SYMBOL(omap_mcbsp_set_rx_threshold);
 
@@ -1696,8 +1698,8 @@ static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 {
 	mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
 	if (cpu_is_omap34xx()) {
-		mcbsp->max_tx_thres = max_thres(mcbsp);
-		mcbsp->max_rx_thres = max_thres(mcbsp);
+		mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
+		mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
 		/*
 		 * REVISIT: Set dmap_op_mode to THRESHOLD as default
 		 * for mcbsp2 instances.
-- 
1.7.1

