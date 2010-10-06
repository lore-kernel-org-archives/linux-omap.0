From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/4] omap4: pandaboard: Adding card detect support for MMC1
Date: Wed, 06 Oct 2010 14:57:35 -0700
Message-ID: <87zkurgf1s.fsf@deeprootsystems.com>
References: <1286399673-912-1-git-send-email-x0132446@ti.com>
	<1286399673-912-4-git-send-email-x0132446@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47728 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759935Ab0JFV5i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 17:57:38 -0400
Received: by iwn5 with SMTP id 5so57219iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 06 Oct 2010 14:57:37 -0700 (PDT)
In-Reply-To: <1286399673-912-4-git-send-email-x0132446@ti.com> (David Anders's
	message of "Wed, 6 Oct 2010 16:14:32 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Anders <x0132446@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Anand Gadiyar <gadiyar@ti.com>

David Anders <x0132446@ti.com> writes:

> Adding card detect callback function and card detect configuration
> function for MMC1 Controller.
>
> Signed-off-by: David Anders <x0132446@ti.com>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
>
> patch depends on https://patchwork.kernel.org/patch/189952/

This link is for v2 of that patch, and the latest was v4.  Has this been
tested with v4?

Kevin

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
