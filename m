From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v8 3/6] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW
 ECC configurations in device_probe
Date: Fri, 11 Oct 2013 12:28:33 -0700
Message-ID: <20131011192833.GL23337@ld-irv-0074.broadcom.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
 <1381498603-15715-4-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:39846 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab3JKT2i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 15:28:38 -0400
Content-Disposition: inline
In-Reply-To: <1381498603-15715-4-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, dedekind1@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Oct 11, 2013 at 07:06:40PM +0530, Pekon Gupta wrote:
> OMAP NAND driver support multiple ECC scheme, which can used in following
> different flavours, depending on in-build Hardware engines supported by SoC.
> 
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
> also require enabling following Kconfigs, in addition to setting appropriate
> DT bindings
> - Kconfig:CONFIG_MTD_NAND_ECC_BCH        enables S/W based BCH ECC algorithm
> - Kconfig:CONFIG_MTD_NAND_OMAP_BCH       enables H/W based BCH ECC algorithm
> 
> This patch
> - separates the configurations code for each ECC schemes
> - fixes dependency issues based on Kconfig options
> - updates ELM device detection in is_elm_present()
> - cleans redundant code

I'll repeat my previous comment on this patch, since it seems entirely
ignored:

<quote>
[this patch] ... does too many unrelated things in a single patch. I am not
comfortable taking large amounts of refactoring mixed in with Kconfig
and #ifdef changes. Can you please separate the steps you list below
into multiple patches and describe each one? I think you are doing many
trivial things, but it's difficult to separate the noise out from the
substantial changes.
</quote>

Considering your frustration, it is certainly in your best interest to
make your patches more easily reviewable and to address my comments when
I make them. I cannot sign off on your patches in the current state, and
you have failed to properly address my comments on the nearly identical
code from weeks ago.

Please, put more effort into splitting your patches into reviewable
chunks and into writing *good* descriptions -- right now, 90% of your
commit message consists of a repeated ECC table, which does not actually
describe your changes. The remaining description is a jumble of multiple
unrelated thoughts, reflecting the similarly confusing patches. A
similar criticism applies to your other patches, whose descriptions do
not adequately reflect their contents.

> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  drivers/mtd/nand/omap2.c | 450 +++++++++++++++++++++++------------------------
>  1 file changed, 220 insertions(+), 230 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 8d521aa..fb96251 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -25,8 +25,10 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  
> -#ifdef CONFIG_MTD_NAND_OMAP_BCH
> +#ifdef CONFIG_MTD_NAND_ECC_BCH
>  #include <linux/bch.h>
> +#endif
> +#ifdef CONFIG_MTD_NAND_OMAP_BCH
>  #include <linux/platform_data/elm.h>
>  #endif
>  

Why do you even need the #ifdef's for the #include's? It is not harmful
to include headers for stuff that is only conditionally used. In fact,
this creates a problem later when you try to use nand_bch_free(), and
you have to surround it with extra #ifdef's.

In short: these #ifdef's just breed more #ifdef's and cause the code to
become harder to read and less maintainable.

(I commented about the #ifdef's around nand_bch_free() in v6, and you
did not address the comment.)

> @@ -1846,20 +1726,18 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	spin_lock_init(&info->controller.lock);
>  	init_waitqueue_head(&info->controller.wq);
>  
> -	info->pdev = pdev;
> -
> +	mtd			= &info->mtd;
> +	mtd->name		= dev_name(&pdev->dev);
> +	mtd->owner		= THIS_MODULE;
> +	mtd->priv		= &info->nand;
> +	nand_chip		= &info->nand;
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
> -	info->nand.options	|= NAND_SKIP_BBTSCAN;
> -#ifdef CONFIG_MTD_NAND_OMAP_BCH
> +	nand_chip->options	|= NAND_SKIP_BBTSCAN | NAND_BUSWIDTH_AUTO;

I recommended (in v6) you split the NAND_BUSWIDTH_AUTO change to a new
patch and to describe it in the commit. You did neither.

>  	info->of_node		= pdata->of_node;
> -#endif
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (res == NULL) {
> @@ -1903,6 +1781,30 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		info->nand.chip_delay = 50;
>  	}
>  
> +	/* scan NAND device conncted to controller */
> +	if (nand_scan_ident(mtd, 1, NULL)) {
> +		err = -ENXIO;
> +		goto out_release_mem_region;
> +	}
> +	pr_info("%s: detected %s NAND flash\n", DRIVER_NAME,
> +			(nand_chip->options & NAND_BUSWIDTH_16) ? "x16" : "x8");

I recommended you kill this in v6, and you did not address my comments.

> +	if ((nand_chip->options & NAND_BUSWIDTH_16) !=
> +			(pdata->devsize & NAND_BUSWIDTH_16)) {
> +		pr_err("%s: but incorrectly configured as %s", DRIVER_NAME,
> +			(pdata->devsize & NAND_BUSWIDTH_16) ? "x16" : "x8");
> +		err = -EINVAL;
> +		goto out_release_mem_region;
...

Brian
