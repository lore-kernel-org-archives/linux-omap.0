From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] Input: ti_am335x_tsc: Add support for
 ti,charge-delay-ns
Date: Tue, 29 Nov 2016 13:09:17 -0800
Message-ID: <20161129210917.GA20680@dtor-ws>
References: <20161110163515.27598-1-mugunthanvnm@ti.com>
 <20161111075819.5760-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161111075819.5760-1-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 11, 2016 at 01:28:19PM +0530, Mugunthan V N wrote:
> ti,charge-delay will be deprecated as it represents number of
> clock cycles and the DT entries are done in assumption of 3MHz
> TSCADC clock, but clock can be set upto 24MHz. So driver add
> support for ti,charge-delay-ns and do not drop support for
> ti,charge-delay to support old dtbs and it will be assumed that
> it is for 3MHz TSCADC clock and will be calculated as per current
> clock speed.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 7953381d939a..104b3640f728 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -379,15 +379,30 @@ static int titsc_parse_dt(struct platform_device *pdev,
>  		ts_dev->coordinate_readouts = 5;
>  	}
>  
> -	err = of_property_read_u32(node, "ti,charge-delay",
> +	err = of_property_read_u32(node, "ti,charge-delay-ns",
>  				   &ts_dev->charge_delay);
> -	/*
> -	 * If ti,charge-delay value is not specified, then use
> -	 * CHARGEDLY_OPENDLY as the default value.
> -	 */
> -	if (err < 0) {
> -		ts_dev->charge_delay = CHARGEDLY_OPENDLY;
> -		dev_warn(&pdev->dev, "ti,charge-delay not specified\n");
> +	if (err >= 0) {
> +		u64 charge_delay = ts_dev->charge_delay;
> +
> +		charge_delay *= ADC_CLK;
> +		do_div(charge_delay, 1E9);
> +		ts_dev->charge_delay = (u32)charge_delay;
> +	} else {
> +		err = of_property_read_u32(node, "ti,charge-delay",
> +					   &ts_dev->charge_delay);
> +		/*
> +		 * If ti,charge-delay value is not specified, then use
> +		 * CHARGEDLY_OPENDLY as the default value.
> +		 */
> +		if (err < 0) {
> +			ts_dev->charge_delay = CHARGEDLY_OPENDLY;
> +			dev_warn(&pdev->dev, "ti,charge-delay not specified\n");
> +		}
> +		/*
> +		 * ti,charge-delay is specified with referrence to 3MHz,
> +		 * so convert it to in referrence to current clock
> +		 */
> +		ts_dev->charge_delay *= ADC_CLK / 3000000;
>  	}
>  
>  	return of_property_read_u32_array(node, "ti,wire-config",
> -- 
> 2.11.0.rc0.7.gbe5a750
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
