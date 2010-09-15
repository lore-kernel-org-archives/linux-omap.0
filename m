From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP clockdomain: initialize clockdomain registers when the clockdomain layer starts
Date: Wed, 15 Sep 2010 12:36:49 -0700
Message-ID: <87iq26dcj2.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1009151144200.458@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:57705 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab0IOTgw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 15:36:52 -0400
Received: by pxi10 with SMTP id 10so168425pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 12:36:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1009151144200.458@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 15 Sep 2010 11:45:29 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> When the clockdomain layer initializes, place all clockdomains into
> software-supervised mode, and clear all wakeup and sleep dependencies
> immediately, rather than waiting for the PM code to do this later.
> This fixes a major bug where critical sleep dependencies added by the
> hwmod code are cleared during late PM init.
>
> As a side benefit, the _init_{wk,sleep}dep_usecount() functions are no
> longer needed, so remove them.
>
> Kevin Hilman <khilman@deeprootsystems.com> did all the really hard work on
> this, identifying the problem and finding the bug.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Thanks Paul. 

I'll queue this in pm-next for 2.6.37 along with the other changes that
depend on it.

Kevin


> ---
>  arch/arm/mach-omap2/clockdomain.c |  110 +++++--------------------------------
>  arch/arm/mach-omap2/pm34xx.c      |    3 -
>  2 files changed, 15 insertions(+), 98 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index 5d80cb8..6fb61b1 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -258,97 +258,6 @@ static void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
>  
>  }
>  
> -/**
> - * _init_wkdep_usecount - initialize wkdep usecounts to match hardware
> - * @clkdm: clockdomain to initialize wkdep usecounts
> - *
> - * Initialize the wakeup dependency usecount variables for clockdomain @clkdm.
> - * If a wakeup dependency is present in the hardware, the usecount will be
> - * set to 1; otherwise, it will be set to 0.  Software should clear all
> - * software wakeup dependencies prior to calling this function if it wishes
> - * to ensure that all usecounts start at 0.  No return value.
> - */
> -static void _init_wkdep_usecount(struct clockdomain *clkdm)
> -{
> -	u32 v;
> -	struct clkdm_dep *cd;
> -
> -	if (!clkdm->wkdep_srcs)
> -		return;
> -
> -	for (cd = clkdm->wkdep_srcs; cd->clkdm_name; cd++) {
> -		if (!omap_chip_is(cd->omap_chip))
> -			continue;
> -
> -		if (!cd->clkdm && cd->clkdm_name)
> -			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
> -
> -		if (!cd->clkdm) {
> -			WARN(!cd->clkdm, "clockdomain: %s: wkdep clkdm %s not "
> -			     "found\n", clkdm->name, cd->clkdm_name);
> -			continue;
> -		}
> -
> -		v = prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
> -					    PM_WKDEP,
> -					    (1 << cd->clkdm->dep_bit));
> -
> -		if (v)
> -			pr_debug("clockdomain: %s: wakeup dependency already "
> -				 "set to wake up when %s wakes\n",
> -				 clkdm->name, cd->clkdm->name);
> -
> -		atomic_set(&cd->wkdep_usecount, (v) ? 1 : 0);
> -	}
> -}
> -
> -/**
> - * _init_sleepdep_usecount - initialize sleepdep usecounts to match hardware
> - * @clkdm: clockdomain to initialize sleepdep usecounts
> - *
> - * Initialize the sleep dependency usecount variables for clockdomain @clkdm.
> - * If a sleep dependency is present in the hardware, the usecount will be
> - * set to 1; otherwise, it will be set to 0.  Software should clear all
> - * software sleep dependencies prior to calling this function if it wishes
> - * to ensure that all usecounts start at 0.  No return value.
> - */
> -static void _init_sleepdep_usecount(struct clockdomain *clkdm)
> -{
> -	u32 v;
> -	struct clkdm_dep *cd;
> -
> -	if (!cpu_is_omap34xx())
> -		return;
> -
> -	if (!clkdm->sleepdep_srcs)
> -		return;
> -
> -	for (cd = clkdm->sleepdep_srcs; cd->clkdm_name; cd++) {
> -		if (!omap_chip_is(cd->omap_chip))
> -			continue;
> -
> -		if (!cd->clkdm && cd->clkdm_name)
> -			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
> -
> -		if (!cd->clkdm) {
> -			WARN(!cd->clkdm, "clockdomain: %s: sleepdep clkdm %s "
> -			     "not found\n", clkdm->name, cd->clkdm_name);
> -			continue;
> -		}
> -
> -		v = prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
> -					    OMAP3430_CM_SLEEPDEP,
> -					    (1 << cd->clkdm->dep_bit));
> -
> -		if (v)
> -			pr_debug("clockdomain: %s: sleep dependency already "
> -				 "set to prevent from idling until %s "
> -				 "idles\n", clkdm->name, cd->clkdm->name);
> -
> -		atomic_set(&cd->sleepdep_usecount, (v) ? 1 : 0);
> -	}
> -};
> -
>  /* Public functions */
>  
>  /**
> @@ -379,12 +288,17 @@ void clkdm_init(struct clockdomain **clkdms,
>  			_autodep_lookup(autodep);
>  
>  	/*
> -	 * Ensure that the *dep_usecount registers reflect the current
> -	 * state of the PRCM.
> +	 * Put all clockdomains into software-supervised mode; PM code
> +	 * should later enable hardware-supervised mode as appropriate
>  	 */
>  	list_for_each_entry(clkdm, &clkdm_list, node) {
> -		_init_wkdep_usecount(clkdm);
> -		_init_sleepdep_usecount(clkdm);
> +		if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
> +			omap2_clkdm_wakeup(clkdm);
> +		else if (clkdm->flags & CLKDM_CAN_DISABLE_AUTO)
> +			omap2_clkdm_deny_idle(clkdm);
> +
> +		clkdm_clear_all_wkdeps(clkdm);
> +		clkdm_clear_all_sleepdeps(clkdm);
>  	}
>  }
>  
> @@ -592,6 +506,9 @@ int clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
>  		if (!omap_chip_is(cd->omap_chip))
>  			continue;
>  
> +		if (!cd->clkdm && cd->clkdm_name)
> +			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
> +
>  		/* PRM accesses are slow, so minimize them */
>  		mask |= 1 << cd->clkdm->dep_bit;
>  		atomic_set(&cd->wkdep_usecount, 0);
> @@ -752,6 +669,9 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
>  		if (!omap_chip_is(cd->omap_chip))
>  			continue;
>  
> +		if (!cd->clkdm && cd->clkdm_name)
> +			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
> +
>  		/* PRM accesses are slow, so minimize them */
>  		mask |= 1 << cd->clkdm->dep_bit;
>  		atomic_set(&cd->sleepdep_usecount, 0);
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 429268e..772e985 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -1024,9 +1024,6 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>   */
>  static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
>  {
> -	clkdm_clear_all_wkdeps(clkdm);
> -	clkdm_clear_all_sleepdeps(clkdm);
> -
>  	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
>  		omap2_clkdm_allow_idle(clkdm);
>  	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
