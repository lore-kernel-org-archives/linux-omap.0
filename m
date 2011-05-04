From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [PATCH 1/4] omap: consolidate touch screen initialization among
 different boards
Date: Wed, 04 May 2011 16:02:08 +0200
Message-ID: <4DC15C60.9060401@gmail.com>
References: <cover.1303682352.git.mike@compulab.co.il> <1738251a50b70224f124d4a54c157cc5e3c6db77.1303682352.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63923 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab1EDPDc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 11:03:32 -0400
Received: by bwz15 with SMTP id 15so1050777bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 04 May 2011 08:03:30 -0700 (PDT)
In-Reply-To: <1738251a50b70224f124d4a54c157cc5e3c6db77.1303682352.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

because ads7846_get_pendown_state() is not longer set in
ads7846_platform_data, the ads7846_setup_pendown tries to request the
pendown gpio and fails because the gpio is already requested.

Thomas

Am 25.04.2011 00:09, schrieb Mike Rapoport:
> Add common-board-devices.c that will contain the code for peripheral
> devices initializatoin shared between multiple boards.
> Start small with touchscreen initialization.
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  arch/arm/mach-omap2/Makefile               |    2 +
>  arch/arm/mach-omap2/board-3430sdp.c        |   65 ++-------------------
>  arch/arm/mach-omap2/board-cm-t35.c         |   58 +------------------
>  arch/arm/mach-omap2/board-devkit8000.c     |   56 +------------------
>  arch/arm/mach-omap2/board-ldp.c            |   57 +------------------
>  arch/arm/mach-omap2/board-omap3evm.c       |   51 +----------------
>  arch/arm/mach-omap2/board-omap3pandora.c   |   49 +---------------
>  arch/arm/mach-omap2/board-omap3stalker.c   |   49 +---------------
>  arch/arm/mach-omap2/board-omap3touchbook.c |   36 +-----------
>  arch/arm/mach-omap2/board-overo.c          |   46 +--------------
>  arch/arm/mach-omap2/common-board-devices.c |   85 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/common-board-devices.h |   18 ++++++
>  12 files changed, 128 insertions(+), 444 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/common-board-devices.c
>  create mode 100644 arch/arm/mach-omap2/common-board-devices.h
>...


> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
> index 65f9fde..9f8338d 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -51,7 +51,6 @@
>  #include <plat/mcspi.h>
>  #include <linux/input/matrix_keypad.h>
>  #include <linux/spi/spi.h>
> -#include <linux/spi/ads7846.h>
>  #include <linux/dm9000.h>
>  #include <linux/interrupt.h>
>  
> @@ -60,6 +59,7 @@
>  #include "mux.h"
>  #include "hsmmc.h"
>  #include "timer-gp.h"
> +#include "common-board-devices.h"
>  
>  #define NAND_BLOCK_SIZE		SZ_128K
>  
> @@ -463,56 +463,6 @@ static void __init devkit8000_init_irq(void)
>  #endif
>  }
>  
> -static void __init devkit8000_ads7846_init(void)
> -{
> -	int gpio = OMAP3_DEVKIT_TS_GPIO;
> -	int ret;
> -
> -	ret = gpio_request(gpio, "ads7846_pen_down");
> -	if (ret < 0) {
> -		printk(KERN_ERR "Failed to request GPIO %d for "
> -				"ads7846 pen down IRQ\n", gpio);
> -		return;
> -	}
> -
> -	gpio_direction_input(gpio);
> -}
> -
> -static int ads7846_get_pendown_state(void)
> -{
> -	return !gpio_get_value(OMAP3_DEVKIT_TS_GPIO);
> -}
> -
> -static struct ads7846_platform_data ads7846_config = {
> -	.x_max                  = 0x0fff,
> -	.y_max                  = 0x0fff,
> -	.x_plate_ohms           = 180,
> -	.pressure_max           = 255,
> -	.debounce_max           = 10,
> -	.debounce_tol           = 5,
> -	.debounce_rep           = 1,
> -	.get_pendown_state	= ads7846_get_pendown_state,
> -	.keep_vref_on		= 1,
> -	.settle_delay_usecs     = 150,
> -};
> -
> -static struct omap2_mcspi_device_config ads7846_mcspi_config = {
> -	.turbo_mode	= 0,
> -	.single_channel	= 1,	/* 0: slave, 1: master */
> -};
> -
> -static struct spi_board_info devkit8000_spi_board_info[] __initdata = {
> -	{
> -		.modalias		= "ads7846",
> -		.bus_num		= 2,
> -		.chip_select		= 0,
> -		.max_speed_hz		= 1500000,
> -		.controller_data	= &ads7846_mcspi_config,
> -		.irq			= OMAP_GPIO_IRQ(OMAP3_DEVKIT_TS_GPIO),
> -		.platform_data		= &ads7846_config,
> -	}
> -};
> -
>  #define OMAP_DM9000_BASE	0x2c000000
>  
>  static struct resource omap_dm9000_resources[] = {
> @@ -795,10 +745,8 @@ static void __init devkit8000_init(void)
>  			ARRAY_SIZE(devkit8000_devices));
>  
>  	omap_display_init(&devkit8000_dss_data);
> -	spi_register_board_info(devkit8000_spi_board_info,
> -	ARRAY_SIZE(devkit8000_spi_board_info));
>  
> -	devkit8000_ads7846_init();
> +	omap_ads7846_init(2, OMAP3_DEVKIT_TS_GPIO, 0, NULL);
>  
>  	usb_musb_init(&musb_board_data);
>  	usbhs_init(&usbhs_bdata);
...
> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
> new file mode 100644
> index 0000000..fad41ec
> --- /dev/null
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -0,0 +1,85 @@
> +/*
> + * common-board-devices.c
> + *
> + * Copyright (C) 2011 CompuLab, Ltd.
> + * Author: Mike Rapoport <mike@compulab.co.il>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/gpio.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/ads7846.h>
> +
> +#include <plat/mcspi.h>
> +
> +#include "common-board-devices.h"
> +
> +static struct omap2_mcspi_device_config ads7846_mcspi_config = {
> +	.turbo_mode	= 0,
> +	.single_channel	= 1,	/* 0: slave, 1: master */
> +};
> +
> +static struct ads7846_platform_data ads7846_config = {
> +	.x_max			= 0x0fff,
> +	.y_max			= 0x0fff,
> +	.x_plate_ohms		= 180,
> +	.pressure_max		= 255,
> +	.debounce_max		= 10,
> +	.debounce_tol		= 3,
> +	.debounce_rep		= 1,
> +	.gpio_pendown		= -EINVAL,
> +	.keep_vref_on		= 1,
> +};
> +
> +static struct spi_board_info ads7846_spi_board_info __initdata = {
> +	.modalias		= "ads7846",
> +	.bus_num		= -EINVAL,
> +	.chip_select		= 0,
> +	.max_speed_hz		= 1500000,
> +	.controller_data	= &ads7846_mcspi_config,
> +	.irq			= -EINVAL,
> +	.platform_data		= &ads7846_config,
> +};
> +
> +void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
> +			      struct ads7846_platform_data *board_pdata)
> +{
> +	struct spi_board_info *spi_bi = &ads7846_spi_board_info;
> +	int err;
> +
> +	err = gpio_request(gpio_pendown, "TS PenDown");
> +	if (err) {
> +		pr_err("Could not obtain gpio for TS PenDown: %d\n", err);
> +		return;
> +	}
> +
> +	gpio_direction_input(gpio_pendown);
> +	gpio_export(gpio_pendown, 0);
> +
> +	if (gpio_debounce)
> +		gpio_set_debounce(gpio_pendown, gpio_debounce);
> +
> +	ads7846_config.gpio_pendown = gpio_pendown;
> +
> +	spi_bi->bus_num	= bus_num;
> +	spi_bi->irq	= OMAP_GPIO_IRQ(gpio_pendown);
> +
> +	if (board_pdata)
> +		spi_bi->platform_data = board_pdata;
> +
> +	spi_register_board_info(&ads7846_spi_board_info, 1);
> +}
> diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
> new file mode 100644
> index 0000000..75f9248d
> --- /dev/null
> +++ b/arch/arm/mach-omap2/common-board-devices.h
> @@ -0,0 +1,18 @@
> +#ifndef __OMAP_COMMON_BOARD_DEVICES__
> +#define __OMAP_COMMON_BOARD_DEVICES__
> +
> +#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
> +	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
> +struct ads7846_platform_data;
> +
> +void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
> +		       struct ads7846_platform_data *board_pdata);
> +#else
> +static inline void omap_ads7846_init(int bus_num,
> +				     int gpio_pendown, int gpio_debounce,
> +				     struct ads7846_platform_data *board_data)
> +{
> +}
> +#endif
> +
> +#endif /* __OMAP_COMMON_BOARD_DEVICES__ */

