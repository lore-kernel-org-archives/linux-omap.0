From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: Audio support via omap-twl4030 and pwm
 support
Date: Tue, 5 Feb 2013 10:46:21 +0100
Message-ID: <5110D4ED.6030306@ti.com>
References: <50FE64DC.2030808@ti.com> <510788B9.9050907@ti.com> <20130130220532.GA22517@atomide.com> <20130204195251.GS22517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38052 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844Ab3BEJqZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 04:46:25 -0500
In-Reply-To: <20130204195251.GS22517@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On 02/04/2013 08:52 PM, Tony Lindgren wrote:
> Looks like this now adds some new section warnings:
>=20
> WARNING: vmlinux.o(.text+0x34124): Section mismatch in reference from=
 the function sdp3430_twl_gpio_setup() to the function .init.text:omap_=
twl4030_audio_init()
> The function sdp3430_twl_gpio_setup() references
> the function __init omap_twl4030_audio_init().
> This is often because sdp3430_twl_gpio_setup lacks a __init=20
> annotation or the annotation of omap_twl4030_audio_init is wrong.
>=20
> WARNING: vmlinux.o(.text+0x34b8c): Section mismatch in reference from=
 the function zoom_twl_gpio_setup() to the function .init.text:omap_twl=
4030_audio_init()
> The function zoom_twl_gpio_setup() references
> the function __init omap_twl4030_audio_init().
> This is often because zoom_twl_gpio_setup lacks a __init=20
> annotation or the annotation of omap_twl4030_audio_init is wrong.

=46or some reason the CONFIG_DEBUG_SECTION_MISMATCH got disabled in my =
rolling
kernel config...


> These can be fixed with the following patch, but I suspect some
> of these cannot be __init/__initdata if the driver reprobes.
>=20
> Can you please check this? I'll hold on sendinf off
> this branch until it's been checked and fixed properly.

I think this is not the correct way. the *_twl_gpio_setup() is called f=
rom the
gpio-twl4030 driver's platform_driver probe function which if I'm not m=
istaken
is not __init.

I think we should remove the __init from the omap_twl4030_audio_init() =
in
twl-common.c
With this change I do not have section mismatch either.

--=20
P=E9ter

>=20
> Regards,
>=20
> Tony
>=20
>=20
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -223,7 +223,7 @@ static struct omap_tw4030_pdata omap_twl4030_audi=
o_data =3D {
>  	.has_linein	=3D OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
>  };
> =20
> -static int sdp3430_twl_gpio_setup(struct device *dev,
> +static int __init sdp3430_twl_gpio_setup(struct device *dev,
>  		unsigned gpio, unsigned ngpio)
>  {
>  	/* gpio + 0 is "mmc0_cd" (input/IRQ),
> @@ -245,7 +245,7 @@ static int sdp3430_twl_gpio_setup(struct device *=
dev,
>  	return 0;
>  }
> =20
> -static struct twl4030_gpio_platform_data sdp3430_gpio_data =3D {
> +static struct twl4030_gpio_platform_data __initdata sdp3430_gpio_dat=
a =3D {
>  	.pulldowns	=3D BIT(2) | BIT(6) | BIT(8) | BIT(13)
>  				| BIT(16) | BIT(17),
>  	.setup		=3D sdp3430_twl_gpio_setup,
> @@ -374,7 +374,7 @@ static struct regulator_init_data sdp3430_vsim =3D=
 {
>  	.consumer_supplies	=3D sdp3430_vsim_supplies,
>  };
> =20
> -static struct twl4030_platform_data sdp3430_twldata =3D {
> +static struct twl4030_platform_data __initdata sdp3430_twldata =3D {
>  	/* platform_data for children goes here */
>  	.gpio		=3D &sdp3430_gpio_data,
>  	.keypad		=3D &sdp3430_kp_data,
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -238,7 +238,7 @@ static struct omap_tw4030_pdata omap_twl4030_audi=
o_data =3D {
>  	.has_linein	=3D OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
>  };
> =20
> -static int zoom_twl_gpio_setup(struct device *dev,
> +static int __init zoom_twl_gpio_setup(struct device *dev,
>  		unsigned gpio, unsigned ngpio)
>  {
>  	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> @@ -252,11 +252,11 @@ static int zoom_twl_gpio_setup(struct device *d=
ev,
>  	return 0;
>  }
> =20
> -static struct twl4030_gpio_platform_data zoom_gpio_data =3D {
> +static struct twl4030_gpio_platform_data __initdata zoom_gpio_data =3D=
 {
>  	.setup		=3D zoom_twl_gpio_setup,
>  };
> =20
> -static struct twl4030_platform_data zoom_twldata =3D {
> +static struct twl4030_platform_data __initdata zoom_twldata =3D {
>  	/* platform_data for children goes here */
>  	.gpio		=3D &zoom_gpio_data,
>  	.keypad		=3D &zoom_kp_twl4030_data,
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
