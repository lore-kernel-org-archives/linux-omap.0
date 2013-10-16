From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v9 3/9] mtd: nand: omap: cleanup: replace local
 references with generic framework names
Date: Wed, 16 Oct 2013 14:30:24 -0700
Message-ID: <20131016213024.GY23337@ld-irv-0074.broadcom.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
 <1381816197-20477-4-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:59133 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932796Ab3JPVa3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Oct 2013 17:30:29 -0400
Content-Disposition: inline
In-Reply-To: <1381816197-20477-4-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, olof@lixom.net, dedekind1@gmail.com, tony@atomide.com, bcousson@baylibre.com, robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

Hi Pekon,

On Tue, Oct 15, 2013 at 11:19:51AM +0530, Pekon Gupta wrote:
> This patch updates following in omap_nand_probe() and omap_nand_remove()
> - replaces "info->nand" with "nand_chip" (struct nand_chip *nand_chip)
> - replaces "info->mtd" with "mtd" (struct mtd_info *mtd)
> - white-space and formatting cleanup
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>

This patch looks good. Thanks for being consistent.

> ---
>  drivers/mtd/nand/omap2.c | 112 ++++++++++++++++++++++++-----------------------
>  1 file changed, 57 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 8d521aa..5596368 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c

...

> @@ -1846,17 +1848,16 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	spin_lock_init(&info->controller.lock);
>  	init_waitqueue_head(&info->controller.wq);
>  
> -	info->pdev = pdev;
> -
> +	info->pdev		= pdev;
>  	info->gpmc_cs		= pdata->cs;
>  	info->reg		= pdata->reg;
> -
> -	info->mtd.priv		= &info->nand;
> -	info->mtd.name		= dev_name(&pdev->dev);
> -	info->mtd.owner		= THIS_MODULE;
> -
> -	info->nand.options	= pdata->devsize;
> -	info->nand.options	|= NAND_SKIP_BBTSCAN;
> +	mtd			= &info->mtd;
> +	mtd->priv		= &info->nand;
> +	mtd->name		= dev_name(&pdev->dev);
> +	mtd->owner		= THIS_MODULE;
> +	nand_chip		= &info->nand;
> +	nand_chip->options	= pdata->devsize;

Trivial side comment: the 'devsize' field is not named very
informatively. It is apparently just a way to specify nand_chip.options,
and it is only actually used for setting a buswidth. (It is also badly
named nand_type in other places.) Not sure if it's worth improving, or
even dropping at some later point in time.

> +	nand_chip->options	|= NAND_SKIP_BBTSCAN;
>  #ifdef CONFIG_MTD_NAND_OMAP_BCH
>  	info->of_node		= pdata->of_node;
>  #endif

[...]

Brian
