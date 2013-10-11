From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v8 5/6] ARM: dts: AM33xx: updated default ECC scheme in
 nand-ecc-opt
Date: Fri, 11 Oct 2013 10:56:01 -0500
Message-ID: <20131011155601.GT25706@radagast>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
 <1381498603-15715-6-git-send-email-pekon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sDhuxz86kt5qlkuV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43764 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206Ab3JKP4y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 11:56:54 -0400
Content-Disposition: inline
In-Reply-To: <1381498603-15715-6-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

--sDhuxz86kt5qlkuV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2013 at 07:06:42PM +0530, Pekon Gupta wrote:
> Updated DTS to replace deprecated binding with newer values
> Refer: Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>=20
> Signed-off-by: Pekon Gupta <pekon@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-evm.dts   | 3 +--
>  arch/arm/boot/dts/omap3430-sdp.dts | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-=
evm.dts
> index e8ec875..1aee6ac 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -269,7 +269,6 @@
>  				reg =3D <0 0 0>; /* CS0, offset 0 */
>  				nand-bus-width =3D <8>;
>  				ti,nand-ecc-opt =3D "bch8";
> -				gpmc,device-nand =3D "true";
>  				gpmc,device-width =3D <1>;
>  				gpmc,sync-clk-ps =3D <0>;
>  				gpmc,cs-on-ns =3D <0>;
> @@ -296,7 +295,7 @@
> =20
>  				#address-cells =3D <1>;
>  				#size-cells =3D <1>;
> -				elm_id =3D <&elm>;
> +				ti,elm-id =3D <&elm>;
> =20
>  				/* MTD partition table */
>  				partition@0 {
> diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3=
430-sdp.dts
> index e2249bc..501f863 100644
> --- a/arch/arm/boot/dts/omap3430-sdp.dts
> +++ b/arch/arm/boot/dts/omap3430-sdp.dts
> @@ -105,7 +105,7 @@
>  		reg =3D <1 0 0x08000000>;
>  		nand-bus-width =3D <8>;
> =20
> -		ti,nand-ecc-opt =3D "sw";
> +		ti,nand-ecc-opt =3D "ham1";
>  		gpmc,cs-on-ns =3D <0>;
>  		gpmc,cs-rd-off-ns =3D <36>;
>  		gpmc,cs-wr-off-ns =3D <36>;
> --=20
> 1.8.1
>=20

--=20
balbi

--sDhuxz86kt5qlkuV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSWB+QAAoJEIaOsuA1yqREYwEP/0Dh7eWDGBAF+rbT5y927SRF
eApiy85IPuMUdzvMO/+f7NpUdB6fY/R6BbIJ9xlKBi4d/kW2DzW9oSOvauCnoxtn
7GrPxED4+c0qCIUini4H3Jp8Czlutdjg0c/FsAUbfHpH84VL1CmtKPLvg9R49Vq3
CfhzD2xOCWXO9qAhKsl1Fow12gC9n/tKe/Lv+yFZy92sk5B7S8lcDoZWAVNEt0mO
gCr6fY9ug++UX4J5PmM2k0QiNNDVcKj7oUhMt+RhgrUfGI7/dIPXWDh5NAdfuSgA
EnpcpoiFbc8ASMc4EPr+4Jwgb9KdXmMjrmKVSl7BL2+LPlgJ/Vypu+emLrTPUV4U
0Laq9iWm9S+qEYV8n7odm5jbyDrVW1qEWT+r/Ju8ot2ft0ABm2FFBhHNVQNIzPj3
fCgDin/x1LQVMoyZJhLXF3UL+ZGq1G1XHClH84Nuy6BU4Z9P00GvGWsASXzA8dx8
ayQl0qrn7CHgk3bcJogRMk2nOlZjsD1xu9+gfhSVbOLSNEmN7gAtY4Y4IUrULHpZ
tltrFSY5/sU+wEJymlb1Y1egG9+DHm0skf+ONZYNaKMv8T6N6KOE4ra3ShSIVzHb
1u/y4LS5PslOIYBKNTdsDncQViPnBgM9GInckz0CWBVTA7w9jHiPdUiZjvxH6IZU
ID8WUAcUz+GwDOAcELHE
=+vNQ
-----END PGP SIGNATURE-----

--sDhuxz86kt5qlkuV--
