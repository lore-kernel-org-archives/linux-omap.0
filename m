From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] Hook into PM counters
Date: Wed, 01 Oct 2008 14:36:24 +0300
Message-ID: <87od24tumf.fsf@deeprootsystems.com>
References: <1222438323-14197-1-git-send-email-peter.de-schrijver@nokia.com>
	<1222438323-14197-2-git-send-email-peter.de-schrijver@nokia.com>
	<1222438323-14197-3-git-send-email-peter.de-schrijver@nokia.com>
	<1222438323-14197-4-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:41111 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbYJALge (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 07:36:34 -0400
Received: by fk-out-0910.google.com with SMTP id 18so60908fkq.5
        for <linux-omap@vger.kernel.org>; Wed, 01 Oct 2008 04:36:32 -0700 (PDT)
In-Reply-To: <1222438323-14197-4-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Fri\, 26 Sep 2008 17\:12\:03 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  arch/arm/mach-omap2/clock.c       |    2 ++
>  arch/arm/mach-omap2/clockdomain.c |    4 ++++
>  arch/arm/mach-omap2/pm34xx.c      |    6 ++++++
>  3 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index c3af24e..dbbc7c8 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -1013,5 +1013,7 @@ void omap2_clk_disable_unused(struct clk *clk)
>  
>  	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
>  	_omap2_clk_disable(clk);
> +	if (clk->clkdm.ptr != NULL)
> +		pwrdm_clkdm_state_switch(clk->clkdm.ptr);
>  }
>  #endif
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index fa62f14..5249fe8 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -567,6 +567,8 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
>  	else
>  		omap2_clkdm_wakeup(clkdm);
>  
> +	pwrdm_clkdm_state_switch(clkdm);
> +
>  	return 0;
>  }
>  
> @@ -618,6 +620,8 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
>  	else
>  		omap2_clkdm_sleep(clkdm);
>  
> +	pwrdm_clkdm_state_switch(clkdm);
> +
>  	return 0;
>  }
>  
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index a828db6..5913c4d 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -170,6 +170,8 @@ static void omap_sram_idle(void)
>  	disable_smartreflex(SR1);
>  	disable_smartreflex(SR2);
>  
> +	pwrdm_pre_suspend();
> +

Maybe these hooks shouldn't be called "suspend" since they happen for
idle and for suspend.  Maybe pwrdm_pre_transition() ?

>  	omap2_gpio_prepare_for_retention();
>  
>  	_omap_sram_idle(NULL, save_state);
> @@ -179,6 +181,9 @@ static void omap_sram_idle(void)
>  	/* Enable smartreflex after WFI */
>  	enable_smartreflex(SR1);
>  	enable_smartreflex(SR2);
> +
> +	pwrdm_post_suspend();
> +

ditto.

>  }
>  
>  /*
> @@ -260,6 +265,7 @@ static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  	if (sleep_switch) {
>  		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
>  		pwrdm_wait_transition(pwrdm);
> +		pwrdm_state_switch(pwrdm);
>  	}
>  
>  err:
> -- 
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
