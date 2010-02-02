From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv4 2/8] OMAP: Powerdomains: Add support for INACTIVE state
 on pwrdm level
Date: Tue, 2 Feb 2010 01:03:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002020027130.19652@utopia.booyaka.com>
References: <> <1264182951-9205-1-git-send-email-tero.kristo@nokia.com> <1264182951-9205-2-git-send-email-tero.kristo@nokia.com> <1264182951-9205-3-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39469 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab0BBIDy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 03:03:54 -0500
In-Reply-To: <1264182951-9205-3-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Hello Tero,

On Fri, 22 Jan 2010, Tero Kristo wrote:

> Currently only ON, RET and OFF are supported, and ON is arguably broken as it
> allows the powerdomain to enter INACTIVE state unless idle is prevented.
> Now, pwrdm code prevents idle if ON is selected and hardware supervised
> mode for the underlying clockdomain is enabled, and also adds support for
> INACTIVE. This simplifies the control needed inside sleep code.
> 
> This patch also requires caching of next power state inside powerdomain code,
> as INACTIVE is not directly supported by hardware. Next powerstate is thus
> now stored for each powerdomain in next_state.

Still thinking about this patch.  Am not sure it makes sense, or at least, 
it is incomplete.  Consider:

1. In the current code, pwrdm->next_state can never be initialized to 
INACTIVE during pwrdm_register(), but this should be possible.  To do 
this, the code needs to iterate through the powerdomain's clockdomains and 
determine whether they are in hardware-supervised idle or 
software-supervised idle.

2. What should happen to pwrdm->next_state if someone calls 
omap2_clkdm_allow_idle(), omap2_clkdm_deny_idle(), omap2_clkdm_sleep(), or 
omap2_clkdm_wakeup()?  Right now, nothing will happen, which is a problem 
since calling one of these functions could mean that the powerdomain's 
possible next state may change from ON to INACTIVE or vice-versa.  A 
similar problem appears to exist with hwsup_changed: other code may have 
changed the clockdomain autoidle state, which may cause hwsup_changed to 
not reflect reality any longer.

...

I am still not sure that the idea of setting the powerdomain's next power 
state to INACTIVE makes sense.  The TRM claims that a powerdomain can be 
"inactive," but this seems to be just poor documentation.  To say that a 
powerdomain can be inactive is really just to say that the powerdomain is 
'ON' -- powered -- but all of its subsidiary clockdomain activity states 
are INACTIVE.  Between ON and INACTIVE, the power state of the powerdomain 
is the same from the hardware's point of view -- but the differences 
between the OFF, RET, and ON power states are distinct.  And from the PRCM 
point of view, the only place that an INACTIVE power domain state shows up 
is in the powerdomain current power state register.

Perhaps a separate code layer that incorporates your ideas is worthwhile 
for use by pm*.c and cpuidle*.c, in order to simplify that code.  But in 
the current powerdomain and clockdomain code, when we depart from what the 
hardware is capable of, the code needs to cover all of the software corner 
cases that can affect state transitions.  Otherwise we probably should 
stick with the simplicity of following the hardware's registers and 
capabilities.

Let's discuss further if you are interested.  Perhaps I simply don't 
understand the patches sufficiently...

A few other thoughts below:

> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c             |   37 +++++++++++++++++++++----
>  arch/arm/mach-omap2/powerdomains34xx.h        |   18 ++++++------
>  arch/arm/plat-omap/include/plat/powerdomain.h |    5 +++
>  3 files changed, 45 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 26b3f3e..bdfbbea 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -110,8 +110,8 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
>  static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>  {
>  
> -	int prev;
> -	int state;
> +	u8 prev;
> +	u8 state;
>  
>  	if (pwrdm == NULL)
>  		return -EINVAL;
> @@ -218,7 +218,9 @@ int pwrdm_register(struct powerdomain *pwrdm)
>  
>  	pr_debug("powerdomain: registered %s\n", pwrdm->name);
>  	ret = 0;
> -
> +	pwrdm->next_state =
> +		prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTCTRL,
> +			OMAP_POWERSTATE_MASK);

(see above)

>  pr_unlock:
>  	write_unlock_irqrestore(&pwrdm_rwlock, flags);
>  
> @@ -699,19 +701,43 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
>   */
>  int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>  {
> +	u8 prg_pwrst;
> +
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> +	if (pwrdm->next_state == pwrst)
> +		return 0;
> +
>  	if (!(pwrdm->pwrsts & (1 << pwrst)))
>  		return -EINVAL;
>  
>  	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
>  		 pwrdm->name, pwrst);
>  
> +	/* INACTIVE is reserved, so we program pwrdm as ON */
> +	if (pwrst == PWRDM_POWER_INACTIVE)
> +		prg_pwrst = PWRDM_POWER_ON;
> +	else
> +		prg_pwrst = pwrst;
> +
>  	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
> -			     (pwrst << OMAP_POWERSTATE_SHIFT),
> +			     (prg_pwrst << OMAP_POWERSTATE_SHIFT),
>  			     pwrdm->prcm_offs, PM_PWSTCTRL);
>  
> +	/* If next state is ON, prevent idle */
> +	if (pwrst == PWRDM_POWER_ON) {
> +		if (omap2_clkdm_get_hwsup(pwrdm->pwrdm_clkdms[0])) {
> +			omap2_clkdm_deny_idle(pwrdm->pwrdm_clkdms[0]);
> +			pwrdm->hwsup_changed = 1;
> +		}
> +	} else if (pwrdm->hwsup_changed) {
> +		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
> +		pwrdm->hwsup_changed = 0;
> +	}

