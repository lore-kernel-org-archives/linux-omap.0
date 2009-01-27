From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM debug: Fix problems with PM timers
Date: Tue, 27 Jan 2009 07:15:57 -0800
Message-ID: <87zlhcu6du.fsf@deeprootsystems.com>
References: <1232959371-16669-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:11013 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbZA0PQC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 10:16:02 -0500
Received: by el-out-1112.google.com with SMTP id b25so1317877elf.1
        for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2009 07:16:00 -0800 (PST)
In-Reply-To: <1232959371-16669-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Mon\, 26 Jan 2009 10\:42\:51 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> Camera sleep deny fix introduced a problem that broke MPU state timers, this
> is now fixed. Also removed DPLL* powerdomain timers from the status dumps.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks, pushing to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/pm-debug.c |    3 ++-
>  arch/arm/mach-omap2/pm34xx.c   |    3 +--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 2fc821a..bbd96a3 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -397,7 +397,8 @@ static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
>  	int i;
>  
>  	if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
> -		strcmp(pwrdm->name, "wkup_pwrdm") == 0)
> +		strcmp(pwrdm->name, "wkup_pwrdm") == 0 ||
> +		strncmp(pwrdm->name, "dpll", 4) == 0)
>  		return 0;
>  
>  	pwrdm_state_switch(pwrdm);
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index b2db0ba..4ab37d5 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -407,8 +407,6 @@ void omap_sram_idle(void)
>  					       OMAP3_PRM_VOLTCTRL_OFFSET);
>  	}
>  
> -	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
> -
>  	/* PER */
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
> @@ -431,6 +429,7 @@ void omap_sram_idle(void)
>  
>  	pwrdm_post_transition();
>  
> +	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>  }
>  
>  /*
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
