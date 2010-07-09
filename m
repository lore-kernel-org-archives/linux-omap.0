From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: rx51: Platform support for tsl2563 ALS
Date: Fri, 9 Jul 2010 10:18:35 +0300
Message-ID: <20100709071835.GF24913@atomide.com>
References: <1278597911-11839-1-git-send-email-mathias.nyman@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54053 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab0GIHSj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 03:18:39 -0400
Content-Disposition: inline
In-Reply-To: <1278597911-11839-1-git-send-email-mathias.nyman@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mathias Nyman <mathias.nyman@nokia.com>
Cc: linux-omap@vger.kernel.org

* Mathias Nyman <mathias.nyman@nokia.com> [100708 16:59]:
> From: Mathias Nyman <mathias.nyman@nokia.com>
> 
> This will enable usage of tsl2563 ambient light sensor on Nokia N900.
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>

Is this your patch or Ameya's patch originally?

Looks like your Signed-off-by is missing..

Tony


> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index 3c3f975..a3a396c 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -35,6 +35,8 @@
>  #include <sound/tlv320aic3x.h>
>  #include <sound/tpa6130a2-plat.h>
>  
> +#include <../drivers/staging/iio/light/tsl2563.h>
> +
>  #include "mux.h"
>  #include "hsmmc.h"
>  
> @@ -53,6 +55,12 @@ enum {
>  
>  static struct wl12xx_platform_data wl1251_pdata;
>  
> +#if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
> +static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
> +	.cover_comp_gain = 16,
> +};
> +#endif
> +
>  static struct omap2_mcspi_device_config wl1251_mcspi_config = {
>  	.turbo_mode	= 0,
>  	.single_channel	= 1,
> @@ -714,6 +722,12 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
>  		I2C_BOARD_INFO("tlv320aic3x", 0x18),
>  		.platform_data = &rx51_aic3x_data,
>  	},
> +#if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
> +	{
> +		I2C_BOARD_INFO("tsl2563", 0x29),
> +		.platform_data = &rx51_tsl2563_platform_data,
> +	},
> +#endif
>  	{
>  		I2C_BOARD_INFO("tpa6130a2", 0x60),
>  		.platform_data = &rx51_tpa6130a2_data,
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
