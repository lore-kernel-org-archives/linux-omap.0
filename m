From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v2 4/5] mtd: nand: omap2: Use devm_kzalloc
Date: Fri, 25 Oct 2013 10:25:02 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA2AD60@DBDE04.ent.ti.com>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382696277-9063-5-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40864 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123Ab3JYKZd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 06:25:33 -0400
In-Reply-To: <1382696277-9063-5-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> 
> This simplifies the error path and makes the code less error-prone.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/mtd/nand/omap2.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index e01a936..d3155b2 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1837,7 +1837,7 @@ static int omap_nand_probe(struct
> platform_device *pdev)
>  		return -ENODEV;
>  	}
> 
> -	info = kzalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
> +	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
> 
> @@ -2067,8 +2067,6 @@ out_release_mem_region:
>  		free_irq(info->gpmc_irq_fifo, info);
>  	release_mem_region(info->phys_base, info->mem_size);
>  out_free_info:
> -	kfree(info);
> -
>  	return err;
>  }
> 
> @@ -2091,7 +2089,6 @@ static int omap_nand_remove(struct
> platform_device *pdev)
>  	nand_release(&info->mtd);
>  	iounmap(info->nand.IO_ADDR_R);
>  	release_mem_region(info->phys_base, info->mem_size);
> -	kfree(info);
>  	return 0;
>  }
> 
> --
> 1.8.1.5

I think these changes are already done as part of following patch..
http://lists.infradead.org/pipermail/linux-mtd/2013-October/049418.html

Did your rebase on my patch-set ?


with regards, pekon
