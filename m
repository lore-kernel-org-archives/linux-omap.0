From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] AM3505/3517 ZCN package support
Date: Wed, 6 Jul 2011 21:41:52 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D9B4CA5@dbde02.ent.ti.com>
References: <4E147F55.8090805@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40279 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093Ab1GFQMB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 12:12:01 -0400
In-Reply-To: <4E147F55.8090805@8d.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rapha=EBl Ass=E9=
nat
> Sent: Wednesday, July 06, 2011 8:59 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH] AM3505/3517 ZCN package support
>=20
> This patch adds support for the AM35xx ZCN package specific muxmodes.
>=20
> Signed-off-by: Raphael Assenat <raph@8d.com>
>=20

[sp] Few quick comments below:

> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index 4ae6257..5c880de 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -103,6 +103,9 @@ config OMAP_PACKAGE_CBL
>  config OMAP_PACKAGE_CBS
>         bool
> =20
> +config OMAP_PACKAGE_ZCN
> +       bool
> +
>  comment "OMAP Board Type"
>  	depends on ARCH_OMAP2PLUS
> =20
> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> index 2132308..f227503 100644
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -62,6 +62,7 @@
> =20
>  /* Flags for omapX_mux_init */
>  #define OMAP_PACKAGE_MASK		0xffff
> +#define OMAP_PACKAGE_ZCN		9		/*=20
> 491-pin 0.65 */
>  #define OMAP_PACKAGE_CBS		8		/*=20
> 547-pin 0.40 0.40 */
>  #define OMAP_PACKAGE_CBL		7		/*=20
> 547-pin 0.40 0.40 */
>  #define OMAP_PACKAGE_CBP		6		/*=20
> 515-pin 0.40 0.50 */
> diff --git a/arch/arm/mach-omap2/mux34xx.c=20
> b/arch/arm/mach-omap2/mux34xx.c
> index 17f80e4..d42ac2e 100644
> --- a/arch/arm/mach-omap2/mux34xx.c
> +++ b/arch/arm/mach-omap2/mux34xx.c
> @@ -37,6 +37,9 @@
>  	.balls		=3D { bb, bt },			=09
> 	\
>  }
> =20
> +#define _OMAP3_NULL_MUXENTRY(M0) _OMAP3_MUXENTRY(M0, 0,=20
> NULL, NULL,	\
> +				NULL, NULL, NULL, NULL, NULL, NULL)
> +
>  /*
>   * Superset of all mux modes for omap3
>   */
> @@ -651,51 +654,50 @@ static struct omap_mux __initdata=20
> omap3_muxmodes[] =3D {
>  		"gpio_166", NULL, NULL, "safe_mode"),
> =20
>  	/* Only on 3630, see omap36xx_cbp_subset for the signals */
> -	_OMAP3_MUXENTRY(GPMC_A11, 0,
> -		NULL, NULL, NULL, NULL,
> -		NULL, NULL, NULL, NULL),
[snip]...[snip]
> +	_OMAP3_NULL_MUXENTRY(GPMC_A11),
> +	_OMAP3_NULL_MUXENTRY(SAD2D_MBUSFLAG),
> +	_OMAP3_NULL_MUXENTRY(SAD2D_MREAD),

[sp] These changes don't go with the current patch description.
     You may want to keep them in a separate patch; and use here.

