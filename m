From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [RFC][PATCH] Add support for hook switch on ams-delta
Date: Tue, 2 Jun 2009 23:04:33 +0100
Message-ID: <20090602220433.GD31770@earth.li>
References: <200905262057.21890.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200905262057.21890.jkrzyszt@tis.icnet.pl>
Sender: linux-input-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 26, 2009 at 08:57:20PM +0200, Janusz Krzysztofik wrote:
> This trivial patch adds gpio-keys compatible platform device definition to 
> ams-delta board, that supports hook switch found on this videophone. It is 
> derived from similiar definitions found in other boards code. The patch is 
> based on linux-2.6.30-rc5. Any comments are welcome.

I'm obviously too late as I've seen the "Applied" mail, but some
comments:

* I don't think SW_HEADPHONE_INSERT is appropriate. input guys, is it
  not reasonable to have SW_PHONE_HOOK or similar? I can't find anything
  else in tree I know to be a VOIP phone that has the concept of a hook
  switch except perhaps the TuxScreen and it doesn't have anything set
  up that I could find. I think you're correct that EV_SW is
  appropriate; it may remain in the off-hook state for some time and
  AFAICT the gpio-key driver would produce a repeating key press if you
  used EV_KEY.

* We assume the bootloader does the appropriate GPIO pin setup for us,
  so I don't think your omap_cfg_reg is required but it doesn't hurt in
  the unlikely event we ever replace the Amstrad PBL.

* The commented out code to include the GPIO status in sysfs shouldn't
  be included. Does the input layer not provide a way to obtain the
  state of the switch?

> diff -Npru a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> --- a/arch/arm/mach-omap1/board-ams-delta.c	2009-05-17 17:58:18.000000000 +0200
> +++ b/arch/arm/mach-omap1/board-ams-delta.c	2009-05-17 16:22:59.000000000 +0200
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/input.h>
> +#include <linux/gpio_keys.h>
>  #include <linux/platform_device.h>
>  
>  #include <mach/hardware.h>
> @@ -213,10 +214,35 @@ static struct platform_device ams_delta_
>  	.id	= -1
>  };
>  
> +static struct gpio_keys_button ams_delta_gpio_keys_buttons[] = {
> +	[0] = {
> +		.desc		= "hook_switch",
> +		.type		= EV_SW,		/* or EV_KEY ? */
> +		.code		= SW_HEADPHONE_INSERT,	/* or a new one ? */
> +		.active_low	= 1,
> +		.gpio		= AMS_DELTA_GPIO_PIN_HOOK_SWITCH,
> +		.debounce_interval = 10,
> +	},
> +};
> +
> +static struct gpio_keys_platform_data ams_delta_gpio_keys = {
> +	.buttons		= ams_delta_gpio_keys_buttons,
> +	.nbuttons		= ARRAY_SIZE(ams_delta_gpio_keys_buttons),
> +};
> +
> +static struct platform_device ams_delta_gpio_keys_device = {
> +	.name			= "gpio-keys",
> +	.id			= -1,
> +	.dev			= {
> +		.platform_data	= &ams_delta_gpio_keys,
> +	},
> +};
> +
>  static struct platform_device *ams_delta_devices[] __initdata = {
>  	&ams_delta_kp_device,
>  	&ams_delta_lcd_device,
>  	&ams_delta_led_device,
> +	&ams_delta_gpio_keys_device,
>  };
>  
>  static void __init ams_delta_init(void)
> @@ -233,6 +259,13 @@ static void __init ams_delta_init_irq(vo
>  
>  	omap_usb_init(&ams_delta_usb_config);
>  	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
> +
> +	omap_cfg_reg(P20_1610_GPIO4); /* is this required? */
> +
> +	/* The hook switch state could be exposed over sysfs with gpio_export().
> +	 * This should be done after the gpio-keys driver calls gpio_request(),
> +	 * but I don't know how to do this from outside of the driver. */
> +	/* gpio_export(AMS_DELTA_GPIO_PIN_HOOK_SWITCH, 0); */
>  }
>  
>  static void __init ams_delta_map_io(void)


J.

-- 
Revd. Jonathan McDowell, ULC | I don't sleep, I dream.
