From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [RFC PATCH 2/5] OMAP3: McBSP: Change the way how the FIFO is
 handled
Date: Mon, 31 May 2010 20:41:12 +0300
Message-ID: <4C03F4B8.9090306@gmail.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com> <1275293810-31984-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45973 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab0EaRlS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 13:41:18 -0400
Received: by ewy8 with SMTP id 8so1025690ewy.28
        for <linux-omap@vger.kernel.org>; Mon, 31 May 2010 10:41:16 -0700 (PDT)
In-Reply-To: <1275293810-31984-3-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, jhnikula@gmail.com, tony@atomide.com, ext-eero.nurkkala@nokia.com, eduardo.valentin@nokia.com

On 05/31/2010 11:16 AM, Peter Ujfalusi wrote:
> Use the actual FIFO size in words as buffer_size on OMAP2.
> Change the threshold configuration to use 1 based numbering, when
> specifying the allowed threshold maximum or the McBSP threshold value.
> Set the default maximum threshold to (buffer_size - 0x10) intialy.
>> From users of McBSP, now it is expected to use this method.
> Asking for threshold 1 means that the value written to threshold registers
> are going to be 0, which means 1 word threshold.

just a 2cent minor comment: maybe omap_mcbsp_platform_data needs 
structure documentation.. it might be difficult for folks to figure that 
out from commit ID itself..
>
> Signed-off-by: Peter Ujfalusi<peter.ujfalusi@nokia.com>
> ---
>   arch/arm/mach-omap2/mcbsp.c |   10 +++++-----
>   arch/arm/plat-omap/mcbsp.c  |   10 ++++++----
>   2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index 016fe60..9139958 100644
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -132,7 +132,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
>   		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
>   		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
>   		.ops		=&omap2_mcbsp_ops,
> -		.buffer_size	= 0x6F,
> +		.buffer_size	= 0x80,
>   	},
>   	{
>   		.phys_base	= OMAP34XX_MCBSP2_BASE,
> @@ -142,7 +142,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
>   		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
>   		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
>   		.ops		=&omap2_mcbsp_ops,
> -		.buffer_size	= 0x3FF,
> +		.buffer_size	= 0x500,
>   	},
>   	{
>   		.phys_base	= OMAP34XX_MCBSP3_BASE,
> @@ -152,7 +152,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
>   		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
>   		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
>   		.ops		=&omap2_mcbsp_ops,
> -		.buffer_size	= 0x6F,
> +		.buffer_size	= 0x80,
>   	},
>   	{
>   		.phys_base	= OMAP34XX_MCBSP4_BASE,
> @@ -161,7 +161,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
>   		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
>   		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
>   		.ops		=&omap2_mcbsp_ops,
> -		.buffer_size	= 0x6F,
> +		.buffer_size	= 0x80,
>   	},
>   	{
>   		.phys_base	= OMAP34XX_MCBSP5_BASE,
> @@ -170,7 +170,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
>   		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
>   		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
>   		.ops		=&omap2_mcbsp_ops,
> -		.buffer_size	= 0x6F,
> +		.buffer_size	= 0x80,
>   	},
>   };
>   #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 51d8abf..6462968 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -497,7 +497,8 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
>   	}
>   	mcbsp = id_to_mcbsp_ptr(id);
>
> -	MCBSP_WRITE(mcbsp, THRSH2, threshold);
> +	if (threshold&&  threshold<= mcbsp->max_tx_thres)
> +		MCBSP_WRITE(mcbsp, THRSH2, threshold - 1);
>   }
>   EXPORT_SYMBOL(omap_mcbsp_set_tx_threshold);
>
> @@ -519,7 +520,8 @@ void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
>   	}
>   	mcbsp = id_to_mcbsp_ptr(id);
>
> -	MCBSP_WRITE(mcbsp, THRSH1, threshold);
> +	if (threshold&&  threshold<= mcbsp->max_rx_thres)
> +		MCBSP_WRITE(mcbsp, THRSH1, threshold - 1);
>   }
>   EXPORT_SYMBOL(omap_mcbsp_set_rx_threshold);
>
> @@ -1696,8 +1698,8 @@ static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
>   {
>   	mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
>   	if (cpu_is_omap34xx()) {
> -		mcbsp->max_tx_thres = max_thres(mcbsp);
> -		mcbsp->max_rx_thres = max_thres(mcbsp);
> +		mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
> +		mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
>   		/*
>   		 * REVISIT: Set dmap_op_mode to THRESHOLD as default
>   		 * for mcbsp2 instances.

