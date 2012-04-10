From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap4: hsmmc: check for null pointer
Date: Mon, 9 Apr 2012 17:08:09 -0700
Message-ID: <20120410000808.GE6487@atomide.com>
References: <1333460858-9324-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42418 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab2DJAIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 20:08:13 -0400
Content-Disposition: inline
In-Reply-To: <1333460858-9324-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Balaji T K <balajitk@ti.com> [120403 06:47]:
> platform_device pdev can be NULL if CONFIG_MMC_OMAP_HS is not set.
> Add check for NULL pointer
> 
> Fixes the following boot crash seen with omap4sdp and omap4panda
> when MMC is disabled.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000008c
> pgd = c0004000
> [0000008c] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0    Not tainted  (3.4.0-rc1-05971-ga4dfa82 #4)
> PC is at omap_4430sdp_init+0x184/0x410
> LR is at device_add+0x1a0/0x664
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c    |    6 +++++-
>  arch/arm/mach-omap2/board-omap4panda.c |    6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index a39fc4b..1ce771d 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -526,8 +526,12 @@ static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
>  	struct omap2_hsmmc_info *c;
>  
>  	omap_hsmmc_init(controllers);
> -	for (c = controllers; c->mmc; c++)
> +	for (c = controllers; c->mmc; c++) {
> +		/* pdev can be null if CONFIG_MMC_OMAP_HS is not set */
> +		if (!c->pdev)
> +			continue;
>  		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
> +	}
>  
>  	return 0;
>  }
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index d8c0e89..104fd6d 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -278,8 +278,12 @@ static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
>  	struct omap2_hsmmc_info *c;
>  
>  	omap_hsmmc_init(controllers);
> -	for (c = controllers; c->mmc; c++)
> +	for (c = controllers; c->mmc; c++) {
> +		/* pdev can be null if CONFIG_MMC_OMAP_HS is not set */
> +		if (!c->pdev)
> +			continue;
>  		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
> +	}
>  
>  	return 0;
>  }

Uhh cut and paste duplicate code.. Let's get rid of that while at
it. Can you please update this so we have only one copy of
omap4_twl6030_hsmmc_init in some place, maybe in one of the
arch/arm/mach-omap2/*twl*.c files?

Thanks,

Tony
