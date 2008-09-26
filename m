From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 1/1] Hook into PM counters
Date: Fri, 26 Sep 2008 17:18:06 +0300
Message-ID: <20080926141806.GC4611@codecarver.research.nokia.com>
References: <1222438323-14197-1-git-send-email-peter.de-schrijver@nokia.com> <1222438323-14197-2-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37983 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbYIZOUh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 10:20:37 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8QEKNU8019058
	for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2008 17:20:35 +0300
Received: from codecarver.research.nokia.com (esdhcp04329.research.nokia.com [172.21.43.29])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8QEI6Ih009795
	for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2008 17:18:06 +0300
Received: from p2 by codecarver.research.nokia.com with local (Exim 4.69)
	(envelope-from <p2@codecarver.research.nokia.com>)
	id 1KjE90-0003iB-B4
	for linux-omap@vger.kernel.org; Fri, 26 Sep 2008 17:18:06 +0300
Content-Disposition: inline
In-Reply-To: <1222438323-14197-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This seems to be duplicate. You can ignore it.

Cheers,

Peter.

> 
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

-- 
goa is a state of mind
