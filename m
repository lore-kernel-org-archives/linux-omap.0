From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 5/5] MACH-OMAP2: MCBSP: Add support for mcbsp on
 mach-omap2
Date: Thu, 29 May 2008 21:38:25 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0228BF15B5@dbde02.ent.ti.com>
References: <1212075098-29819-1-git-send-email-edubezval@gmail.com>
 <1212075098-29819-2-git-send-email-edubezval@gmail.com>
 <1212075098-29819-3-git-send-email-edubezval@gmail.com>,<1212075098-29819-4-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:43191 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbYE2QRW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2008 12:17:22 -0400
In-Reply-To: <1212075098-29819-4-git-send-email-edubezval@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

> +
> +static struct omap_mcbsp_platform_data omap2_mcbsp_pdata[] = {
> +#ifdef CONFIG_ARCH_OMAP24XX
> +       {
> +               .virt_base      = IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
> +               .dma_rx_sync    = OMAP24XX_DMA_MCBSP1_RX,
> +               .dma_tx_sync    = OMAP24XX_DMA_MCBSP1_TX,
> +               .rx_irq         = INT_24XX_MCBSP1_IRQ_RX,
> +               .tx_irq         = INT_24XX_MCBSP1_IRQ_TX,
> +               .ops            = &omap2_mcbsp_ops,
> +               .clk_name       = "mcbsp_clk",
> +       },
> +       {
> +               .virt_base      = IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
> +               .dma_rx_sync    = OMAP24XX_DMA_MCBSP2_RX,
> +               .dma_tx_sync    = OMAP24XX_DMA_MCBSP2_TX,
> +               .rx_irq         = INT_24XX_MCBSP2_IRQ_RX,
> +               .tx_irq         = INT_24XX_MCBSP2_IRQ_TX,
> +               .ops            = &omap2_mcbsp_ops,
> +               .clk_name       = "mcbsp_clk",
> +       },
> +#endif
> +#ifdef CONFIG_ARCH_OMAP34XX
> +       {
> +               .virt_base      = IO_ADDRESS(OMAP34XX_MCBSP1_BASE),
> +               .dma_rx_sync    = OMAP24XX_DMA_MCBSP1_RX,
> +               .dma_tx_sync    = OMAP24XX_DMA_MCBSP1_TX,
> +               .rx_irq         = INT_24XX_MCBSP1_IRQ_RX,
> +               .tx_irq         = INT_24XX_MCBSP1_IRQ_TX,
> +               .ops            = &omap2_mcbsp_ops,
> +               .clk_name       = "mcbsp_clk",
> +       },
> +       {
> +               .virt_base      = IO_ADDRESS(OMAP34XX_MCBSP2_BASE),
> +               .dma_rx_sync    = OMAP24XX_DMA_MCBSP2_RX,
> +               .dma_tx_sync    = OMAP24XX_DMA_MCBSP2_TX,
> +               .rx_irq         = INT_24XX_MCBSP2_IRQ_RX,
> +               .tx_irq         = INT_24XX_MCBSP2_IRQ_TX,
> +               .ops            = &omap2_mcbsp_ops,
> +               .clk_name       = "mcbsp_clk",
> +       },
> +#endif
> +};

I guess Tony won't like this as it will break support for multi-omap.

Regards,
Anand
