From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] omap2: McBSP: Remove mux code for OMAP2420 McBSP2 and do cleanups
Date: Fri,  6 Aug 2010 15:39:02 +0300
Message-ID: <1281098342-5161-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46416 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934066Ab0HFMh6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 08:37:58 -0400
Received: by ewy23 with SMTP id 23so2746944ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Aug 2010 05:37:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>

This 'legacy' OMAP2420 McBSP2 muxing code is currently broken after recent
conversion to new mux code. The omap_mcbsp_request calling this code is
usually called after booting whereas the omap_mux_init_signal is __init
marked so null pointer dereference would occur.

Fix this by removing the muxing code and let the bootloader or board file to
do it if necessary. Remove also omap2_mcbsp_ops as there is no use for it.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/mcbsp.c |   39 ---------------------------------------
 1 files changed, 0 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 87aa4c9..fa8da0a 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -23,29 +23,6 @@
 #include <plat/cpu.h>
 #include <plat/mcbsp.h>
 
-#include "mux.h"
-
-static void omap2_mcbsp2_mux_setup(void)
-{
-	omap_mux_init_signal("eac_ac_sclk.mcbsp2_clkx", OMAP_PULL_ENA);
-	omap_mux_init_signal("eac_ac_fs.mcbsp2_fsx", OMAP_PULL_ENA);
-	omap_mux_init_signal("eac_ac_din.mcbsp2_dr", OMAP_PULL_ENA);
-	omap_mux_init_signal("eac_ac_dout.mcbsp2_dx", OMAP_PULL_ENA);
-	omap_mux_init_gpio(117, OMAP_PULL_ENA);
-	/*
-	 * TODO: Need to add MUX settings for OMAP 2430 SDP
-	 */
-}
-
-static void omap2_mcbsp_request(unsigned int id)
-{
-	if (cpu_is_omap2420() && (id == OMAP_MCBSP2))
-		omap2_mcbsp2_mux_setup();
-}
-
-static struct omap_mcbsp_ops omap2_mcbsp_ops = {
-	.request	= omap2_mcbsp_request,
-};
 
 #ifdef CONFIG_ARCH_OMAP2420
 static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
@@ -55,7 +32,6 @@ static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 	},
 	{
 		.phys_base	= OMAP24XX_MCBSP2_BASE,
@@ -63,7 +39,6 @@ static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 	},
 };
 #define OMAP2420_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2420_mcbsp_pdata)
@@ -82,7 +57,6 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 	},
 	{
 		.phys_base	= OMAP24XX_MCBSP2_BASE,
@@ -90,7 +64,6 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP3_BASE,
@@ -98,7 +71,6 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP4_BASE,
@@ -106,7 +78,6 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP5_BASE,
@@ -114,7 +85,6 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 	},
 };
 #define OMAP2430_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2430_mcbsp_pdata)
@@ -133,7 +103,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 		.buffer_size	= 0x6F,
 	},
 	{
@@ -143,7 +112,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 		.buffer_size	= 0x3FF,
 	},
 	{
@@ -153,7 +121,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 		.buffer_size	= 0x6F,
 	},
 	{
@@ -162,7 +129,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 		.buffer_size	= 0x6F,
 	},
 	{
@@ -171,7 +137,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 		.buffer_size	= 0x6F,
 	},
 };
@@ -189,28 +154,24 @@ static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] = {
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP1_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP1_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP1,
-		.ops            = &omap2_mcbsp_ops,
 	},
 	{
 		.phys_base      = OMAP44XX_MCBSP2_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP2_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP2_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP2,
-		.ops            = &omap2_mcbsp_ops,
 	},
 	{
 		.phys_base      = OMAP44XX_MCBSP3_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP3_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP3_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP3,
-		.ops            = &omap2_mcbsp_ops,
 	},
 	{
 		.phys_base      = OMAP44XX_MCBSP4_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP4_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP4_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP4,
-		.ops            = &omap2_mcbsp_ops,
 	},
 };
 #define OMAP44XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap44xx_mcbsp_pdata)
-- 
1.7.1

