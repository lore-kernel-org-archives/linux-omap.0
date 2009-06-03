From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][PATCH] Add support for hook switch on ams-delta
Date: Wed, 3 Jun 2009 11:03:20 +0200
Message-ID: <200906031103.21758.jkrzyszt@tis.icnet.pl>
References: <200905262057.21890.jkrzyszt@tis.icnet.pl> <20090602220433.GD31770@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:42542 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755516AbZFCJDr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 05:03:47 -0400
In-Reply-To: <20090602220433.GD31770@earth.li>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org

Hi Jonathan,

Wednesday 03 June 2009 00:04:33 Jonathan McDowell napisa=C5=82(a):
> I'm obviously too late as I've seen the "Applied" mail,

No problem, I'm glad to hear from you.

> but some=20
> comments:
>
> * I don't think SW_HEADPHONE_INSERT is appropriate. input guys, is it=
=20
>   not reasonable to have SW_PHONE_HOOK or similar?

I do share you point of view. However, I didn't want to start a discuss=
ion if=20
there is a need for another symbol or not before the patch got any=20
acceptance.

> * We assume the bootloader does the appropriate GPIO pin setup for us=
,
>   so I don't think your omap_cfg_reg is required but it doesn't hurt =
in
>   the unlikely event we ever replace the Amstrad PBL.

OK, let it stay there. Do you see a need for replaceing it with a new=20
ams_delta_hook_switch_init() function call that just calls omap_cfg_reg=
()?

> * The commented out code to include the GPIO status in sysfs shouldn'=
t
>   be included.

Yes, I put it there to get a feedback.

>   Does the input layer not provide a way to obtain the=20
>   state of the switch?

Yes, it does, with EVIOCGSW ioctl()[1]. I personally don't like this wa=
y of=20
getting the switch status and would rather see it available over sysfs.=
=20
However, input guys may have their own preferences and gpio-keys driver=
=20
belongs to them.

Thanks,
Janusz

[1] http://www.spinics.net/lists/linux-input/msg03482.html

P.S. I include my Signed-off-by, as Tony have requested, to avoid the c=
ode=20
without one floating around.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

> > diff -Npru a/arch/arm/mach-omap1/board-ams-delta.c
> > b/arch/arm/mach-omap1/board-ams-delta.c ---
> > a/arch/arm/mach-omap1/board-ams-delta.c	2009-05-17 17:58:18.0000000=
00
> > +0200 +++ b/arch/arm/mach-omap1/board-ams-delta.c	2009-05-17
> > 16:22:59.000000000 +0200 @@ -15,6 +15,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> >  #include <linux/input.h>
> > +#include <linux/gpio_keys.h>
> >  #include <linux/platform_device.h>
> >
> >  #include <mach/hardware.h>
> > @@ -213,10 +214,35 @@ static struct platform_device ams_delta_
> >  	.id	=3D -1
> >  };
> >
> > +static struct gpio_keys_button ams_delta_gpio_keys_buttons[] =3D {
> > +	[0] =3D {
> > +		.desc		=3D "hook_switch",
> > +		.type		=3D EV_SW,		/* or EV_KEY ? */
> > +		.code		=3D SW_HEADPHONE_INSERT,	/* or a new one ? */
> > +		.active_low	=3D 1,
> > +		.gpio		=3D AMS_DELTA_GPIO_PIN_HOOK_SWITCH,
> > +		.debounce_interval =3D 10,
> > +	},
> > +};
> > +
> > +static struct gpio_keys_platform_data ams_delta_gpio_keys =3D {
> > +	.buttons		=3D ams_delta_gpio_keys_buttons,
> > +	.nbuttons		=3D ARRAY_SIZE(ams_delta_gpio_keys_buttons),
> > +};
> > +
> > +static struct platform_device ams_delta_gpio_keys_device =3D {
> > +	.name			=3D "gpio-keys",
> > +	.id			=3D -1,
> > +	.dev			=3D {
> > +		.platform_data	=3D &ams_delta_gpio_keys,
> > +	},
> > +};
> > +
> >  static struct platform_device *ams_delta_devices[] __initdata =3D =
{
> >  	&ams_delta_kp_device,
> >  	&ams_delta_lcd_device,
> >  	&ams_delta_led_device,
> > +	&ams_delta_gpio_keys_device,
> >  };
> >
> >  static void __init ams_delta_init(void)
> > @@ -233,6 +259,13 @@ static void __init ams_delta_init_irq(vo
> >
> >  	omap_usb_init(&ams_delta_usb_config);
> >  	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devi=
ces));
> > +
> > +	omap_cfg_reg(P20_1610_GPIO4); /* is this required? */
> > +
> > +	/* The hook switch state could be exposed over sysfs with
> > gpio_export(). +	 * This should be done after the gpio-keys driver =
calls
> > gpio_request(), +	 * but I don't know how to do this from outside o=
f the
> > driver. */ +	/* gpio_export(AMS_DELTA_GPIO_PIN_HOOK_SWITCH, 0); */
> >  }
> >
> >  static void __init ams_delta_map_io(void)
>
> J.


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
