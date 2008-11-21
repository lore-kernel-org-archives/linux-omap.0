From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Fri, 21 Nov 2008 14:08:57 -0800
Message-ID: <20081121220856.GD4927@atomide.com>
References: <12266521173159-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63639 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbYKUWI6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 17:08:58 -0500
Content-Disposition: inline
In-Reply-To: <12266521173159-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: linux-omap@vger.kernel.org

* ext-eero.nurkkala@nokia.com <ext-eero.nurkkala@nokia.com> [081114 00:43]:
> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> The prescalers for 100 kHz and 400 kHz mode
> are wrong. The internal clock is the fclock
> divided by the prescaler. The PSC is an 8 bit
> field in omap3430. Moreover, the scll and
> sclh values should be adjusted properly.
> Having the correct prescaler is important in
> the process of getting a finite i2c clock. In
> addition, the prescaler is used in the process
> of activating the correct noise filter and thus,
> lets more error resilient i2c communications.

I guess this should be also updated to use dev->rev so it works on
2430 too?

Tony

> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   21 ++++++++++++++++++---
>  1 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index e708ebd..a42003a 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -288,7 +288,17 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
>  
>  		/* HSI2C controller internal clk rate should be 19.2 Mhz */
> -		internal_clk = 19200;
> +		if (cpu_is_omap34xx()) {
> +			if (dev->speed > 400)
> +				internal_clk = 19200;
> +			else if (dev->speed > 100)
> +				internal_clk = 9600;
> +			else
> +				internal_clk = 4000;
> +		} else {
> +			internal_clk = 19200;
> +		}
> +
>  		fclk_rate = clk_get_rate(dev->fclk) / 1000;
>  
>  		/* Compute prescaler divisor */
> @@ -306,8 +316,13 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			hssclh = fclk_rate / (dev->speed * 2) - 6;
>  		} else {
>  			/* To handle F/S modes */
> -			fsscll = internal_clk / (dev->speed * 2) - 6;
> -			fssclh = internal_clk / (dev->speed * 2) - 6;
> +			if (cpu_is_omap34xx()) {
> +				fsscll = internal_clk / (dev->speed * 2) - 7;
> +				fssclh = internal_clk / (dev->speed * 2) - 5;
> +			} else {
> +				fsscll = internal_clk / (dev->speed * 2) - 6;
> +				fssclh = internal_clk / (dev->speed * 2) - 6;
> +			}
>  		}
>  		scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
>  		sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
> -- 
> 1.6.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
