From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v9 9/9] mtd: nand: omap: updated devm_xx for all
 resource allocation and free calls
Date: Wed, 16 Oct 2013 19:29:19 -0700
Message-ID: <20131017022919.GD23337@ld-irv-0074.broadcom.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
 <1381816197-20477-10-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:42755 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761651Ab3JQC3Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Oct 2013 22:29:24 -0400
Content-Disposition: inline
In-Reply-To: <1381816197-20477-10-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, olof@lixom.net, dedekind1@gmail.com, tony@atomide.com, bcousson@baylibre.com, robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Oct 15, 2013 at 11:19:57AM +0530, Pekon Gupta wrote:
> "Managed Device Resource" or devm_xx calls takes care of automatic freeing
> of the resource in case of:
> - failure during driver probe
> - failure during resource allocation
> - detaching or unloading of driver module (rmmod)
> Reference: Documentation/driver-model/devres.txt
> 
> Though OMAP NAND driver handles freeing of resource allocation in most of
> the cases, but using devm_xx provides more clean and effortless approach
> to handle all such cases.
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  drivers/mtd/nand/omap2.c | 44 ++++++++++++++------------------------------
>  1 file changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 769ff65..0ed0d6f 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c

[...]

> @@ -1796,8 +1799,9 @@ static int omap_nand_probe(struct platform_device *pdev)
>  			err = -ENODEV;
>  			goto out_release_mem_region;
>  		}
> -		err = request_irq(info->gpmc_irq_count,	omap_nand_irq,
> -					IRQF_SHARED, "gpmc-nand-count", info);
> +		err = devm_request_irq(&pdev->dev, info->gpmc_irq_count,
> +					omap_nand_irq, IRQF_SHARED,
> +					"gpmc-nand-count", info);
>  		if (err) {
>  			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
>  						info->gpmc_irq_count, err);
> @@ -2010,45 +2014,25 @@ static int omap_nand_probe(struct platform_device *pdev)
>  out_release_mem_region:

Now that you've simplified this error path, you don't need so verbose of
a name (it could just be 'out'), but that's not worth another revision.

>  	if (info->dma)
>  		dma_release_channel(info->dma);
> -	if (info->gpmc_irq_count > 0)
> -		free_irq(info->gpmc_irq_count, info);
> -	if (info->gpmc_irq_fifo > 0)
> -		free_irq(info->gpmc_irq_fifo, info);
> -	release_mem_region(info->phys_base, info->mem_size);
> -out_free_info:
>  	if (info->nand.ecc.priv) {
>  		nand_bch_free(info->nand.ecc.priv);
>  		info->nand.ecc.priv = NULL;
>  	}
> -	kfree(info);
> -
>  	return err;
>  }

[...]

This patch version looks much better. Thanks for the rewrite.

Brian
