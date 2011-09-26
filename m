From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 04/26] gpio/omap: fix pwrdm_post_transition call sequence
Date: Mon, 26 Sep 2011 16:15:52 -0700
Message-ID: <87ty7y7v4n.fsf@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:55587 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752701Ab1IZXP6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 19:15:58 -0400
Received: by mail-yi0-f50.google.com with SMTP id 25so4815817yib.9
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 16:15:57 -0700 (PDT)
In-Reply-To: <1315918979-26173-5-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 13 Sep 2011 18:32:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> The context lost count is modified in omap_sram_idle() path when
> pwrdm_post_transition() is called. But pwrdm_post_transition() is called
> only after omap_gpio_resume_after_idle() is called. Correct this so that
> context lost count is modified before calling omap_gpio_resume_after_idle().
>
> This would be useful when OMAP GPIO save/restore context is called by
> the OMAP GPIO driver itself.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

This one isn't directly related to the GPIO cleanup, so I'll pull it out
and add it to my PM cleanup queue for v3.2, adding Tony's ack.

I'll also change the subject prefix to: ARM: OMAP3: PM: ...

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7255d9b..1915050 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -363,7 +363,6 @@ void omap_sram_idle(void)
>  		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
>  		return;
>  	}
> -	pwrdm_pre_transition();
>  
>  	/* NEON control */
>  	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
> @@ -386,6 +385,8 @@ void omap_sram_idle(void)
>  			if (!console_trylock())
>  				goto console_still_active;
>  
> +	pwrdm_pre_transition();
> +
>  	/* PER */
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
> @@ -455,6 +456,8 @@ void omap_sram_idle(void)
>  	}
>  	omap3_intc_resume_idle();
>  
> +	pwrdm_post_transition();
> +
>  	/* PER */
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
> @@ -478,8 +481,6 @@ console_still_active:
>  		omap3_disable_io_chain();
>  	}
>  
> -	pwrdm_post_transition();
> -
>  	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>  }
