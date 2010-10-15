From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] omap4: pandaboard: fix up mmc card detect logic
Date: Fri, 15 Oct 2010 08:37:24 -0500
Message-ID: <4CB85914.2060700@ti.com>
References: <1287149087-16656-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39611 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754384Ab0JONhe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Oct 2010 09:37:34 -0400
In-Reply-To: <1287149087-16656-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: "Anders, David" <x0132446@ti.com>, Tony Lindgren <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, Samuel Ortiz <sameo@linux.intel.com>

Menon, Nishanth had written, on 10/15/2010 08:24 AM, the following:
> For MMC1 Controller, card detect interrupt source is
> twl6030 which is non-gpio. The card detect call back function provides
> card present/absent status by reading MMC Control register present
> on twl6030. This functionality was introduced in mfd tree on
> track to kernel.org
> 
> Sync pandaboard to the same and make mmc work.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> Cc: Adrian Hunter <adrian.hunter@nokia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> 
> Acked-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Depends on 
> http://git.kernel.org/?p=linux/kernel/git/sameo/mfd-2.6.git;a=commitdiff;h=1bf5197061a4aec99e9fd4f92d4a543310f83585;hp=0c9b33e5a23e2053165c9e30ffff3b3a3cf1b2b8
> This patch probably should be squashed to that.

Note to Tony/Sameo:
I generated this patch for linux-omap after cherry picking the above 
patch. reason being:
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=refs/heads/omap-for-linus
has fixes we need for Pandaboard

I am at a loss however which tree this patch might be carried on..

> 
>  arch/arm/mach-omap2/board-omap4panda.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index a9d8a19..47cc8d2 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -160,10 +160,19 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
>  				struct platform_device, dev);
>  	struct omap_mmc_platform_data *pdata = dev->platform_data;
>  
> +	if (!pdata) {
> +		dev_err(dev, "%s: NULL platform data\n", __func__);
> +		return -EINVAL;
> +	}
>  	/* Setting MMC1 Card detect Irq */
> -	if (pdev->id == 0)
> -		pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
> -						MMCDETECT_INTR_OFFSET;
> +	if (pdev->id == 0) {
> +		ret = twl6030_mmc_card_detect_config();
> +		 if (ret)
> +			dev_err(dev, "%s: Error card detect config(%d)\n",
> +				__func__, ret);
> +		 else
> +			pdata->slots[0].card_detect = twl6030_mmc_card_detect;
> +	}
>  	return ret;
>  }
>  


-- 
Regards,
Nishanth Menon
