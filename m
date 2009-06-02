From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] I2C: OMAP2/3: Fix scll/sclh calculations
Date: Tue, 2 Jun 2009 10:51:16 -0700
Message-ID: <20090602175115.GG27332@atomide.com>
References: <1243436086-3623-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1243436086-3623-1-git-send-email-aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> [090527 07:55]:
> Fix scll/sclh calculations for HS and fast modes. Currently the driver
> uses equal (roughly) low/high times which will result in too short
> low time.
> 
> OMAP3430 TRM gives the following equations:
> 
> 	F/S: tLow  = (scll + 7) * internal_clk
> 	     tHigh = (sclh + 5) * internal_clk
> 	HS:  tLow  = (scll + 7) * fclk
> 	     tHigh = (sclh + 5) * fclk
> 
> Furthermore, the I2C specification sets the following minimum values
> for HS tLow/tHigh for capacitive bus loads 100 pF (maximum speed 3400)
> and 400 pF (maximum speed 1700):
> 
> 	speed	tLow		tHigh
> 	3400	160 ns		60 ns
> 	1700	320 ns		120 ns
> 
> and for F/S:
> 
> 	speed	tLow		tHigh
> 	400	1300 ns		600 ns
> 	100	4700 ns		4000 ns
> 
> By using duty cycles 33/66 (HS, F) and 50/50 (S) we stay above these
> minimum values.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Ben can you please queue this?

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-omap.c |   25 ++++++++++++++++++-------
>  1 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 9919c08..5d9880c 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -343,17 +343,28 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  
>  		/* If configured for High Speed */
>  		if (dev->speed > 400) {
> +			unsigned long scl;
> +
>  			/* For first phase of HS mode */
> -			fsscll = internal_clk / (400 * 2) - 6;
> -			fssclh = internal_clk / (400 * 2) - 6;
> +			scl = internal_clk / 400;
> +			fsscll = scl - (scl / 3) - 7;
> +			fssclh = (scl / 3) - 5;
>  
>  			/* For second phase of HS mode */
> -			hsscll = fclk_rate / (dev->speed * 2) - 6;
> -			hssclh = fclk_rate / (dev->speed * 2) - 6;
> +			scl = fclk_rate / dev->speed;
> +			hsscll = scl - (scl / 3) - 7;
> +			hssclh = (scl / 3) - 5;
> +		} else if (dev->speed > 100) {
> +			unsigned long scl;
> +
> +			/* Fast mode */
> +			scl = internal_clk / dev->speed;
> +			fsscll = scl - (scl / 3) - 7;
> +			fssclh = (scl / 3) - 5;
>  		} else {
> -			/* To handle F/S modes */
> -			fsscll = internal_clk / (dev->speed * 2) - 6;
> -			fssclh = internal_clk / (dev->speed * 2) - 6;
> +			/* Standard mode */
> +			fsscll = internal_clk / (dev->speed * 2) - 7;
> +			fssclh = internal_clk / (dev->speed * 2) - 5;
>  		}
>  		scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
>  		sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
