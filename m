From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/6] OMAP: Powerdomains: Add support for checking if pwrdm can idle
Date: Mon, 16 Nov 2009 12:13:26 -0800
Message-ID: <87vdhagrdl.fsf@deeprootsystems.com>
References: <1258045359-7962-1-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-2-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-3-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-4-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-5-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-6-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:54211 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbZKPUNW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 15:13:22 -0500
Received: by pzk1 with SMTP id 1so3029879pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 12:13:28 -0800 (PST)
In-Reply-To: <1258045359-7962-6-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 12 Nov 2009 19\:02\:38 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> pwrdm_can_idle(pwrdm) will check if the specified powerdomain can enter
> idle. This is done by checking the current fclk enable bits.
>
> This call can be used e.g. inside cpuidle to decide which power states
> core and mpu should enter during idle, as there are certain dependencies
> between wakeup capabilities and reset logic.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

In your initial implementatio, you were checking all (most) of the
fclks in a given powerdomain.  In this version, you're currently only
checking masks in CORE (UART1 and 2) and PER (UART3.)

I'll assume it's just to propose the idea and we can add more fclks
later.  

That being said, I'm a little reluctant to add another list of FCLK
masks. This seems like something that clock/clockdomain code should be
handling.

In terms of cleanness, it seems that pwrdm_can_idle() should call some
sort of clkdm_can_idle() call for all the clockdomains associated with
it (pwrdm->pwrdm_clkdms[].)

The clockdomain code already tracks its usecount, so clkdm_can_idle()
might be as simple as checking clkdm->usecount.  Just a thought
without digging into the clkdm code.

Kevin

> ---
>  arch/arm/mach-omap2/powerdomain.c             |   22 ++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomains34xx.h        |   14 ++++++++++++++
>  arch/arm/plat-omap/include/plat/powerdomain.h |    9 +++++++++
>  3 files changed, 45 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 1237717..bf2b97a 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -1217,6 +1217,28 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
>  	return 0;
>  }
>  
> +/**
> + * pwrdm_can_idle - check if the powerdomain can enter idle
> + * @pwrdm: struct powerdomain * the powerdomain to check status of
> + *
> + * Does a functional clock check for the powerdomain and returns 1 if the
> + * powerdomain can enter idle, 0 if not.
> + */
> +int pwrdm_can_idle(struct powerdomain *pwrdm)
> +{
> +	int i;
> +	const int fclk_regs[] = { CM_FCLKEN, OMAP3430ES2_CM_FCLKEN3 };
> +
> +	if (!pwrdm)
> +		return -EINVAL;
> +
> +	for (i = 0; i < pwrdm->fclk_reg_amt; i++)
> +		if (cm_read_mod_reg(pwrdm->prcm_offs, fclk_regs[i]) &
> +				(0xffffffff ^ pwrdm->fclk_masks[i]))
> +			return 0;
> +	return 1;
> +}
> +
>  int pwrdm_state_switch(struct powerdomain *pwrdm)
>  {
>  	return _pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
> diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
> index 9eb2dc5..c8cd297 100644
> --- a/arch/arm/mach-omap2/powerdomains34xx.h
> +++ b/arch/arm/mach-omap2/powerdomains34xx.h
> @@ -180,6 +180,7 @@ static struct powerdomain iva2_pwrdm = {
>  		[2] = PWRSTS_OFF_ON,
>  		[3] = PWRDM_POWER_ON,
>  	},
> +	.fclk_reg_amt	  = 1,
>  };
>  
>  static struct powerdomain mpu_34xx_pwrdm = {
> @@ -236,6 +237,11 @@ static struct powerdomain core_34xx_es3_1_pwrdm = {
>  		[0] = PWRSTS_OFF_RET_INA_ON, /* MEM1ONSTATE */
>  		[1] = PWRSTS_OFF_RET_INA_ON, /* MEM2ONSTATE */
>  	},
> +	.fclk_reg_amt	  = 2,
> +	.fclk_masks	  = {
> +		[0] = OMAP3430_EN_UART2 | OMAP3430_EN_UART1,
> +		[1] = 0,
> +	},
>  };
>  
>  /* Another case of bit name collisions between several registers: EN_DSS */
> @@ -255,6 +261,7 @@ static struct powerdomain dss_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
>  	},
> +	.fclk_reg_amt	  = 1,
>  };
>  
>  /*
> @@ -278,6 +285,7 @@ static struct powerdomain sgx_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
>  	},
> +	.fclk_reg_amt	  = 1,
>  };
>  
>  static struct powerdomain cam_pwrdm = {
> @@ -295,6 +303,7 @@ static struct powerdomain cam_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
>  	},
> +	.fclk_reg_amt	  = 1,
>  };
>  
>  static struct powerdomain per_pwrdm = {
> @@ -313,6 +322,10 @@ static struct powerdomain per_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
>  	},
> +	.fclk_reg_amt	  = 1,
> +	.fclk_masks	  = {
> +		[0] = OMAP3430_EN_UART3,
> +	},
>  };
>  
>  static struct powerdomain emu_pwrdm = {
> @@ -352,6 +365,7 @@ static struct powerdomain usbhost_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
>  	},
> +	.fclk_reg_amt	  = 1,
>  };
>  
>  static struct powerdomain dpll1_pwrdm = {
> diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
> index 55350d0..b004d88 100644
> --- a/arch/arm/plat-omap/include/plat/powerdomain.h
> +++ b/arch/arm/plat-omap/include/plat/powerdomain.h
> @@ -57,6 +57,12 @@
>   */
>  #define PWRDM_MAX_CLKDMS	4
>  
> +/*
> + * Maximum number of FCLK register masks that can be associated with a
> + * powerdomain. CORE powerdomain on OMAP3 is the worst case
> + */
> +#define PWRDM_MAX_FCLK		2
> +
>  /* XXX A completely arbitrary number. What is reasonable here? */
>  #define PWRDM_TRANSITION_BAILOUT 100000
>  
> @@ -124,6 +130,8 @@ struct powerdomain {
>  	s8 next_state;
>  	unsigned state_counter[4];
>  
> +	u8 fclk_reg_amt;
> +	u32 fclk_masks[PWRDM_MAX_FCLK];
>  #ifdef CONFIG_PM_DEBUG
>  	s64 timer;
>  	s64 state_timer[4];
> @@ -177,6 +185,7 @@ int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
>  bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
>  
>  int pwrdm_wait_transition(struct powerdomain *pwrdm);
> +int pwrdm_can_idle(struct powerdomain *pwrdm);
>  
>  int pwrdm_state_switch(struct powerdomain *pwrdm);
>  int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
> -- 
> 1.5.4.3
