From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 5/6] OMAP: Powerdomains: Add support for checking if pwrdm/clkdm can idle
Date: Mon, 18 Jan 2010 10:41:23 -0800
Message-ID: <87bpgrgsrw.fsf@deeprootsystems.com>
References: <1263559617-663-1-git-send-email-tero.kristo@nokia.com>
	<1263559617-663-2-git-send-email-tero.kristo@nokia.com>
	<1263559617-663-3-git-send-email-tero.kristo@nokia.com>
	<1263559617-663-4-git-send-email-tero.kristo@nokia.com>
	<1263559617-663-5-git-send-email-tero.kristo@nokia.com>
	<1263559617-663-6-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:36932 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab0ARSl2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 13:41:28 -0500
Received: by iwn35 with SMTP id 35so2270437iwn.4
        for <linux-omap@vger.kernel.org>; Mon, 18 Jan 2010 10:41:28 -0800 (PST)
In-Reply-To: <1263559617-663-6-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 15 Jan 2010 14\:46\:56 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> pwrdm_can_idle(pwrdm) will check if the specified powerdomain can enter
> idle. This is done by checking all clockdomains under the powerdomain
> if they can idle also.
>
> omap2_clkdm_can_idle(clkdm) will check if the specified clockdomain can
> enter idle. This checks the functional clocks and idle status bits of the
> domain according to following rules:
> 1) get inverse of idlest and mask against idle_def.mask
>   * this gives a bitmask with non-idle bits high
> 2) bitwise OR active functional clocks from the domain to the result
>   * in some cases FCLK can be active but idlest still shows module in idle
> 3) disable bits defined in idle_def.mask

disable?  it looks like they're just being ignored.

>   * some bits should be ignored, like UART clocks which are dynamically
>     switched inside sleep loop
>
> These calls can be used e.g. inside cpuidle to decide which power states
> core and mpu should enter during idle, as there are certain dependencies
> between wakeup capabilities and reset logic.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks for adding the IDLEST checks, I think that will help.

In the .mask field, instead of using a hard-coded mask, probably using
the existing bitfields headers would be a bit more readable, and help
ensure correctness.

Hopefully there's a way to auto-generate these for OMAP4.

