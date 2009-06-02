From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] I2C: OMAP3: Better noise suppression for
	fast/standard modes
Date: Tue, 2 Jun 2009 10:52:07 -0700
Message-ID: <20090602175206.GH27332@atomide.com>
References: <1243436086-3623-1-git-send-email-aaro.koskinen@nokia.com> <1243436086-3623-2-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55668 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbZFBRwK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 13:52:10 -0400
Content-Disposition: inline
In-Reply-To: <1243436086-3623-2-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@nokia.com> [090527 07:55]:
> Use longer noise filter period for fast and standard mode. Based on an
> earlier patch by Eero Nurkkala.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Ben this should be queued too.

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/i2c/busses/i2c-omap.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 5d9880c..8c76cea 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -333,8 +333,18 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  
>  	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
>  
> -		/* HSI2C controller internal clk rate should be 19.2 Mhz */
> -		internal_clk = 19200;
> +		/*
> +		 * HSI2C controller internal clk rate should be 19.2 Mhz for
> +		 * HS and for all modes on 2430. On 34xx we can use lower rate
> +		 * to get longer filter period for better noise suppression.
> +		 * The filter is iclk (fclk for HS) period.
> +		 */
> +		if (dev->speed > 400 || cpu_is_omap_2430())
> +			internal_clk = 19200;
> +		else if (dev->speed > 100)
> +			internal_clk = 9600;
> +		else
> +			internal_clk = 4000;
>  		fclk_rate = clk_get_rate(dev->fclk) / 1000;
>  
>  		/* Compute prescaler divisor */
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
