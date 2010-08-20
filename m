From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [RFC  PATCH] Board support for the the GPIO keys
Date: Fri, 20 Aug 2010 13:44:33 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B39A36E2@dbde02.ent.ti.com>
References: <1282218130-17111-1-git-send-email-shubhrajyoti@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C67AE9EE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44939 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674Ab0HTIOj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 04:14:39 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C67AE9EE@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Charu,
Agree to your comments.
Will fix them.

> -----Original Message-----
> From: Varadarajan, Charulatha
> Sent: Friday, August 20, 2010 12:13 PM
> To: Datta, Shubhrajyoti; linux-omap@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Subject: RE: [RFC PATCH] Board support for the the GPIO keys
> 
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Datta,
> > Shubhrajyoti
> > Sent: Thursday, August 19, 2010 5:12 PM
> > To: linux-omap@vger.kernel.org
> > Cc: linux-input@vger.kernel.org; Datta, Shubhrajyoti
> > Subject: [RFC PATCH] Board support for the the GPIO keys
> >
> > Board support for the GPIO keys.
> > The proximity sensor is connected to GPIO and is registered as a
> > GPIO key.
> >
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-4430sdp.c |   56
> > +++++++++++++++++++++++++++++++++++
> >  1 files changed, 56 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c
> > b/arch/arm/mach-omap2/board-4430sdp.c
> > index 9447644..7f619bf 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/usb/otg.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/i2c/twl.h>
> > +#include <linux/gpio_keys.h>
> >  #include <linux/regulator/machine.h>
> >  #include <linux/leds.h>
> >
> > @@ -40,6 +41,10 @@
> >  #define ETH_KS8851_IRQ			34
> >  #define ETH_KS8851_POWER_ON		48
> >  #define ETH_KS8851_QUART		138
> > +#define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
> > +#define OMAP4_SFH7741_ENABLE_GPIO		188
> 
> Insert a new line.
> 
> > +static int omap_prox_activate(struct device *dev);
> > +static void omap_prox_deactivate(struct device *dev);
> >
> >  static struct gpio_led sdp4430_gpio_leds[] = {
> >  	{
> > @@ -76,11 +81,33 @@ static struct gpio_led sdp4430_gpio_leds[] = {
> >  	},
> >
> >  };
> > +static struct gpio_keys_button sdp4430_gpio_keys[] = {
> > +	{
> > +		.desc			= "Proximity Sensor",
> > +		.type			= EV_SW,
> > +		.code			= SW_FRONT_PROXIMITY,
> > +		.gpio			=
> > OMAP4_SFH7741_SENSOR_OUTPUT_GPIO,
> > +		.active_low		= 0,
> > +	}
> > +};
> >
> >  static struct gpio_led_platform_data sdp4430_led_data = {
> >  	.leds	= sdp4430_gpio_leds,
> >  	.num_leds	= ARRAY_SIZE(sdp4430_gpio_leds),
> >  };
> 
> Insert a new line.
> 
> > +static struct gpio_keys_platform_data sdp4430_gpio_keys_data = {
> > +	.buttons	= sdp4430_gpio_keys,
> > +	.nbuttons	= ARRAY_SIZE(sdp4430_gpio_keys),
> > +	.enable		= omap_prox_activate,
> > +	.disable	= omap_prox_deactivate,
> > +};
> 
> Insert a new line.
> 
> > +static struct platform_device sdp4430_gpio_keys_device = {
> > +	.name	= "gpio-keys",
> > +	.id	= -1,
> > +	.dev	= {
> > +		.platform_data	= &sdp4430_gpio_keys_data,
> > +	},
> > +};
> >
> >  static struct platform_device sdp4430_leds_gpio = {
> >  	.name	= "leds-gpio",
> > @@ -161,6 +188,7 @@ static struct platform_device
> > sdp4430_lcd_device = {
> >
> >  static struct platform_device *sdp4430_devices[] __initdata = {
> >  	&sdp4430_lcd_device,
> > +	&sdp4430_gpio_keys_device,
> >  	&sdp4430_leds_gpio,
> >  };
> >
> > @@ -426,6 +454,33 @@ static int __init omap4_i2c_init(void)
> >  	omap_register_i2c_bus(4, 400, NULL, 0);
> >  	return 0;
> >  }
> 
> Insert a new line.
> 
> > +static int  omap_prox_activate(struct device *dev)
> > +{
> > +	gpio_set_value(OMAP4_SFH7741_ENABLE_GPIO , 1);
> > +	return 0;
> > +}
> 
> Insert a new line.
> 
> > +static void omap_prox_deactivate(struct device *dev)
> > +{
> > +	gpio_set_value(OMAP4_SFH7741_ENABLE_GPIO , 0);
> > +}
> 
> Insert a new line.
> 
> > +static void omap_sfh7741prox_init(void)
> > +{
> > +	int  error;
> > +
> > +	error = gpio_request(OMAP4_SFH7741_ENABLE_GPIO, "sfh7741");
> > +	if (error < 0) {
> > +		pr_err("failed to request GPIO %d, error %d\n",
> > +			OMAP4_SFH7741_ENABLE_GPIO, error);
> > +		return;
> > +	}
> > +
> > +	error = gpio_direction_output(OMAP4_SFH7741_ENABLE_GPIO , 1);
> > +	if (error < 0) {
> > +		pr_err("%s: GPIO configuration failed: GPIO
> > %d,error %d\n",\
> > +			 __func__, OMAP4_SFH7741_ENABLE_GPIO, error);
> > +		gpio_free(OMAP4_SFH7741_ENABLE_GPIO);
> > +	}
> > +}
> 
> Insert a new line.
> 
> >  static void __init omap_4430sdp_init(void)
> >  {
> >  	int status;
> > @@ -448,6 +503,7 @@ static void __init omap_4430sdp_init(void)
> >  		spi_register_board_info(sdp4430_spi_board_info,
> >  				ARRAY_SIZE(sdp4430_spi_board_info));
> >  	}
> > +	omap_sfh7741prox_init();
> >  }
> >
> >  static void __init omap_4430sdp_map_io(void)
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
