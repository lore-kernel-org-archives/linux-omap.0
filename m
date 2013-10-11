From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v8 2/6] ARM: OMAP2+: cleaned-up DT support of various ECC
 schemes
Date: Fri, 11 Oct 2013 10:55:27 -0500
Message-ID: <20131011155527.GP25706@radagast>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
 <1381498603-15715-3-git-send-email-pekon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="90KBcPA0h13nTGdQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53776 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756250Ab3JKP4X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 11:56:23 -0400
Content-Disposition: inline
In-Reply-To: <1381498603-15715-3-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

--90KBcPA0h13nTGdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2013 at 07:06:39PM +0530, Pekon Gupta wrote:
> OMAP NAND driver support multiple ECC scheme, which can used in following
> different flavours, depending on in-build Hardware engines supported by S=
oC.
>=20
> +---------------------------------------+---------------+---------------+
> | ECC scheme                            |ECC calculation|Error detection|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_HAM1_CODE_HW                  |H/W (GPMC)     |S/W            |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W            |
> |(requires CONFIG_MTD_NAND_ECC_BCH)     |               |               |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> |(requires CONFIG_MTD_NAND_OMAP_BCH &&  |               |               |
> | ti,elm-id in DT)                      |               |               |
> +---------------------------------------+---------------+---------------+
> To optimize footprint of omap2-nand driver, selection of some ECC schemes
> also require enabling following Kconfigs, in addition to setting appropri=
ate
> DT bindings
> - Kconfig:CONFIG_MTD_NAND_ECC_BCH        error detection done in software
> - Kconfig:CONFIG_MTD_NAND_OMAP_BCH       error detection done by h/w engi=
ne
>=20
> DT binding updates in this patch are:
> - ti,elm-id: replaces elm_id
> - ti,nand-ecc-opts: supported values ham1, bch4, and bch8
> 	selection of h/w or s/w implementation depends on ti,elm-id
>=20
> Signed-off-by: Pekon Gupta <pekon@ti.com>

