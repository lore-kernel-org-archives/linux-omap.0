From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] omap4: pandaboard: Adding card detect support for
 MMC1
Date: Wed, 6 Oct 2010 14:59:38 -0700
Message-ID: <20101006215938.GB4859@atomide.com>
References: <1286399673-912-1-git-send-email-x0132446@ti.com>
 <1286399673-912-4-git-send-email-x0132446@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59442 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab0JFV7q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 17:59:46 -0400
Content-Disposition: inline
In-Reply-To: <1286399673-912-4-git-send-email-x0132446@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Anders <x0132446@ti.com>, kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Anand Gadiyar <gadiyar@ti.com>

* David Anders <x0132446@ti.com> [101006 14:06]:
> Adding card detect callback function and card detect configuration
> function for MMC1 Controller.

This one would be best merged into this patch from Kishore:

https://patchwork.kernel.org/patch/189952/

Kishore, care to update your patch with this one and then send
the updated version to Samuel? I think there may have been some
other pending comments too.

The other three look OK to me to queue.

Regards,

Tony

> 
> Signed-off-by: David Anders <x0132446@ti.com>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
> 
> patch depends on https://patchwork.kernel.org/patch/189952/
> 
>  arch/arm/mach-omap2/board-omap4panda.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 697c0bd..94e819c 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -77,9 +77,14 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
>  	struct omap_mmc_platform_data *pdata = dev->platform_data;
>  
>  	/* Setting MMC1 Card detect Irq */
> -	if (pdev->id == 0)
> +	if (pdev->id == 0) {
> +		ret = twl6030_mmc_card_detect_config();
> +		if (ret)
> +			pr_err("Failed configuring MMC1 card detect\n");
>  		pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
>  						MMCDETECT_INTR_OFFSET;
> +		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
> +	}
>  	return ret;
>  }
>  
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
