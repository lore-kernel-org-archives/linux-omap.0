From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: HSMMC: enable use as a module
Date: Thu, 20 Mar 2008 14:59:42 +0200
Message-ID: <20080320125941.GJ14978@atomide.com>
References: <1205966825-1864-1-git-send-email-khilman@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49492 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbYCTM7p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 08:59:45 -0400
Content-Disposition: inline
In-Reply-To: <1205966825-1864-1-git-send-email-khilman@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [080320 01:54]:
> When building as a module, the board support code (which is compiled
> in) cannot directly call the driver code (which may be in a module.)
> 
> This patch the separates the card-detect IRQ usage into board-specific
> code and driver code, and adds a couple slot-specific items to the MMC
> platform data.
> 
> Tested on 3430SDP ES2.

Pushing today.

Tony



> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> ---
>  arch/arm/mach-omap2/board-sdp-hsmmc.c |   19 ++++++-------------
>  drivers/mmc/host/omap_hsmmc.c         |   25 ++++++++++++++++++++++---
>  include/asm-arm/arch-omap/mmc.h       |    5 ++++-
>  3 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-sdp-hsmmc.c b/arch/arm/mach-omap2/board-sdp-hsmmc.c
> index 90e8def..7661a79 100644
> --- a/arch/arm/mach-omap2/board-sdp-hsmmc.c
> +++ b/arch/arm/mach-omap2/board-sdp-hsmmc.c
> @@ -19,7 +19,7 @@
>  #include <asm/arch/board.h>
>  #include <asm/io.h>
>  
> -#ifdef CONFIG_MMC_OMAP_HS
> +#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
>  
>  #define VMMC1_DEV_GRP		0x27
>  #define P1_DEV_GRP		0x20
> @@ -35,13 +35,9 @@
>  #define MMC1_CD_IRQ		0
>  #define MMC2_CD_IRQ		1
>  
> -static irqreturn_t mmc_omap_cd_handler(int irq, void *dev_id)
> +static int sdp_mmc_card_detect(int irq)
>  {
> -	int detect;
> -
> -	detect = twl4030_get_gpio_datain(MMC1_CD_IRQ);
> -	omap_mmc_notify_card_detect(dev_id, 0, detect);
> -	return IRQ_HANDLED;
> +	return twl4030_get_gpio_datain(irq - IH_TWL4030_GPIO_BASE);
>  }
>  
>  /*
> @@ -72,11 +68,6 @@ static int sdp_mmc_late_init(struct device *dev)
>  	if (ret != 0)
>  		goto err;
>  
> -	ret = request_irq(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ),
> -		mmc_omap_cd_handler, IRQF_DISABLED, "MMC1_CD_IRQ", dev);
> -	if (ret < 0)
> -		goto err;
> -
>  	return ret;
>  err:
>  	dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
> @@ -89,7 +80,6 @@ static void sdp_mmc_cleanup(struct device *dev)
>  	int ret = 0;
>  
>  	ret = twl4030_free_gpio(MMC1_CD_IRQ);
> -	free_irq(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ), dev);
>  	if (ret != 0)
>  		dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
>  }
> @@ -259,6 +249,9 @@ static struct omap_mmc_platform_data sdp_mmc_data = {
>  		.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34 |
>  						MMC_VDD_165_195,
>  		.name			= "first slot",
> +
> +		.card_detect_irq        = TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ),
> +		.card_detect            = sdp_mmc_card_detect,
>  	},
>  };
>  
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 3d4a7d1..047c64d 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -432,11 +432,14 @@ static void mmc_omap_detect(struct work_struct *work)
>  /*
>   * ISR for handling card insertion and removal
>   */
> -void omap_mmc_notify_card_detect(struct device *dev, int slot, int detected)
> +static irqreturn_t omap_mmc_cd_handler(int irq, void *dev_id)
>  {
> -	struct mmc_omap_host *host = dev_get_drvdata(dev);
> -	host->carddetect = detected;
> +	struct mmc_omap_host *host = (struct mmc_omap_host *)dev_id;
> +
> +	host->carddetect = mmc_slot(host).card_detect(irq);
>  	schedule_work(&host->mmc_carddetect_work);
> +
> +	return IRQ_HANDLED;
>  }
>  
>  /*
> @@ -797,9 +800,23 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
>  		goto irq_err;
>  	}
>  
> +	/* Request IRQ for card detect */
> +	if ((mmc_slot(host).card_detect_irq) && (mmc_slot(host).card_detect)) {
> +		ret = request_irq(mmc_slot(host).card_detect_irq,
> +				  omap_mmc_cd_handler, IRQF_DISABLED, "MMC CD",
> +				  host);
> +		if (ret) {
> +			dev_dbg(mmc_dev(host->mmc),
> +				"Unable to grab MMC CD IRQ");
> +			free_irq(host->irq, host);
> +			goto irq_err;
> +		}
> +	}
> +
>  	INIT_WORK(&host->mmc_carddetect_work, mmc_omap_detect);
>  	if (pdata->init != NULL) {
>  		if (pdata->init(&pdev->dev) != 0) {
> +			free_irq(mmc_slot(host).card_detect_irq, host);
>  			free_irq(host->irq, host);
>  			goto irq_err;
>  		}
> @@ -843,6 +860,8 @@ static int omap_mmc_remove(struct platform_device *pdev)
>  	if (host) {
>  		host->pdata->cleanup(&pdev->dev);
>  		free_irq(host->irq, host);
> +		if (mmc_slot(host).card_detect_irq)
> +			free_irq(mmc_slot(host).card_detect_irq, host);
>  		flush_scheduled_work();
>  
>  		clk_disable(host->fclk);
> diff --git a/include/asm-arm/arch-omap/mmc.h b/include/asm-arm/arch-omap/mmc.h
> index 4d40db0..3c2f2c1 100644
> --- a/include/asm-arm/arch-omap/mmc.h
> +++ b/include/asm-arm/arch-omap/mmc.h
> @@ -55,13 +55,16 @@ struct omap_mmc_platform_data {
>  
>  		const char *name;
>  		u32 ocr_mask;
> +
> +		/* Card detection IRQs */
> +		int card_detect_irq;
> +		int (* card_detect)(int irq);
>  	} slots[OMAP_MMC_MAX_SLOTS];
>  };
>  
>  extern void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info);
>  
>  /* called from board-specific card detection service routine */
> -extern void omap_mmc_notify_card_detect(struct device *dev, int slot, int detected);
>  extern void omap_mmc_notify_cover_event(struct device *dev, int slot, int is_closed);
>  
>  #endif
> -- 
> 1.5.4.1.162.g72eef
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
