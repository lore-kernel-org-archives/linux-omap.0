From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH 1/2] ARM: McBSP: Fix request for irq in OMAP4
Date: Wed, 5 May 2010 08:32:13 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C6E56@dbde02.ent.ti.com>
References: <1273016270-31452-1-git-send-email-jorge.candelaria@ti.com>
 <1273016270-31452-2-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53031 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626Ab0EEDCT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 23:02:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4532FYa021343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 4 May 2010 22:02:18 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o4532EV5007378
	for <linux-omap@vger.kernel.org>; Wed, 5 May 2010 08:32:15 +0530 (IST)
In-Reply-To: <1273016270-31452-2-git-send-email-jorge.candelaria@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Jorge 
> Eduardo Candelaria
> Sent: Wednesday, May 05, 2010 5:08 AM
> To: linux-omap@vger.kernel.org
> Cc: Candelaria Villarreal, Jorge
> Subject: [PATCH 1/2] ARM: McBSP: Fix request for irq in OMAP4
> 
> In OMAP4, there is only one irq line for TX and RX paths. Use
> the correct irq line to avoid errors at runtime.
> 
> Also, request irq line only once (instead of requesting for TX
> and RX).
> 
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> ---
>  arch/arm/mach-omap2/mcbsp.c |   12 ++++--------
>  arch/arm/plat-omap/mcbsp.c  |   20 ++++++++++++--------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index 2f3cad6..6b550ec 100644
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -187,32 +187,28 @@ static struct omap_mcbsp_platform_data 
> omap44xx_mcbsp_pdata[] = {
>  		.phys_base      = OMAP44XX_MCBSP1_BASE,
>  		.dma_rx_sync    = OMAP44XX_DMA_MCBSP1_RX,
>  		.dma_tx_sync    = OMAP44XX_DMA_MCBSP1_TX,
> -		.rx_irq         = INT_24XX_MCBSP1_IRQ_RX,
> -		.tx_irq         = INT_24XX_MCBSP1_IRQ_TX,
> +		.tx_irq         = INT_44XX_MCBSP1_IRQ,
>  		.ops            = &omap2_mcbsp_ops,
>  	},
>  	{
>  		.phys_base      = OMAP44XX_MCBSP2_BASE,
>  		.dma_rx_sync    = OMAP44XX_DMA_MCBSP2_RX,
>  		.dma_tx_sync    = OMAP44XX_DMA_MCBSP2_TX,
> -		.rx_irq         = INT_24XX_MCBSP2_IRQ_RX,
> -		.tx_irq         = INT_24XX_MCBSP2_IRQ_TX,
> +		.tx_irq         = INT_44XX_MCBSP2_IRQ,
>  		.ops            = &omap2_mcbsp_ops,
>  	},
>  	{
>  		.phys_base      = OMAP44XX_MCBSP3_BASE,
>  		.dma_rx_sync    = OMAP44XX_DMA_MCBSP3_RX,
>  		.dma_tx_sync    = OMAP44XX_DMA_MCBSP3_TX,
> -		.rx_irq         = INT_24XX_MCBSP3_IRQ_RX,
> -		.tx_irq         = INT_24XX_MCBSP3_IRQ_TX,
> +		.tx_irq         = INT_44XX_MCBSP3_IRQ,
>  		.ops            = &omap2_mcbsp_ops,
>  	},
>  	{
>  		.phys_base      = OMAP44XX_MCBSP4_BASE,
>  		.dma_rx_sync    = OMAP44XX_DMA_MCBSP4_RX,
>  		.dma_tx_sync    = OMAP44XX_DMA_MCBSP4_TX,
> -		.rx_irq         = INT_24XX_MCBSP4_IRQ_RX,
> -		.tx_irq         = INT_24XX_MCBSP4_IRQ_TX,
> +		.tx_irq         = INT_44XX_MCBSP4_IRQ,
>  		.ops            = &omap2_mcbsp_ops,
>  	},
>  };
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index e1d0440..6e9660d 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -724,14 +724,17 @@ int omap_mcbsp_request(unsigned int id)
>  			goto err_clk_disable;
>  		}
>  
> -		init_completion(&mcbsp->rx_irq_completion);
> -		err = request_irq(mcbsp->rx_irq, 
> omap_mcbsp_rx_irq_handler,
> +		if (!cpu_is_omap44xx) {
> +			init_completion(&mcbsp->rx_irq_completion);
> +			err = request_irq(mcbsp->rx_irq,
> +					omap_mcbsp_rx_irq_handler,
>  					0, "McBSP", (void *)mcbsp);

How about using request_threaded_irq?
Refer to: http://lwn.net/Articles/302043/

-Manjunath