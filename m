From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2] mtd: nand: omap2: Remove omap_nand_platform_data
Date: Sat, 14 Oct 2017 17:11:44 +0200
Message-ID: <20171014171144.4bbc6f8c@bbrezillon>
References: <20171010123807.ha43wsnqw5uncf3n@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171010123807.ha43wsnqw5uncf3n@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Richard Weinberger <richard@nod.at>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 10 Oct 2017 14:38:07 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> As driver is now configured using DT, omap_nand_platform_data structure
> is no longer needed.
> 

Applied.

Thanks,

Boris

> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Changes:
>  -v2: Remove check for dev->of_node, drop platform_set_drvdata removal
>       change from this patch
> 
>  drivers/mtd/nand/omap2.c                     |   37 +++++----------------------
>  include/linux/platform_data/mtd-nand-omap2.h |   17 ------------
>  2 files changed, 8 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 54540c8fa1a2..01368a8f9e3f 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1588,8 +1588,7 @@ static bool is_elm_present(struct omap_nand_info *info,
>  	return true;
>  }
>  
> -static bool omap2_nand_ecc_check(struct omap_nand_info *info,
> -				 struct omap_nand_platform_data	*pdata)
> +static bool omap2_nand_ecc_check(struct omap_nand_info *info)
>  {
>  	bool ecc_needs_bch, ecc_needs_omap_bch, ecc_needs_elm;
>  
> @@ -1804,7 +1803,6 @@ static const struct mtd_ooblayout_ops omap_sw_ooblayout_ops = {
>  static int omap_nand_probe(struct platform_device *pdev)
>  {
>  	struct omap_nand_info		*info;
> -	struct omap_nand_platform_data	*pdata = NULL;
>  	struct mtd_info			*mtd;
>  	struct nand_chip		*nand_chip;
>  	int				err;
> @@ -1821,27 +1819,9 @@ static int omap_nand_probe(struct platform_device *pdev)
>  
>  	info->pdev = pdev;
>  
> -	if (dev->of_node) {
> -		if (omap_get_dt_info(dev, info))
> -			return -EINVAL;
> -	} else {
> -		pdata = dev_get_platdata(&pdev->dev);
> -		if (!pdata) {
> -			dev_err(&pdev->dev, "platform data missing\n");
> -			return -EINVAL;
> -		}
> -
> -		info->gpmc_cs = pdata->cs;
> -		info->reg = pdata->reg;
> -		info->ecc_opt = pdata->ecc_opt;
> -		if (pdata->dev_ready)
> -			dev_info(&pdev->dev, "pdata->dev_ready is deprecated\n");
> -
> -		info->xfer_type = pdata->xfer_type;
> -		info->devsize = pdata->devsize;
> -		info->elm_of_node = pdata->elm_of_node;
> -		info->flash_bbt = pdata->flash_bbt;
> -	}
> +	err = omap_get_dt_info(dev, info);
> +	if (err)
> +		return err;
>  
>  	platform_set_drvdata(pdev, info);
>  	info->ops = gpmc_omap_get_nand_ops(&info->reg, info->gpmc_cs);
> @@ -2002,7 +1982,7 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		goto return_error;
>  	}
>  
> -	if (!omap2_nand_ecc_check(info, pdata)) {
> +	if (!omap2_nand_ecc_check(info)) {
>  		err = -EINVAL;
>  		goto return_error;
>  	}
> @@ -2167,10 +2147,9 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	if (err)
>  		goto return_error;
>  
> -	if (dev->of_node)
> -		mtd_device_register(mtd, NULL, 0);
> -	else
> -		mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
> +	err = mtd_device_register(mtd, NULL, 0);
> +	if (err)
> +		goto return_error;
>  
>  	platform_set_drvdata(pdev, mtd);
>  
> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
> index 25e267f1970c..619df2431e75 100644
> --- a/include/linux/platform_data/mtd-nand-omap2.h
> +++ b/include/linux/platform_data/mtd-nand-omap2.h
> @@ -64,21 +64,4 @@ struct gpmc_nand_regs {
>  	void __iomem	*gpmc_bch_result5[GPMC_BCH_NUM_REMAINDER];
>  	void __iomem	*gpmc_bch_result6[GPMC_BCH_NUM_REMAINDER];
>  };
> -
> -struct omap_nand_platform_data {
> -	int			cs;
> -	struct mtd_partition	*parts;
> -	int			nr_parts;
> -	bool			flash_bbt;
> -	enum nand_io		xfer_type;
> -	int			devsize;
> -	enum omap_ecc           ecc_opt;
> -
> -	struct device_node	*elm_of_node;
> -
> -	/* deprecated */
> -	struct gpmc_nand_regs	reg;
> -	struct device_node	*of_node;
> -	bool			dev_ready;
> -};
>  #endif
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
