From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: hsmmc: fix memory leak
Date: Tue, 9 Feb 2010 15:17:32 -0800
Message-ID: <20100209231732.GM21755@atomide.com>
References: <1265632385-27448-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53721 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695Ab0BIXQ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 18:16:56 -0500
Content-Disposition: inline
In-Reply-To: <1265632385-27448-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org, adrian.hunter@nokia.com, jarkko.lavinen@nokia.com

* Aaro Koskinen <aaro.koskinen@nokia.com> [100208 04:29]:
> The platform data allocated with kmalloc() will become unreachable once
> the init is complete, so it should be freed. The problem was discovered
> by kmemleak.

Looks like this is safe to do as platform_device_add_data does kmemdup
on the data.

BTW, if you want to create a version for 2.6.33, we should still have
enough time to queue it as a fix. It's a very limited size leak though,
but still a leak.

Regards,

Tony
 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/arm/mach-omap2/hsmmc.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 1156b28..9ad2295 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -145,6 +145,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
>  {
>  	struct omap2_hsmmc_info *c;
>  	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
> +	int i;
>  
>  	if (cpu_is_omap2430()) {
>  		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
> @@ -171,7 +172,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
>  			      GFP_KERNEL);
>  		if (!mmc) {
>  			pr_err("Cannot allocate memory for mmc device!\n");
> -			return;
> +			goto done;
>  		}
>  
>  		if (c->name)
> @@ -256,6 +257,10 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
>  			continue;
>  		c->dev = mmc->dev;
>  	}
> +
> +done:
> +	for (i = 0; i < nr_hsmmc; i++)
> +		kfree(hsmmc_data[i]);
>  }
>  
>  #endif
> -- 
> 1.5.6.5
> 
