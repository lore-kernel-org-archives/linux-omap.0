From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v6 2/4] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW
 ECC configurations in device_probe
Date: Wed, 25 Sep 2013 12:02:06 -0700
Message-ID: <20130925190206.GD23337@ld-irv-0074.broadcom.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
 <1378986619-26765-3-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1378986619-26765-3-git-send-email-pekon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Pekon Gupta <pekon@ti.com>
Cc: devicetree@vger.kernel.org, arnd@arndb.de, dedekind1@gmail.com, tony@atomide.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, olof@lixom.net, benoit.cousson@linaro.org, linux-omap@vger.kernel.org, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org

BTW, I'll elaborate on a few things that are hidden in the noise here.

On Thu, Sep 12, 2013 at 05:20:17PM +0530, Pekon Gupta wrote:
> OMAP NAND driver support multiple ECC scheme, which can used in following
> different flavours, depending on in-build Hardware engines supported by SoC.
...
> This patch
> - removes OMAP_ECC_HAMMING_CODE_DEFAULT and OMAP_ECC_HAMMING_CODE_HW_ROMCODE
> - separates the configurations for other ECC schemes
> - fixes dependency issues based on Kconfig options
> - updates ELM device detection in is_elm_present()
> - cleans redundant code
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  drivers/mtd/nand/omap2.c                     | 530 +++++++++++++--------------
>  include/linux/platform_data/mtd-nand-omap2.h |   7 +-
>  2 files changed, 260 insertions(+), 277 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 4ecf0e5..420078f 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
...
> @@ -1846,20 +1720,20 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	spin_lock_init(&info->controller.lock);
>  	init_waitqueue_head(&info->controller.wq);
>  
> -	info->pdev = pdev;
> +	mtd			= &info->mtd;
> +	mtd->name		= dev_name(&pdev->dev);
> +	mtd->owner		= THIS_MODULE;
> +	mtd->priv		= &info->nand;
> +	chip			= mtd->priv;
>  
> +	info->pdev		= pdev;
>  	info->gpmc_cs		= pdata->cs;
>  	info->reg		= pdata->reg;
> +	info->bch		= NULL;
>  
> -	info->mtd.priv		= &info->nand;
> -	info->mtd.name		= dev_name(&pdev->dev);
> -	info->mtd.owner		= THIS_MODULE;
> -
> -	info->nand.options	= pdata->devsize;
> +	info->nand.options	= NAND_BUSWIDTH_AUTO;

You're changing the buswidth detection significantly. You don't even
mention that in the commit description. This should be a separate patch.

>  	info->nand.options	|= NAND_SKIP_BBTSCAN;
> -#ifdef CONFIG_MTD_NAND_OMAP_BCH
>  	info->of_node		= pdata->of_node;
> -#endif
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (res == NULL) {
> @@ -1903,6 +1777,30 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		info->nand.chip_delay = 50;
>  	}
>  
> +	/* scan NAND device conncted to controller */
> +	if (nand_scan_ident(mtd, 1, NULL)) {
> +		err = -ENXIO;
> +		goto out_release_mem_region;
> +	}
> +	pr_info("%s: detected %s NAND flash\n", DRIVER_NAME,
> +			(info->nand.options & NAND_BUSWIDTH_16) ? "x16" : "x8");

Do you really need to print this unconditionally? nand_base already has
some device info printed out (not the buswidth), so if it's really
needed, it should go there. But we really don't need to print out all
this IMO.

Perhaps move the print into the 'if' block, so that you only alert the
user about the buswidth if it doesn't match.

> +	if ((info->nand.options & NAND_BUSWIDTH_16) !=
> +			(pdata->devsize & NAND_BUSWIDTH_16)) {
> +		pr_err("%s: but incorrectly configured as %s", DRIVER_NAME,
> +			(pdata->devsize & NAND_BUSWIDTH_16) ? "x16" : "x8");
> +		err = -EINVAL;
> +		goto out_release_mem_region;
> +	}
> +
> +	/* check for small page devices */
> +	if ((mtd->oobsize < 64) &&
> +		(pdata->ecc_opt != OMAP_ECC_HAMMING_CODE_HW)) {
> +		pr_err("small page devices are not supported\n");
> +		err = -EINVAL;
> +		goto out_release_mem_region;
> +	}
> +
> +	/* populate read & write API based on xfer_type selected */
>  	switch (pdata->xfer_type) {
>  	case NAND_OMAP_PREFETCH_POLLED:
>  		info->nand.read_buf   = omap_read_buf_pref;
> @@ -1992,64 +1890,152 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		goto out_release_mem_region;
>  	}
>  
> -	/* select the ecc type */
> -	if (pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_DEFAULT)
> -		info->nand.ecc.mode = NAND_ECC_SOFT;
> -	else if ((pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_HW) ||
> -		(pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_HW_ROMCODE)) {
> +	/* populate MTD interface based on ECC scheme */
> +	chip->ecclayout		= &omap_oobinfo;

This field was recently removed in l2-mtd.git. It was redundant with
chip->ecc.layout.

> +	chip->ecc.layout	= &omap_oobinfo;
> +	ecclayout		= &omap_oobinfo;
> +	switch (pdata->ecc_opt) {
> +	case OMAP_ECC_HAMMING_CODE_HW:
> +		pr_info("nand: using OMAP_ECC_HAMMING_CODE_HW\n");
> +		info->nand.ecc.mode             = NAND_ECC_HW;
>  		info->nand.ecc.bytes            = 3;
>  		info->nand.ecc.size             = 512;
>  		info->nand.ecc.strength         = 1;
>  		info->nand.ecc.calculate        = omap_calculate_ecc;
>  		info->nand.ecc.hwctl            = omap_enable_hwecc;
>  		info->nand.ecc.correct          = omap_correct_data;
...

So please, separate pure refactoring from significant changes.

Brian

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
