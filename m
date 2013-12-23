From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Mon, 23 Dec 2013 09:53:45 +0200
Message-ID: <52B7EC09.8080206@ti.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk> <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com> <20131219175644.GE32243@n2100.arm.linux.org.uk> <20131219182252.GP27438@atomide.com> <20131220112700.GF32243@n2100.arm.linux.org.uk> <20131220114837.GH32243@n2100.arm.linux.org.uk> <52B44982.4020501@ti.com> <20131220160432.GZ27438@atomide.com> <20131220165456.GD27438@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="LvIA6uSmMSLxNq0wVneD2Vpc9xrIOmGqN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59284 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab3LWHyM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Dec 2013 02:54:12 -0500
In-Reply-To: <20131220165456.GD27438@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--LvIA6uSmMSLxNq0wVneD2Vpc9xrIOmGqN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-20 18:55, Tony Lindgren wrote:

>> I bet that's it though. If the display is probed before twl4030 GPIO
>> is initialized, the GPIO numbers will be 0. I'm using omap2plus_defcon=
fig
>> which has DSS built as modules.
>=20
> Yeah this seems to do the trick for me for the built-in DSS on LDP.
>=20
> Tony
>=20
> 8< -----------------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 20 Dec 2013 08:53:27 -0800
> Subject: [PATCH] ARM: OMAP2+: Fix LCD panel backlight regression for LD=
P legacy booting
>=20
> Looks like the LCD panel on LDP has been broken quite a while, and
> recently got fixed. However, there's still an issue where the panel
> backlight does not come on if the LCD drivers are built into the
> kernel.
>=20
> Fix the issue by registering the DPI LCD panel only after the twl4030
> GPIO has probed.
>=20
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -248,7 +248,7 @@ static int ldp_twl_gpio_setup(struct device *dev, u=
nsigned gpio, unsigned ngpio)
>  	/* Backlight enable GPIO */
>  	ldp_lcd_pdata.backlight_gpio =3D gpio + 15;
> =20
> -	return 0;
> +	return platform_device_register(&ldp_lcd_device);

If the panel device registration fails, does the whole TWL probe fail?
If so, that sounds a bit harsh to me.

>  }
> =20
>  static struct twl4030_gpio_platform_data ldp_gpio_data =3D {
> @@ -346,7 +346,6 @@ static struct omap2_hsmmc_info mmc[] __initdata =3D=
 {
> =20
>  static struct platform_device *ldp_devices[] __initdata =3D {
>  	&ldp_gpio_keys_device,
> -	&ldp_lcd_device,
>  };
> =20
>  #ifdef CONFIG_OMAP_MUX
>=20

Looks right to me:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Rather ugly, though, but there's probably no point in trying to do it in
a cleaner way (the new GPIO API, I think?), as we'll move to DT soon.

 Tomi



--LvIA6uSmMSLxNq0wVneD2Vpc9xrIOmGqN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSt+wJAAoJEPo9qoy8lh71WHwP/i7fJbeO6TGS9If8pc0BCgyY
Qxk4etKguSoxKtu+L7Pd41TJ5N7Q6xw7RLQRhLyH0hi/lqu6GQ+4L7/W6lChME+2
yRjjlAeB4Vt1pxvuDZpNnkmpTAr7zqPMIn7IoSzy3NQDpt31QaguvNsRH3yo2CB1
dA9xvmrWkKQH/NoPMngds4bkMiH9lDAUJpwJQx87KtcPyliPkgJ5wHABlh5rzLuk
2QIk8agu9FaoDa/iu9V1NB074eoG892zFu6X32rYmIWl2NqWUFsJAEBvA6CPzFx6
WvaAX3+CpjsUO3x5HX2/a+7sNdu7UB5BsBrJDkcWZIP0YjvjEPg8/dpmVK0b+e6K
vbIM0YbSa569s19e0GlJrOTdn8vmGiVsdzEorE6ZkhpJfYrlbga1FO8QlSpfQeVy
rFzmQW/uqLJ0VzcFR4LJt9tLedr3C3yXrGG+yB5ibcjhvTr4cDbI1qc0BDqnaG4n
Xb/mqeYoDn6dIcJ35Z/1foXRSCvsHL0khf0J/wlrNRtNJgEACcUy4ijalvfBzbYn
ZKAF9Fj4hXuaO3h8WaAwGZNnGdPYTwt/XPlWU+tidslLbASrV13ibM7aas0UEHC9
GhMDrtfKyb7f22g6l4lN06Q8hC1IAtnbN0yDc+/pP0wXPjNiLrnJ4Euw2LsDvfOD
c0trlOBQAs8moLOU/oeP
=abEs
-----END PGP SIGNATURE-----

--LvIA6uSmMSLxNq0wVneD2Vpc9xrIOmGqN--
