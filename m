From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 4/8] OMAP2+: PM: idle clkdms only if already in idle
Date: Thu, 9 Jun 2011 17:15:56 -0700
Message-ID: <20110610001556.GA9159@google.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
 <1307616853-28395-2-git-send-email-rnayak@ti.com>
 <1307616853-28395-3-git-send-email-rnayak@ti.com>
 <1307616853-28395-4-git-send-email-rnayak@ti.com>
 <1307616853-28395-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:1814 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab1FJAQH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 20:16:07 -0400
Content-Disposition: inline
In-Reply-To: <1307616853-28395-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, Jun 09, 2011 at 04:24:09PM +0530, Rajendra Nayak wrote:
> The omap_set_pwrdm_state function forces clockdomains
> to idle, without checking the existing idle state
> programmed, instead based solely on the HW capability
> of the clockdomain to support idle.
> This is wrong and the clockdomains should be idled
> post a state_switch *only* if idle transitions on the
> clockdomain were already enabled.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/pm.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index d48813f..840b0e1 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -108,6 +108,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  	u32 cur_state;
>  	int sleep_switch = -1;
>  	int ret = 0;
> +	int hwsup = 0;
>  
>  	if (pwrdm == NULL || IS_ERR(pwrdm))
>  		return -EINVAL;
> @@ -127,6 +128,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
>  			sleep_switch = LOWPOWERSTATE_SWITCH;
>  		} else {
> +			hwsup = clkdm_is_idle(pwrdm->pwrdm_clkdms[0]);
>  			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
>  			pwrdm_wait_transition(pwrdm);
>  			sleep_switch = FORCEWAKEUP_SWITCH;
> @@ -142,7 +144,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  
>  	switch (sleep_switch) {
>  	case FORCEWAKEUP_SWITCH:
> -		if (pwrdm->pwrdm_clkdms[0]->flags & CLKDM_CAN_ENABLE_AUTO)
> +		if (hwsup)
>  			clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
>  		else
>  			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);

Is concurrency protection needed here?  Not sure if it's expected that
multiple threads would simultaneously manage the state of the same power
domain, or that the associated clock domain would change state
concurrently.


Todd
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
