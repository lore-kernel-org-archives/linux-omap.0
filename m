From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 2/6] OMAP3: PM: Added support for INACTIVE and ON states for powerdomains
Date: Tue, 12 Jan 2010 10:28:08 -0800
Message-ID: <87ljg3ch53.fsf@deeprootsystems.com>
References: <1259916781-2741-1-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-2-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-3-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:59034 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab0ALS2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 13:28:12 -0500
Received: by pxi4 with SMTP id 4so4797322pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 10:28:11 -0800 (PST)
In-Reply-To: <1259916781-2741-3-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\,  4 Dec 2009 10\:52\:57 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Previously omap_sram_idle() did not know about the difference between ON and
> INACTIVE states, which complicated the state handling in these cases. Now,
> the following changes are done in the idle logic:
>
> - Check for IO-chain arming is changed to reflect desired state (RET)
> - UART clocks will be disabled if we attempt to enter INACTIVE (this allows
>   the state change to actually happen)
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Looks good, will add to PM branch after issues with patch 1 are resolved.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 3b62c96..574492e 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -391,6 +391,7 @@ void omap_sram_idle(void)
>  	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
>  	switch (mpu_next_state) {
>  	case PWRDM_POWER_ON:
> +	case PWRDM_POWER_INACTIVE:
>  	case PWRDM_POWER_RET:
>  		/* No need to save context */
>  		save_state = 0;
> @@ -460,9 +461,11 @@ void omap_sram_idle(void)
>  						OMAP3430_GR_MOD,
>  						OMAP3_PRM_VOLTCTRL_OFFSET);
>  		}
> -		/* Enable IO-PAD and IO-CHAIN wakeups */
> -		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
> -		omap3_enable_io_chain();
> +		if (core_next_state <= PWRDM_POWER_RET) {
> +			/* Enable IO-PAD and IO-CHAIN wakeups */
> +			prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
> +			omap3_enable_io_chain();
> +		}
>  	}
>  	omap3_intc_prepare_idle();
>  
> @@ -561,15 +564,13 @@ void omap_sram_idle(void)
>  	}
>  
>  	/* Disable IO-PAD and IO-CHAIN wakeup */
> -	if (core_next_state < PWRDM_POWER_ON) {
> +	if (core_next_state <= PWRDM_POWER_RET) {
>  		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
>  		omap3_disable_io_chain();
>  	}
>  
>  
>  	pwrdm_post_transition();
> -
> -	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>  }
>  
>  int omap3_can_sleep(void)
> @@ -617,7 +618,6 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  	}
>  
>  	if (sleep_switch) {
> -		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
>  		pwrdm_wait_transition(pwrdm);
>  		pwrdm_state_switch(pwrdm);
>  	}
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
