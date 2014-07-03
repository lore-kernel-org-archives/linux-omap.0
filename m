From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/5] ARM: configs: omap2plus_defconfig: enable TPS65218
 configs
Date: Thu, 3 Jul 2014 09:24:08 -0500
Message-ID: <20140703142408.GK5814@saruman.home>
References: <1404395102-21469-1-git-send-email-j-keerthy@ti.com>
 <1404395102-21469-6-git-send-email-j-keerthy@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bPg9NdpM9EETxvqt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404395102-21469-6-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mark.rutland@arm.com, galak@codeaurora.org, robh+dt@kernel.org, linux@arm.linux.org.uk, balbi@ti.com, tony@atomide.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

--bPg9NdpM9EETxvqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 07:15:02PM +0530, Keerthy wrote:
> Enable TPS65218 config options.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/configs/omap2plus_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap=
2plus_defconfig
> index 536a137..f650f00 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -180,6 +180,7 @@ CONFIG_TWL4030_WATCHDOG=3Dy
>  CONFIG_MFD_SYSCON=3Dy
>  CONFIG_MFD_PALMAS=3Dy
>  CONFIG_MFD_TPS65217=3Dy
> +CONFIG_MFD_TPS65218=3Dy
>  CONFIG_MFD_TPS65910=3Dy
>  CONFIG_TWL6040_CORE=3Dy
>  CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
> @@ -188,6 +189,7 @@ CONFIG_REGULATOR_TI_ABB=3Dy
>  CONFIG_REGULATOR_TPS65023=3Dy
>  CONFIG_REGULATOR_TPS6507X=3Dy
>  CONFIG_REGULATOR_TPS65217=3Dy
> +CONFIG_REGULATOR_TPS65218=3Dy
>  CONFIG_REGULATOR_TPS65910=3Dy
>  CONFIG_REGULATOR_TWL4030=3Dy
>  CONFIG_REGULATOR_PBIAS=3Dy
> --=20
> 1.7.9.5
>=20

--=20
balbi

--bPg9NdpM9EETxvqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTtWeIAAoJEIaOsuA1yqREcF0QALRiCTwAXWYUe5rrsIJZqK4E
6MsRUXkKBulotcckJP+I+PDFCve2wWj60e0+qeytgyssoe9dLHM8cgcIK+HouxsG
pJezQZ3rrCl6LVw8MDJ5/5RK2BmA7r1KtysDZKQ7QXxMF5DdVBIfYqhduPJLxpCZ
CqAyfWNfMuHRHVWKSc408vai1jKtVXZ+Cyjk43TtHA4NGhWbla0dNQIiEu01LIk7
g+cc2Bbgw+iSUg7Yxp/lAUzQVse0R3fUmI1sgwlN2o8iK+MwVbJrAwWxbaaAEN0h
sbHngP2ihagHG+iPsIHlwZWnHwHFdQfD2zOvYL9yA4wR62brkpOKOoTurHUXcBlP
qJrDn2PtK15eC3pRTpOWCghAvaRsGH8lGArgIbdw0Xuihk4UDRy8pqM8CnHVUPoL
fe8goMc0upgBWFbvvz4Tf1W8kX+ZVjZxvJ0gJ/FGGfjDOyhJYjjZC+ERCLUo3xKy
0E7VCBqJpoXDXfbdIghsw1/s13+CKSPhDjwGp4rhXEtSJ8qY67k1v0HMRguFJlBe
oaq836PQIFLVtQfbGyuLA/5hblTcSHbe6XJQtDwngCRtpuYQEULcxQSyedo9sFfR
0wfeqNQhFpeVyx2q1IQmM+E5ftIXkZekS8RsCcLFryJxUkg+ViNOf6PRlPGNsdXt
BlaFNIwa26sVhRP4YEWD
=dx7f
-----END PGP SIGNATURE-----

--bPg9NdpM9EETxvqt--
