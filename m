From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP PM: SRF: Drop unnecessary powerdomain activity hooks
Date: Tue, 27 Oct 2009 14:04:19 -0700
Message-ID: <87y6mw8s6k.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.0910271424420.10228@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:64677 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932334AbZJ0VEQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 17:04:16 -0400
Received: by mail-px0-f180.google.com with SMTP id 10so91699pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2009 14:04:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0910271424420.10228@utopia.booyaka.com> (Paul Walmsley's message of "Tue\, 27 Oct 2009 14\:25\:30 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com

Paul Walmsley <paul@pwsan.com> writes:

> This patch applies against the PM branch.
>
> omap_pm_pwrdm_active() and omap_pm_pwrdm_inactive() were dropped from the
> OMAP PM interface some time ago, but evidently we did not drop them from
> omap-pm-srf.c; this patch does that now.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, pushing to PM branch.

Kevin

> ---
>  arch/arm/plat-omap/omap-pm-srf.c |   38 +-------------------------------------
>  1 files changed, 1 insertions(+), 37 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
> index d769b90..ef1d235 100644
> --- a/arch/arm/plat-omap/omap-pm-srf.c
> +++ b/arch/arm/plat-omap/omap-pm-srf.c
> @@ -297,43 +297,7 @@ int omap_pm_get_dev_context_loss_count(struct device *dev)
>  }
>  
>  /*
> - * Powerdomain usecounting hooks
> - */
> -
> -void omap_pm_pwrdm_active(struct powerdomain *pwrdm)
> -{
> -	if (!pwrdm) {
> -		WARN_ON(1);
> -		return;
> -	};
> -
> -	pr_debug("OMAP PM: powerdomain %s is becoming active\n", pwrdm->name);
> -
> -	/*
> -	 * CDP code apparently will need these for the enable_power_domain()
> -	 * and disable_power_domain() functions.
> -	 */
> -}
> -
> -void omap_pm_pwrdm_inactive(struct powerdomain *pwrdm)
> -{
> -	if (!pwrdm) {
> -		WARN_ON(1);
> -		return;
> -	};
> -
> -	pr_debug("OMAP PM: powerdomain %s is becoming inactive\n",
> -		 pwrdm->name);
> -
> -	/*
> -	 * CDP code apparently will need these for the enable_power_domain()
> -	 * and disable_power_domain() functions.
> -	 */
> -}
> -
> -/*
> - * Should be called before clk framework since clk fw will call
> - * omap_pm_pwrdm_{in,}active()
> + * Must be called before clk framework init
>   */
>  int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
>  				 struct omap_opp *dsp_opp_table,
> -- 
> 1.6.5.GIT