since this maintains backwards compatibility, I think it should be
alright to apply

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  8 +++-
>  arch/arm/mach-omap2/gpmc.c                         | 45 ++++++++++++++++=
------
>  include/linux/platform_data/mtd-nand-omap2.h       | 14 +++++--
>  3 files changed, 50 insertions(+), 17 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Docume=
ntation/devicetree/bindings/mtd/gpmc-nand.txt
> index 25ee232..5e1f31b 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> @@ -36,8 +36,12 @@ Optional properties:
>  		"prefetch-dma"		Prefetch enabled sDMA mode
>  		"prefetch-irq"		Prefetch enabled irq mode
> =20
> - - elm_id:	Specifies elm device node. This is required to support BCH
> - 		error correction using ELM module.
> + - elm_id:	<deprecated> use "ti,elm-id" instead
> + - ti,elm-id:	Specifies phandle of the ELM devicetree node.
> +		ELM is an on-chip hardware engine on TI SoC which is used for
> +		locating ECC errors for BCHx algorithms. SoC devices which have
> +		ELM hardware engines should specify this device node in .dtsi
> +		Using ELM for ECC error correction frees some CPU cycles.
> =20
>  For inline partiton table parsing (optional):
> =20
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index c9fb353..9473c9f 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1341,12 +1341,6 @@ static void __maybe_unused gpmc_read_timings_dt(st=
ruct device_node *np,
> =20
>  #ifdef CONFIG_MTD_NAND
> =20
> -static const char * const nand_ecc_opts[] =3D {
> -	[OMAP_ECC_HAM1_CODE_HW]			=3D "ham1",
> -	[OMAP_ECC_BCH4_CODE_HW]			=3D "bch4",
> -	[OMAP_ECC_BCH8_CODE_HW]			=3D "bch8",
> -};
> -
>  static const char * const nand_xfer_types[] =3D {
>  	[NAND_OMAP_PREFETCH_POLLED]		=3D "prefetch-polled",
>  	[NAND_OMAP_POLLED]			=3D "polled",
> @@ -1376,12 +1370,39 @@ static int gpmc_probe_nand_child(struct platform_=
device *pdev,
>  	gpmc_nand_data->cs =3D val;
>  	gpmc_nand_data->of_node =3D child;
> =20
> -	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s))
> -		for (val =3D 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
> -			if (!strcasecmp(s, nand_ecc_opts[val])) {
> -				gpmc_nand_data->ecc_opt =3D val;
> -				break;
> -			}
> +	/* Detect availability of ELM module */
> +	gpmc_nand_data->elm_of_node =3D of_parse_phandle(child, "ti,elm-id", 0);
> +	if (gpmc_nand_data->elm_of_node =3D=3D NULL)
> +		gpmc_nand_data->elm_of_node =3D
> +					of_parse_phandle(child, "elm_id", 0);
> +	if (gpmc_nand_data->elm_of_node =3D=3D NULL)
> +		pr_warn("%s: ti,elm-id property not found\n", __func__);
> +
> +	/* select NAND ecc-opt */
> +	if (of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
> +		pr_err("%s: ti,nand-ecc-opt not found\n", __func__);
> +		return -ENODEV;
> +	}
> +	if (!strcmp(s, "ham1") || !strcmp(s, "sw") ||
> +		!strcmp(s, "hw") || !strcmp(s, "hw-romcode"))
> +		gpmc_nand_data->ecc_opt =3D
> +				OMAP_ECC_HAM1_CODE_HW;
> +	else if (!strcmp(s, "bch4"))
> +		if (gpmc_nand_data->elm_of_node)
> +			gpmc_nand_data->ecc_opt =3D
> +				OMAP_ECC_BCH4_CODE_HW;
> +		else
> +			gpmc_nand_data->ecc_opt =3D
> +				OMAP_ECC_BCH4_CODE_HW_DETECTION_SW;
> +	else if (!strcmp(s, "bch8"))
> +		if (gpmc_nand_data->elm_of_node)
> +			gpmc_nand_data->ecc_opt =3D
> +				OMAP_ECC_BCH8_CODE_HW;
> +		else
> +			gpmc_nand_data->ecc_opt =3D
> +				OMAP_ECC_BCH8_CODE_HW_DETECTION_SW;
> +	else
> +		pr_err("%s: ti,nand-ecc-opt invalid value\n", __func__);
> =20
>  	if (!of_property_read_string(child, "ti,nand-xfer-type", &s))
>  		for (val =3D 0; val < ARRAY_SIZE(nand_xfer_types); val++)
> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux=
/platform_data/mtd-nand-omap2.h
> index cb5a54a..4da5bfa 100644
> --- a/include/linux/platform_data/mtd-nand-omap2.h
> +++ b/include/linux/platform_data/mtd-nand-omap2.h
> @@ -23,9 +23,16 @@ enum nand_io {
>  };
> =20
>  enum omap_ecc {
> -	OMAP_ECC_HAM1_CODE_HW =3D 0, /* 1-bit Hamming ecc code */
> -	OMAP_ECC_BCH4_CODE_HW, /* 4-bit BCH ecc code */
> -	OMAP_ECC_BCH8_CODE_HW, /* 8-bit BCH ecc code */
> +	/* 1-bit  ECC calculation by GPMC, Error detection by Software */
> +	OMAP_ECC_HAM1_CODE_HW =3D 0,
> +	/* 4-bit  ECC calculation by GPMC, Error detection by Software */
> +	OMAP_ECC_BCH4_CODE_HW_DETECTION_SW,
> +	/* 4-bit  ECC calculation by GPMC, Error detection by ELM */
> +	OMAP_ECC_BCH4_CODE_HW,
> +	/* 8-bit  ECC calculation by GPMC, Error detection by Software */
> +	OMAP_ECC_BCH8_CODE_HW_DETECTION_SW,
> +	/* 8-bit  ECC calculation by GPMC, Error detection by ELM */
> +	OMAP_ECC_BCH8_CODE_HW,
>  };
> =20
>  struct gpmc_nand_regs {
> @@ -59,5 +66,6 @@ struct omap_nand_platform_data {
> =20
>  	/* for passing the partitions */
>  	struct device_node	*of_node;
> +	struct device_node	*elm_of_node;
>  };
>  #endif
> --=20
> 1.8.1
>=20

--=20
balbi

--90KBcPA0h13nTGdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSWB9vAAoJEIaOsuA1yqREBwIP/i7wXrn14+njf0eW2sYbb1TZ
NV2meJo+yAGbj5uo4J6KCoruB/fADbk8W/27H5eKWdAZT+Sef1w5D2inzXqU1tmL
iqSqwaqLhpsQsC3tjHQz67mc4GUbay9vTvyqA31PV+5OHqRKMajIKenigii55O2I
UIQTFDHhxnqfB/qu/HlBov7zigaSCASs3XwpherjNJXTlCfBx2fcqTGETMB5rhvD
Os77v+OaxTnZ2df02pT/VbbUSnFWSvUNfkU7Y7g/vsHhy6MoMdI0EfolJ55VnIio
dP3c32gzg9lzD/ODLiZQmKugPqyGC/guNPDfRa+oetgEzYLRNZdqaCFfVz2VeARy
teAJG4zTGXzC/IXf3ss9PIgGdiUWxsiE87RlCptJ7ILEJOkj4Khfk8sY1LBlE1uv
ecRYeE3NwLUdkSwGgvX61O1zKLR/MtUk/4ecWwokIm/gzK4HIwK0DrnPaCTE8bQb
AnJ06dH1IRcz4NlA9Kj0gEj+HYAppersk3mPeBV5rMXqxmI9pyrZaOSOxzDTu7UW
R1wz+vSo2pjKD8OD6Itz/Kah/DqNeZoR4nBuaH8BWX4+WOuPRTGzzlPuJR3C7RFH
xKWR+b+DZ3oeCxCNT4qaUUeEuCwysQ/NUPFxrPK0u5qrwfQk18Exa4XFxug5x7ik
xttsBiRQiYnCKqA/Lnqe
=0S6H
-----END PGP SIGNATURE-----

--90KBcPA0h13nTGdQ--
