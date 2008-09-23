From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH] PM: Fixed clockdomain state control for OMAP3
Date: Tue, 23 Sep 2008 07:22:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0809230722140.27938@utopia.booyaka.com>
References: <> <1221582816-21372-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41956 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYIWNWZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 09:22:25 -0400
In-Reply-To: <1221582816-21372-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tue, 16 Sep 2008, Tero Kristo wrote:

> Hardware supervised control for clockdomain power state transitions now
> enabled in omap3_pm_init(). Also fixed set_pwrdm_state() to allow state
> changes between sleep states (i.e. RET<->OFF.)
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


> ---
>  arch/arm/mach-omap2/pm34xx.c |   38 +++++++++++++++++++-------------------
>  1 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 01b637a..2bccdab 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -227,28 +227,13 @@ static int omap3_can_sleep(void)
>  	return 1;
>  }
>  
> -/* _clkdm_deny_idle - private callback function used by set_pwrdm_state() */
> -static int _clkdm_deny_idle(struct powerdomain *pwrdm,
> -			    struct clockdomain *clkdm)
> -{
> -	omap2_clkdm_deny_idle(clkdm);
> -	return 0;
> -}
> -
> -/* _clkdm_allow_idle - private callback function used by set_pwrdm_state() */
> -static int _clkdm_allow_idle(struct powerdomain *pwrdm,
> -			     struct clockdomain *clkdm)
> -{
> -	omap2_clkdm_allow_idle(clkdm);
> -	return 0;
> -}
> -
>  /* This sets pwrdm state (other than mpu & core. Currently only ON &
>   * RET are supported. Function is assuming that clkdm doesn't have
>   * hw_sup mode enabled. */
>  static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  {
>  	u32 cur_state;
> +	int sleep_switch = 0;
>  	int ret = 0;
>  
>  	if (pwrdm == NULL || IS_ERR(pwrdm))
> @@ -259,8 +244,12 @@ static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  	if (cur_state == state)
>  		return ret;
>  
> -	pwrdm_for_each_clkdm(pwrdm, _clkdm_deny_idle);
> -
> +	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
> +		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
> +		sleep_switch = 1;
> +		pwrdm_wait_transition(pwrdm);
> +	}
> +
>  	ret = pwrdm_set_next_pwrst(pwrdm, state);
>  	if (ret) {
>  		printk(KERN_ERR "Unable to set state of powerdomain: %s\n",
> @@ -268,7 +257,10 @@ static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  		goto err;
>  	}
>  
> -	pwrdm_for_each_clkdm(pwrdm, _clkdm_allow_idle);
> +	if (sleep_switch) {
> +		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
> +		pwrdm_wait_transition(pwrdm);
> +	}
>  
>  err:
>  	return ret;
> @@ -540,6 +532,12 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
>  	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
>  }
>  
> +static int __init clkdms_setup(struct clockdomain *clkdm)
> +{
> +	omap2_clkdm_allow_idle(clkdm);
> +	return 0;
> +}
> +
>  int __init omap3_pm_init(void)
>  {
>  	struct power_state *pwrst;
> @@ -566,6 +564,8 @@ int __init omap3_pm_init(void)
>  		goto err2;
>  	}
>  
> +	(void) clkdm_for_each(clkdms_setup);
> +
>  	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
>  	if (mpu_pwrdm == NULL) {
>  		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
