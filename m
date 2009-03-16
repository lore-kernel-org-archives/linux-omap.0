From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/4] ARM: OMAP3: Add ADS7846 touchscreen support to
	Overo platform, v2
Date: Mon, 16 Mar 2009 23:57:26 +0200
Message-ID: <20090316215726.GA31250@gandalf>
References: <20090313224259.8810.3283.stgit@localhost> <20090313224610.8810.93492.stgit@localhost> <20090316203855.GM19229@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59600 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757087AbZCPV5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 17:57:34 -0400
Content-Disposition: inline
In-Reply-To: <20090316203855.GM19229@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

On Mon, Mar 16, 2009 at 01:38:55PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [090313 15:46]:
> > From: Steve Sakoman <sakoman@gmail.com>
> > 
> > An upcoming Overo expansion board includes an ADS7846 touchscreen controller.
> > 
> > This patch adds support via the ads7846 driver when enabled in the
> > kernel config.
> 
> Here's this one refreshed to apply without the smsc911x patch.
> 
> Tony

> From b4b560d6323bd56a7c450b81263d09464d8c6e36 Mon Sep 17 00:00:00 2001
> From: Steve Sakoman <sakoman@gmail.com>
> Date: Mon, 16 Mar 2009 13:28:00 -0700
> Subject: [PATCH] ARM: OMAP3: Add ADS7846 touchscreen support to Overo platform, v2
> 
> An upcoming Overo expansion board includes an ADS7846 touchscreen controller.
> 
> This patch adds support via the ads7846 driver when enabled in the
> kernel config.
> 
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index d785aa8..4d03b70 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -52,6 +52,66 @@
>  #define GPMC_CS0_BASE  0x60
>  #define GPMC_CS_SIZE   0x30
>  
> +#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
> +	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)

I'm wondering if this is really necessary since ...

> +#include <mach/mcspi.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/ads7846.h>
> +
> +static struct omap2_mcspi_device_config ads7846_mcspi_config = {

__initdata ??

> +	.turbo_mode	= 0,
> +	.single_channel	= 1,	/* 0: slave, 1: master */
> +};
> +
> +

one blank line enough ?

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

... this is initdata, meaning that this region will be freed anyways after
__init even if the driver doesn't probe. So I guess we could remove the
ifdeferry and mark the other ads7846-related stuff as either __init or
__initdata.

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

-- 
balbi
