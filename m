From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH] [I2C]pass scll, sclh through board file for
 Errata i585
Date: Mon, 26 Apr 2010 15:43:14 -0700
Message-ID: <20100426224314.GP7225@atomide.com>
References: <1271689408-2397-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51871 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432Ab0DZWnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 18:43:15 -0400
Content-Disposition: inline
In-Reply-To: <1271689408-2397-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balajitk@ti.com
Cc: linux-omap@vger.kernel.org

* balajitk@ti.com <balajitk@ti.com> [100419 07:59]:
> From: Balaji T K <balajitk@ti.com>
> 
> Errata ID: i535 - I2C1 to 3 SCL low period is shorter in FS mode
> Due to IO cell influence, I2C1 to 3 SCL low period can be shorter than expected. 
> As a result, I2C AC timing (SCL minimum low period) in FS mode may not meet 
> the timing configured by software.
> 
> I2C1 to 3, SCL low period is programmable and proper adjustments
> to the SCLL/HSSCLL values can avoid the issue.
> 
> This patch provides flexibility to control tLOW, tHIGH for different boards.
> scll, sclh values are to be provide in board data
> for differents modes (standard, fast and high speed mode)
> as the scl rate (I2C bus speed) can be changed by bootargs.
> 
> If scll, sclh values are not provided, scll and sclh values will be computed 
> for duty cycle tHIGH:tLOW of 1:2 (for HS, FS) and 1:1 for Standard as before

<snip>

> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -594,6 +594,26 @@ static struct twl4030_platform_data sdp3430_twldata = {
>  	.vpll2		= &sdp3430_vpll2,
>  };
>  
> +static struct omap_i2c_scl_data __initdata sdp3430_i2c1_scl_data = {
> +	.rate	= 2600,
> +	.standard_scll	= 20,	/* For 100Khz */
> +	.standard_sclh	= 20,	/* For 100Khz */
> +	.fast_mode_scll	= 16,	/* For 400Khz */
> +	.fast_mode_sclh	= 8,	/* For 400Khz */
> +	.hs_phase1_scll	= 32,	/* For 2600Khz */
> +	.hs_phase1_sclh	= 16,	/* For 2600Khz */
> +	.hs_phase2_scll	= 24,	/* For 2600Khz */
> +	.hs_phase2_sclh	= 12,	/* For 2600Khz */
> +};

Can you please describe how you get these values for each board-*.c file?

> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
> @@ -70,14 +70,14 @@ static struct resource i2c_resources[][2] = {
>  		},					\
>  	}
>  
> -static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
> +static struct omap_i2c_platform_data i2c_pdata[ARRAY_SIZE(i2c_resources)];
>  static struct platform_device omap_i2c_devices[] = {
> -	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
> +	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_pdata[0]),
>  #if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> -	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
> +	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_pdata[1]),
>  #endif
>  #if	defined(CONFIG_ARCH_OMAP3)
> -	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
> +	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_pdata[2]),
>  #endif
>  };
>  
> @@ -146,8 +146,8 @@ static int __init omap_i2c_bus_setup(char *str)
>  	get_options(str, 3, ints);
>  	if (ints[0] < 2 || ints[1] < 1 || ints[1] > ports)
>  		return 0;
> -	i2c_rate[ints[1] - 1] = ints[2];
> -	i2c_rate[ints[1] - 1] |= OMAP_I2C_CMDLINE_SETUP;
> +	i2c_pdata[ints[1] - 1].rate = ints[2];
> +	i2c_pdata[ints[1] - 1].rate |= OMAP_I2C_CMDLINE_SETUP;
>  
>  	return 1;
>  }

FYI, the change from i2c_rate to i2c_pdata is needed also for
"i2c-omap: add mpu wake up latency constraint in i2c" as that
blocks some PM changes from going upstream. So once that's sorted
out some minor rebasing of that patch is needed.

> @@ -446,24 +453,47 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  
>  			/* For first phase of HS mode */
>  			scl = internal_clk / 400;
> -			fsscll = scl - (scl / 3) - 7;
> -			fssclh = (scl / 3) - 5;
> +			if ((pdata->hs_phase1.scll > 7) &&
> +					(pdata->hs_phase1.sclh > 5)) {
> +				fsscll = pdata->hs_phase1.scll - 7;
> +				fssclh = pdata->hs_phase1.sclh - 5;
> +			} else {
> +				fsscll = scl - (scl / 3) - 7;
> +				fssclh = (scl / 3) - 5;
> +			}
>  
>  			/* For second phase of HS mode */
>  			scl = fclk_rate / dev->speed;
> -			hsscll = scl - (scl / 3) - 7;
> -			hssclh = (scl / 3) - 5;
> +			if ((pdata->hs_phase2.scll > 7) &&
> +					(pdata->hs_phase2.sclh > 5)) {
> +				hsscll = pdata->hs_phase2.scll - 7;
> +				hssclh = pdata->hs_phase2.sclh - 5;
> +			} else {
> +				hsscll = scl - (scl / 3) - 7;
> +				hssclh = (scl / 3) - 5;
> +			}
>  		} else if (dev->speed > 100) {
>  			unsigned long scl;
>  
>  			/* Fast mode */
>  			scl = internal_clk / dev->speed;
> -			fsscll = scl - (scl / 3) - 7;
> -			fssclh = (scl / 3) - 5;
> +			if ((pdata->fast.scll > 7) && (pdata->fast.sclh > 5)) {
> +				fsscll = pdata->fast.scll - 7;
> +				fssclh = pdata->fast.sclh - 5;
> +			} else {
> +				fsscll = scl - (scl / 3) - 7;
> +				fssclh = (scl / 3) - 5;
> +			}
>  		} else {
>  			/* Standard mode */
> -			fsscll = internal_clk / (dev->speed * 2) - 7;
> -			fssclh = internal_clk / (dev->speed * 2) - 5;
> +			if ((pdata->standard.scll > 7) &&
> +					(pdata->standard.sclh > 5)) {
> +				fsscll = pdata->standard.scll - 7;
> +				fssclh = pdata->standard.sclh - 5;
> +			} else {
> +				fsscll = internal_clk / (dev->speed * 2) - 7;
> +				fssclh = internal_clk / (dev->speed * 2) - 5;
> +			}
>  		}
>  		scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
>  		sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;

To me it looks like you should not ignore the scl for these calculations
as it can be different depending on the omap.

Also, this should be also posted to the i2c mailing list for review.

Regards,

Tony
