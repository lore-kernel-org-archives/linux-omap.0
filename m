From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] i2c: omap: Remove the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE
 flag
Date: Mon, 26 Nov 2012 11:14:00 +0200
Message-ID: <20121126091400.GD15766@arwen.pp.htv.fi>
References: <1353921235-22408-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44127 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754622Ab2KZJU6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 04:20:58 -0500
Content-Disposition: inline
In-Reply-To: <1353921235-22408-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, balbi@ti.com, w.sang@pengutronix.de

--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2012 at 02:43:55PM +0530, Shubhrajyoti D wrote:
> The OMAP_I2C_FLAG_RESET_REGS_POSTIDLE is not used anymore
> in the i2c driver. Remove the flag.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> Has dependency on the below patch
> http://git.pengutronix.de/?p=3Dwsa/linux.git;a=3Dcommitdiff;h=3D554c96744=
afd169886bd6fc2736fb0d9aaf634e8
>=20
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +--
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +--
>  drivers/i2c/busses/i2c-omap.c              |    3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_3xxx_data.c
> index 943222c4..3dd9e69 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -791,8 +791,7 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod =3D {
>  /* I2C1 */
>  static struct omap_i2c_dev_attr i2c1_dev_attr =3D {
>  	.fifo_depth	=3D 8, /* bytes */
> -	.flags		=3D OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
> -			  OMAP_I2C_FLAG_BUS_SHIFT_2,
> +	.flags		=3D OMAP_I2C_FLAG_BUS_SHIFT_2,

if it's not used anymore, how about removing its definition too ?

--=20
balbi

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQszLXAAoJEIaOsuA1yqRE5N4QAIL/XTVH0zh3maWpoUI8ECdN
SdhG76p6j4TR4P5Uy6dX9nrHoqMbrdWN1yquDpt2YefQtnHC21FJGBvv9UJtyFUn
TJGTdBUM0aPkgMPUZ6h7wdWuzmCo3DaUmhCVDCydtuOGbsbThh5LfMFeglgIOUDQ
8B/tLgKTFnXGdNXVgezVwqTuhBShhpOQU0MPMCYwspobz/EAxNnKJ+OMRyvDerYh
7UPCUw/i+Yw5BwjvccwPQPxhgjXZKDmfYs2f0NnOa2KpC4RGEmHwZlH7+P2/D/s8
INX1XK23rELGZqPsBQ4J3lDndwTPUPGTTa5YrB5oc9ymZoZQhEdh5i73M1PnnOh9
i2WmS80XdYcyHPzyiDGfH7+UvyfQ4rzzstOReLKj4zDBK0HBKK9XDFyVMFYaDK+G
LPlEy0+GkmJJXurJ49K4GSqCbJ0+xCDpl7xzNULijSuEndEzKq4qKQ69shmKBIjk
p2EDiEUtoLMjbiGaX2kt6OrK3SW+kUsMdZUzoIYvYpnOkWa3o5VHxDP1mo99IY+b
yyqjksEBe4wFqRz2zmA2c62aWYM/qDLv0/RNeMAvVGibihT46/idsS1yngVg0dvU
U0dhXYJoNe3lmRk5cRMwi+8DJgpZfQ4ZYZabmsNnIFGVkN2cT2DnwyYc7k/X0mPj
gVXz545GjgkCS1usb7fQ
=Hnb4
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
