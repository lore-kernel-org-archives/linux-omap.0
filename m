From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/6] OMAP3: PM: Added support for INACTIVE and ON states for powerdomains
Date: Mon, 16 Nov 2009 11:42:04 -0800
Message-ID: <87bpj2jlyr.fsf@deeprootsystems.com>
References: <1258045359-7962-1-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-2-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-3-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:50160 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbZKPTmA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 14:42:00 -0500
Received: by pzk1 with SMTP id 1so3011132pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 11:42:06 -0800 (PST)
In-Reply-To: <1258045359-7962-3-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 12 Nov 2009 19\:02\:35 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Previously omap_sram_idle() did not know about the difference between ON and
> INACTIVE states, which complicated the state handling in these cases.

This changelog needs an update.

This patch changes makes the IO-chain arming conditional and removes
the clockdomain idle calls.

While I understand the clkdm idle call removal, It's not clear from
the changelog how these are related to the new handling of INACTIVE
states.

> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 9d0a9b4..7b52f30 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -383,6 +383,7 @@ void omap_sram_idle(void)
>  	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
>  	switch (mpu_next_state) {
>  	case PWRDM_POWER_ON:
> +	case PWRDM_POWER_INACTIVE:
>  	case PWRDM_POWER_RET:
>  		/* No need to save context */
>  		save_state = 0;
> @@ -448,9 +449,11 @@ void omap_sram_idle(void)
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
> @@ -542,15 +545,13 @@ void omap_sram_idle(void)
>  	}
>  
>  	/* Disable IO-PAD and IO-CHAIN wakeup */
> -	if (core_next_state < PWRDM_POWER_ON) {
> +	if (core_next_state <= PWRDM_POWER_ON) {

Hmm, did you mean <= RET here?   

Otherwise, you can just remove the conditional.

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
> @@ -598,7 +599,6 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  	}
>  
>  	if (sleep_switch) {
> -		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
>  		pwrdm_wait_transition(pwrdm);
>  		pwrdm_state_switch(pwrdm);
>  	}
> -- 
> 1.5.4.3

Kevin
