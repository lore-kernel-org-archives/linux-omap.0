From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Devkit8000: Fix dvi output
Date: Mon, 19 Nov 2012 07:52:09 +0200
Message-ID: <50A9C909.1030006@ti.com>
References: <1353256083-19983-1-git-send-email-thomas@tomweber.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCADAF954BE296BD9190C5304"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54744 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab2KSFwY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 00:52:24 -0500
In-Reply-To: <1353256083-19983-1-git-send-email-thomas@tomweber.eu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <thomas@tomweber.eu>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org.#v3.5.v3.6

--------------enigCADAF954BE296BD9190C5304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-18 18:28, Thomas Weber wrote:
> Add i2c bus number for DVI output.
> The driver uses this to detect if a panel is connected and to read EDID=
=2E
>=20
> Signed-off-by: Thomas Weber <thomas@tomweber.eu>
> Cc: stable@vger.kernel.org #v3.5 v3.6
> ---
>  arch/arm/mach-omap2/board-devkit8000.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-oma=
p2/board-devkit8000.c
> index 1fd161e..73d3d8e 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -138,6 +138,7 @@ static struct omap_dss_device devkit8000_lcd_device=
 =3D {
>  };
> =20
>  static struct tfp410_platform_data dvi_panel =3D {
> +	.i2c_bus_num		=3D 1,
>  	.power_down_gpio	=3D -1,
>  };

That change is already included in the "[PATCH] OMAP: board-files: fix
i2c_bus for tfp410" path I sent on Friday.

 Tomi



--------------enigCADAF954BE296BD9190C5304
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQqckOAAoJEPo9qoy8lh71tsgP/3qXxjBQ6Ew+UzbGVbJMigTu
cTohM27R0ppsZICalGqqHkYr/KVtMhMMfb3Hvqb6KtnRLtIOHH+Y1MTphFM9SSmJ
7D4ch6UWvur88p1PfDCwIEX81FrWxCgDQAPWMAwQJFPdXDeOv54shGBWLit9811E
7FcJ3i/sHFMJINiP+usFUORGzR4psQWQpw+z60edH84ZaFcSE2QqUipyE/F4lJ9z
sl7plFMmaeGQ2GlnBmRTvQAcal/UR4hne8IwCndV1vnQ7ilvPWUvEQgSugumIP8z
h5WTh78dbZmepMP1G2cml0LBwPiGg2l1mxyqNjWtUQv+07eM26D7SZlWGtJYZnLM
IkUoKFVCOpVTvy5WFnXwAajERpF/EmyfgwM3ItLJuUG5kpjseYY/2X3P9+K6/ARK
ll1W1nRF7nEhgdKSiuZy6CFcCvfhvMYKEcud3ABzovXf0L2+hCJDfLu3Rmz/wV3h
iYjUn4s0Wb28ihpgn2vAhXbxOaLioc4VxfC6JLhuUwXWF+NhPdZtTfE328glCxfX
iFCYS+AZJNiyCxcQ3jzdduQ5hWiyr1fyf7/tqdKxOMpv/wLbombhNG9fmh94sp2Q
WG61bJ2iUcmjfHto04krodldiTKWhgfDo+ojJYHPT822JR1ObeGx0VWyARrGq3z0
5dSzc7yVGri+L0xTq0b7
=5CmG
-----END PGP SIGNATURE-----

--------------enigCADAF954BE296BD9190C5304--
