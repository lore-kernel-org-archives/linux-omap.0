From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH / RFC] Basic OMAP2430 High speed I2C & Speed handling
	(final)
Date: Tue, 17 Apr 2007 19:56:20 +0000
Message-ID: <20070417195619.GD26287@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47A95873@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47A95873@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Syed Mohammed, Khasim <x0khasim@ti.com> [070412 01:21]:
> This patch moves I2C speed parameter (from module) to platform data.
> This is part of a discussion that Nishanth and I were discussing (also
> on
> lmsensors). 

OK, great.

> I have also added basic High Speed support based on I2C bus speed. 
> This patch is tested for high speed I2C (with TWL4030 Keypad) and works
> as expected.

Some comments below.

> --- linux-omap/drivers/i2c/busses/i2c-omap.c	2007-01-08
> 18:56:31.000000000 -0600
> +++ lin_for_hsi2c/drivers/i2c/busses/i2c-omap.c	2007-04-11
> 11:47:54.000000000 -0500
> @@ -3,7 +3,10 @@
>   *
>   * Copyright (C) 2003 MontaVista Software, Inc.
>   * Copyright (C) 2004 Texas Instruments.
> - *
> + *
> + * Updated to support High Speed I2C mode by
> + * Syed Mohammed Khasim <x0khasim@ti.com>
> + *
>   * Updated to work with multiple I2C interfaces on 24xx by
>   * Tony Lindgren <tony@atomide.com> and Imre Deak <imre.deak@nokia.com>
>   * Copyright (C) 2005 Nokia Corporation
> @@ -87,6 +90,7 @@

Let's rewrite the the header a bit to leave out change log type
comments, something like this would be better in general:

Copyright (C) 2003 MontaVista Software, Inc.
Copyright (C) 2004 - 2007 Texas Instruments
Copyright (C) 2005 Nokia Corporation
...

Written by:
...

This will avoid getting comments like "change log should be in git"
on LKML.


> @@ -154,17 +157,30 @@ static int omap_i2c_get_clocks(struct om
>  			return -ENODEV;
>  		}
>  	}
> -
> -	dev->fclk = clk_get(dev->dev, "i2c_fck");
> -	if (IS_ERR(dev->fclk)) {
> -		if (dev->iclk != NULL) {
> -			clk_put(dev->iclk);
> -			dev->iclk = NULL;
> +
> +	if (cpu_is_omap2430()) {
> +		dev->fclk = clk_get(dev->dev, "i2chs_fck");
> +		if (IS_ERR(dev->fclk)) {
> +			if (dev->iclk != NULL) {
> +				clk_put(dev->iclk);
> +				dev->iclk = NULL;
> +			}
> +			dev->fclk = NULL;
> +			return -ENODEV;
>  		}
> -		dev->fclk = NULL;
> -		return -ENODEV;
>  	}
> -
> +	else {
> +		dev->fclk = clk_get(dev->dev, "i2c_fck");
> +		if (IS_ERR(dev->fclk)) {
> +			if (dev->iclk != NULL) {
> +				clk_put(dev->iclk);
> +				dev->iclk = NULL;
> +			}
> +			dev->fclk = NULL;
> +			return -ENODEV;
> +		}
> +	}
> +
>  	return 0;
>  }

Is the i2c_fck needed on 2430? If not, we could just rename i2chs_fck
to i2c_fck in clock.h. Then just add a comment that i2c_fck is available
for 2430 too, but i2chs_fck is the preferred one to use.

Doing this would leave out the clock tinkering above.


> @@ -238,28 +256,59 @@ static int omap_i2c_init(struct omap_i2c
>  		if (fclk_rate > 12000000)
>  			psc = fclk_rate / 12000000;
>  	}
> +
> +	if (cpu_is_omap2430()) {
> +
> +		/* HS I2C controller should be operated at 19.2 Mhz */
> +		internal_clk = 19200;
> +		fclk_rate = clk_get_rate(dev->fclk) / 1000;
> +
> +		/* Compute prescaler divisor */
> +		psc = fclk_rate / internal_clk;
> +		psc = psc - 1;
> +
> +		/* If configured for High Speed */
> +		if (dev->speed > 400) {
> +			/* For first phase of HS mode */
> +			fsscll = internal_clk / (400 * 2) - 6;
> +			fssclh = internal_clk / (400 * 2) - 6;
> +
> +			/* For second phase of HS mode */
> +			hsscll = fclk_rate / (dev->speed * 2) - 6;
> +			hssclh = fclk_rate / (dev->speed * 2) - 6;
> +		}
> +		else {
> +			/* To handle F/S modes */
> +			fsscll = internal_clk / (dev->speed * 2) - 6;
> +			fssclh = internal_clk / (dev->speed * 2) - 6;
> +		}
> +		scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
> +		sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
> +	}
> +	else {
> +		/* Program desired operating rate */
> +		fclk_rate /= (psc + 1) * 1000;
> +		if (psc > 2)
> +			psc = 2;
> +		scll = fclk_rate / (dev->speed * 2) - 7 + psc;
> +		sclh = fclk_rate / (dev->speed * 2) - 7 + psc;
> +	}

According to CodingStyle else above should be on the same line with
the brace. It's on separate lines in two places above.


>  	/* Setup clock prescaler to obtain approx 12MHz I2C module
> clock: */
>  	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, psc);
> -
> -	/* Program desired operating rate */
> -	fclk_rate /= (psc + 1) * 1000;
> -	if (psc > 2)
> -		psc = 2;
> -
> -	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG,
> -			   fclk_rate / (clock * 2) - 7 + psc);
> -	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG,
> -			   fclk_rate / (clock * 2) - 7 + psc);
> -
> +
> +	/* SCL low and high time values */
> +	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
> +	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
> +
>  	/* Take the I2C module out of reset: */
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>  
>  	/* Enable interrupts */
>  	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
> -			   (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
> -			    OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
> -			    OMAP_I2C_IE_AL));
> +				(OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
> +				OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
> +				OMAP_I2C_IE_AL));
>  	return 0;
>  }