For completeness, since this is code that is intended to be chip-agnostic, 
this code should probably iterate over all of the clockdomains in the 
powerdomains above, rather than assume that there is only one clockdomain 
in each powerdomain that is important.

> +
> +	pwrdm->next_state = pwrst;
> +
>  	return 0;
>  }
>  
> @@ -728,8 +754,7 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> -	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTCTRL,
> -					OMAP_POWERSTATE_MASK);
> +	return pwrdm->next_state;
>  }
>  
>  /**
> diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
> index 588f7e0..7a7d8d3 100644
> --- a/arch/arm/mach-omap2/powerdomains34xx.h
> +++ b/arch/arm/mach-omap2/powerdomains34xx.h
> @@ -165,7 +165,7 @@ static struct powerdomain iva2_pwrdm = {
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  	.dep_bit	  = OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
>  	.wkdep_srcs	  = iva2_wkdeps,
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 4,
>  	.pwrsts_mem_ret	  = {
> @@ -188,7 +188,7 @@ static struct powerdomain mpu_34xx_pwrdm = {
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  	.dep_bit	  = OMAP3430_EN_MPU_SHIFT,
>  	.wkdep_srcs	  = mpu_34xx_wkdeps,
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.flags		  = PWRDM_HAS_MPU_QUIRK,
>  	.banks		  = 1,
> @@ -207,7 +207,7 @@ static struct powerdomain core_34xx_pre_es3_1_pwrdm = {
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
>  					   CHIP_IS_OMAP3430ES2 |
>  					   CHIP_IS_OMAP3430ES3_0),
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
>  	.banks		  = 2,
>  	.pwrsts_mem_ret	  = {
> @@ -225,7 +225,7 @@ static struct powerdomain core_34xx_es3_1_pwrdm = {
>  	.name		  = "core_pwrdm",
>  	.prcm_offs	  = CORE_MOD,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
>  	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
>  	.banks		  = 2,
> @@ -247,7 +247,7 @@ static struct powerdomain dss_pwrdm = {
>  	.dep_bit	  = OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
>  	.wkdep_srcs	  = cam_dss_wkdeps,
>  	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRDM_POWER_RET,
>  	.banks		  = 1,
>  	.pwrsts_mem_ret	  = {

Is the SGX power domain missing here - shouldn't it also be capable of 
entering INACTIVE?

> @@ -287,7 +287,7 @@ static struct powerdomain cam_pwrdm = {
>  	.prcm_offs	  = OMAP3430_CAM_MOD,
>  	.wkdep_srcs	  = cam_dss_wkdeps,
>  	.sleepdep_srcs	  = cam_gfx_sleepdeps,
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRDM_POWER_RET,
>  	.banks		  = 1,
>  	.pwrsts_mem_ret	  = {
> @@ -305,7 +305,7 @@ static struct powerdomain per_pwrdm = {
>  	.dep_bit	  = OMAP3430_EN_PER_SHIFT,
>  	.wkdep_srcs	  = per_usbhost_wkdeps,
>  	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 1,
>  	.pwrsts_mem_ret	  = {
> @@ -327,7 +327,7 @@ static struct powerdomain neon_pwrdm = {
>  	.prcm_offs	  = OMAP3430_NEON_MOD,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  	.wkdep_srcs	  = neon_wkdeps,
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRDM_POWER_RET,
>  };
>  
> @@ -337,7 +337,7 @@ static struct powerdomain usbhost_pwrdm = {
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
>  	.wkdep_srcs	  = per_usbhost_wkdeps,
>  	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRDM_POWER_RET,
>  	/*
>  	 * REVISIT: Enabling usb host save and restore mechanism seems to
> diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
> index 0b96005..17377c3 100644
> --- a/arch/arm/plat-omap/include/plat/powerdomain.h
> +++ b/arch/arm/plat-omap/include/plat/powerdomain.h
> @@ -39,6 +39,9 @@
>  
>  #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | (1 << PWRDM_POWER_ON))
>  
> +#define PWRSTS_OFF_RET_INA_ON	(PWRSTS_OFF_RET_ON | \
> +				 (1 << PWRDM_POWER_INACTIVE))
> +
>  
>  /* Powerdomain flags */
>  #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore support */
> @@ -123,6 +126,8 @@ struct powerdomain {
>  	struct list_head node;
>  
>  	int state;
> +	int next_state;
> +	int hwsup_changed;

Both of these variables can be u8.  Also it would be good to have the 
kerneldoc documentation for struct powerdomain updated when patches change 
the structure.

>  	unsigned state_counter[PWRDM_MAX_PWRSTS];
>  
>  #ifdef CONFIG_PM_DEBUG
> -- 
> 1.5.4.3

regards,

- Paul
