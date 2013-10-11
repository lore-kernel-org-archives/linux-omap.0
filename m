From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v8 4/6] mtd:nand:omap2: updated support for BCH4 ECC
 scheme
Date: Fri, 11 Oct 2013 13:28:50 -0700
Message-ID: <20131011202850.GM23337@ld-irv-0074.broadcom.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
 <1381498603-15715-5-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34561 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759187Ab3JKU24 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 16:28:56 -0400
Content-Disposition: inline
In-Reply-To: <1381498603-15715-5-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, dedekind1@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Oct 11, 2013 at 07:06:41PM +0530, Pekon Gupta wrote:
> This patch adds following two flavours of BCH4 ECC scheme in omap2-nand driver
> - OMAP_ECC_BCH4_CODE_HW_DETECTION_SW
> 	- uses GPMC H/W engine for calculating ECC.
> 	- uses software library (lib/bch.h & nand_bch.h) for error correction.
> 
> - OMAP_ECC_BCH4_CODE_HW
> 	- uses GPMC H/W engine for calculating ECC.
> 	- uses ELM H/W engine for error correction.
> 
> With this patch omap2-nand driver supports following ECC schemes:
> +---------------------------------------+---------------+---------------+
> | ECC scheme                            |ECC calculation|Error detection|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_HAM1_CODE_HW                  |H/W (GPMC)     |S/W            |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH4_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.h)|
> |OMAP_ECC_BCH4_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.h)|
> |OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> +---------------------------------------+---------------+---------------+
> Important:
> - Selection of OMAP_ECC_BCHx_CODE_HW_DETECTION_SW requires,
> 	Kconfig: CONFIG_MTD_NAND_ECC_BCH: enables S/W based BCH ECC algorithm.
> 
> - Selection of OMAP_ECC_BCHx_CODE_HW requires,
> 	Kconfig: CONFIG_MTD_NAND_OMAP_BCH: enables ELM H/W module.
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  drivers/mtd/nand/Kconfig |  30 ++---------
>  drivers/mtd/nand/omap2.c | 134 +++++++++++++++++++++--------------------------
>  2 files changed, 63 insertions(+), 101 deletions(-)
> 

...

> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index fb96251..a783dae 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1927,7 +1868,7 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		nand_chip->ecc.bytes		= 7;
>  		nand_chip->ecc.strength		= 4;
>  		nand_chip->ecc.hwctl		= omap3_enable_hwecc_bch;
> -		nand_chip->ecc.correct		= omap3_correct_data_bch;
> +		info->nand.ecc.correct		= nand_bch_correct_data;

Your patch description doesn't talk about this (and the deletion of
omap3_correct_data_bch() above). Is the NAND BCH library a drop-in
replacement for omap3_correct_data_bch()? If so, TELL me about it in the
commit description. If not, this is an incompatible change and should at
least be documented so that people can understand the change. These
questions are being asked by the DT guys, so include it in your
descriptions.

Also, you're very inconsistent on using 'nand_chip' vs. 'info->nand'.
You added 'nand_chip' amid the noise of patch 3, so if you have it, use
it consistently throughout probe(). Or remove it and don't use it at
all. (This would be an independent patch from patch 3 and 4, in case
you're wondering, since it causes a lot of diff noise.)

>  		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch4;
>  		/* define custom ECC layout */
>  		ecclayout->eccbytes		= nand_chip->ecc.bytes *

> @@ -2061,7 +2036,12 @@ out_release_mem_region:
>  		free_irq(info->gpmc_irq_fifo, info);
>  	release_mem_region(info->phys_base, info->mem_size);
>  out_free_info:
> -	omap3_free_bch(&info->mtd);
> +#ifdef CONFIG_MTD_NAND_ECC_BCH
> +	if (info->nand.ecc.priv) {
> +		nand_bch_free(info->nand.ecc.priv);
> +		info->nand.ecc.priv = NULL;
> +	}
> +#endif

As noted previously, the #ifdef should not be necessary.

>  	kfree(info);
>  
>  	return err;
> @@ -2072,8 +2052,12 @@ static int omap_nand_remove(struct platform_device *pdev)
>  	struct mtd_info *mtd = platform_get_drvdata(pdev);
>  	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
>  							mtd);
> -	omap3_free_bch(&info->mtd);
> -
> +#ifdef CONFIG_MTD_NAND_ECC_BCH
> +	if (info->nand.ecc.priv) {
> +		nand_bch_free(info->nand.ecc.priv);
> +		info->nand.ecc.priv = NULL;
> +	}
> +#endif

Ditto.

>  	if (info->dma)
>  		dma_release_channel(info->dma);
>  

Brian
