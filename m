From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 11/27] mtd: nand: omap: Clean up device tree support
Date: Wed, 2 Dec 2015 20:29:54 -0800
Message-ID: <20151203042954.GB120110@google.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <1442588029-13769-12-git-send-email-rogerq@ti.com>
 <5613A404.9010106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5613A404.9010106-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Tue, Oct 06, 2015 at 01:35:48PM +0300, Roger Quadros wrote:
> Move NAND specific device tree parsing to NAND driver.
> 
> The NAND controller node must have a compatible id, register space
> resource and interrupt resource.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

This one's going to need rebased, as there are some conflicting of_node
changes in l2-mtd.git.

> ---
> v4: Warn if using older incompatible DT i.e. compatible property not present
> in nand node.
> 
>  arch/arm/mach-omap2/gpmc-nand.c              |   5 +-
>  drivers/memory/omap-gpmc.c                   | 143 +++++++--------------------
>  drivers/mtd/nand/omap2.c                     | 136 +++++++++++++++++++++----
>  include/linux/platform_data/mtd-nand-omap2.h |   3 +-
>  4 files changed, 155 insertions(+), 132 deletions(-)

Also, this is going to be hard to manage across trees, as you touch
three drivers all at once. Is it not possible to split any of this apart
better?

> 
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index ffe646a..e07ca27 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -95,10 +95,7 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>  	gpmc_nand_res[1].start = gpmc_get_irq();
>  
>  	memset(&s, 0, sizeof(struct gpmc_settings));
> -	if (gpmc_nand_data->of_node)
> -		gpmc_read_settings_dt(gpmc_nand_data->of_node, &s);
> -	else
> -		gpmc_set_legacy(gpmc_nand_data, &s);
> +	gpmc_set_legacy(gpmc_nand_data, &s);
>  
>  	s.device_nand = true;
>  
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index e75226d..318c187 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -29,7 +29,6 @@
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
>  #include <linux/omap-gpmc.h>
> -#include <linux/mtd/nand.h>
>  #include <linux/pm_runtime.h>
>  
>  #include <linux/platform_data/mtd-nand-omap2.h>
> @@ -1716,105 +1715,6 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
>  		of_property_read_bool(np, "gpmc,time-para-granularity");
>  }
>  
> -#if IS_ENABLED(CONFIG_MTD_NAND)
> -
> -static const char * const nand_xfer_types[] = {
> -	[NAND_OMAP_PREFETCH_POLLED]		= "prefetch-polled",
> -	[NAND_OMAP_POLLED]			= "polled",
> -	[NAND_OMAP_PREFETCH_DMA]		= "prefetch-dma",
> -	[NAND_OMAP_PREFETCH_IRQ]		= "prefetch-irq",
> -};
> -
> -static int gpmc_probe_nand_child(struct platform_device *pdev,
> -				 struct device_node *child)
> -{
> -	u32 val;
> -	const char *s;
> -	struct gpmc_timings gpmc_t;
> -	struct omap_nand_platform_data *gpmc_nand_data;
> -
> -	if (of_property_read_u32(child, "reg", &val) < 0) {
> -		dev_err(&pdev->dev, "%s has no 'reg' property\n",
> -			child->full_name);
> -		return -ENODEV;
> -	}
> -
> -	gpmc_nand_data = devm_kzalloc(&pdev->dev, sizeof(*gpmc_nand_data),
> -				      GFP_KERNEL);
> -	if (!gpmc_nand_data)
> -		return -ENOMEM;
> -
> -	gpmc_nand_data->cs = val;
> -	gpmc_nand_data->of_node = child;
> -
> -	/* Detect availability of ELM module */
> -	gpmc_nand_data->elm_of_node = of_parse_phandle(child, "ti,elm-id", 0);
> -	if (gpmc_nand_data->elm_of_node == NULL)
> -		gpmc_nand_data->elm_of_node =
> -					of_parse_phandle(child, "elm_id", 0);
> -
> -	/* select ecc-scheme for NAND */
> -	if (of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
> -		pr_err("%s: ti,nand-ecc-opt not found\n", __func__);
> -		return -ENODEV;
> -	}
> -
> -	if (!strcmp(s, "sw"))
> -		gpmc_nand_data->ecc_opt = OMAP_ECC_HAM1_CODE_SW;
> -	else if (!strcmp(s, "ham1") ||
> -		 !strcmp(s, "hw") || !strcmp(s, "hw-romcode"))
> -		gpmc_nand_data->ecc_opt =
> -				OMAP_ECC_HAM1_CODE_HW;
> -	else if (!strcmp(s, "bch4"))
> -		if (gpmc_nand_data->elm_of_node)
> -			gpmc_nand_data->ecc_opt =
> -				OMAP_ECC_BCH4_CODE_HW;
> -		else
> -			gpmc_nand_data->ecc_opt =
> -				OMAP_ECC_BCH4_CODE_HW_DETECTION_SW;
> -	else if (!strcmp(s, "bch8"))
> -		if (gpmc_nand_data->elm_of_node)
> -			gpmc_nand_data->ecc_opt =
> -				OMAP_ECC_BCH8_CODE_HW;
> -		else
> -			gpmc_nand_data->ecc_opt =
> -				OMAP_ECC_BCH8_CODE_HW_DETECTION_SW;
> -	else if (!strcmp(s, "bch16"))
> -		if (gpmc_nand_data->elm_of_node)
> -			gpmc_nand_data->ecc_opt =
> -				OMAP_ECC_BCH16_CODE_HW;
> -		else
> -			pr_err("%s: BCH16 requires ELM support\n", __func__);
> -	else
> -		pr_err("%s: ti,nand-ecc-opt invalid value\n", __func__);
> -
> -	/* select data transfer mode for NAND controller */
> -	if (!of_property_read_string(child, "ti,nand-xfer-type", &s))
> -		for (val = 0; val < ARRAY_SIZE(nand_xfer_types); val++)
> -			if (!strcasecmp(s, nand_xfer_types[val])) {
> -				gpmc_nand_data->xfer_type = val;
> -				break;
> -			}
> -
> -	gpmc_nand_data->flash_bbt = of_get_nand_on_flash_bbt(child);
> -
> -	val = of_get_nand_bus_width(child);
> -	if (val == 16)
> -		gpmc_nand_data->devsize = NAND_BUSWIDTH_16;
> -
> -	gpmc_read_timings_dt(child, &gpmc_t);
> -	gpmc_nand_init(gpmc_nand_data, &gpmc_t);
> -
> -	return 0;
> -}
> -#else
> -static int gpmc_probe_nand_child(struct platform_device *pdev,
> -				 struct device_node *child)
> -{
> -	return 0;
> -}
> -#endif
> -
>  #if IS_ENABLED(CONFIG_MTD_ONENAND)
>  static int gpmc_probe_onenand_child(struct platform_device *pdev,
>  				 struct device_node *child)
> @@ -1933,9 +1833,42 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  		goto err;
>  	}
>  
> -	ret = of_property_read_u32(child, "bank-width", &gpmc_s.device_width);
> -	if (ret < 0)
> -		goto err;
> +	if (of_node_cmp(child->name, "nand") == 0) {
> +		/* NAND specific setup */
> +		u32 val;
> +
> +		/* Warn about older DT blobs with no compatible property */
> +		if (!of_property_read_bool(child, "compatible")) {
> +			dev_warn(&pdev->dev,
> +				 "Incompatible NAND node: missing compatible");
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		val = of_get_nand_bus_width(child);
> +		switch (val) {
> +		case 8:
> +			gpmc_s.device_width = GPMC_DEVWIDTH_8BIT;
> +			break;
> +		case 16:
> +			gpmc_s.device_width = GPMC_DEVWIDTH_16BIT;
> +			break;
> +		default:
> +			dev_err(&pdev->dev, "%s: invalid 'nand-bus-width'\n",
> +				child->name);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		/* disable write protect */
> +		gpmc_configure(GPMC_CONFIG_WP, 0);
> +		gpmc_s.device_nand = true;
> +	} else {
> +		ret = of_property_read_u32(child, "bank-width",
> +					   &gpmc_s.device_width);
> +		if (ret < 0)
> +			goto err;
> +	}
>  
>  	ret = gpmc_cs_program_settings(cs, &gpmc_s);
>  	if (ret < 0)
> @@ -2018,9 +1951,7 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>  		if (!child->name)
>  			continue;
>  
> -		if (of_node_cmp(child->name, "nand") == 0)
> -			ret = gpmc_probe_nand_child(pdev, child);
> -		else if (of_node_cmp(child->name, "onenand") == 0)
> +		if (of_node_cmp(child->name, "onenand") == 0)
>  			ret = gpmc_probe_onenand_child(pdev, child);
>  		else
>  			ret = gpmc_probe_generic_child(pdev, child);
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index c35405c..228f498 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -24,6 +24,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_mtd.h>
>  
>  #include <linux/mtd/nand_bch.h>
>  #include <linux/platform_data/elm.h>
> @@ -177,6 +178,8 @@ struct omap_nand_info {
>  	struct gpmc_nand_regs		reg;
>  	struct gpmc_nand_ops		*ops;
>  	/* generated at runtime depending on ECC algorithm and layout selected */
> +	bool				flash_bbt;
> +	/* generated at runtime depending on ECC algorithm and layout */
>  	struct nand_ecclayout		oobinfo;
>  	/* fields specific for BCHx_HW ECC scheme */
>  	struct device			*elm_dev;
> @@ -1668,10 +1671,84 @@ static bool omap2_nand_ecc_check(struct omap_nand_info *info,
>  	return true;
>  }
>  
> +static const char * const nand_xfer_types[] = {
> +	[NAND_OMAP_PREFETCH_POLLED] = "prefetch-polled",
> +	[NAND_OMAP_POLLED] = "polled",
> +	[NAND_OMAP_PREFETCH_DMA] = "prefetch-dma",
> +	[NAND_OMAP_PREFETCH_IRQ] = "prefetch-irq",
> +};
> +
> +static int omap_get_dt_info(struct device *dev, struct omap_nand_info *info)
> +{
> +	struct device_node *child = dev->of_node;
> +	int i;
> +	const char *s;
> +
> +	/* In old bindings, CS num is embedded in reg property */
> +	if (of_property_read_u32(child, "reg", &info->gpmc_cs) < 0) {
> +		dev_err(dev, "reg not found in DT\n");
> +		return -EINVAL;
> +	}
> +
> +	/* detect availability of ELM module. Won't be present pre-OMAP4 */
> +	info->elm_of_node = of_parse_phandle(child, "ti,elm-id", 0);
> +	if (!info->elm_of_node)
> +		dev_dbg(dev, "ti,elm-id not in DT\n");
> +
> +	/* select ecc-scheme for NAND */
> +	if (of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
> +		dev_err(dev, "ti,nand-ecc-opt not found\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!strcmp(s, "sw")) {
> +		info->ecc_opt = OMAP_ECC_HAM1_CODE_SW;
> +	} else if (!strcmp(s, "ham1") ||
> +		   !strcmp(s, "hw") || !strcmp(s, "hw-romcode")) {
> +		info->ecc_opt =	OMAP_ECC_HAM1_CODE_HW;
> +	} else if (!strcmp(s, "bch4")) {
> +		if (info->elm_of_node)
> +			info->ecc_opt = OMAP_ECC_BCH4_CODE_HW;
> +		else
> +			info->ecc_opt = OMAP_ECC_BCH4_CODE_HW_DETECTION_SW;
> +	} else if (!strcmp(s, "bch8")) {
> +		if (info->elm_of_node)
> +			info->ecc_opt = OMAP_ECC_BCH8_CODE_HW;
> +		else
> +			info->ecc_opt = OMAP_ECC_BCH8_CODE_HW_DETECTION_SW;
> +	} else if (!strcmp(s, "bch16")) {
> +		info->ecc_opt =	OMAP_ECC_BCH16_CODE_HW;
> +	} else {
> +		dev_err(dev, "unrecognized value for ti,nand-ecc-opt\n");
> +		return -EINVAL;
> +	}
> +
> +	/* select data transfer mode */
> +	if (!of_property_read_string(child, "ti,nand-xfer-type", &s)) {
> +		for (i = 0; i < ARRAY_SIZE(nand_xfer_types); i++) {
> +			if (!strcasecmp(s, nand_xfer_types[i])) {
> +				info->xfer_type = i;
> +				goto next;
> +			}
> +		}
> +
> +		dev_err(dev, "unrecognized value for ti,nand-xfer-type\n");
> +		return -EINVAL;
> +	}
> +
> +next:
> +	of_get_nand_on_flash_bbt(child);
> +
> +	if (of_get_nand_bus_width(child) == 16)
> +		info->devsize = NAND_BUSWIDTH_16;
> +
> +	return 0;
> +}
> +
>  static int omap_nand_probe(struct platform_device *pdev)
>  {
>  	struct omap_nand_info		*info;
> -	struct omap_nand_platform_data	*pdata;
> +	struct omap_nand_platform_data	*pdata = NULL;
>  	struct mtd_info			*mtd;
>  	struct nand_chip		*nand_chip;
>  	struct nand_ecclayout		*ecclayout;
> @@ -1682,33 +1759,42 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	unsigned			oob_index;
>  	struct resource			*res;
>  	struct mtd_part_parser_data	ppdata = {};
> -
> -	pdata = dev_get_platdata(&pdev->dev);
> -	if (pdata == NULL) {
> -		dev_err(&pdev->dev, "platform data missing\n");
> -		return -ENODEV;
> -	}
> +	struct device			*dev = &pdev->dev;
>  
>  	info = devm_kzalloc(&pdev->dev, sizeof(struct omap_nand_info),
>  				GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, info);
> +	info->pdev = pdev;
>  
> +	if (dev->of_node) {
> +		if (omap_get_dt_info(dev, info))
> +			return -EINVAL;
> +	} else {
> +		pdata = dev_get_platdata(&pdev->dev);
> +		if (!pdata) {
> +			dev_err(&pdev->dev, "platform data missing\n");
> +			return -EINVAL;
> +		}
> +
> +		info->gpmc_cs = pdata->cs;
> +		info->reg = pdata->reg;
> +		info->of_node = pdata->of_node;
> +		info->ecc_opt = pdata->ecc_opt;
> +		info->dev_ready	= pdata->dev_ready;
> +		info->xfer_type = pdata->xfer_type;
> +		info->devsize = pdata->devsize;
> +		info->elm_of_node = pdata->elm_of_node;
> +		info->flash_bbt = pdata->flash_bbt;
> +	}
> +
> +	platform_set_drvdata(pdev, info);
>  	info->ops = gpmc_omap_get_nand_ops(&info->reg, info->gpmc_cs);
>  	if (!info->ops) {
>  		dev_err(&pdev->dev, "Failed to get GPMC->NAND interface\n");
>  		return -ENODEV;
>  	}
> -	info->pdev		= pdev;
> -	info->gpmc_cs		= pdata->cs;
> -	info->of_node		= pdata->of_node;
> -	info->ecc_opt		= pdata->ecc_opt;
> -	info->dev_ready	= pdata->dev_ready;
> -	info->xfer_type = pdata->xfer_type;
> -	info->devsize = pdata->devsize;
> -	info->elm_of_node = pdata->elm_of_node;
>  
>  	mtd			= &info->mtd;
>  	mtd->priv		= &info->nand;
> @@ -1744,7 +1830,7 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		nand_chip->chip_delay = 50;
>  	}
>  
> -	if (pdata->flash_bbt)
> +	if (info->flash_bbt)
>  		nand_chip->bbt_options |= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
>  	else
>  		nand_chip->options |= NAND_SKIP_BBTSCAN;
> @@ -2049,9 +2135,13 @@ scan_tail:
>  		goto return_error;
>  	}
>  
> -	ppdata.of_node = pdata->of_node;
> -	mtd_device_parse_register(mtd, NULL, &ppdata, pdata->parts,
> -				  pdata->nr_parts);
> +	if (dev->of_node) {
> +		ppdata.of_node = dev->of_node;

The latest l2-mtd.git changed how the partitions' of_node is passed. Now
this is handled by nand_set_flash_node().

> +		mtd_device_parse_register(mtd, NULL, &ppdata, NULL, 0);
> +
> +	} else {
> +		mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
> +	}
>  
>  	platform_set_drvdata(pdev, mtd);
>  
> @@ -2083,11 +2173,17 @@ static int omap_nand_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id omap_nand_ids[] = {
> +	{ .compatible = "ti,omap2-nand", },
> +	{},
> +};
> +
>  static struct platform_driver omap_nand_driver = {
>  	.probe		= omap_nand_probe,
>  	.remove		= omap_nand_remove,
>  	.driver		= {
>  		.name	= DRIVER_NAME,
> +		.of_match_table = of_match_ptr(omap_nand_ids),
>  	},
>  };
>  
> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
> index a067f58..ff27e5a 100644
> --- a/include/linux/platform_data/mtd-nand-omap2.h
> +++ b/include/linux/platform_data/mtd-nand-omap2.h
> @@ -76,11 +76,10 @@ struct omap_nand_platform_data {
>  	int			devsize;
>  	enum omap_ecc           ecc_opt;
>  
> -	/* for passing the partitions */
> -	struct device_node	*of_node;
>  	struct device_node	*elm_of_node;
>  
>  	/* deprecated */
>  	struct gpmc_nand_regs	reg;
> +	struct device_node	*of_node;

I'm a little confused here. Do you have a mixed platform data / device
tree setup here? That's odd. (It also seems if that was really
necessary, you could have the board file set pdev->dev.of_node before
registering it, then you don't need this field.) But really, if you're
partly using device tree, can't you just convert completely? Or is this
a two-phase process, and you're planning to convert omap2 to full device
tree?

>  };
>  #endif

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
