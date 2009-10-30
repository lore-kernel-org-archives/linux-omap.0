From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM OMAP3: RX-51 board: add initialization of gpio
	keys
Date: Fri, 30 Oct 2009 10:43:15 -0700
Message-ID: <20091030174314.GA7180@atomide.com>
References: <cover.1256907278.git.ext-jani.1.nikula@nokia.com> <859ce18ccdcfac80d2fafa73b6aef2fa5fd6feb6.1256907278.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54188 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932708AbZJ3RnN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 13:43:13 -0400
Content-Disposition: inline
In-Reply-To: <859ce18ccdcfac80d2fafa73b6aef2fa5fd6feb6.1256907278.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org, linux-input@vger.kernel.org

* Jani Nikula <ext-jani.1.nikula@nokia.com> [091030 06:38]:
> From: Jani Nikula <ext-jani.1.nikula@nokia.com>
> 
> Initialize some of the RX-51 input GPIO lines as gpio keys.
> 
> Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>

To me this looks like a nice way to deal with all the board
specific gpio buttons.

It also looks safe to merge via Dmitry once he's happy with it.

Hmm, should it be in board-rx51-peripherals.c instead?
Up to Jani to decide, just a thought.

Acked-by: Tony Lindgren <tony@atomide.com>

>  arch/arm/mach-omap2/board-rx51.c |   84 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 84 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index f1e7e5b..fe47790 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -16,6 +16,8 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/gpio.h>
> +#include <linux/input.h>
> +#include <linux/gpio_keys.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -30,6 +32,86 @@
>  #include <plat/gpmc.h>
>  #include <plat/usb.h>
>  
> +#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
> +
> +#define RX51_GPIO_CAMERA_LENSE_COVER	110
> +#define RX51_GPIO_CAMERA_FOCUS		68
> +#define RX51_GPIO_CAMERA_CAPTURE	69
> +#define RX51_GPIO_KEYPAD_SLIDE		71
> +#define RX51_GPIO_LOCK_BUTTON		113
> +#define RX51_GPIO_PROXIMITY		89
> +
> +#define RX51_GPIO_DEBOUNCE_TIMEOUT	10
> +
> +static struct gpio_keys_button rx51_gpio_keys[] = {
> +	{
> +		.desc			= "Camera Lense Cover",
> +		.type			= EV_SW,
> +		.code			= SW_CAMERA_LENSE_COVER,
> +		.gpio			= RX51_GPIO_CAMERA_LENSE_COVER,
> +		.active_low		= 1,
> +		.debounce_interval	= RX51_GPIO_DEBOUNCE_TIMEOUT,
> +	}, {
> +		.desc			= "Camera Focus",
> +		.type			= EV_KEY,
> +		.code			= KEY_CAMERA_FOCUS,
> +		.gpio			= RX51_GPIO_CAMERA_FOCUS,
> +		.active_low		= 1,
> +		.debounce_interval	= RX51_GPIO_DEBOUNCE_TIMEOUT,
> +	}, {
> +		.desc			= "Camera Capture",
> +		.type			= EV_KEY,
> +		.code			= KEY_CAMERA,
> +		.gpio			= RX51_GPIO_CAMERA_CAPTURE,
> +		.active_low		= 1,
> +		.debounce_interval	= RX51_GPIO_DEBOUNCE_TIMEOUT,
> +	}, {
> +		.desc			= "Lock Button",
> +		.type			= EV_KEY,
> +		.code			= KEY_SCREENLOCK,
> +		.gpio			= RX51_GPIO_LOCK_BUTTON,
> +		.active_low		= 1,
> +		.debounce_interval	= RX51_GPIO_DEBOUNCE_TIMEOUT,
> +	}, {
> +		.desc			= "Keypad Slide",
> +		.type			= EV_SW,
> +		.code			= SW_KEYPAD_SLIDE,
> +		.gpio			= RX51_GPIO_KEYPAD_SLIDE,
> +		.active_low		= 1,
> +		.debounce_interval	= RX51_GPIO_DEBOUNCE_TIMEOUT,
> +	}, {
> +		.desc			= "Proximity Sensor",
> +		.type			= EV_SW,
> +		.code			= SW_FRONT_PROXIMITY,
> +		.gpio			= RX51_GPIO_PROXIMITY,
> +		.active_low		= 0,
> +		.debounce_interval	= RX51_GPIO_DEBOUNCE_TIMEOUT,
> +	}
> +};
> +
> +static struct gpio_keys_platform_data rx51_gpio_keys_data = {
> +	.buttons	= rx51_gpio_keys,
> +	.nbuttons	= ARRAY_SIZE(rx51_gpio_keys),
> +};
> +
> +static struct platform_device rx51_gpio_keys_device = {
> +	.name	= "gpio-keys",
> +	.id	= -1,
> +	.dev	= {
> +		.platform_data	= &rx51_gpio_keys_data,
> +	},
> +};
> +
> +static void __init rx51_add_gpio_keys(void)
> +{
> +	platform_device_register(&rx51_gpio_keys_device);
> +}
> +#else
> +static void __init rx51_add_gpio_keys(void)
> +{
> +}
> +#endif
> +
>  static struct omap_lcd_config rx51_lcd_config = {
>  	.ctrl_name	= "internal",
>  };
> @@ -73,6 +155,8 @@ static void __init rx51_init(void)
>  	/* Ensure SDRC pins are mux'd for self-refresh */
>  	omap_cfg_reg(H16_34XX_SDRC_CKE0);
>  	omap_cfg_reg(H17_34XX_SDRC_CKE1);
> +
> +	rx51_add_gpio_keys();
>  }
>  
>  static void __init rx51_map_io(void)
> -- 
> 1.6.5.2
> 
