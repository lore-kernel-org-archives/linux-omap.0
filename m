From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 02/12] mtd: nand: atmel: rely on generic DT parsing done
 in nand_scan_ident()
Date: Wed, 13 Apr 2016 14:55:45 +0200
Message-ID: <570E41D1.3090609@atmel.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459515272-31011-3-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459515272-31011-3-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Han Xu <han.xu@nxp.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Agner <stefan@agner.ch>
Cc: linux-omap@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Zhou Wang <wangzhou1@hisilicon.com>, Alex Smith <alex.smith@imgtec.com>, Harvey Hunt <harvey.hunt@imgtec.com>
List-Id: linux-omap@vger.kernel.org

Le 01/04/2016 14:54, Boris Brezillon a =E9crit :
> The core now takes care of parsing generic DT properties in
> nand_scan_ident() when nand_set_flash_node() has been called.
> Rely on this initialization instead of calling of_get_nand_xxx()
> manually.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

It seems okay:
Reviewed-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks Boris, bye,


> ---
>  drivers/mtd/nand/atmel_nand.c | 133 +++++++++++++++++++++++---------=
----------
>  1 file changed, 73 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_n=
and.c
> index 0b5da72..5e716f2 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -36,7 +36,6 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
> -#include <linux/of_mtd.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/nand.h>
>  #include <linux/mtd/partitions.h>
> @@ -434,14 +433,13 @@ err_buf:
>  static void atmel_read_buf(struct mtd_info *mtd, u8 *buf, int len)
>  {
>  	struct nand_chip *chip =3D mtd_to_nand(mtd);
> -	struct atmel_nand_host *host =3D nand_get_controller_data(chip);
> =20
>  	if (use_dma && len > mtd->oobsize)
>  		/* only use DMA for bigger than oob size: better performances */
>  		if (atmel_nand_dma_op(mtd, buf, len, 1) =3D=3D 0)
>  			return;
> =20
> -	if (host->board.bus_width_16)
> +	if (chip->options & NAND_BUSWIDTH_16)
>  		atmel_read_buf16(mtd, buf, len);
>  	else
>  		atmel_read_buf8(mtd, buf, len);
> @@ -450,14 +448,13 @@ static void atmel_read_buf(struct mtd_info *mtd=
, u8 *buf, int len)
>  static void atmel_write_buf(struct mtd_info *mtd, const u8 *buf, int=
 len)
>  {
>  	struct nand_chip *chip =3D mtd_to_nand(mtd);
> -	struct atmel_nand_host *host =3D nand_get_controller_data(chip);
> =20
>  	if (use_dma && len > mtd->oobsize)
>  		/* only use DMA for bigger than oob size: better performances */
>  		if (atmel_nand_dma_op(mtd, (void *)buf, len, 0) =3D=3D 0)
>  			return;
> =20
> -	if (host->board.bus_width_16)
> +	if (chip->options & NAND_BUSWIDTH_16)
>  		atmel_write_buf16(mtd, buf, len);
>  	else
>  		atmel_write_buf8(mtd, buf, len);
> @@ -1507,58 +1504,17 @@ static void atmel_nand_hwctl(struct mtd_info =
*mtd, int mode)
>  		ecc_writel(host->ecc, CR, ATMEL_ECC_RST);
>  }
> =20
> -static int atmel_of_init_port(struct atmel_nand_host *host,
> -			      struct device_node *np)
> +static int atmel_of_init_ecc(struct atmel_nand_host *host,
> +			     struct device_node *np)
>  {
> -	u32 val;
>  	u32 offset[2];
> -	int ecc_mode;
> -	struct atmel_nand_data *board =3D &host->board;
> -	enum of_gpio_flags flags =3D 0;
> -
> -	host->caps =3D (struct atmel_nand_caps *)
> -		of_device_get_match_data(host->dev);
> -
> -	if (of_property_read_u32(np, "atmel,nand-addr-offset", &val) =3D=3D=
 0) {
> -		if (val >=3D 32) {
> -			dev_err(host->dev, "invalid addr-offset %u\n", val);
> -			return -EINVAL;
> -		}
> -		board->ale =3D val;
> -	}
> -
> -	if (of_property_read_u32(np, "atmel,nand-cmd-offset", &val) =3D=3D =
0) {
> -		if (val >=3D 32) {
> -			dev_err(host->dev, "invalid cmd-offset %u\n", val);
> -			return -EINVAL;
> -		}
> -		board->cle =3D val;
> -	}
> -
> -	ecc_mode =3D of_get_nand_ecc_mode(np);
> -
> -	board->ecc_mode =3D ecc_mode < 0 ? NAND_ECC_SOFT : ecc_mode;
> -
> -	board->on_flash_bbt =3D of_get_nand_on_flash_bbt(np);
> -
> -	board->has_dma =3D of_property_read_bool(np, "atmel,nand-has-dma");
> -
> -	if (of_get_nand_bus_width(np) =3D=3D 16)
> -		board->bus_width_16 =3D 1;
> -
> -	board->rdy_pin =3D of_get_gpio_flags(np, 0, &flags);
> -	board->rdy_pin_active_low =3D (flags =3D=3D OF_GPIO_ACTIVE_LOW);
> -
> -	board->enable_pin =3D of_get_gpio(np, 1);
> -	board->det_pin =3D of_get_gpio(np, 2);
> +	u32 val;
> =20
>  	host->has_pmecc =3D of_property_read_bool(np, "atmel,has-pmecc");
> =20
> -	/* load the nfc driver if there is */
> -	of_platform_populate(np, NULL, NULL, host->dev);
> -
> -	if (!(board->ecc_mode =3D=3D NAND_ECC_HW) || !host->has_pmecc)
> -		return 0;	/* Not using PMECC */
> +	/* Not using PMECC */
> +	if (!(host->nand_chip.ecc.mode =3D=3D NAND_ECC_HW) || !host->has_pm=
ecc)
> +		return 0;
> =20
>  	/* use PMECC, get correction capability, sector size and lookup
>  	 * table offset.
> @@ -1599,16 +1555,64 @@ static int atmel_of_init_port(struct atmel_na=
nd_host *host,
>  		/* Will build a lookup table and initialize the offset later */
>  		return 0;
>  	}
> +
>  	if (!offset[0] && !offset[1]) {
>  		dev_err(host->dev, "Invalid PMECC lookup table offset\n");
>  		return -EINVAL;
>  	}
> +
>  	host->pmecc_lookup_table_offset_512 =3D offset[0];
>  	host->pmecc_lookup_table_offset_1024 =3D offset[1];
> =20
>  	return 0;
>  }
> =20
> +static int atmel_of_init_port(struct atmel_nand_host *host,
> +			      struct device_node *np)
> +{
> +	u32 val;
> +	struct atmel_nand_data *board =3D &host->board;
> +	enum of_gpio_flags flags =3D 0;
> +
> +	host->caps =3D (struct atmel_nand_caps *)
> +		of_device_get_match_data(host->dev);
> +
> +	if (of_property_read_u32(np, "atmel,nand-addr-offset", &val) =3D=3D=
 0) {
> +		if (val >=3D 32) {
> +			dev_err(host->dev, "invalid addr-offset %u\n", val);
> +			return -EINVAL;
> +		}
> +		board->ale =3D val;
> +	}
> +
> +	if (of_property_read_u32(np, "atmel,nand-cmd-offset", &val) =3D=3D =
0) {
> +		if (val >=3D 32) {
> +			dev_err(host->dev, "invalid cmd-offset %u\n", val);
> +			return -EINVAL;
> +		}
> +		board->cle =3D val;
> +	}
> +
> +	board->has_dma =3D of_property_read_bool(np, "atmel,nand-has-dma");
> +
> +	board->rdy_pin =3D of_get_gpio_flags(np, 0, &flags);
> +	board->rdy_pin_active_low =3D (flags =3D=3D OF_GPIO_ACTIVE_LOW);
> +
> +	board->enable_pin =3D of_get_gpio(np, 1);
> +	board->det_pin =3D of_get_gpio(np, 2);
> +
> +	/* load the nfc driver if there is */
> +	of_platform_populate(np, NULL, NULL, host->dev);
> +
> +	/*
> +	 * Initialize ECC mode to NAND_ECC_SOFT so that we have a correct v=
alue
> +	 * even if the nand-ecc-mode property is not defined.
> +	 */
> +	host->nand_chip.ecc.mode =3D NAND_ECC_SOFT;
> +
> +	return 0;
> +}
> +
>  static int atmel_hw_nand_init_params(struct platform_device *pdev,
>  					 struct atmel_nand_host *host)
>  {
> @@ -2150,6 +2154,11 @@ static int atmel_nand_probe(struct platform_de=
vice *pdev)
>  	} else {
>  		memcpy(&host->board, dev_get_platdata(&pdev->dev),
>  		       sizeof(struct atmel_nand_data));
> +		nand_chip->ecc.mode =3D host->board.ecc_mode;
> +
> +		/* 16-bit bus width */
> +		if (host->board.bus_width_16)
> +			nand_chip->options |=3D NAND_BUSWIDTH_16;
>  	}
> =20
>  	 /* link the private data structures */
> @@ -2191,11 +2200,8 @@ static int atmel_nand_probe(struct platform_de=
vice *pdev)
>  		nand_chip->cmd_ctrl =3D atmel_nand_cmd_ctrl;
>  	}
> =20
> -	nand_chip->ecc.mode =3D host->board.ecc_mode;
>  	nand_chip->chip_delay =3D 40;		/* 40us command delay time */
> =20
> -	if (host->board.bus_width_16)	/* 16-bit bus width */
> -		nand_chip->options |=3D NAND_BUSWIDTH_16;
> =20
>  	nand_chip->read_buf =3D atmel_read_buf;
>  	nand_chip->write_buf =3D atmel_write_buf;
> @@ -2228,11 +2234,6 @@ static int atmel_nand_probe(struct platform_de=
vice *pdev)
>  		}
>  	}
> =20
> -	if (host->board.on_flash_bbt || on_flash_bbt) {
> -		dev_info(&pdev->dev, "Use On Flash BBT\n");
> -		nand_chip->bbt_options |=3D NAND_BBT_USE_FLASH;
> -	}
> -
>  	if (!host->board.has_dma)
>  		use_dma =3D 0;
> =20
> @@ -2259,6 +2260,18 @@ static int atmel_nand_probe(struct platform_de=
vice *pdev)
>  		goto err_scan_ident;
>  	}
> =20
> +	if (host->board.on_flash_bbt || on_flash_bbt)
> +		nand_chip->bbt_options |=3D NAND_BBT_USE_FLASH;
> +
> +	if (nand_chip->bbt_options & NAND_BBT_USE_FLASH)
> +		dev_info(&pdev->dev, "Use On Flash BBT\n");
> +
> +	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
> +		res =3D atmel_of_init_ecc(host, pdev->dev.of_node);
> +		if (res)
> +			goto err_hw_ecc;
> +	}
> +
>  	if (nand_chip->ecc.mode =3D=3D NAND_ECC_HW) {
>  		if (host->has_pmecc)
>  			res =3D atmel_pmecc_nand_init_params(pdev, host);
>=20


--=20
Nicolas Ferre
