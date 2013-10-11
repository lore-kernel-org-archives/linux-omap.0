From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v8 1/6] mtd: nand: omap: combine different flavours of
 1-bit hamming ecc schemes
Date: Fri, 11 Oct 2013 10:55:36 -0500
Message-ID: <20131011155535.GQ25706@radagast>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
 <1381498603-15715-2-git-send-email-pekon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="chReQkDOePndSGWY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53770 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756250Ab3JKP4U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 11:56:20 -0400
Content-Disposition: inline
In-Reply-To: <1381498603-15715-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

--chReQkDOePndSGWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2013 at 07:06:38PM +0530, Pekon Gupta wrote:
> OMAP NAND driver currently supports multiple flavours of 1-bit Hamming
> ecc-scheme, like:
> - OMAP_ECC_HAMMING_CODE_DEFAULT
> 	1-bit hamming ecc code using software library
> - OMAP_ECC_HAMMING_CODE_HW
> 	1-bit hamming ecc-code using GPMC h/w engine
> - OMAP_ECC_HAMMING_CODE_HW_ROMCODE
> 	1-bit hamming ecc-code using GPMC h/w engin with ecc-layout compatible
> 	to ROM code.
>=20
> This patch combines above multiple ecc-schemes into single implementation:
> - OMAP_ECC_HAM1_CODE_HW
> 	1-bit hamming ecc-code using GPMC h/w engine with ROM-code compatible
> 	ecc-layout.
>=20
> Signed-off-by: Pekon Gupta <pekon@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  Documentation/devicetree/bindings/mtd/gpmc-nand.txt | 8 ++++----
>  arch/arm/mach-omap2/board-flash.c                   | 2 +-
>  arch/arm/mach-omap2/gpmc.c                          | 4 +---
>  drivers/mtd/nand/omap2.c                            | 9 +++------
>  include/linux/platform_data/mtd-nand-omap2.h        | 6 +-----
>  5 files changed, 10 insertions(+), 19 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Docume=
ntation/devicetree/bindings/mtd/gpmc-nand.txt
> index df338cb..25ee232 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> @@ -22,10 +22,10 @@ Optional properties:
>  				width of 8 is assumed.
> =20
>   - ti,nand-ecc-opt:		A string setting the ECC layout to use. One of:
> -
> -		"sw"		Software method (default)
> -		"hw"		Hardware method
> -		"hw-romcode"	gpmc hamming mode method & romcode layout
> +		"sw"		<deprecated> use "ham1" instead
> +		"hw"		<deprecated> use "ham1" instead
> +		"hw-romcode"	<deprecated> use "ham1" instead
> +		"ham1"		1-bit Hamming ecc code
>  		"bch4"		4-bit BCH ecc code
>  		"bch8"		8-bit BCH ecc code
> =20
> diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/boar=
d-flash.c
> index fc20a61..ac82512 100644
> --- a/arch/arm/mach-omap2/board-flash.c
> +++ b/arch/arm/mach-omap2/board-flash.c
> @@ -142,7 +142,7 @@ __init board_nand_init(struct mtd_partition *nand_par=
ts, u8 nr_parts, u8 cs,
>  	board_nand_data.nr_parts	=3D nr_parts;
>  	board_nand_data.devsize		=3D nand_type;
> =20
> -	board_nand_data.ecc_opt =3D OMAP_ECC_HAMMING_CODE_DEFAULT;
> +	board_nand_data.ecc_opt =3D OMAP_ECC_BCH8_CODE_HW;
>  	gpmc_nand_init(&board_nand_data, gpmc_t);
>  }
>  #endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 579697a..c9fb353 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1342,9 +1342,7 @@ static void __maybe_unused gpmc_read_timings_dt(str=
uct device_node *np,
>  #ifdef CONFIG_MTD_NAND
> =20
>  static const char * const nand_ecc_opts[] =3D {
> -	[OMAP_ECC_HAMMING_CODE_DEFAULT]		=3D "sw",
> -	[OMAP_ECC_HAMMING_CODE_HW]		=3D "hw",
> -	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	=3D "hw-romcode",
> +	[OMAP_ECC_HAM1_CODE_HW]			=3D "ham1",
>  	[OMAP_ECC_BCH4_CODE_HW]			=3D "bch4",
>  	[OMAP_ECC_BCH8_CODE_HW]			=3D "bch8",
>  };
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 4ecf0e5..8d521aa 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1993,10 +1993,7 @@ static int omap_nand_probe(struct platform_device =
*pdev)
>  	}
> =20
>  	/* select the ecc type */
> -	if (pdata->ecc_opt =3D=3D OMAP_ECC_HAMMING_CODE_DEFAULT)
> -		info->nand.ecc.mode =3D NAND_ECC_SOFT;
> -	else if ((pdata->ecc_opt =3D=3D OMAP_ECC_HAMMING_CODE_HW) ||
> -		(pdata->ecc_opt =3D=3D OMAP_ECC_HAMMING_CODE_HW_ROMCODE)) {
> +	if (pdata->ecc_opt =3D=3D OMAP_ECC_HAM1_CODE_HW) {
>  		info->nand.ecc.bytes            =3D 3;
>  		info->nand.ecc.size             =3D 512;
>  		info->nand.ecc.strength         =3D 1;
> @@ -2025,7 +2022,7 @@ static int omap_nand_probe(struct platform_device *=
pdev)
>  	}
> =20
>  	/* rom code layout */
> -	if (pdata->ecc_opt =3D=3D OMAP_ECC_HAMMING_CODE_HW_ROMCODE) {
> +	if (pdata->ecc_opt =3D=3D OMAP_ECC_HAM1_CODE_HW) {
> =20
>  		if (info->nand.options & NAND_BUSWIDTH_16)
>  			offset =3D 2;
> @@ -2033,7 +2030,7 @@ static int omap_nand_probe(struct platform_device *=
pdev)
>  			offset =3D 1;
>  			info->nand.badblock_pattern =3D &bb_descrip_flashbased;
>  		}
> -		omap_oobinfo.eccbytes =3D 3 * (info->mtd.oobsize/16);
> +		omap_oobinfo.eccbytes =3D 3 * (info->mtd.writesize / 512);
>  		for (i =3D 0; i < omap_oobinfo.eccbytes; i++)
>  			omap_oobinfo.eccpos[i] =3D i+offset;
> =20
> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux=
/platform_data/mtd-nand-omap2.h
> index 6bf9ef4..cb5a54a 100644
> --- a/include/linux/platform_data/mtd-nand-omap2.h
> +++ b/include/linux/platform_data/mtd-nand-omap2.h
> @@ -23,11 +23,7 @@ enum nand_io {
>  };
> =20
>  enum omap_ecc {
> -		/* 1-bit ecc: stored at end of spare area */
> -	OMAP_ECC_HAMMING_CODE_DEFAULT =3D 0, /* Default, s/w method */
> -	OMAP_ECC_HAMMING_CODE_HW, /* gpmc to detect the error */
> -		/* 1-bit ecc: stored at beginning of spare area as romcode */
> -	OMAP_ECC_HAMMING_CODE_HW_ROMCODE, /* gpmc method & romcode layout */
> +	OMAP_ECC_HAM1_CODE_HW =3D 0, /* 1-bit Hamming ecc code */
>  	OMAP_ECC_BCH4_CODE_HW, /* 4-bit BCH ecc code */
>  	OMAP_ECC_BCH8_CODE_HW, /* 8-bit BCH ecc code */
>  };
> --=20
> 1.8.1
>=20

--=20
balbi

--chReQkDOePndSGWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSWB93AAoJEIaOsuA1yqRER8IP/3XaxuhqRm3cdiIlq+5PKoaq
T7G2y5fgofZ1lPPtUv5WABC8YN0yAlDC7wHQKEAh5yPcmu7bcmL2uMJ08B/NrE1Y
dC+cdWTLCkkt5t3srG+V322482zj/nkzAYC+cENckZ+KDtcwkBHxl0lIx6RbcDPP
93+zNNht4eibbRIKKPZGA1SGICAbac+iGDbEqSAXRyYrT2e9QSKc9sn1y56oeAa9
523WIDT9uqdW9q6fhDCyH4a93zcnCTzhS3bJZQMkj0G/5UVlQhtjfmYJa6kXLRPV
B6Yk2koWRWVAOe2XYrMLbvJ+CdQ3yKDUZiA9Z5+tAAOEM+Dflhscn5NcufU5snSk
ux/J1dCnUfGpth1mjlHZqGoJAWgHEfMB72/mNpsRNtCF6tLXXg+qRit1QVBM03LX
BABDn1WYo3RqhNz0IsnVH5vPU11dMQLw6S/2UlwejpI6P//1O9uQk79MyRjalW8/
qP0L9/ERsmcsu1z4Ru8PaIUSHIR4I4OANbB54gImYursMgBB3pSB90Hu9sgKxKGo
rnbLbwGnb3l7m41OxTspgf3BDpTPP/6rsPJb42hQbaspEDmiPcE1KjFK2XT6rX9x
I9lNihG6fNfGsopjeoQ4uHnise18F/WdeNbKpoGxQlujpi15NagyhxIHuhP+fMuF
FiIU4XqH5CyEN+J5K2mI
=ETp/
-----END PGP SIGNATURE-----

--chReQkDOePndSGWY--
