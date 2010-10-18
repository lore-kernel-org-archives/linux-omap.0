From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] omap4: pandaboard: fix up mmc card detect logic
Date: Mon, 18 Oct 2010 12:06:24 -0500
Message-ID: <2E5804DAE93D403D9F7FCEDBF6367E59@am.dhcp.ti.com>
References: <1287149087-16656-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45232 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777Ab0JRRGb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Oct 2010 13:06:31 -0400
In-Reply-To: <1287149087-16656-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Nishanth Menon' <nm@ti.com>, 'l-o' <linux-omap@vger.kernel.org>
Cc: 'Dave' <x0132446@ti.com>, 'Tony Lindgren' <tony@atomide.com>, 'Adrian Hunter' <adrian.hunter@nokia.com>, 'Samuel Ortiz' <sameo@linux.intel.com>



> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com]
> Sent: Friday, October 15, 2010 8:25 AM
> To: l-o
> Cc: Dave; Nishanth Menon; Tony Lindgren; Madhusudhan Chikkature; Adrian
> Hunter; Samuel Ortiz
> Subject: [PATCH] omap4: pandaboard: fix up mmc card detect logic
> 
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

The patch looks good.
Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Depends on
> http://git.kernel.org/?p=linux/kernel/git/sameo/mfd-
> 2.6.git;a=commitdiff;h=1bf5197061a4aec99e9fd4f92d4a543310f83585;hp=0c9b33e
> 5a23e2053165c9e30ffff3b3a3cf1b2b8
> This patch probably should be squashed to that.
> 
>  arch/arm/mach-omap2/board-omap4panda.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-
> omap2/board-omap4panda.c
> index a9d8a19..47cc8d2 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -160,10 +160,19 @@ static int omap4_twl6030_hsmmc_late_init(struct
> device *dev)
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
> +			pdata->slots[0].card_detect =
twl6030_mmc_card_detect;
> +	}
>  	return ret;
>  }
> 
> --
> 1.6.3.3