Please separate formatting changes to a separate patch with no
functional changes. Maybe one follow-up patch for the getting rid
of the changelog in the header, and formatting changes?


> --- linux-omap/arch/arm/mach-omap2/devices.c	2007-04-02
> 02:29:57.000000000 -0500
> +++ lin_for_hsi2c/arch/arm/mach-omap2/devices.c	2007-04-11
> 12:01:30.000000000 -0500
> @@ -30,6 +30,12 @@
>  #define OMAP2_I2C_BASE2		0x48072000
>  #define OMAP2_I2C_INT2		57
>  
> +#if defined(CONFIG_MACH_OMAP_2430SDP)
> +static u32 omap2_i2c2_clkrate	= 2600;
> +#else
> +static u32 omap2_i2c2_clkrate	= 100;
> +#endif
> +
>  static struct resource i2c_resources2[] = {
>  	{
>  		.start		= OMAP2_I2C_BASE2,
> @@ -47,6 +53,9 @@ static struct platform_device omap_i2c_d
>  	.id             = 2,
>  	.num_resources	= ARRAY_SIZE(i2c_resources2),
>  	.resource	= i2c_resources2,
> +	.dev		= {
> +		.platform_data	= &omap2_i2c2_clkrate,
> +	},
>  };
>  
>  /* See also arch/arm/plat-omap/devices.c for first I2C on 24xx */

The if defined(CONFIG_MACH_OMAP_2430SDP) adds an unnecessary dependency
for not being possibly able to compile in multiple omaps. Let's rather
just do something with if (cpu_is_omap2430()) to set the
omap2_i2c2_clkrate.


> --- linux-omap/arch/arm/plat-omap/devices.c	2007-04-04
> 18:13:49.000000000 -0500
> +++ lin_for_hsi2c/arch/arm/plat-omap/devices.c	2007-04-11
> 12:02:19.000000000 -0500
> @@ -97,6 +97,12 @@ static inline void omap_init_dsp(void) {
>  #define OMAP1_I2C_INT		INT_I2C
>  #define OMAP2_I2C_INT1		56
>  
> +#if defined(CONFIG_MACH_OMAP_2430SDP)
> +	static u32 omap2_i2c1_clkrate	= 400;
> +#else
> +	static u32 omap2_i2c1_clkrate	= 100;
> +#endif
> +
>  static struct resource i2c_resources1[] = {
>  	{
>  		.start		= 0,
> @@ -116,6 +122,9 @@ static struct platform_device omap_i2c_d
>  	.id             = 1,
>  	.num_resources	= ARRAY_SIZE(i2c_resources1),
>  	.resource	= i2c_resources1,
> +	.dev		= {
> +		.platform_data	= &omap2_i2c1_clkrate,
> +	},
>  };
>  
>  /* See also arch/arm/mach-omap2/devices.c for second I2C on 24xx */

Same here with omap2_i2c1_clkrate.

Regards,

Tony