> +
> +	/* Only on AM35xx, see am35xx_zcn_subset for the signals */
> +	_OMAP3_NULL_MUXENTRY(CCDC_PCLK),
> +	_OMAP3_NULL_MUXENTRY(CCDC_FIELD),
> +	_OMAP3_NULL_MUXENTRY(CCDC_HD),
> +	_OMAP3_NULL_MUXENTRY(CCDC_VD),
> +	_OMAP3_NULL_MUXENTRY(CCDC_WEN),
> +	_OMAP3_NULL_MUXENTRY(CCDC_DATA0),
> +	_OMAP3_NULL_MUXENTRY(CCDC_DATA1),
> +	_OMAP3_NULL_MUXENTRY(CCDC_DATA2),
> +	_OMAP3_NULL_MUXENTRY(CCDC_DATA3),
> +	_OMAP3_NULL_MUXENTRY(CCDC_DATA4),
> +	_OMAP3_NULL_MUXENTRY(CCDC_DATA5),
> +	_OMAP3_NULL_MUXENTRY(CCDC_DATA6),
> +	_OMAP3_NULL_MUXENTRY(CCDC_DATA7),
> +	_OMAP3_NULL_MUXENTRY(RMII_MDIO_DATA),
> +	_OMAP3_NULL_MUXENTRY(RMII_MDIO_CLK),
> +	_OMAP3_NULL_MUXENTRY(RMII_RXD0),
> +	_OMAP3_NULL_MUXENTRY(RMII_RXD1),
> +	_OMAP3_NULL_MUXENTRY(RMII_CRS_DV),
> +	_OMAP3_NULL_MUXENTRY(RMII_RXER),
> +	_OMAP3_NULL_MUXENTRY(RMII_TXD0),
> +	_OMAP3_NULL_MUXENTRY(RMII_TXD1),
> +	_OMAP3_NULL_MUXENTRY(RMII_TXEN),
> +	_OMAP3_NULL_MUXENTRY(RMII_50MHZ_CLK),
> +	_OMAP3_NULL_MUXENTRY(USB0_DRVVBUS),
> +	_OMAP3_NULL_MUXENTRY(HECC1_TXD),
> +	_OMAP3_NULL_MUXENTRY(HECC1_RXD),
> +

[sp] Extra line.

