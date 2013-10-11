From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v8 3/6] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC
 configurations in device_probe
Date: Fri, 11 Oct 2013 10:55:44 -0500
Message-ID: <20131011155544.GR25706@radagast>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
 <1381498603-15715-4-git-send-email-pekon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E1BPhOSoTthPQdPL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53792 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754792Ab3JKP4b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 11:56:31 -0400
Content-Disposition: inline
In-Reply-To: <1381498603-15715-4-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

--E1BPhOSoTthPQdPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2013 at 07:06:40PM +0530, Pekon Gupta wrote:
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
> - Kconfig:CONFIG_MTD_NAND_ECC_BCH        enables S/W based BCH ECC algori=
thm
> - Kconfig:CONFIG_MTD_NAND_OMAP_BCH       enables H/W based BCH ECC algori=
thm
>=20
> This patch
> - separates the configurations code for each ECC schemes
> - fixes dependency issues based on Kconfig options
> - updates ELM device detection in is_elm_present()
> - cleans redundant code
>=20
> Signed-off-by: Pekon Gupta <pekon@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/mtd/nand/omap2.c | 450 +++++++++++++++++++++++------------------=
------
>  1 file changed, 220 insertions(+), 230 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 8d521aa..fb96251 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -25,8 +25,10 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> =20
> -#ifdef CONFIG_MTD_NAND_OMAP_BCH
> +#ifdef CONFIG_MTD_NAND_ECC_BCH
>  #include <linux/bch.h>
> +#endif
> +#ifdef CONFIG_MTD_NAND_OMAP_BCH
>  #include <linux/platform_data/elm.h>
>  #endif
> =20
> @@ -141,6 +143,9 @@
>  #define BCH_ECC_SIZE0		0x0	/* ecc_size0 =3D 0, no oob protection */
>  #define BCH_ECC_SIZE1		0x20	/* ecc_size1 =3D 32 */
> =20
> +#define BADBLOCK_MARKER_LENGTH		2
> +#define OMAP_ECC_BCH8_POLYNOMIAL	0x201b
> +
>  #ifdef CONFIG_MTD_NAND_OMAP_BCH
>  static u_char bch8_vector[] =3D {0xf3, 0xdb, 0x14, 0x16, 0x8b, 0xd2, 0xb=
e, 0xcc,
>  	0xac, 0x6b, 0xff, 0x99, 0x7b};
> @@ -182,14 +187,11 @@ struct omap_nand_info {
>  	u_char				*buf;
>  	int					buf_len;
>  	struct gpmc_nand_regs		reg;
> -
> -#ifdef CONFIG_MTD_NAND_OMAP_BCH
> -	struct bch_control             *bch;
> -	struct nand_ecclayout           ecclayout;
> +	/* fields specific for BCHx_HW ECC scheme */
> +	struct bch_control              *bch;
>  	bool				is_elm_used;
>  	struct device			*elm_dev;
>  	struct device_node		*of_node;
> -#endif
>  };
> =20
>  /**
> @@ -1058,8 +1060,7 @@ static int omap_dev_ready(struct mtd_info *mtd)
>  	}
>  }
> =20
> -#ifdef CONFIG_MTD_NAND_OMAP_BCH
> -
> +#if defined(CONFIG_MTD_NAND_ECC_BCH) || defined(CONFIG_MTD_NAND_OMAP_BCH)
>  /**
>   * omap3_enable_hwecc_bch - Program OMAP3 GPMC to perform BCH ECC correc=
tion
>   * @mtd: MTD device structure
> @@ -1140,7 +1141,9 @@ static void omap3_enable_hwecc_bch(struct mtd_info =
*mtd, int mode)
>  	/* Clear ecc and enable bits */
>  	writel(ECCCLEAR | ECC1, info->reg.gpmc_ecc_control);
>  }
> +#endif
> =20
> +#ifdef CONFIG_MTD_NAND_ECC_BCH
>  /**
>   * omap3_calculate_ecc_bch4 - Generate 7 bytes of ECC bytes
>   * @mtd: MTD device structure
> @@ -1225,7 +1228,9 @@ static int omap3_calculate_ecc_bch8(struct mtd_info=
 *mtd, const u_char *dat,
> =20
>  	return 0;
>  }
> +#endif /* CONFIG_MTD_NAND_ECC_BCH */
> =20
> +#ifdef CONFIG_MTD_NAND_OMAP_BCH
>  /**
>   * omap3_calculate_ecc_bch - Generate bytes of ECC bytes
>   * @mtd:	MTD device structure
> @@ -1517,7 +1522,9 @@ static int omap_elm_correct_data(struct mtd_info *m=
td, u_char *data,
> =20
>  	return stat;
>  }
> +#endif /* CONFIG_MTD_NAND_OMAP_BCH */
> =20
> +#ifdef CONFIG_MTD_NAND_ECC_BCH
>  /**
>   * omap3_correct_data_bch - Decode received data and correct errors
>   * @mtd: MTD device structure
> @@ -1549,7 +1556,9 @@ static int omap3_correct_data_bch(struct mtd_info *=
mtd, u_char *data,
>  	}
>  	return count;
>  }
> +#endif /* CONFIG_MTD_NAND_ECC_BCH */
> =20
> +#ifdef CONFIG_MTD_NAND_OMAP_BCH
>  /**
>   * omap_write_page_bch - BCH ecc based write page function for entire pa=
ge
>   * @mtd:		mtd info structure
> @@ -1637,197 +1646,68 @@ static int omap_read_page_bch(struct mtd_info *m=
td, struct nand_chip *chip,
>  }
> =20
>  /**
> - * omap3_free_bch - Release BCH ecc resources
> - * @mtd: MTD device structure
> + * is_elm_present - checks for presence of ELM module by scanning DT nod=
es
> + * @omap_nand_info: NAND device structure containing platform data
> + * @bch_type: 0x0=3DBCH4, 0x1=3DBCH8, 0x2=3DBCH16
>   */
> -static void omap3_free_bch(struct mtd_info *mtd)
> +static int is_elm_present(struct omap_nand_info *info,
> +			struct device_node *elm_node, enum bch_ecc bch_type)
>  {
> -	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_info,
> -						   mtd);
> -	if (info->bch) {
> -		free_bch(info->bch);
> -		info->bch =3D NULL;
> -	}
> -}
> -
> -/**
> - * omap3_init_bch - Initialize BCH ECC
> - * @mtd: MTD device structure
> - * @ecc_opt: OMAP ECC mode (OMAP_ECC_BCH4_CODE_HW or OMAP_ECC_BCH8_CODE_=
HW)
> - */
> -static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
> -{
> -	int max_errors;
> -	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_info,
> -						   mtd);
> -#ifdef CONFIG_MTD_NAND_OMAP_BCH8
> -	const int hw_errors =3D BCH8_MAX_ERROR;
> -#else
> -	const int hw_errors =3D BCH4_MAX_ERROR;
> -#endif
> -	enum bch_ecc bch_type;
> -	const __be32 *parp;
> -	int lenp;
> -	struct device_node *elm_node;
> -
> -	info->bch =3D NULL;
> -
> -	max_errors =3D (ecc_opt =3D=3D OMAP_ECC_BCH8_CODE_HW) ?
> -		BCH8_MAX_ERROR : BCH4_MAX_ERROR;
> -	if (max_errors !=3D hw_errors) {
> -		pr_err("cannot configure %d-bit BCH ecc, only %d-bit supported",
> -		       max_errors, hw_errors);
> -		goto fail;
> -	}
> -
> -	info->nand.ecc.size =3D 512;
> -	info->nand.ecc.hwctl =3D omap3_enable_hwecc_bch;
> -	info->nand.ecc.mode =3D NAND_ECC_HW;
> -	info->nand.ecc.strength =3D max_errors;
> -
> -	if (hw_errors =3D=3D BCH8_MAX_ERROR)
> -		bch_type =3D BCH8_ECC;
> -	else
> -		bch_type =3D BCH4_ECC;
> -
> -	/* Detect availability of ELM module */
> -	parp =3D of_get_property(info->of_node, "elm_id", &lenp);
> -	if ((parp =3D=3D NULL) && (lenp !=3D (sizeof(void *) * 2))) {
> -		pr_err("Missing elm_id property, fall back to Software BCH\n");
> -		info->is_elm_used =3D false;
> -	} else {
> -		struct platform_device *pdev;
> -
> -		elm_node =3D of_find_node_by_phandle(be32_to_cpup(parp));
> -		pdev =3D of_find_device_by_node(elm_node);
> -		info->elm_dev =3D &pdev->dev;
> -
> -		if (elm_config(info->elm_dev, bch_type) =3D=3D 0)
> -			info->is_elm_used =3D true;
> +	struct platform_device *pdev;
> +	info->is_elm_used =3D false;
> +	/* check whether elm-id is passed via DT */
> +	if (!elm_node) {
> +		pr_err("nand: error: ELM DT node not found\n");
> +		return -ENODEV;
>  	}
> -
> -	if (info->is_elm_used && (mtd->writesize <=3D 4096)) {
> -
> -		if (hw_errors =3D=3D BCH8_MAX_ERROR)
> -			info->nand.ecc.bytes =3D BCH8_SIZE;
> -		else
> -			info->nand.ecc.bytes =3D BCH4_SIZE;
> -
> -		info->nand.ecc.correct =3D omap_elm_correct_data;
> -		info->nand.ecc.calculate =3D omap3_calculate_ecc_bch;
> -		info->nand.ecc.read_page =3D omap_read_page_bch;
> -		info->nand.ecc.write_page =3D omap_write_page_bch;
> -	} else {
> -		/*
> -		 * software bch library is only used to detect and
> -		 * locate errors
> -		 */
> -		info->bch =3D init_bch(13, max_errors,
> -				0x201b /* hw polynomial */);
> -		if (!info->bch)
> -			goto fail;
> -
> -		info->nand.ecc.correct =3D omap3_correct_data_bch;
> -
> -		/*
> -		 * The number of corrected errors in an ecc block that will
> -		 * trigger block scrubbing defaults to the ecc strength (4 or 8)
> -		 * Set mtd->bitflip_threshold here to define a custom threshold.
> -		 */
> -
> -		if (max_errors =3D=3D 8) {
> -			info->nand.ecc.bytes =3D 13;
> -			info->nand.ecc.calculate =3D omap3_calculate_ecc_bch8;
> -		} else {
> -			info->nand.ecc.bytes =3D 7;
> -			info->nand.ecc.calculate =3D omap3_calculate_ecc_bch4;
> -		}
> +	pdev =3D of_find_device_by_node(elm_node);
> +	/* check whether ELM device is registered */
> +	if (!pdev) {
> +		pr_err("nand: error: ELM device not found\n");
> +		return -ENODEV;
>  	}
> -
> -	pr_info("enabling NAND BCH ecc with %d-bit correction\n", max_errors);
> +	/* ELM module available, now configure it */
> +	info->elm_dev =3D &pdev->dev;
> +	if (elm_config(info->elm_dev, bch_type))
> +		return -ENODEV;
> +	info->is_elm_used =3D true;
>  	return 0;
> -fail:
> -	omap3_free_bch(mtd);
> -	return -1;
>  }
> +#endif /* CONFIG_MTD_NAND_ECC_BCH */
> =20
> +#ifdef CONFIG_MTD_NAND_ECC_BCH
>  /**
> - * omap3_init_bch_tail - Build an oob layout for BCH ECC correction.
> + * omap3_free_bch - Release BCH ecc resources
>   * @mtd: MTD device structure
>   */
> -static int omap3_init_bch_tail(struct mtd_info *mtd)
> +static void omap3_free_bch(struct mtd_info *mtd)
>  {
> -	int i, steps, offset;
>  	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_info,
>  						   mtd);
> -	struct nand_ecclayout *layout =3D &info->ecclayout;
> -
> -	/* build oob layout */
> -	steps =3D mtd->writesize/info->nand.ecc.size;
> -	layout->eccbytes =3D steps*info->nand.ecc.bytes;
> -
> -	/* do not bother creating special oob layouts for small page devices */
> -	if (mtd->oobsize < 64) {
> -		pr_err("BCH ecc is not supported on small page devices\n");
> -		goto fail;
> -	}
> -
> -	/* reserve 2 bytes for bad block marker */
> -	if (layout->eccbytes+2 > mtd->oobsize) {
> -		pr_err("no oob layout available for oobsize %d eccbytes %u\n",
> -		       mtd->oobsize, layout->eccbytes);
> -		goto fail;
> +	if (info->bch) {
> +		free_bch(info->bch);
> +		info->bch =3D NULL;
>  	}
> -
> -	/* ECC layout compatible with RBL for BCH8 */
> -	if (info->is_elm_used && (info->nand.ecc.bytes =3D=3D BCH8_SIZE))
> -		offset =3D 2;
> -	else
> -		offset =3D mtd->oobsize - layout->eccbytes;
> -
> -	/* put ecc bytes at oob tail */
> -	for (i =3D 0; i < layout->eccbytes; i++)
> -		layout->eccpos[i] =3D offset + i;
> -
> -	if (info->is_elm_used && (info->nand.ecc.bytes =3D=3D BCH8_SIZE))
> -		layout->oobfree[0].offset =3D 2 + layout->eccbytes * steps;
> -	else
> -		layout->oobfree[0].offset =3D 2;
> -
> -	layout->oobfree[0].length =3D mtd->oobsize-2-layout->eccbytes;
> -	info->nand.ecc.layout =3D layout;
> -
> -	if (!(info->nand.options & NAND_BUSWIDTH_16))
> -		info->nand.badblock_pattern =3D &bb_descrip_flashbased;
> -	return 0;
> -fail:
> -	omap3_free_bch(mtd);
> -	return -1;
>  }
> =20
>  #else
> -static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
> -{
> -	pr_err("CONFIG_MTD_NAND_OMAP_BCH is not enabled\n");
> -	return -1;
> -}
> -static int omap3_init_bch_tail(struct mtd_info *mtd)
> -{
> -	return -1;
> -}
> +
>  static void omap3_free_bch(struct mtd_info *mtd)
>  {
>  }
> -#endif /* CONFIG_MTD_NAND_OMAP_BCH */
> +#endif /* CONFIG_MTD_NAND_ECC_BCH */
> =20
>  static int omap_nand_probe(struct platform_device *pdev)
>  {
>  	struct omap_nand_info		*info;
>  	struct omap_nand_platform_data	*pdata;
> +	struct mtd_info			*mtd;
> +	struct nand_chip		*nand_chip;
> +	struct nand_ecclayout		*ecclayout;
>  	int				err;
> -	int				i, offset;
> -	dma_cap_mask_t mask;
> -	unsigned sig;
> +	int				i;
> +	dma_cap_mask_t			mask;
> +	unsigned			sig;
>  	struct resource			*res;
>  	struct mtd_part_parser_data	ppdata =3D {};
> =20
> @@ -1846,20 +1726,18 @@ static int omap_nand_probe(struct platform_device=
 *pdev)
>  	spin_lock_init(&info->controller.lock);
>  	init_waitqueue_head(&info->controller.wq);
> =20
> -	info->pdev =3D pdev;
> -
> +	mtd			=3D &info->mtd;
> +	mtd->name		=3D dev_name(&pdev->dev);
> +	mtd->owner		=3D THIS_MODULE;
> +	mtd->priv		=3D &info->nand;
> +	nand_chip		=3D &info->nand;
> +	info->pdev		=3D pdev;
>  	info->gpmc_cs		=3D pdata->cs;
>  	info->reg		=3D pdata->reg;
> +	info->bch		=3D NULL;
> =20
> -	info->mtd.priv		=3D &info->nand;
> -	info->mtd.name		=3D dev_name(&pdev->dev);
> -	info->mtd.owner		=3D THIS_MODULE;
> -
> -	info->nand.options	=3D pdata->devsize;
> -	info->nand.options	|=3D NAND_SKIP_BBTSCAN;
> -#ifdef CONFIG_MTD_NAND_OMAP_BCH
> +	nand_chip->options	|=3D NAND_SKIP_BBTSCAN | NAND_BUSWIDTH_AUTO;
>  	info->of_node		=3D pdata->of_node;
> -#endif
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (res =3D=3D NULL) {
> @@ -1903,6 +1781,30 @@ static int omap_nand_probe(struct platform_device =
*pdev)
>  		info->nand.chip_delay =3D 50;
>  	}
> =20
> +	/* scan NAND device conncted to controller */
> +	if (nand_scan_ident(mtd, 1, NULL)) {
> +		err =3D -ENXIO;
> +		goto out_release_mem_region;
> +	}
> +	pr_info("%s: detected %s NAND flash\n", DRIVER_NAME,
> +			(nand_chip->options & NAND_BUSWIDTH_16) ? "x16" : "x8");
> +	if ((nand_chip->options & NAND_BUSWIDTH_16) !=3D
> +			(pdata->devsize & NAND_BUSWIDTH_16)) {
> +		pr_err("%s: but incorrectly configured as %s", DRIVER_NAME,
> +			(pdata->devsize & NAND_BUSWIDTH_16) ? "x16" : "x8");
> +		err =3D -EINVAL;
> +		goto out_release_mem_region;
> +	}
> +
> +	/* check for small page devices */
> +	if ((mtd->oobsize < 64) &&
> +		(pdata->ecc_opt !=3D OMAP_ECC_HAM1_CODE_HW)) {
> +		pr_err("small page devices are not supported\n");
> +		err =3D -EINVAL;
> +		goto out_release_mem_region;
> +	}
> +
> +	/* populate read & write API based on xfer_type selected */
>  	switch (pdata->xfer_type) {
>  	case NAND_OMAP_PREFETCH_POLLED:
>  		info->nand.read_buf   =3D omap_read_buf_pref;
> @@ -1992,61 +1894,148 @@ static int omap_nand_probe(struct platform_devic=
e *pdev)
>  		goto out_release_mem_region;
>  	}
> =20
> -	/* select the ecc type */
> -	if (pdata->ecc_opt =3D=3D OMAP_ECC_HAM1_CODE_HW) {
> -		info->nand.ecc.bytes            =3D 3;
> -		info->nand.ecc.size             =3D 512;
> -		info->nand.ecc.strength         =3D 1;
> -		info->nand.ecc.calculate        =3D omap_calculate_ecc;
> -		info->nand.ecc.hwctl            =3D omap_enable_hwecc;
> -		info->nand.ecc.correct          =3D omap_correct_data;
> -		info->nand.ecc.mode             =3D NAND_ECC_HW;
> -	} else if ((pdata->ecc_opt =3D=3D OMAP_ECC_BCH4_CODE_HW) ||
> -		   (pdata->ecc_opt =3D=3D OMAP_ECC_BCH8_CODE_HW)) {
> -		err =3D omap3_init_bch(&info->mtd, pdata->ecc_opt);
> -		if (err) {
> +	/* populate MTD interface based on ECC scheme */
> +	nand_chip->ecc.layout	=3D &omap_oobinfo;
> +	ecclayout		=3D &omap_oobinfo;
> +	switch (pdata->ecc_opt) {
> +	case OMAP_ECC_HAM1_CODE_HW:
> +		pr_info("nand: using OMAP_ECC_HAM1_CODE_HW\n");
> +		nand_chip->ecc.mode             =3D NAND_ECC_HW;
> +		nand_chip->ecc.bytes            =3D 3;
> +		nand_chip->ecc.size             =3D 512;
> +		nand_chip->ecc.strength         =3D 1;
> +		nand_chip->ecc.calculate        =3D omap_calculate_ecc;
> +		nand_chip->ecc.hwctl            =3D omap_enable_hwecc;
> +		nand_chip->ecc.correct          =3D omap_correct_data;
> +		/* define custom ECC layout */
> +		ecclayout->eccbytes		=3D nand_chip->ecc.bytes *
> +							(mtd->writesize /
> +							nand_chip->ecc.size);
> +		if (nand_chip->options & NAND_BUSWIDTH_16)
> +			ecclayout->eccpos[0]	=3D BADBLOCK_MARKER_LENGTH;
> +		else
> +			ecclayout->eccpos[0]	=3D 1;
> +		ecclayout->oobfree->offset	=3D ecclayout->eccpos[0] +
> +							ecclayout->eccbytes;
> +		break;
> +
> +	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
> +#ifdef CONFIG_MTD_NAND_ECC_BCH
> +		pr_info("nand: using OMAP_ECC_BCH4_CODE_HW_DETECTION_SW\n");
> +		nand_chip->ecc.mode		=3D NAND_ECC_HW;
> +		nand_chip->ecc.size		=3D 512;
> +		nand_chip->ecc.bytes		=3D 7;
> +		nand_chip->ecc.strength		=3D 4;
> +		nand_chip->ecc.hwctl		=3D omap3_enable_hwecc_bch;
> +		nand_chip->ecc.correct		=3D omap3_correct_data_bch;
> +		nand_chip->ecc.calculate	=3D omap3_calculate_ecc_bch4;
> +		/* define custom ECC layout */
> +		ecclayout->eccbytes		=3D nand_chip->ecc.bytes *
> +							(mtd->writesize /
> +							nand_chip->ecc.size);
> +		ecclayout->eccpos[0]		=3D BADBLOCK_MARKER_LENGTH;
> +		ecclayout->oobfree->offset	=3D ecclayout->eccpos[0] +
> +							ecclayout->eccbytes;
> +		/* software bch library is used for locating errors */
> +		info->bch =3D init_bch(nand_chip->ecc.bytes,
> +					nand_chip->ecc.strength,
> +					OMAP_ECC_BCH8_POLYNOMIAL);
> +		if (!info->bch) {
> +			pr_err("nand: error: unable to use s/w BCH library\n");
>  			err =3D -EINVAL;
> -			goto out_release_mem_region;
>  		}
> -	}
> +		break;
> +#else
> +		pr_err("nand: error: CONFIG_MTD_NAND_ECC_BCH not enabled\n");
> +		err =3D -EINVAL;
> +		goto out_release_mem_region;
> +#endif
> =20
> -	/* DIP switches on some boards change between 8 and 16 bit
> -	 * bus widths for flash.  Try the other width if the first try fails.
> -	 */
> -	if (nand_scan_ident(&info->mtd, 1, NULL)) {
> -		info->nand.options ^=3D NAND_BUSWIDTH_16;
> -		if (nand_scan_ident(&info->mtd, 1, NULL)) {
> -			err =3D -ENXIO;
> +	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
> +#ifdef CONFIG_MTD_NAND_ECC_BCH
> +		pr_info("nand: using OMAP_ECC_BCH8_CODE_HW_DETECTION_SW\n");
> +		nand_chip->ecc.mode		=3D NAND_ECC_HW;
> +		nand_chip->ecc.size		=3D 512;
> +		nand_chip->ecc.bytes		=3D 13;
> +		nand_chip->ecc.strength		=3D 8;
> +		nand_chip->ecc.hwctl		=3D omap3_enable_hwecc_bch;
> +		nand_chip->ecc.correct		=3D omap3_correct_data_bch;
> +		nand_chip->ecc.calculate	=3D omap3_calculate_ecc_bch8;
> +		/* define custom ECC layout */
> +		ecclayout->eccbytes		=3D nand_chip->ecc.bytes *
> +							(mtd->writesize /
> +							nand_chip->ecc.size);
> +		ecclayout->eccpos[0]		=3D BADBLOCK_MARKER_LENGTH;
> +		ecclayout->oobfree->offset	=3D ecclayout->eccpos[0] +
> +							ecclayout->eccbytes;
> +		/* software bch library is used for locating errors */
> +		info->bch =3D init_bch(nand_chip->ecc.bytes,
> +					nand_chip->ecc.strength,
> +					OMAP_ECC_BCH8_POLYNOMIAL);
> +		if (!info->bch) {
> +			pr_err("nand: error: unable to use s/w BCH library\n");
> +			err =3D -EINVAL;
>  			goto out_release_mem_region;
>  		}
> -	}
> -
> -	/* rom code layout */
> -	if (pdata->ecc_opt =3D=3D OMAP_ECC_HAM1_CODE_HW) {
> +		break;
> +#else
> +		pr_err("nand: error: CONFIG_MTD_NAND_ECC_BCH not enabled\n");
> +		err =3D -EINVAL;
> +		goto out_release_mem_region;
> +#endif
> =20
> -		if (info->nand.options & NAND_BUSWIDTH_16)
> -			offset =3D 2;
> -		else {
> -			offset =3D 1;
> -			info->nand.badblock_pattern =3D &bb_descrip_flashbased;
> -		}
> -		omap_oobinfo.eccbytes =3D 3 * (info->mtd.writesize / 512);
> -		for (i =3D 0; i < omap_oobinfo.eccbytes; i++)
> -			omap_oobinfo.eccpos[i] =3D i+offset;
> -
> -		omap_oobinfo.oobfree->offset =3D offset + omap_oobinfo.eccbytes;
> -		omap_oobinfo.oobfree->length =3D info->mtd.oobsize -
> -					(offset + omap_oobinfo.eccbytes);
> -
> -		info->nand.ecc.layout =3D &omap_oobinfo;
> -	} else if ((pdata->ecc_opt =3D=3D OMAP_ECC_BCH4_CODE_HW) ||
> -		   (pdata->ecc_opt =3D=3D OMAP_ECC_BCH8_CODE_HW)) {
> -		/* build OOB layout for BCH ECC correction */
> -		err =3D omap3_init_bch_tail(&info->mtd);
> -		if (err) {
> -			err =3D -EINVAL;
> +	case OMAP_ECC_BCH8_CODE_HW:
> +#ifdef CONFIG_MTD_NAND_OMAP_BCH
> +		pr_info("nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme\n");
> +		nand_chip->ecc.mode		=3D NAND_ECC_HW;
> +		nand_chip->ecc.size		=3D 512;
> +		/* 14th bit is kept reserved for ROM-code compatibility */
> +		nand_chip->ecc.bytes		=3D 13 + 1;
> +		nand_chip->ecc.strength		=3D 8;
> +		nand_chip->ecc.hwctl		=3D omap3_enable_hwecc_bch;
> +		nand_chip->ecc.correct		=3D omap_elm_correct_data;
> +		nand_chip->ecc.calculate	=3D omap3_calculate_ecc_bch;
> +		nand_chip->ecc.read_page	=3D omap_read_page_bch;
> +		nand_chip->ecc.write_page	=3D omap_write_page_bch;
> +		/* This ECC scheme requires ELM H/W block */
> +		if (is_elm_present(info, pdata->elm_of_node, BCH8_ECC) < 0) {
> +			pr_err("nand: error: could not initialize ELM\n");
>  			goto out_release_mem_region;
>  		}
> +		/* define custom ECC layout */
> +		ecclayout->eccbytes		=3D nand_chip->ecc.bytes *
> +							(mtd->writesize /
> +							nand_chip->ecc.size);
> +		ecclayout->eccpos[0]		=3D BADBLOCK_MARKER_LENGTH;
> +		ecclayout->oobfree->offset	=3D ecclayout->eccpos[0] +
> +							ecclayout->eccbytes;
> +		break;
> +#else
> +		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
> +		err =3D -EINVAL;
> +		goto out_release_mem_region;
> +#endif
> +
> +	default:
> +		pr_err("nand: error: invalid or unsupported ECC scheme\n");
> +		err =3D -EINVAL;
> +		goto out_release_mem_region;
> +	}
> +
> +	/* populate remaining info for custom ecc layout */
> +	pr_info("%s: using custom ecc layout\n", DRIVER_NAME);
> +	ecclayout->oobfree->length =3D mtd->oobsize - BADBLOCK_MARKER_LENGTH
> +						- ecclayout->eccbytes;
> +	if (!(nand_chip->options & NAND_BUSWIDTH_16))
> +		nand_chip->badblock_pattern =3D &bb_descrip_flashbased;
> +	for (i =3D 1; i < ecclayout->eccbytes; i++)
> +		ecclayout->eccpos[i] =3D ecclayout->eccpos[0] + i;
> +	/* check if NAND OOBSIZE meets ECC scheme requirement */
> +	if (mtd->oobsize < (ecclayout->eccbytes + BADBLOCK_MARKER_LENGTH)) {
> +		pr_err("not enough OOB bytes required =3D %d, available=3D%d\n",
> +			ecclayout->eccbytes, mtd->oobsize);
> +		err =3D -EINVAL;
> +		goto out_release_mem_region;
>  	}
> =20
>  	/* second phase scan */
> @@ -2072,6 +2061,7 @@ out_release_mem_region:
>  		free_irq(info->gpmc_irq_fifo, info);
>  	release_mem_region(info->phys_base, info->mem_size);
>  out_free_info:
> +	omap3_free_bch(&info->mtd);
>  	kfree(info);
> =20
>  	return err;
> --=20
> 1.8.1
>=20

--=20
balbi

--E1BPhOSoTthPQdPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSWB+AAAoJEIaOsuA1yqREA/QP/iAir/BFTaiNyGsqXmLzVG/E
RiurABu3Sdb4GRS6/fHGlXB2/PtZKciFRkpg9KpQ5B5tQxO8HqrcnPJ9VQfzNU32
KWVww1lQiS6X0JjmgemDimkQf0sBJadQMwwYTcd9hnXbIXvgq5QDUvxKAiCgojx3
sXuQUeM/fWLfk4yJPW6Sefh+1TMR8N6JIG+W/ZETmlBkEXS4Wpi9GsupccNXcPSI
deirtnw4W4JUMXh1pZRQsIJ9MSLydq894lhBLkP5mXutOR0I8yyHWZ9mZY3fWJFf
ajPcFhEyE6aWmXY9Bo312AKacS0TpyLGW+gwl2CZYMVu5NnlfBJ4c+Q8ppkIbrdR
8tNC/uCGDvn8GoBhOAuli6je+QOefOcT6ugvebDjbIybHaCewIfrD6J4dZLBrGbf
ssriRFVopCoi6ye7lkhbdBALiihCLuCaXQIR7tOMC7fk2XRaVmw9w4Bs94wUyOcN
Ell1Ngxy/6CrNu1hecq4nKyeftadrAdHKr+z4Igt/PljrjvlbncHQYXjr4ETy7cQ
04UNKHiaW4EU26A9jnVE1qEdjc8/K5il3ASxWgZp4gIbnWz8uzMi7i5SV7gajghW
yClc7AZs6cAEBe6ItSqybXdfzRS5KM59ACZfMgMeVBmUuqwih09P+eu78C/x7oY0
lj0EraCzXkhrcf6InojE
=32DV
-----END PGP SIGNATURE-----

--E1BPhOSoTthPQdPL--
