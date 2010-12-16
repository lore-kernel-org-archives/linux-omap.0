From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/5] OMAP4: PM: Use the low-power state change feature on OMAP4
Date: Thu, 16 Dec 2010 08:45:34 -0800
Message-ID: <87d3p1hdjl.fsf@deeprootsystems.com>
References: <1292503605-14523-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:57505 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115Ab0LPQpk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 11:45:40 -0500
Received: by pzk36 with SMTP id 36so662436pzk.11
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 08:45:40 -0800 (PST)
In-Reply-To: <1292503605-14523-1-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Thu, 16 Dec 2010 18:16:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>

Rajendra Nayak <rnayak@ti.com> writes:

> For pwrdm's which support LOWPOWERSTATECHANGE, do not try waking
> up the domain to put it back to deeper sleep state.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
> Changes in v2:
> Changed implementation for better readability and code
> reuse as suggested here
> http://marc.info/?l=linux-omap&m=129245686306262&w=2
>
> The below branch is updated with this version of the patch
> git://gitorious.org/omap-pm/linux.git for_2.6.38/power
>
>  arch/arm/mach-omap2/pm.c |   28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> Index: linux/arch/arm/mach-omap2/pm.c
> ===================================================================
> --- linux.orig/arch/arm/mach-omap2/pm.c	2010-12-15 17:29:42.361228780 +0530
> +++ linux/arch/arm/mach-omap2/pm.c	2010-12-15 20:19:48.321228780 +0530
> @@ -89,6 +89,10 @@
>  	}
>  }
>  
> +/* Types of sleep_switch used in omap_set_pwrdm_state */
> +#define FORCEWAKEUP_SWITCH	0
> +#define LOWPOWERSTATE_SWITCH	1
> +
>  /*
>   * This sets pwrdm state (other than mpu & core. Currently only ON &
>   * RET are supported. Function is assuming that clkdm doesn't have
> @@ -114,9 +118,14 @@
>  		return ret;
>  
>  	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
> -		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
> -		sleep_switch = 1;
> -		pwrdm_wait_transition(pwrdm);
> +		if ((pwrdm_read_pwrst(pwrdm) > state) &&
> +			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
> +			sleep_switch = LOWPOWERSTATE_SWITCH;
> +		} else {
> +			omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
> +			pwrdm_wait_transition(pwrdm);
> +			sleep_switch = FORCEWAKEUP_SWITCH;
> +		}
>  	}
>  
>  	ret = pwrdm_set_next_pwrst(pwrdm, state);
> @@ -126,12 +135,19 @@
>  		goto err;
>  	}
>  
> -	if (sleep_switch) {
> +	switch (sleep_switch) {
> +	case FORCEWAKEUP_SWITCH:
>  		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
> -		pwrdm_wait_transition(pwrdm);
> -		pwrdm_state_switch(pwrdm);
> +		break;
> +	case LOWPOWERSTATE_SWITCH:
> +		pwrdm_set_lowpwrstchange(pwrdm);
> +		break;
> +	default:
> +		return ret;
>  	}
>  
> +	pwrdm_wait_transition(pwrdm);
> +	pwrdm_state_switch(pwrdm);
>  err:
>  	return ret;
>  }
