From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH 2/5] MACH-OMAP1: MCBSP: Add support for mcbsp on mach-omap1
Date: Thu, 29 May 2008 17:55:17 +0200
Message-ID: <fb249edb0805290855s120d52ecrcdd3cf731cc42a97@mail.gmail.com>
References: <1212075098-29819-1-git-send-email-edubezval@gmail.com>
	 <1212075098-29819-2-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:11498 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbYE2PzV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2008 11:55:21 -0400
Received: by ug-out-1314.google.com with SMTP id h2so124872ugf.16
        for <linux-omap@vger.kernel.org>; Thu, 29 May 2008 08:55:17 -0700 (PDT)
In-Reply-To: <1212075098-29819-2-git-send-email-edubezval@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hiya,

On 29/05/2008, Eduardo Valentin <edubezval@gmail.com> wrote:
>  +static struct omap_mcbsp_platform_data omap1_mcbsp_pdata[] = {
>  +#ifdef CONFIG_ARCH_OMAP730
>  +       {
>  +               .virt_base      = io_p2v(OMAP730_MCBSP1_BASE),
>  +               .dma_rx_sync    = OMAP_DMA_MCBSP1_RX,
>  +               .dma_tx_sync    = OMAP_DMA_MCBSP1_TX,
>  +               .rx_irq         = INT_730_McBSP1RX,
>  +               .tx_irq         = INT_730_McBSP1TX,
>  +               .ops            = &omap1_mcbsp_ops,
>  +       },
>  +       {
>  +               .virt_base      = io_p2v(OMAP730_MCBSP2_BASE),
>  +               .dma_rx_sync    = OMAP_DMA_MCBSP3_RX,
>  +               .dma_tx_sync    = OMAP_DMA_MCBSP3_TX,
>  +               .rx_irq         = INT_730_McBSP2RX,
>  +               .tx_irq         = INT_730_McBSP2TX
>  +               .ops            = &omap1_mcbsp_ops,
>  +       },
>  +#endif
>  +#ifdef CONFIG_ARCH_OMAP15XX
>  +       {
>  +               .virt_base      = OMAP1510_MCBSP1_BASE,
>  +               .dma_rx_sync    = OMAP_DMA_MCBSP1_RX,
>  +               .dma_tx_sync    = OMAP_DMA_MCBSP1_TX,
>  +               .rx_irq         = INT_McBSP1RX,
>  +               .tx_irq         = INT_McBSP1TX,
>  +               .ops            = &omap1_mcbsp_ops,
>  +               .clk_name       = "mcbsp_clk",
>  +               },
>  +       {
>  +               .virt_base      = io_p2v(OMAP1510_MCBSP2_BASE),
>  +               .dma_rx_sync    = OMAP_DMA_MCBSP2_RX,
>  +               .dma_tx_sync    = OMAP_DMA_MCBSP2_TX,
>  +               .rx_irq         = INT_1510_SPI_RX,
>  +               .tx_irq         = INT_1510_SPI_TX,
>  +               .ops            = &omap1_mcbsp_ops,
>  +       },
>  +       {
>  +               .virt_base      = OMAP1510_MCBSP3_BASE,
>  +               .dma_rx_sync    = OMAP_DMA_MCBSP3_RX,
>  +               .dma_tx_sync    = OMAP_DMA_MCBSP3_TX,
>  +               .rx_irq         = INT_McBSP3RX,
>  +               .tx_irq         = INT_McBSP3TX,
>  +               .ops            = &omap1_mcbsp_ops,
>  +               .clk_name       = "mcbsp_clk",
>  +       },
>  +#endif
>  +#ifdef CONFIG_ARCH_OMAP16XX
>  +       {
>  +               .virt_base      = OMAP1610_MCBSP1_BASE,
>  +               .dma_rx_sync    = OMAP_DMA_MCBSP1_RX,
>  +               .dma_tx_sync    = OMAP_DMA_MCBSP1_TX,
>  +               .rx_irq         = INT_McBSP1RX,
>  +               .tx_irq         = INT_McBSP1TX,
>  +               .ops            = &omap1_mcbsp_ops,
>  +               .clk_name       = "mcbsp_clk",
>  +       },
>  +       {
>  +               .virt_base      = io_p2v(OMAP1610_MCBSP2_BASE),
>  +               .dma_rx_sync    = OMAP_DMA_MCBSP2_RX,
>  +               .dma_tx_sync    = OMAP_DMA_MCBSP2_TX,
>  +               .rx_irq         = INT_1610_McBSP2_RX,
>  +               .tx_irq         = INT_1610_McBSP2_TX,
>  +               .ops            = &omap1_mcbsp_ops,
>  +       },
>  +       {
>  +               .virt_base      = OMAP1610_MCBSP3_BASE,
>  +               .dma_rx_sync    = OMAP_DMA_MCBSP3_RX,
>  +               .dma_tx_sync    = OMAP_DMA_MCBSP3_TX,
>  +               .rx_irq         = INT_McBSP3RX,
>  +               .tx_irq         = INT_McBSP3TX,
>  +               .ops            = &omap1_mcbsp_ops,
>  +               .clk_name       = "mcbsp_clk",
>  +       },
>  +#endif
>  +};

I think you need a runtime omap model check here.  Otherwise if you
have all three models enabled in the config (I don't remember if that
is supported but that's not the point) you'll get eight
platform_devices.  That will not Oops because there's a sanity check
in omap_mcbsp_register_board_cfg() but only the first three will get
registered.

There is a runtime check in the original version.

Same applies to PATCH 5/5 for omap2.

Cheers,
Andrew
