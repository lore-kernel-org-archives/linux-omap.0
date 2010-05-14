From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 OMAP3 PM]: Remove IVA state conflict between PM and DspBridge code
Date: Fri, 14 May 2010 10:36:46 -0700
Message-ID: <874oial70x.fsf@deeprootsystems.com>
References: <1273745778-32325-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47037 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187Ab0ENRgu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 13:36:50 -0400
Received: by pwi10 with SMTP id 10so729360pwi.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 10:36:49 -0700 (PDT)
In-Reply-To: <1273745778-32325-1-git-send-email-shweta.gulati@ti.com> (shweta gulati's message of "Thu\, 13 May 2010 15\:46\:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shweta gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Sripathy Vishwanath <vishwanath.bs@ti.com>

shweta gulati <shweta.gulati@ti.com> writes:

> From: Shweta Gulati <shweta.gulati@ti.com>
>
> This version of patch incorporates review comments which includes
> shifting the code change in specific function 'omap3_iva_idle' and
> removing iva_pwrdm from pwrst_list rather than checking all the pwrdms
> in list to exclude iva_pwrdm. 

Comments about the version history of a patch don't belong here.  They
belong after the '---' so they are not picked up in the git history.

> The PM code should not set latency on IVA power state based on 
> the flag 'enable_off_mode'.

Why?  A changelog is about answering *both* 'what' and 'why'

Also the SRF change should be a separate patch since SRF is PM branch
only.  The primary change here should be targetted for mainline.

> This is taken care of in this version.   
>
> Signed-off-by: Sripathy Vishwanath <vishwanath.bs@ti.com>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---

I *strongly* recommend using git-format-patch, then manually editing
this part to add patch version history.

> Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c
> +++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
> @@ -786,6 +786,12 @@ static void __init omap3_iva_idle(void)
>  			  OMAP3430_RST2_IVA2 |
>  			  OMAP3430_RST3_IVA2,
>  			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
> +	/* Put the IVA2 In Idle */
> +	prm_rmw_mod_reg_bits(OMAP3430_LASTPOWERSTATEENTERED_MASK, 0,
> +				OMAP3430_IVA2_MOD, OMAP2_PM_PWSTCTRL);

huh?

this is confusing for multiple reasons

1. The comment is wrong.  You're setting the nex powerstate to OFF.

2. LASTPOWERSTATEENTERED is a field in PM_PREPWSTST, not in PM_PWSTCTRL,
   so the field your changing is the POWERSTATE field of PM_PWRSTCTRL.

3. setting this state is already done in pwrdms_setup()


> +	/* Make Clock transition Automatic*/

nit: need a space before the '*/'

> +	cm_rmw_mod_reg_bits(OMAP3430_CLKTRCTRL_IVA2_MASK, 0x3,
> +				OMAP3430_IVA2_MOD, OMAP2_CM_CLKSTCTRL);
>  }
>  
>  static void __init omap3_d2d_idle(void)
> @@ -1074,8 +1080,11 @@ static int __init pwrdms_setup(struct po
>  	if (!pwrst)
>  		return -ENOMEM;
>  	pwrst->pwrdm = pwrdm;
> -	pwrst->next_state = PWRDM_POWER_RET;
> -	list_add(&pwrst->node, &pwrst_list);
> +	if (strcmp("iva2_pwrdm", pwrdm->name)) {
> +		pwrst->next_state = PWRDM_POWER_RET;
> +		list_add(&pwrst->node, &pwrst_list);
> +	} else
> +		 pwrst->next_state = PWRDM_POWER_OFF;

See Documentation/CodingStyle about use of {}.  If one part
of an 'if' has {}s, the other(s) should as well.

>  	if (pwrdm_has_hdwr_sar(pwrdm))
>  		pwrdm_enable_hdwr_sar(pwrdm);
> Index: linux-omap-pm/arch/arm/mach-omap2/resource34xx.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/resource34xx.c
> +++ linux-omap-pm/arch/arm/mach-omap2/resource34xx.c
> @@ -140,7 +140,8 @@ int set_pd_latency(struct shared_resourc
>  	}
>  
>  	if (!enable_off_mode && pd_lat_level == PD_LATENCY_OFF)
> -		pd_lat_level = PD_LATENCY_RET;
> +		if (strcmp("iva2_pwrdm", pwrdm->name))
> +			pd_lat_level = PD_LATENCY_RET;
>  
>  	resp->curr_level = pd_lat_level;
>  	set_pwrdm_state(pwrdm, pd_lat_level);

This change should be a separate patch including a changelog that
answers "why?"

Kevin
