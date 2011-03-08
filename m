From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: overo: Add regulator for ads7846
Date: Tue, 8 Mar 2011 15:16:16 -0800
Message-ID: <20110308231615.GH26463@atomide.com>
References: <1299341546-17289-1-git-send-email-steve@sakoman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21098 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024Ab1CHXQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 18:16:29 -0500
Content-Disposition: inline
In-Reply-To: <1299341546-17289-1-git-send-email-steve@sakoman.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <steve@sakoman.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com

* Steve Sakoman <steve@sakoman.com> [110305 08:10]:
> The ads7846 driver now requires a regulator.  This patch adds the
> necessary regulator to the overo board file.  Without it, the
> following error occurs (and the touchscreen will not function):
> 
> ads7846 spi1.0: unable to get regulator: -19
> 
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
> Note: this patch should be applied after the "[PATCH v3 0/2] Add DSS2
> support on Overo" series.

Tomi can you please take this one to avoid merge conflicts?

Acked-by: Tony Lindgren <tony@atomide.com>
 
>  arch/arm/mach-omap2/board-overo.c |   31 +++++++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index a2c17c9..1aee5b7 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -28,6 +28,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/regulator/fixed.h>
>  #include <linux/spi/spi.h>
>  
>  #include <linux/mtd/mtd.h>
> @@ -97,6 +98,34 @@ static struct ads7846_platform_data ads7846_config = {
>  	.keep_vref_on		= 1,
>  };
>  
> +/* fixed regulator for ads7846 */
> +static struct regulator_consumer_supply ads7846_supply =
> +	REGULATOR_SUPPLY("vcc", "spi1.0");
> +
> +static struct regulator_init_data vads7846_regulator = {
> +	.constraints = {
> +		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	= &ads7846_supply,
> +};
> +
> +static struct fixed_voltage_config vads7846 = {
> +	.supply_name		= "vads7846",
> +	.microvolts		= 3300000, /* 3.3V */
> +	.gpio			= -EINVAL,
> +	.startup_delay		= 0,
> +	.init_data		= &vads7846_regulator,
> +};
> +
> +static struct platform_device vads7846_device = {
> +	.name		= "reg-fixed-voltage",
> +	.id		= 1,
> +	.dev = {
> +		.platform_data = &vads7846,
> +	},
> +};
> +
>  static void __init overo_ads7846_init(void)
>  {
>  	if ((gpio_request(OVERO_GPIO_PENDOWN, "ADS7846_PENDOWN") == 0) &&
> @@ -106,6 +135,8 @@ static void __init overo_ads7846_init(void)
>  		printk(KERN_ERR "could not obtain gpio for ADS7846_PENDOWN\n");
>  		return;
>  	}
> +
> +	platform_device_register(&vads7846_device);
>  }
>  
>  #else
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
