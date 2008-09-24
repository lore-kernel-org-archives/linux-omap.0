From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Add RX/TX interrupts for 2430 and 34xx
	McBSP ports 3-5
Date: Wed, 24 Sep 2008 12:14:03 +0300
Message-ID: <20080924091402.GK5222@atomide.com>
References: <1221569813-29771-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56062 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYIXJOG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 05:14:06 -0400
Content-Disposition: inline
In-Reply-To: <1221569813-29771-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080916 16:02]:
> Without RX and TX interrupt definitions, the omap_mcbsp_request will
> fail on OMAP2430 and OMAP34xx for ports 3-5 since default io_type is
> OMAP_MCBSP_IRQ_IO.

Pushing to l-o and merging into your earlier patch
"Add support for OMAP2430 in McBSP" for upstream.

Tony

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/mach-omap2/mcbsp.c            |   12 ++++++++++++
>  arch/arm/plat-omap/include/mach/irqs.h |    6 ++++++
>  2 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index afbe1e6..cae3ebe 100644
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -196,6 +196,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
>  		.phys_base	= OMAP2430_MCBSP3_BASE,
>  		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
>  		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
> +		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
> +		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
>  		.ops		= &omap2_mcbsp_ops,
>  		.clk_name	= "mcbsp_clk",
>  	},
> @@ -203,6 +205,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
>  		.phys_base	= OMAP2430_MCBSP4_BASE,
>  		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
>  		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
> +		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
> +		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
>  		.ops		= &omap2_mcbsp_ops,
>  		.clk_name	= "mcbsp_clk",
>  	},
> @@ -210,6 +214,8 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
>  		.phys_base	= OMAP2430_MCBSP5_BASE,
>  		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
>  		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
> +		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
> +		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
>  		.ops		= &omap2_mcbsp_ops,
>  		.clk_name	= "mcbsp_clk",
>  	},
> @@ -244,6 +250,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
>  		.phys_base	= OMAP34XX_MCBSP3_BASE,
>  		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
>  		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
> +		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
> +		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
>  		.ops		= &omap2_mcbsp_ops,
>  		.clk_name	= "mcbsp_clk",
>  	},
> @@ -251,6 +259,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
>  		.phys_base	= OMAP34XX_MCBSP4_BASE,
>  		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
>  		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
> +		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
> +		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
>  		.ops		= &omap2_mcbsp_ops,
>  		.clk_name	= "mcbsp_clk",
>  	},
> @@ -258,6 +268,8 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
>  		.phys_base	= OMAP34XX_MCBSP5_BASE,
>  		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
>  		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
> +		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
> +		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
>  		.ops		= &omap2_mcbsp_ops,
>  		.clk_name	= "mcbsp_clk",
>  	},
> diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
> index e51e5e6..0d22c82 100644
> --- a/arch/arm/plat-omap/include/mach/irqs.h
> +++ b/arch/arm/plat-omap/include/mach/irqs.h
> @@ -266,6 +266,8 @@
>  #define INT_24XX_GPTIMER11	47
>  #define INT_24XX_GPTIMER12	48
>  #define INT_24XX_SHA1MD5	51
> +#define INT_24XX_MCBSP4_IRQ_TX	54
> +#define INT_24XX_MCBSP4_IRQ_RX	55
>  #define INT_24XX_I2C1_IRQ	56
>  #define INT_24XX_I2C2_IRQ	57
>  #define INT_24XX_HDQ_IRQ	58
> @@ -284,8 +286,12 @@
>  #define INT_24XX_USB_IRQ_HGEN	78
>  #define INT_24XX_USB_IRQ_HSOF	79
>  #define INT_24XX_USB_IRQ_OTG	80
> +#define INT_24XX_MCBSP5_IRQ_TX	81
> +#define INT_24XX_MCBSP5_IRQ_RX	82
>  #define INT_24XX_MMC_IRQ	83
>  #define INT_24XX_MMC2_IRQ	86
> +#define INT_24XX_MCBSP3_IRQ_TX	89
> +#define INT_24XX_MCBSP3_IRQ_RX	90
>  #define INT_24XX_SPI3_IRQ	91
>  
>  #define INT_243X_MCBSP2_IRQ	16
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
