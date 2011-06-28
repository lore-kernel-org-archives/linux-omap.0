From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v3 4/8] OMAP2+: PM: idle clkdms only if already in idle
Date: Mon, 27 Jun 2011 18:00:21 -0700
Message-ID: <20110628010021.GA21519@google.com>
References: <1309191103-8817-1-git-send-email-b-cousson@ti.com>
 <1309191103-8817-5-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:35447 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab1F1BA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 21:00:57 -0400
Content-Disposition: inline
In-Reply-To: <1309191103-8817-5-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

On Mon, Jun 27, 2011 at 06:11:39PM +0200, Benoit Cousson wrote:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> The omap_set_pwrdm_state function forces clockdomains
> to idle, without checking the existing idle state
> programmed, instead based solely on the HW capability
> of the clockdomain to support idle.
> This is wrong and the clockdomains should be idled
> post a state_switch *only* if idle transitions on the
> clockdomain were already enabled.
...
>  		} else {
> +			hwsup = clkdm_allows_idle(pwrdm->pwrdm_clkdms[0]);
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

Since it seems these power domain state transitions could be executed
concurrently with other operations on the clock domain that is first
in the list, is there still a chance for a race, such that it may no
longer be appropriate to put the clock domain in h/w-supervised idle
mode after the power domain transition is complete?  If so, perhaps an
atomic wakeup refcount could flag when it is OK to allow idle on the
clock domain.


Todd
