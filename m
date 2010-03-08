From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/3] OMAP3: PM: Bug fix in Smartreflex driver.
Date: Mon, 08 Mar 2010 09:38:49 -0800
Message-ID: <873a0avhli.fsf@deeprootsystems.com>
References: <1268068851-30022-1-git-send-email-thara@ti.com>
	<1268068851-30022-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f198.google.com ([209.85.221.198]:46428 "EHLO
	mail-qy0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab0CHRiy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 12:38:54 -0500
Received: by qyk36 with SMTP id 36so4457502qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 09:38:53 -0800 (PST)
In-Reply-To: <1268068851-30022-2-git-send-email-thara@ti.com> (Thara Gopinath's message of "Mon\,  8 Mar 2010 22\:50\:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch sets and unsets is_sr_reset is appropriate places so that
> trying to enable smart reflex in a non-supported OMAP chip does not
> lead to unnecessary crash

$SUBJECT needs to be more desciptive.   Patch content looks fine.

Kevin


> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   31 +++++++++++++++++++++----------
>  1 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index ca2223d..7aa84ab 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -108,9 +108,14 @@ static int sr_clk_enable(struct omap_sr *sr)
>  {
>  	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
>  
> +	if (!sr->is_sr_reset)
> +		return 0;
> +
>  	if (pdata->device_enable)
>  		pdata->device_enable(sr->pdev);
>  
> +	sr->is_sr_reset = 0;
> +
>  	return 0;
>  }
>  
> @@ -118,6 +123,9 @@ static void sr_clk_disable(struct omap_sr *sr)
>  {
>  	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
>  
> +	if (sr->is_sr_reset)
> +		return;
> +
>  	if (pdata->device_idle)
>  		pdata->device_idle(sr->pdev);
>  
> @@ -262,7 +270,6 @@ static void sr_configure(struct omap_sr *sr)
>  			 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
>  			 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
>  	}
> -	sr->is_sr_reset = 0;
>  }
>  
>  static void sr_start_vddautocomap(int srid)
> @@ -283,8 +290,7 @@ static void sr_start_vddautocomap(int srid)
>  	sr->is_autocomp_active = 1;
>  	if (!sr_class->enable(srid)) {
>  		sr->is_autocomp_active = 0;
> -		if (sr->is_sr_reset == 1)
> -			sr_clk_disable(sr);
> +		sr_clk_disable(sr);
>  	}
>  }
>  
> @@ -303,8 +309,10 @@ static void sr_stop_vddautocomap(int srid)
>  	}
>  
>  	if (sr->is_autocomp_active == 1) {
> -		sr_class->disable(srid);
> -		sr_clk_disable(sr);
> +		if (!sr->is_sr_reset) {
> +			sr_class->disable(srid);
> +			sr_clk_disable(sr);
> +		}
>  		sr->is_autocomp_active = 0;
>  	}
>  
> @@ -357,6 +365,11 @@ int sr_enable(int srid, u32 target_opp_no)
>  
>  	/* Enable the clocks and configure SR */
>  	sr_clk_enable(sr);
> +
> +	/* Check if SR is already enabled. If yes do nothing */
> +	if (sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE)
> +		return true;
> +
>  	sr_configure(sr);
>  
>  	nvalue_reciprocal = pdata->sr_nvalue[target_opp_no - 1];
> @@ -447,10 +460,8 @@ void omap_smartreflex_enable(int srid)
>  	}
>  
>  	if (sr->is_autocomp_active == 1) {
> -		if (sr->is_sr_reset == 1) {
> -			if (!sr_class->enable(srid))
> -				sr_clk_disable(sr);
> -		}
> +		if (!sr_class->enable(srid))
> +			sr_clk_disable(sr);
>  	}
>  }
>  
> @@ -478,7 +489,7 @@ void omap_smartreflex_disable(int srid)
>  	}
>  
>  	if (sr->is_autocomp_active == 1) {
> -		if (sr->is_sr_reset == 0) {
> +		if (!sr->is_sr_reset) {
>  			sr_class->disable(srid);
>  			/* Disable SR clk */
>  			sr_clk_disable(sr);
> -- 
> 1.7.0.rc1.33.g07cf0f