> ---
>  arch/arm/mach-omap2/clockdomain.c             |   27 ++++++++++++
>  arch/arm/mach-omap2/clockdomains.h            |   54 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomain.c             |   25 +++++++++++
>  arch/arm/plat-omap/include/plat/clockdomain.h |   17 ++++++++
>  arch/arm/plat-omap/include/plat/powerdomain.h |    1 +
>  5 files changed, 124 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index dd285f0..f42111a 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -472,6 +472,33 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
>  	return 0;
>  }
>  
> +
> +/**
> + * omap2_clkdm_can_idle - check if clockdomain has any active clocks or not
> + * @clkdm: struct clockdomain *
> + *
> + * Checks if the clockdomain has any active clock or not, i.e. whether it
> + * can enter idle. Returns -EINVAL if clkdm is NULL; 0 if unable to idle;
> + * 1 if can idle.
> + */
> +int omap2_clkdm_can_idle(struct clockdomain *clkdm)
> +{
> +	int i;
> +
> +	if (!clkdm)
> +		return -EINVAL;
> +
> +	for (i = 0; i < clkdm->clk_reg_amt; i++)
> +		if (((~cm_read_mod_reg(clkdm->pwrdm.ptr->prcm_offs,
> +				CM_IDLEST + 4 * i) &
> +				clkdm->idle_def[i].mask) |
> +				cm_read_mod_reg(clkdm->pwrdm.ptr->prcm_offs,
> +				CM_FCLKEN + 4 * i)) &
> +				~clkdm->idle_def[i].ignore)

This has some readability/indent issues.  

Also, could check fclk first, if active fclks, no reason to check
idlest.  How about something like this (untested, but I *think* I kept
the same logic):

	for (i = 0; i < clkdm->clk_reg_amt; i++) {
		u32 idlest, fclk;

		fclk = cm_read_mod_reg(clkdm->pwrdm.ptr->prcm_offs,
				       CM_FCLKEN + 4 * i);
		if (fclk & ~clkdm->idle_def[i].ignore)
			return 0;

		idlest = cm_read_mod_reg(clkdm->pwrdm.ptr->prcm_offs,
					 CM_IDLEST + 4 * i);
		if (~idlest & clkdm->idle_def[i].mask)
			return 0;
	}

> +			return 0;
> +	return 1;
> +}
> +
>  /**
>   * omap2_clkdm_allow_idle - enable hwsup idle transitions for clkdm
>   * @clkdm: struct clockdomain *
> diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
> index c4ee076..2c1f2eb 100644
> --- a/arch/arm/mach-omap2/clockdomains.h
> +++ b/arch/arm/mach-omap2/clockdomains.h
> @@ -167,6 +167,12 @@ static struct clockdomain iva2_clkdm = {
>  	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_IVA2_MASK,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.clk_reg_amt	= 1,
> +	.idle_def	= {
> +		[0] = {
> +			.mask = 0x1,

Use OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK

> +		},
> +	},
>  };
>  
>  static struct clockdomain gfx_3430es1_clkdm = {
> @@ -183,6 +189,12 @@ static struct clockdomain sgx_clkdm = {
>  	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>  	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
> +	.clk_reg_amt	= 1,
> +	.idle_def	= {
> +		[0] = {
> +			.mask = 0x1,

Use OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_MASK

And here's a a good reason for using the pre-defined bitmasks.  According to
the #defines (and the TRM) The single EN bit in SGX is actually in bit 1, not bit 0)

> +		},
> +	},
>  };
>  
>  /*
> @@ -206,6 +218,23 @@ static struct clockdomain core_l3_34xx_clkdm = {
>  	.flags		= CLKDM_CAN_HWSUP,
>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L3_MASK,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.clk_reg_amt	= 3,
> +	.idle_def	= {
> +		[0] = {
> +			.ignore = OMAP3430_ST_UART2_MASK |
> +				OMAP3430_ST_UART1_MASK |
> +				OMAP3430_ST_SDRC_MASK |
> +				OMAP3430_ST_OMAPCTRL_MASK |
> +				OMAP3430ES2_ST_HSOTGUSB_IDLE_MASK,

Hmm, why ignore OTG mask?  I think we need some comments as to why all
of these are ignored.  You mention the UARTs in the changelog, but not
the others.

> +			.mask = 0xffffffff,

There are a lot of reserved bits here that I'm not sure we should be
checking.

> +		},
> +		[1] = {
> +			.mask = 0x1f,
> +		},
> +		[2] = {
> +			.mask = 0x4,
> +		},
> +	},
>  };
>  
>  static struct clockdomain core_l4_34xx_clkdm = {
> @@ -222,6 +251,12 @@ static struct clockdomain dss_34xx_clkdm = {
>  	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_DSS_MASK,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.clk_reg_amt	= 1,
> +	.idle_def	= {
> +		[0] = {
> +			.mask = 0x1,
> +		},
> +	},
>  };
>  
>  static struct clockdomain cam_clkdm = {
> @@ -230,6 +265,12 @@ static struct clockdomain cam_clkdm = {
>  	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_CAM_MASK,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.clk_reg_amt	= 1,
> +	.idle_def	= {
> +		[0] = {
> +			.mask = 0x1,
> +		},
> +	},
>  };
>  
>  static struct clockdomain usbhost_clkdm = {
> @@ -238,6 +279,12 @@ static struct clockdomain usbhost_clkdm = {
>  	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>  	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
> +	.clk_reg_amt	= 1,
> +	.idle_def	= {
> +		[0] = {
> +			.mask = 0x1,
> +		},
> +	},
>  };
>  
>  static struct clockdomain per_clkdm = {
> @@ -246,6 +293,13 @@ static struct clockdomain per_clkdm = {
>  	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.clk_reg_amt	= 1,
> +	.idle_def	= {
> +		[0] = {
> +			.ignore = OMAP3430_ST_UART3_MASK,
> +			.mask = 0x1fff,
> +		},
> +	},
>  };
>  
>  /*
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index a08d596..46090bc 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -1219,6 +1219,31 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
>  	return 0;
>  }
>  
> +/**
> + * pwrdm_can_idle - check if the powerdomain can enter idle
> + * @pwrdm: struct powerdomain * the powerdomain to check status of
> + *
> + * Checks all associated clockdomains if they can idle or not.
> + * Returns 1 if the powerdomain can idle, 0 if not.
> + */
> +int pwrdm_can_idle(struct powerdomain *pwrdm)
> +{
> +	unsigned long flags;
> +	int i;
> +	int ret = 1;
> +
> +	read_lock_irqsave(&pwrdm_rwlock, flags);
> +
> +	for (i = 0; i < PWRDM_MAX_CLKDMS; i++)
> +		if (pwrdm->pwrdm_clkdms[i] &&
> +		    !omap2_clkdm_can_idle(pwrdm->pwrdm_clkdms[i]))
> +			ret = 0;
> +
> +	read_unlock_irqrestore(&pwrdm_rwlock, flags);
> +
> +	return ret;
> +}
> +
>  int pwrdm_state_switch(struct powerdomain *pwrdm)
>  {
>  	return _pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
> diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
> index eb73482..71cbc5c 100644
> --- a/arch/arm/plat-omap/include/plat/clockdomain.h
> +++ b/arch/arm/plat-omap/include/plat/clockdomain.h
> @@ -30,6 +30,12 @@
>  #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
>  #define CLKDM_CAN_HWSUP_SWSUP	(CLKDM_CAN_SWSUP | CLKDM_CAN_HWSUP)
>  
> +/*
> + * Maximum number of FCLK register masks that can be associated with a
> + * clockdomain. CORE powerdomain on OMAP3 is the worst case
> + */
> +#define CLKDM_MAX_CLK_REGS			3
> +
>  /* OMAP24XX CM_CLKSTCTRL_*.AUTOSTATE_* register bit values */
v>  #define OMAP24XX_CLKSTCTRL_DISABLE_AUTO		0x0
>  #define OMAP24XX_CLKSTCTRL_ENABLE_AUTO		0x1
> @@ -61,6 +67,11 @@ struct clkdm_pwrdm_autodep {
>  
>  };
>  
> +struct clkdm_idle_def {
> +	u32 ignore;

I think fclk_ignore is a better name

> +	u32 mask;

and idlest_mask here.

> +};
> +
>  struct clockdomain {
>  
>  	/* Clockdomain name */
> @@ -83,6 +94,10 @@ struct clockdomain {
>  	/* OMAP chip types that this clockdomain is valid on */
>  	const struct omap_chip_id omap_chip;
>  
> +	/* For idle checks */
> +	u8 clk_reg_amt;

I think clk_reg_num is a better name here.

> +	struct clkdm_idle_def idle_def[CLKDM_MAX_CLK_REGS];
> +
>  	/* Usecount tracking */
>  	atomic_t usecount;
>  
> @@ -108,4 +123,6 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm);
>  int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
>  int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
>  
> +int omap2_clkdm_can_idle(struct clockdomain *clkdm);
> +
>  #endif
> diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
> index 159e4ad..42f5f88 100644
> --- a/arch/arm/plat-omap/include/plat/powerdomain.h
> +++ b/arch/arm/plat-omap/include/plat/powerdomain.h
> @@ -182,6 +182,7 @@ int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
>  bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
>  
>  int pwrdm_wait_transition(struct powerdomain *pwrdm);
> +int pwrdm_can_idle(struct powerdomain *pwrdm);
>  
>  int pwrdm_state_switch(struct powerdomain *pwrdm);
>  int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
> -- 
> 1.5.4.3
