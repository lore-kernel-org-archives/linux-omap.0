From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] Add touchscreen support for Pandora
Date: Thu, 13 Nov 2008 15:05:14 -0800
Message-ID: <20081113230513.GR3106@atomide.com>
References: <1226000998-22397-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49492 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbYKMXFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 18:05:17 -0500
Content-Disposition: inline
In-Reply-To: <1226000998-22397-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [081106 11:50]:
> This patch adds ADS7846 compatible touchscreen support for
> OMAP3 Pandora.

Pushing these today.

Tony

> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  arch/arm/mach-omap2/board-omap3pandora.c |   57 ++++++++++++++++++++++++++++++
>  1 files changed, 57 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
> index 9fd3499..b10bf00 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -25,6 +25,8 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  
> +#include <linux/spi/spi.h>
> +#include <linux/spi/ads7846.h>
>  #include <linux/i2c/twl4030.h>
>  
>  #include <linux/mtd/mtd.h>
> @@ -45,6 +47,7 @@
>  #include <mach/nand.h>
>  #include <mach/usb-ehci.h>
>  #include <mach/usb-musb.h>
> +#include <mach/mcspi.h>
>  
>  #include "sdram-micron-mt46h32m32lf-6.h"
>  #include "mmc-twl4030.h"
> @@ -54,6 +57,8 @@
>  #define GPMC_CS0_BASE  0x60
>  #define GPMC_CS_SIZE   0x30
>  
> +#define OMAP3_PANDORA_TS_GPIO		94
> +
>  static struct mtd_partition omap3pandora_nand_partitions[] = {
>  	{
>  		.name           = "xloader",
> @@ -185,6 +190,55 @@ static void __init omap3pandora_init_irq(void)
>  	omap_gpio_init();
>  }
>  
> +static void __init omap3pandora_ads7846_init(void)
> +{
> +	int gpio = OMAP3_PANDORA_TS_GPIO;
> +	int ret;
> +
> +	ret = gpio_request(gpio, "ads7846_pen_down");
> +	if (ret < 0) {
> +		printk(KERN_ERR "Failed to request GPIO %d for "
> +				"ads7846 pen down IRQ\n", gpio);
> +		return;
> +	}
> +
> +	gpio_direction_input(gpio);
> +}
> +
> +static int ads7846_get_pendown_state(void)
> +{
> +	return !gpio_get_value(OMAP3_PANDORA_TS_GPIO);
> +}
> +
> +static struct ads7846_platform_data ads7846_config = {
> +	.x_max			= 0x0fff,
> +	.y_max			= 0x0fff,
> +	.x_plate_ohms		= 180,
> +	.pressure_max		= 255,
> +	.debounce_max		= 10,
> +	.debounce_tol		= 3,
> +	.debounce_rep		= 1,
> +	.get_pendown_state	= ads7846_get_pendown_state,
> +	.keep_vref_on		= 1,
> +};
> +
> +static struct omap2_mcspi_device_config ads7846_mcspi_config = {
> +	.turbo_mode	= 0,
> +	.single_channel	= 1,  /* 0: slave, 1: master */
> +};
> +
> +static struct spi_board_info omap3pandora_spi_board_info[] __initdata = {
> +	{
> +		.modalias		= "ads7846",
> +		.bus_num		= 1,
> +		.chip_select		= 0,
> +		.max_speed_hz		= 1500000,
> +		.controller_data	= &ads7846_mcspi_config,
> +		.irq			= OMAP_GPIO_IRQ(OMAP3_PANDORA_TS_GPIO),
> +		.platform_data		= &ads7846_config,
> +	}
> +};
> +
>  static struct platform_device omap3pandora_lcd_device = {
>  	.name		= "pandora_lcd",
>  	.id		= -1,
> @@ -219,10 +273,13 @@ static void __init omap3pandora_init(void)
>  	omap_board_config = omap3pandora_config;
>  	omap_board_config_size = ARRAY_SIZE(omap3pandora_config);
>  	omap_serial_init();
> +	spi_register_board_info(omap3pandora_spi_board_info,
> +			ARRAY_SIZE(omap3pandora_spi_board_info));
>  	hsmmc_init(mmc);
>  	usb_musb_init();
>  	usb_ehci_init();
>  	omap3pandora_flash_init();
> +	omap3pandora_ads7846_init();
>  }
>  
>  static void __init omap3pandora_map_io(void)
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
