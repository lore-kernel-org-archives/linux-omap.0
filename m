From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2 3/3] OMAP: McBSP: Remove null omap44xx ops comment
Date: Wed,  6 Oct 2010 08:50:42 +0300
Message-ID: <1286344242-430-4-git-send-email-jhnikula@gmail.com>
References: <1286344242-430-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43593 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756958Ab0JFFu1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 01:50:27 -0400
Received: by mail-ey0-f174.google.com with SMTP id 6so2726728eyb.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 22:50:26 -0700 (PDT)
In-Reply-To: <1286344242-430-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jhnikula@gmail.com>

It seems these comments where accidentally added so remove them.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
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

