From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP1: DMA: Correct the number of logical channels
Date: Thu, 5 Jan 2017 23:47:50 +0200
Message-ID: <20170105214750.g7d6kbaq7q4vgrug@raspberrypi-2.musicnaut.iki.fi>
References: <20170103112234.19097-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170103112234.19097-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Jan 03, 2017 at 01:22:34PM +0200, Peter Ujfalusi wrote:
> OMAP1510, OMAP5910 and OMAP310 have only 9 logical channels.
> OMAP1610, OMAP5912, OMAP1710, OMAP730, and OMAP850 have 16 logical channels
> available.
> 
> The wired 17 for the lch_count must have been used to cover the 16 + 1
> dedicated LCD channel, in reality we can only use 9 or 16 channels.
> 
> The d->chan_count is not used by the omap-dma stack, so we can skip the
> setup. chan_count was configured to the number of logical channels and not
> the actual number of physical channels anyways.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  arch/arm/mach-omap1/dma.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> index f6ba589cd312..c821c1d5610e 100644
> --- a/arch/arm/mach-omap1/dma.c
> +++ b/arch/arm/mach-omap1/dma.c
> @@ -32,7 +32,6 @@
>  #include "soc.h"
>  
>  #define OMAP1_DMA_BASE			(0xfffed800)
> -#define OMAP1_LOGICAL_DMA_CH_COUNT	17
>  
>  static u32 enable_1510_mode;
>  
> @@ -348,8 +347,6 @@ static int __init omap1_system_dma_init(void)
>  		goto exit_iounmap;
>  	}
>  
> -	d->lch_count		= OMAP1_LOGICAL_DMA_CH_COUNT;
> -
>  	/* Valid attributes for omap1 plus processors */
>  	if (cpu_is_omap15xx())
>  		d->dev_caps = ENABLE_1510_MODE;
> @@ -366,13 +363,14 @@ static int __init omap1_system_dma_init(void)
>  	d->dev_caps		|= CLEAR_CSR_ON_READ;
>  	d->dev_caps		|= IS_WORD_16;
>  
> -	if (cpu_is_omap15xx())
> -		d->chan_count = 9;
> -	else if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
> -		if (!(d->dev_caps & ENABLE_1510_MODE))
> -			d->chan_count = 16;
> +	/* available logical channels */
> +	if (cpu_is_omap15xx()) {
> +		d->lch_count = 9;
> +	} else {
> +		if (d->dev_caps & ENABLE_1510_MODE)
> +			d->lch_count = 9;
>  		else
> -			d->chan_count = 9;
> +			d->lch_count = 16;
>  	}
>  
>  	p = dma_plat_info;
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
