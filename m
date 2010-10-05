From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/3] OMAP: McBSP: Remove null omap44xx ops comment
Date: Tue,  5 Oct 2010 15:29:35 +0300
Message-ID: <1286281775-27692-3-git-send-email-jhnikula@gmail.com>
References: <1286281775-27692-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46523 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165Ab0JEM3R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 08:29:17 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so2438284ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 05:29:17 -0700 (PDT)
In-Reply-To: <1286281775-27692-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Paul Walmsley <paul@pwsan.com>

It seems these comments where accidentally added so remove them.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/mcbsp.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index f6b772e..f9c9df5 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -240,21 +240,18 @@ static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] = {
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP2_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP2_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP2,
-		/* XXX .ops ? */
 	},
 	{
 		.phys_base      = OMAP44XX_MCBSP3_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP3_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP3_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP3,
-		/* XXX .ops ? */
 	},
 	{
 		.phys_base      = OMAP44XX_MCBSP4_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP4_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP4_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP4,
-		/* XXX .ops ? */
 	},
 };
 #define OMAP44XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap44xx_mcbsp_pdata)
-- 
1.7.1

