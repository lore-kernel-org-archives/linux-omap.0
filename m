From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] omap patches for review for v2.6.37 merge window
Date: Fri, 24 Sep 2010 11:12:09 -0700
Message-ID: <20100924181209.GF4211@atomide.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
 <20100924085337.69c99bd8.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54047 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757250Ab0IXSMK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 14:12:10 -0400
Content-Disposition: inline
In-Reply-To: <20100924085337.69c99bd8.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Jarkko Nikula <jhnikula@gmail.com> [100923 22:45]:
> On Thu, 23 Sep 2010 18:50:38 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > Hi all,
> > 
> > Here are some omap patches that have not yet been posted to
> > linux-arm-kernel for review.
> > 
> > Jarkko Nikula (4):
> >       omap: n8x0: Cleanup i2c1 and menelaus registration
> >       omap: n8x0: Register i2c2 and add board info with tlv320aic3xfor N810
> >       omap: n8x0: Mux i2s codec port pins for McBSP block
> >       omap2: McBSP: Remove mux code for OMAP2420 McBSP2 and docleanups
> > 
> ...
> > Subramaniam C.A (1):
> >       omap: i2c: Avoid compilation error in case the header is included multiple times
> > 
> Hmm... I wonder do I have something wrong or in patchwork but it looks
> like somehow a line feed gets introduced to subject line of some of
> my patches. And it seems to do with my patches only.
> 
> Original patch in my mailbox or archive doesn't show it but it is in
> patchwork.
> 
> http://marc.info/?l=linux-omap&m=128324955316265&w=2
> https://patchwork.kernel.org/patch/144841/mbox

Hmm yeah looks like patchwork wraps the subject line.. Need to look
to see where the bug is later on.

Here's the patch with fixed subject.

Tony


From: Jarkko Nikula <jhnikula@gmail.com>
Date: Tue, 31 Aug 2010 10:12:56 +0000
Subject: [PATCH] omap2: McBSP: Remove mux code for OMAP2420 McBSP2 and do cleanups

This 'legacy' OMAP2420 McBSP2 muxing code is currently broken after recent
conversion to new mux code. The omap_mcbsp_request calling this code is
usually called after booting whereas the omap_mux_init_signal is __init
marked so null pointer dereference would occur.

Fix this by removing the muxing code and let the bootloader or board file to
do it if necessary. Remove also omap2_mcbsp_ops as there is no use for it.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 467aae2..88b8790 100644
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
 		.buffer_size	= 0x80, /* The FIFO has 128 locations */
 	},
 	{
@@ -143,7 +112,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 		.buffer_size	= 0x500, /* The FIFO has 1024 + 256 locations */
 	},
 	{
@@ -153,7 +121,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 		.buffer_size	= 0x80, /* The FIFO has 128 locations */
 	},
 	{
@@ -162,7 +129,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 		.buffer_size	= 0x80, /* The FIFO has 128 locations */
 	},
 	{
@@ -171,7 +137,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
-		.ops		= &omap2_mcbsp_ops,
 		.buffer_size	= 0x80, /* The FIFO has 128 locations */
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
