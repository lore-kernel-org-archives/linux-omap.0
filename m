From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH/RFC] ARM: Add ADS7846 touchscreen support to Overo
	platform
Date: Fri, 20 Feb 2009 12:43:41 -0800
Message-ID: <20090220204340.GD7414@atomide.com>
References: <5e088bd90902012242q2bc7a272p244a02e9b54002ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52126 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbZBTUno (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 15:43:44 -0500
Content-Disposition: inline
In-Reply-To: <5e088bd90902012242q2bc7a272p244a02e9b54002ec@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Steve Sakoman <sakoman@gmail.com> [090201 22:42]:
> An upcoming Overo expansion board includes an ADS7846 touchscreen controller.
> 
> This patch adds support via the ads7846 driver when enabled in the
> kernel config.

Adding this also to omap3-upstream and linux-omap.

Tony

> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  arch/arm/mach-omap2/board-overo.c             |   61 +++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/board-overo.h |    1 +
>  2 files changed, 62 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-overo.c
> b/arch/arm/mach-omap2/board-overo.c
> index 032a2c9..2521b21 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -116,6 +116,66 @@ static inline void __init overo_init_smsc911x(void)
>  static inline void __init overo_init_smsc911x(void) { return; }
>  #endif
> 
> +#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
> +	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
> +
> +#include <mach/mcspi.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/ads7846.h>
> +
> +static struct omap2_mcspi_device_config ads7846_mcspi_config = {
> +	.turbo_mode	= 0,
> +	.single_channel	= 1,	/* 0: slave, 1: master */
> +};
> +
> +
> +static int ads7846_get_pendown_state(void)
> +{
> +	return !gpio_get_value(OVERO_GPIO_PENDOWN);
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
> +static struct spi_board_info overo_spi_board_info[] __initdata = {
> +	{
> +		.modalias		= "ads7846",
> +		.bus_num		= 1,
> +		.chip_select		= 0,
> +		.max_speed_hz		= 1500000,
> +		.controller_data	= &ads7846_mcspi_config,
> +		.irq			= OMAP_GPIO_IRQ(OVERO_GPIO_PENDOWN),
> +		.platform_data		= &ads7846_config,
> +	}
> +};
> +
> +static void __init overo_ads7846_init(void)
> +{
> +	if ((gpio_request(OVERO_GPIO_PENDOWN, "ADS7846_PENDOWN") == 0) &&
> +	    (gpio_direction_input(OVERO_GPIO_PENDOWN) == 0)) {
> +		gpio_export(OVERO_GPIO_PENDOWN, 0);
> +	} else {
> +		printk(KERN_ERR "could not obtain gpio for ADS7846_PENDOWN\n");
> +		return;
> +	}
> +
> +	spi_register_board_info(overo_spi_board_info,
> +			ARRAY_SIZE(overo_spi_board_info));
> +}
> +
> +#else
> +static inline void __init overo_ads7846_init(void) { return; }
> +#endif
> +
>  static struct mtd_partition overo_nand_partitions[] = {
>  	{
>  		.name           = "xloader",
> @@ -296,6 +356,7 @@ static void __init overo_init(void)
>  	usb_ehci_init();
>  	overo_flash_init();
>  	overo_init_smsc911x();
> +	overo_ads7846_init();
> 
>  	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
>  			  "OVERO_GPIO_W2W_NRESET") == 0) &&
> diff --git a/arch/arm/plat-omap/include/mach/board-overo.h
> b/arch/arm/plat-omap/include/mach/board-overo.h
> index 8635171..aca717d 100644
> --- a/arch/arm/plat-omap/include/mach/board-overo.h
> +++ b/arch/arm/plat-omap/include/mach/board-overo.h
> @@ -18,6 +18,7 @@
> 
>  #define OVERO_GPIO_BT_XGATE	15
>  #define OVERO_GPIO_W2W_NRESET	16
> +#define OVERO_GPIO_PENDOWN	114
>  #define OVERO_GPIO_BT_NRESET	164
>  #define OVERO_GPIO_USBH_CPEN	168
>  #define OVERO_GPIO_USBH_NRESET	183
> -- 
> 1.5.6.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