>  	{ .reg_offset =3D OMAP_MUX_TERMINATOR },
>  };
> =20
> @@ -2026,6 +2028,490 @@ static struct omap_ball __initdata=20
> omap36xx_cbp_ball[] =3D {
>  #define omap36xx_cbp_ball	 NULL
>  #endif
> =20
> +/*
> + * Signals different on AM35XX ZCN package comapared to 34XX=20
> CBC package
> + */
> +#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_OMAP_PACKAGE_ZCN)
> +static struct omap_mux __initdata am35xx_zcn_subset[] =3D {

[snip]...[snip]

> +	{ .reg_offset =3D OMAP_MUX_TERMINATOR },
> +};
> +#else
> +#define am35xx_zcn_subset	NULL
> +#endif
> +
> +/*
> + * Balls for AM35XX ZCN package
> + * 491-pin s-PBGA Package, 0.65mm Ball Pitch
> + */
> +#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)=09
> 	\
> +		&& defined (CONFIG_OMAP_PACKAGE_ZCN)
> +static struct omap_ball __initdata am35xx_zcn_ball[] =3D {

[snip]...[snip]

> +
> +	{ .reg_offset =3D OMAP_MUX_TERMINATOR },
> +};
> +#else
> +#define am35xx_zcn_ball	 NULL
> +#endif
> +
> +

[sp] Extra line.

>  int __init omap3_mux_init(struct omap_board_mux=20
> *board_subset, int flags)
>  {
>  	struct omap_mux *package_subset;
> @@ -2048,6 +2534,10 @@ int __init omap3_mux_init(struct=20
> omap_board_mux *board_subset, int flags)
>  		package_subset =3D omap36xx_cbp_subset;
>  		package_balls =3D omap36xx_cbp_ball;
>  		break;
> +	case OMAP_PACKAGE_ZCN:
> +		package_subset =3D am35xx_zcn_subset;
> +		package_balls =3D am35xx_zcn_ball;
> +		break;
>  	default:
>  		pr_err("%s Unknown omap package, mux=20
> disabled\n", __func__);
>  		return -EINVAL;
> diff --git a/arch/arm/mach-omap2/mux34xx.h=20
> b/arch/arm/mach-omap2/mux34xx.h
> index 6543ebf..997387d 100644
> --- a/arch/arm/mach-omap2/mux34xx.h
> +++ b/arch/arm/mach-omap2/mux34xx.h
> @@ -316,6 +316,43 @@
>  #define OMAP3_CONTROL_PADCONF_SDRC_CKE0_OFFSET	=09
> 	0x232
>  #define OMAP3_CONTROL_PADCONF_SDRC_CKE1_OFFSET	=09
> 	0x234
> =20
> +/* AM3505/3516 only */

[sp] Small typo in 3516.

> +#define OMAP3_CONTROL_PADCONF_CCDC_PCLK_OFFSET	=09
> 	0x1b4
> +#define OMAP3_CONTROL_PADCONF_CCDC_FIELD_OFFSET	=09
> 	0x1b6
> +#define OMAP3_CONTROL_PADCONF_CCDC_HD_OFFSET			0x1b8
> +#define OMAP3_CONTROL_PADCONF_CCDC_VD_OFFSET			0x1ba
> +#define OMAP3_CONTROL_PADCONF_CCDC_WEN_OFFSET	=09
> 	0x1bc
> +#define OMAP3_CONTROL_PADCONF_CCDC_DATA0_OFFSET	=09
> 	0x1be
> +#define OMAP3_CONTROL_PADCONF_CCDC_DATA1_OFFSET	=09
> 	0x1c0
> +#define OMAP3_CONTROL_PADCONF_CCDC_DATA2_OFFSET	=09
> 	0x1c2
> +#define OMAP3_CONTROL_PADCONF_CCDC_DATA3_OFFSET	=09
> 	0x1c4
> +#define OMAP3_CONTROL_PADCONF_CCDC_DATA4_OFFSET	=09
> 	0x1c6
> +#define OMAP3_CONTROL_PADCONF_CCDC_DATA5_OFFSET	=09
> 	0x1c8
> +#define OMAP3_CONTROL_PADCONF_CCDC_DATA6_OFFSET	=09
> 	0x1ca
> +#define OMAP3_CONTROL_PADCONF_CCDC_DATA7_OFFSET	=09
> 	0x1cc
> +#define OMAP3_CONTROL_PADCONF_RMII_MDIO_DATA_OFFSET		0x1ce
> +#define OMAP3_CONTROL_PADCONF_RMII_MDIO_CLK_OFFSET		0x1d0
> +#define OMAP3_CONTROL_PADCONF_RMII_RXD0_OFFSET	=09
> 	0x1d2
> +#define OMAP3_CONTROL_PADCONF_RMII_RXD1_OFFSET	=09
> 	0x1d4
> +#define OMAP3_CONTROL_PADCONF_RMII_CRS_DV_OFFSET		0x1d6
> +#define OMAP3_CONTROL_PADCONF_RMII_RXER_OFFSET	=09
> 	0x1d8
> +#define OMAP3_CONTROL_PADCONF_RMII_TXD0_OFFSET	=09
> 	0x1da
> +#define OMAP3_CONTROL_PADCONF_RMII_TXD1_OFFSET	=09
> 	0x1dc
> +#define OMAP3_CONTROL_PADCONF_RMII_TXEN_OFFSET	=09
> 	0x1de
> +#define OMAP3_CONTROL_PADCONF_RMII_50MHZ_CLK_OFFSET		0x1e0
> +#define OMAP3_CONTROL_PADCONF_USB0_DRVVBUS_OFFSET		0x1e2
> +#define OMAP3_CONTROL_PADCONF_HECC1_TXD_OFFSET	=09
> 	0x1e4
> +#define OMAP3_CONTROL_PADCONF_HECC1_RXD_OFFSET	=09
> 	0x1e6
> +#define OMAP3_CONTROL_PADCONF_SYS_BOOT7_OFFSET	=09
> 	0x1e8
> +#define OMAP3_CONTROL_PADCONF_SDRC_DQS0N_OFFSET	=09
> 	0x1ea
> +#define OMAP3_CONTROL_PADCONF_SDRC_DQS1N_OFFSET	=09
> 	0x1ec
> +#define OMAP3_CONTROL_PADCONF_SDRC_DQS2N_OFFSET	=09
> 	0x1ee
> +#define OMAP3_CONTROL_PADCONF_SDRC_DQS3N_OFFSET	=09
> 	0x1f0
> +#define OMAP3_CONTROL_PADCONF_SDRC_STRBEN_DLY0_OFFSET=09
> 	0x1f2
> +#define OMAP3_CONTROL_PADCONF_SDRC_STRBEN_DLY1_OFFSET=09
> 	0x1f4
> +#define OMAP3_CONTROL_PADCONF_SYS_BOOT8_OFFSET	=09
> 	0x1f6
> +
> +

[sp] Extra line.

>  /* 36xx only */
>  #define OMAP3_CONTROL_PADCONF_GPMC_A11_OFFSET	=09
> 	0x236
>  #define OMAP3_CONTROL_PADCONF_SDRC_BA0_OFFSET	=09
> 	0x570
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
