From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH] OMAP3: CPUIDLE & PM: check_bm fix.
Date: Wed, 9 Jul 2008 12:14:09 +0530
Message-ID: <000b01c8e18f$31708610$68bf18ac@ent.ti.com>
References: <1215519440-10234-1-git-send-email-jouni.hogander@nokia.com> <1215584973-14982-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:50488 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbYGIGpU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2008 02:45:20 -0400
In-Reply-To: <1215584973-14982-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Jouni Hogander' <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

 
> -----Original Message-----
> From: Jouni Hogander [mailto:jouni.hogander@nokia.com] 
> Sent: Wednesday, July 09, 2008 12:00 PM
> To: linux-omap@vger.kernel.org; rnayak@ti.com
> Subject: [PATCH] OMAP3: CPUIDLE & PM: check_bm fix.
> 
> This patch fixes problems with uart usage. omap3_enter_idle_bm was
> select C5 and C6 states even if there was "bus activity.

Am not very clear on what was the issue with the previous logic that it would 
attempt a C5/C6 even with bus activity.

> 
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   23 +++++++----------------
>  arch/arm/mach-omap2/pm34xx.c      |    2 +-
>  2 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c 
> b/arch/arm/mach-omap2/cpuidle34xx.c
> index c14152f..a636edb 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -473,31 +473,22 @@ static int omap3_enter_idle_bm(struct 
> cpuidle_device *dev,
>  			       struct cpuidle_state *state)
>  {
>  	struct cpuidle_state *new_state = NULL;
> -	int i, j;
> -
> -	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && 
> omap3_idle_bm_check()) {
> -
> -		/* Find current state in list */
> -		for (i = 0; i < OMAP3_MAX_STATES; i++)
> -			if (state == &dev->states[i])
> -				break;
> -		BUG_ON(i == OMAP3_MAX_STATES);
> -
> -		/* Back up to non 'CHECK_BM' state */
> -		for (j = i - 1;  j > 0; j--) {
> -			struct cpuidle_state *s = &dev->states[j];
> +	int i;
>  
> +	if (omap3_idle_bm_check()) {
> +		for (i = 0; i < OMAP3_MAX_STATES; i++) {
> +			struct cpuidle_state *s = &dev->states[i];

So now a C0 is attempted every time there is bus activity?

>  			if (!(s->flags & CPUIDLE_FLAG_CHECK_BM)) {
>  				new_state = s;
>  				break;
>  			}
>  		}
> -
> +		BUG_ON(i == OMAP3_MAX_STATES);
>  		pr_debug("%s: Bus activity: Entering %s 
> (instead of %s)\n",
> -			__FUNCTION__, new_state->name, state->name);
> +			 __FUNCTION__, new_state->name, state->name);
>  	}
>  
> -	return omap3_enter_idle(dev, new_state ? : state);
> +	return omap3_enter_idle(dev, new_state ? new_state : state);
>  }
>  
>  DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
> diff --git a/arch/arm/mach-omap2/pm34xx.c 
> b/arch/arm/mach-omap2/pm34xx.c
> index 9f73e5c..ca0600a 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -734,7 +734,7 @@ static int __init pwrdms_setup(struct 
> powerdomain *pwrdm)
>  		pwrdm_enable_hdwr_sar(pwrdm);
>  
>  	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm") || 
> !strcmp(pwrst->pwrdm->name, "mpu_pwrdm") ||
> -	    !strcmp(pwrst->pwrdm->name, "mpu_pwrdm"))
> +	    !strcmp(pwrst->pwrdm->name, "neon_pwrdm"))
>  		return set_pwrdm_state(pwrst->pwrdm, PWRDM_POWER_ON);
>  	else
>  		return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
> -- 
> 1.5.5
> 
> 

