From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: mmc: fix compile breakage on board-n800-mmc.c
Date: Mon, 6 Oct 2008 12:21:38 +0300
Message-ID: <20081006092137.GB2806@atomide.com>
References: <1223284162-7511-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61238 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbYJFJSk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 05:18:40 -0400
Content-Disposition: inline
In-Reply-To: <1223284162-7511-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [081006 12:10]:
> Commit 81d2c7d87a9c1eb724788fce7312922effa1b1ae broke
> compilation of board-n800-mmc.c, this patch fixes it.

Thanks, pushing.

> Still n810 doesn't boot anymore with current linux-omap.
> Will look into that soon.

Could it be because of the removal of the 0 byte I2C hack?

Tony

> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/board-n800-mmc.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800-mmc.c b/arch/arm/mach-omap2/board-n800-mmc.c
> index 2cf8213..2c5c97c 100644
> --- a/arch/arm/mach-omap2/board-n800-mmc.c
> +++ b/arch/arm/mach-omap2/board-n800-mmc.c
> @@ -336,7 +336,7 @@ void __init n800_mmc_init(void)
>  
>  {
>  	if (machine_is_nokia_n810()) {
> -		n800_mmc1_data.slots[0].name = "external";
> +		mmc1_data.slots[0].name = "external";
>  
>  		/*
>  		 * Some Samsung Movinand chips do not like open-ended
> @@ -344,8 +344,8 @@ void __init n800_mmc_init(void)
>  		 * while doing so. Reducing the number of blocks in
>  		 * the transfer or delays in clock disable do not help
>  		 */
> -		n800_mmc1_data.slots[1].name = "internal";
> -		n800_mmc1_data.slots[1].ban_openended = 1;
> +		mmc1_data.slots[1].name = "internal";
> +		mmc1_data.slots[1].ban_openended = 1;
>  	}
>  
>  	if (omap_request_gpio(slot_switch_gpio) < 0)
> -- 
> 1.6.0.2.307.gc427
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
