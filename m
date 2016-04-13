From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 02/12] mtd: nand: atmel: rely on generic DT
 parsing done in nand_scan_ident()
Date: Wed, 13 Apr 2016 14:31:43 +0200
Message-ID: <20160413143143.6c4b7de8@bbrezillon>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
	<1459515272-31011-3-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBMPYXC4AKGQEP4J4KPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1459515272-31011-3-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Zhou Wang <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Alex Smith <alex.smith-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Harvey Hunt <harvey.hunt-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri,  1 Apr 2016 14:54:22 +0200
Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> The core now takes care of parsing generic DT properties in
> nand_scan_ident() when nand_set_flash_node() has been called.
> Rely on this initialization instead of calling of_get_nand_xxx()
> manually.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Tested on sama5d4ek.

Tested-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

> ---
>  drivers/mtd/nand/atmel_nand.c | 133 +++++++++++++++++++++++-------------------
>  1 file changed, 73 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
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
>  	struct nand_chip *chip = mtd_to_nand(mtd);
> -	struct atmel_nand_host *host = nand_get_controller_data(chip);
>  
>  	if (use_dma && len > mtd->oobsize)
>  		/* only use DMA for bigger than oob size: better performances */
>  		if (atmel_nand_dma_op(mtd, buf, len, 1) == 0)
>  			return;
>  
> -	if (host->board.bus_width_16)
> +	if (chip->options & NAND_BUSWIDTH_16)
>  		atmel_read_buf16(mtd, buf, len);
>  	else
>  		atmel_read_buf8(mtd, buf, len);
> @@ -450,14 +448,13 @@ static void atmel_read_buf(struct mtd_info *mtd, u8 *buf, int len)
>  static void atmel_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
>  {
>  	struct nand_chip *chip = mtd_to_nand(mtd);
> -	struct atmel_nand_host *host = nand_get_controller_data(chip);
>  
>  	if (use_dma && len > mtd->oobsize)
>  		/* only use DMA for bigger than oob size: better performances */
>  		if (atmel_nand_dma_op(mtd, (void *)buf, len, 0) == 0)
>  			return;
>  
> -	if (host->board.bus_width_16)
> +	if (chip->options & NAND_BUSWIDTH_16)
>  		atmel_write_buf16(mtd, buf, len);
>  	else
>  		atmel_write_buf8(mtd, buf, len);
> @@ -1507,58 +1504,17 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
>  		ecc_writel(host->ecc, CR, ATMEL_ECC_RST);
>  }
>  
> -static int atmel_of_init_port(struct atmel_nand_host *host,
> -			      struct device_node *np)
> +static int atmel_of_init_ecc(struct atmel_nand_host *host,
> +			     struct device_node *np)
>  {
> -	u32 val;
>  	u32 offset[2];
> -	int ecc_mode;
> -	struct atmel_nand_data *board = &host->board;
> -	enum of_gpio_flags flags = 0;
> -
> -	host->caps = (struct atmel_nand_caps *)
> -		of_device_get_match_data(host->dev);
> -
> -	if (of_property_read_u32(np, "atmel,nand-addr-offset", &val) == 0) {
> -		if (val >= 32) {
> -			dev_err(host->dev, "invalid addr-offset %u\n", val);
> -			return -EINVAL;
> -		}
> -		board->ale = val;
> -	}
> -
> -	if (of_property_read_u32(np, "atmel,nand-cmd-offset", &val) == 0) {
> -		if (val >= 32) {
> -			dev_err(host->dev, "invalid cmd-offset %u\n", val);
> -			return -EINVAL;
> -		}
> -		board->cle = val;
> -	}
> -
> -	ecc_mode = of_get_nand_ecc_mode(np);
> -
> -	board->ecc_mode = ecc_mode < 0 ? NAND_ECC_SOFT : ecc_mode;
> -
> -	board->on_flash_bbt = of_get_nand_on_flash_bbt(np);
> -
> -	board->has_dma = of_property_read_bool(np, "atmel,nand-has-dma");
> -
> -	if (of_get_nand_bus_width(np) == 16)
> -		board->bus_width_16 = 1;
> -
> -	board->rdy_pin = of_get_gpio_flags(np, 0, &flags);
> -	board->rdy_pin_active_low = (flags == OF_GPIO_ACTIVE_LOW);
> -
> -	board->enable_pin = of_get_gpio(np, 1);
> -	board->det_pin = of_get_gpio(np, 2);
> +	u32 val;
>  
>  	host->has_pmecc = of_property_read_bool(np, "atmel,has-pmecc");
>  
> -	/* load the nfc driver if there is */
> -	of_platform_populate(np, NULL, NULL, host->dev);
> -
> -	if (!(board->ecc_mode == NAND_ECC_HW) || !host->has_pmecc)
> -		return 0;	/* Not using PMECC */
> +	/* Not using PMECC */
> +	if (!(host->nand_chip.ecc.mode == NAND_ECC_HW) || !host->has_pmecc)
> +		return 0;
>  
>  	/* use PMECC, get correction capability, sector size and lookup
>  	 * table offset.
> @@ -1599,16 +1555,64 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
>  		/* Will build a lookup table and initialize the offset later */
>  		return 0;
>  	}
> +
>  	if (!offset[0] && !offset[1]) {
>  		dev_err(host->dev, "Invalid PMECC lookup table offset\n");
>  		return -EINVAL;
>  	}
> +
>  	host->pmecc_lookup_table_offset_512 = offset[0];
>  	host->pmecc_lookup_table_offset_1024 = offset[1];
>  
>  	return 0;
>  }
>  
> +static int atmel_of_init_port(struct atmel_nand_host *host,
> +			      struct device_node *np)
> +{
> +	u32 val;
> +	struct atmel_nand_data *board = &host->board;
> +	enum of_gpio_flags flags = 0;
> +
> +	host->caps = (struct atmel_nand_caps *)
> +		of_device_get_match_data(host->dev);
> +
> +	if (of_property_read_u32(np, "atmel,nand-addr-offset", &val) == 0) {
> +		if (val >= 32) {
> +			dev_err(host->dev, "invalid addr-offset %u\n", val);
> +			return -EINVAL;
> +		}
> +		board->ale = val;
> +	}
> +
> +	if (of_property_read_u32(np, "atmel,nand-cmd-offset", &val) == 0) {
> +		if (val >= 32) {
> +			dev_err(host->dev, "invalid cmd-offset %u\n", val);
> +			return -EINVAL;
> +		}
> +		board->cle = val;
> +	}
> +
> +	board->has_dma = of_property_read_bool(np, "atmel,nand-has-dma");
> +
> +	board->rdy_pin = of_get_gpio_flags(np, 0, &flags);
> +	board->rdy_pin_active_low = (flags == OF_GPIO_ACTIVE_LOW);
> +
> +	board->enable_pin = of_get_gpio(np, 1);
> +	board->det_pin = of_get_gpio(np, 2);
> +
> +	/* load the nfc driver if there is */
> +	of_platform_populate(np, NULL, NULL, host->dev);
> +
> +	/*
> +	 * Initialize ECC mode to NAND_ECC_SOFT so that we have a correct value
> +	 * even if the nand-ecc-mode property is not defined.
> +	 */
> +	host->nand_chip.ecc.mode = NAND_ECC_SOFT;
> +
> +	return 0;
> +}
> +
>  static int atmel_hw_nand_init_params(struct platform_device *pdev,
>  					 struct atmel_nand_host *host)
>  {
> @@ -2150,6 +2154,11 @@ static int atmel_nand_probe(struct platform_device *pdev)
>  	} else {
>  		memcpy(&host->board, dev_get_platdata(&pdev->dev),
>  		       sizeof(struct atmel_nand_data));
> +		nand_chip->ecc.mode = host->board.ecc_mode;
> +
> +		/* 16-bit bus width */
> +		if (host->board.bus_width_16)
> +			nand_chip->options |= NAND_BUSWIDTH_16;
>  	}
>  
>  	 /* link the private data structures */
> @@ -2191,11 +2200,8 @@ static int atmel_nand_probe(struct platform_device *pdev)
>  		nand_chip->cmd_ctrl = atmel_nand_cmd_ctrl;
>  	}
>  
> -	nand_chip->ecc.mode = host->board.ecc_mode;
>  	nand_chip->chip_delay = 40;		/* 40us command delay time */
>  
> -	if (host->board.bus_width_16)	/* 16-bit bus width */
> -		nand_chip->options |= NAND_BUSWIDTH_16;
>  
>  	nand_chip->read_buf = atmel_read_buf;
>  	nand_chip->write_buf = atmel_write_buf;
> @@ -2228,11 +2234,6 @@ static int atmel_nand_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	if (host->board.on_flash_bbt || on_flash_bbt) {
> -		dev_info(&pdev->dev, "Use On Flash BBT\n");
> -		nand_chip->bbt_options |= NAND_BBT_USE_FLASH;
> -	}
> -
>  	if (!host->board.has_dma)
>  		use_dma = 0;
>  
> @@ -2259,6 +2260,18 @@ static int atmel_nand_probe(struct platform_device *pdev)
>  		goto err_scan_ident;
>  	}
>  
> +	if (host->board.on_flash_bbt || on_flash_bbt)
> +		nand_chip->bbt_options |= NAND_BBT_USE_FLASH;
> +
> +	if (nand_chip->bbt_options & NAND_BBT_USE_FLASH)
> +		dev_info(&pdev->dev, "Use On Flash BBT\n");
> +
> +	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
> +		res = atmel_of_init_ecc(host, pdev->dev.of_node);
> +		if (res)
> +			goto err_hw_ecc;
> +	}
> +
>  	if (nand_chip->ecc.mode == NAND_ECC_HW) {
>  		if (host->has_pmecc)
>  			res = atmel_pmecc_nand_init_params(pdev, host);



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
