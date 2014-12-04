From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap2: rx51-peripherals: fix build warning
Date: Thu, 4 Dec 2014 09:24:11 -0600
Message-ID: <20141204152411.GF18045@saruman>
References: <1417033655-32332-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43673 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932375AbaLDPYx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2014 10:24:53 -0500
Content-Disposition: inline
In-Reply-To: <1417033655-32332-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Sebastian Reichel <sre@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>

--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2014 at 02:27:35PM -0600, Felipe Balbi wrote:
> commit 68a3c04 ([media] ARM: OMAP2: RX-51: update
> si4713 platform data) updated board-rx51-peripherals.c
> so that si4713 could be easily used on DT boot, but
> it ended up introducing a build warning whenever
> si4713 isn't enabled.
>=20
> This patches fixes that warning:
>=20
> arch/arm/mach-omap2/board-rx51-peripherals.c:1000:36: warning: \
> 	=E2=80=98rx51_si4713_platform_data=E2=80=99 defined but not used [-Wunus=
ed-variable]
>  static struct si4713_platform_data rx51_si4713_platform_data =3D {
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

a gentle reminder on this one.

> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach=
-omap2/board-rx51-peripherals.c
> index d18a5cf..bda20c5 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -997,9 +997,11 @@ static struct aic3x_pdata rx51_aic3x_data2 =3D {
>  	.gpio_reset =3D 60,
>  };
> =20
> +#if IS_ENABLED(CONFIG_I2C_SI4713) && IS_ENABLED(CONFIG_PLATFORM_SI4713)
>  static struct si4713_platform_data rx51_si4713_platform_data =3D {
>  	.is_platform_device =3D true
>  };
> +#endif
> =20
>  static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_=
2[] =3D {
>  #if IS_ENABLED(CONFIG_I2C_SI4713) && IS_ENABLED(CONFIG_PLATFORM_SI4713)
> --=20
> 2.1.0.GIT
>=20

--=20
balbi

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgHybAAoJEIaOsuA1yqREvnEP/i4kMZcxkkyDNVWY4d0cjNO9
NUieVe/n3Cu79sKTNtdoWEp2Pe/gJjaayjJI6RY98KdemyLoqjFNBEXy9CJ6bJPW
XGrF4YfJH+gVqwnAv7lZNU6jT5Rlqzd29T8NT6NeYQ6M/jGswQtrxaMQM9wzkter
e+suA6C0nqh5KUh8TtWhC7dZ97ezV5XNIetuj4sagMtAYcojo1gPP1FOazre2TfW
ShZdSk9wX+pmqpUgZOF3tkMPzw4L/RvJEn8BojC07w44rMmY+21OEl5Ofc5vWBnV
CDquijXyBO9aSRaO9/WYePsKY00U/UHOQ9BQsG0zWqrG5aRVM4CYc8udJERa/Ap7
vdoqZ9MP6ToKFyNKYDfIFpOICJWh3Ut80SULb4UmnzGc+65fO8Lx3B2yDKJbIsaz
EuagOx6WsNVMXt1FpsdxdPLiPGTgXYOqvebIUAGOsXy481z8YqWy3jvF2ukpfWs6
mpfEzRkRA9+VIgS5xYZXX2lETJvUS1safqrRfVbssMYSn1l608qKcHOBIItaWlZ8
SHwl0JbODK+aSZOM0qK7Jeyak/xlbqFoGqcA5KDNXLbipm07z9Syy37l3FgQ3efs
LwrOZiSeq4hCLPGYnuX5Mhzu/Vn2QZqtZ4Ra2rr0pi4G4u5bCMm8bR5gTdpIyIKh
yI24OIL9Pel5+dguAPSt
=ypwX
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--
