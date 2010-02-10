From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: hsmmc: fix memory leak
Date: Wed, 10 Feb 2010 09:22:21 -0800
Message-ID: <20100210172220.GT21755@atomide.com>
References: <1265632385-27448-1-git-send-email-aaro.koskinen@nokia.com>
 <20100209231732.GM21755@atomide.com>
 <alpine.DEB.2.00.1002101419540.20129@ak-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49209 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab0BJRVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 12:21:41 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1002101419540.20129@ak-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter Adrian (Nokia-D/Helsinki)" <adrian.hunter@nokia.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, linux-arm-kernel@lists.infradead.org

Hi

Added LAKML to Cc for a quick review there too.

* Aaro Koskinen <aaro.koskinen@nokia.com> [100210 04:25]:
> Hi,
> 
> On Wed, 10 Feb 2010, Tony Lindgren wrote:
> >* Aaro Koskinen <aaro.koskinen@nokia.com> [100208 04:29]:
> >>The platform data allocated with kmalloc() will become unreachable once
> >>the init is complete, so it should be freed. The problem was discovered
> >>by kmemleak.
> >
> >Looks like this is safe to do as platform_device_add_data does kmemdup
> >on the data.
> >
> >BTW, if you want to create a version for 2.6.33, we should still have
> >enough time to queue it as a fix. It's a very limited size leak though,
> >but still a leak.
> 
> The version for 2.6.33 is below (also attached).

Thanks, added to omap-fixes for 2.6.33.

Regards,

Tony

> 
> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> Date: Thu, 4 Feb 2010 13:06:59 +0200
> Subject: [PATCH] OMAP: hsmmc: fix memory leak
> 
> The platform data allocated with kmalloc() will become unreachable once
> the init is complete, so it should be freed. The problem was discovered
> by kmemleak.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/arm/mach-omap2/mmc-twl4030.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
> index 0c3c72d..8afe9dd 100644
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> @@ -408,6 +408,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
>  {
>  	struct twl4030_hsmmc_info *c;
>  	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
> +	int i;
> 
>  	if (cpu_is_omap2430()) {
>  		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
> @@ -434,7 +435,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
>  		mmc = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
>  		if (!mmc) {
>  			pr_err("Cannot allocate memory for mmc device!\n");
> -			return;
> +			goto done;
>  		}
> 
>  		if (c->name)
> @@ -532,6 +533,10 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
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

> From 6d15f48ecc177bde18033af2884eb2c5ce53bfd7 Mon Sep 17 00:00:00 2001
> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> Date: Thu, 4 Feb 2010 13:06:59 +0200
> Subject: [PATCH] OMAP: hsmmc: fix memory leak
> 
> The platform data allocated with kmalloc() will become unreachable once
> the init is complete, so it should be freed. The problem was discovered
> by kmemleak.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/arm/mach-omap2/mmc-twl4030.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
> index 0c3c72d..8afe9dd 100644
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> @@ -408,6 +408,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
>  {
>  	struct twl4030_hsmmc_info *c;
>  	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
> +	int i;
>  
>  	if (cpu_is_omap2430()) {
>  		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
> @@ -434,7 +435,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
>  		mmc = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
>  		if (!mmc) {
>  			pr_err("Cannot allocate memory for mmc device!\n");
> -			return;
> +			goto done;
>  		}
>  
>  		if (c->name)
> @@ -532,6 +533,10 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
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

