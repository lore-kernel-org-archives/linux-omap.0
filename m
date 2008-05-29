From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] MACH-OMAP2: MCBSP: Add support for mcbsp on
	mach-omap2
Date: Thu, 29 May 2008 11:01:20 -0700
Message-ID: <20080529180120.GC8013@atomide.com>
References: <1212075098-29819-1-git-send-email-edubezval@gmail.com> <1212075098-29819-2-git-send-email-edubezval@gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB0228BF15B5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:59969 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbYE2SBY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2008 14:01:24 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0228BF15B5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@indt.org.br>

* Gadiyar, Anand <gadiyar@ti.com> [080529 09:18]:
> > +
> > +static struct omap_mcbsp_platform_data omap2_mcbsp_pdata[] = {
> > +#ifdef CONFIG_ARCH_OMAP24XX
> > +       {
> > +               .virt_base      = IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
> > +               .dma_rx_sync    = OMAP24XX_DMA_MCBSP1_RX,
> > +               .dma_tx_sync    = OMAP24XX_DMA_MCBSP1_TX,
> > +               .rx_irq         = INT_24XX_MCBSP1_IRQ_RX,
> > +               .tx_irq         = INT_24XX_MCBSP1_IRQ_TX,
> > +               .ops            = &omap2_mcbsp_ops,
> > +               .clk_name       = "mcbsp_clk",
> > +       },
> > +       {
> > +               .virt_base      = IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
> > +               .dma_rx_sync    = OMAP24XX_DMA_MCBSP2_RX,
> > +               .dma_tx_sync    = OMAP24XX_DMA_MCBSP2_TX,
> > +               .rx_irq         = INT_24XX_MCBSP2_IRQ_RX,
> > +               .tx_irq         = INT_24XX_MCBSP2_IRQ_TX,
> > +               .ops            = &omap2_mcbsp_ops,
> > +               .clk_name       = "mcbsp_clk",
> > +       },
> > +#endif
> > +#ifdef CONFIG_ARCH_OMAP34XX
> > +       {
> > +               .virt_base      = IO_ADDRESS(OMAP34XX_MCBSP1_BASE),
> > +               .dma_rx_sync    = OMAP24XX_DMA_MCBSP1_RX,
> > +               .dma_tx_sync    = OMAP24XX_DMA_MCBSP1_TX,
> > +               .rx_irq         = INT_24XX_MCBSP1_IRQ_RX,
> > +               .tx_irq         = INT_24XX_MCBSP1_IRQ_TX,
> > +               .ops            = &omap2_mcbsp_ops,
> > +               .clk_name       = "mcbsp_clk",
> > +       },
> > +       {
> > +               .virt_base      = IO_ADDRESS(OMAP34XX_MCBSP2_BASE),
> > +               .dma_rx_sync    = OMAP24XX_DMA_MCBSP2_RX,
> > +               .dma_tx_sync    = OMAP24XX_DMA_MCBSP2_TX,
> > +               .rx_irq         = INT_24XX_MCBSP2_IRQ_RX,
> > +               .tx_irq         = INT_24XX_MCBSP2_IRQ_TX,
> > +               .ops            = &omap2_mcbsp_ops,
> > +               .clk_name       = "mcbsp_clk",
> > +       },
> > +#endif
> > +};
> 
> I guess Tony won't like this as it will break support for multi-omap.

Well looks like they both can be compiled in, so it should be fine :)
That is assuming 242x and 243x have same OMAP2XX_MCBSP[12]_BASE.

And IO_ADDRESS will eventually be OMAP2_IO_ADDRESS, which is same
for 24xx and 34xx.

Regards,

Tony
