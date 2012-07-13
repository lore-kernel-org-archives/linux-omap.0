From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Fri, 13 Jul 2012 08:54:59 -0500
Message-ID: <500028B3.1040309@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60097 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab2GMNzf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 09:55:35 -0400
In-Reply-To: <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Paul,

On 07/12/2012 04:17 PM, Paul Walmsley wrote:
> Hello Jon
> 
> On Thu, 7 Jun 2012, Jon Hunter wrote:
> 
>> By removing the CLKDM_CAN_ENABLE_AUTO flag, the EMU clock domain will always
>> remain on and hence, this will break low-power modes. The EMU clock domain only
>> support the SW_WKUP and HW_AUTO transition modes (for more details refer to the
>> OMAP4430 TRM) and power down the EMU power domain we need to place the EMU
>> clock domain back into the HW_AUTO mode. This can be accomplished by setting
>> the CLKDM_CAN_FORCE_SLEEP flag, which for an OMAP4 device will enable the
>> HW_AUTO mode.
> 
> Hmm, it would be nice if we could keep the CLKDM_CAN_* flags matching the 
> hardware capabilities.  Looking at the 4430 TRM Rev X Table 3-744 
> "CM_EMU_CLKSTCTRL", the CLKTRCTRL field isn't documented as supporting the 
> SW_SLEEP mode (which CLKDM_CAN_FORCE_SLEEP will set).

Right, however, this was part of the recommendation from Benoit. In
patch #7 of this series we actually made the following modification ...

"By eliminating the SW_SLEEP mode the the mapping of the flags for OMAP4
devices can becomes ...

CLKDM_CAN_DISABLE_AUTO	--> NO_SLEEP
CLKDM_CAN_ENABLE_AUTO	--> HW_AUTO
CLKDM_CAN_FORCE_SLEEP	--> HW_AUTO
CLKDM_CAN_FORCE_WAKEUP	--> SW_WKUP"

So now, by setting CLKDM_CAN_FORCE_SLEEP we are actually enabling
HW_AUTO and not SW_SLEEP (for OMAP4). This was the purpose of patch #7
was to remove the SW_SLEEP for OMAP4 as it is equivalent to HW_AUTO when
using it to disable the module. Unfortunately, although this works it
does make the flags a bit less clearer. The upside is the solution is
simpler.

> Maybe the CLKDM_CAN_* flags should be moved to a separate u8...
> 
> Anyway, what do you think about the following approach?  It uses a 
> special flag to indicate that the EMU clockdomain is behaving in an 
> unexpected way.  If you think it's reasonable, perhaps you could try your 
> PMU tests with it?  It applies on top of linux-omap master 
> (cb07e3394573a419147a1783f3bd7ef13045353c) plus the clockdomain patch 
> posted earlier at:
> 
> http://marc.info/?l=linux-omap&m=134209072829531&w=2
> 
> But these patches may need to be applied on Kevin's 'pm' branch for 
> meaningful PM testing:
> 
> http://marc.info/?l=linux-omap&m=134196493819792&w=2
> 
> 
> 
> - Paul
> 
> From: Paul Walmsley <paul@pwsan.com>
> Date: Thu, 12 Jul 2012 14:58:43 -0600
> Subject: [PATCH] ARM: OMAP2+: clockdomain/hwmod: add workaround for EMU
>  clockdomain idle problems
> 
> The idle status of the IP blocks and clocks inside the EMU clockdomain
> isn't taken into account by the PRCM hardware when deciding whether
> the clockdomain is idle.  Add a workaround flag, CLKDM_MISSING_IDLE_REPORTING,
> to deal with this problem, and add the code necessary to support it.
> 
> XXX Add more description of what this flag actually does
> 
> XXX Jon, Ming, Will
> ---
>  arch/arm/mach-omap2/clockdomain.c           |   17 ++++++
>  arch/arm/mach-omap2/clockdomain.h           |   20 ++++++-
>  arch/arm/mach-omap2/clockdomain2xxx_3xxx.c  |   86 +++++++++++++++++----------
>  arch/arm/mach-omap2/clockdomain44xx.c       |   11 ++++
>  arch/arm/mach-omap2/clockdomains3xxx_data.c |    7 +--
>  arch/arm/mach-omap2/clockdomains44xx_data.c |    3 +-
>  arch/arm/mach-omap2/omap_hwmod.c            |    3 +-
>  7 files changed, 105 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index b851ba4..17b1d32 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -914,6 +914,23 @@ bool clkdm_in_hwsup(struct clockdomain *clkdm)
>  	return ret;
>  }
>  
> +/**
> + * clkdm_missing_idle_reporting - can @clkdm enter autoidle even if in use?
> + * @clkdm: struct clockdomain *
> + *
> + * Returns true if clockdomain @clkdm has the
> + * CLKDM_MISSING_IDLE_REPORTING flag set, or false if not or @clkdm is
> + * null.  More information is available in the documentation for the
> + * CLKDM_MISSING_IDLE_REPORTING macro.
> + */
> +bool clkdm_missing_idle_reporting(struct clockdomain *clkdm)
> +{
> +	if (!clkdm)
> +		return false;
> +
> +	return (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING) ? true : false;
> +}
> +
>  /* Clockdomain-to-clock/hwmod framework interface code */
>  
>  static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
> diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
> index 7b3c1d2..fb5d37f 100644
> --- a/arch/arm/mach-omap2/clockdomain.h
> +++ b/arch/arm/mach-omap2/clockdomain.h
> @@ -1,9 +1,7 @@
>  /*
> - * arch/arm/plat-omap/include/mach/clockdomain.h
> - *
>   * OMAP2/3 clockdomain framework functions
>   *
> - * Copyright (C) 2008 Texas Instruments, Inc.
> + * Copyright (C) 2008, 2012 Texas Instruments, Inc.
>   * Copyright (C) 2008-2011 Nokia Corporation
>   *
>   * Paul Walmsley
> @@ -34,6 +32,20 @@
>   * CLKDM_ACTIVE_WITH_MPU: The PRCM guarantees that this clockdomain is
>   *     active whenever the MPU is active.  True for interconnects and
>   *     the WKUP clockdomains.
> + * CLKDM_MISSING_IDLE_REPORTING: The idle status of the IP blocks and
> + *     clocks inside this clockdomain are not taken into account by
> + *     the PRCM when determining whether the clockdomain is idle.
> + *     Without this flag, if the clockdomain is set to
> + *     hardware-supervised idle mode, the PRCM may transition the
> + *     enclosing powerdomain to a low power state, even when devices
> + *     inside the clockdomain and powerdomain are in use.  (An example
> + *     of such a clockdomain is the EMU clockdomain on OMAP3/4.)  If
> + *     this flag is set, and the clockdomain does not support the
> + *     force-sleep mode, then the HW_AUTO mode will be used to put the
> + *     clockdomain to sleep.  Similarly, if the clockdomain supports
> + *     the force-wakeup mode, then it will be used whenever a clock or
> + *     IP block inside the clockdomain is active, rather than the
> + *     HW_AUTO mode.

I am not sure if it is really a matter of the clock domain missing the
idle reporting, but more of a problem that the EMU power domain power
state is programmed in HW to OFF and cannot be changed by software. (see
POWER_STATE field of PM_EMU_PWRSTCTRL register description in the TRM).

This means that when the EMU clock domain does idle, the EMU power
domain can transition to OFF and hence we loss the EMU logic context. So
we need to keep the EMU CLKDM on to keep the EMU PWRDM on, but it is
really the lack of control we have over the PWRDM that is the problem. I
would not say this is a HW bug but more of a design choice probably to
keep the design simpler at the expense of power.

I believe that this problem would happen to all power domains if they
were programmed for the OFF power state when the clock domain idled. For
other power domains we avoid this by programming them to the ON state
when we are using them.

Therefore, we need to keep the EMU CLKDM ON while active to prevent the
PWRDM transitioning to OFF, when the CLKDM idles. So I would see this
problem as more like the CLKDM_CANNOT_IDLE_WHILE_ACTIVE vs
CLKDM_MISSING_IDLE_REPORTING.

>   */
>  #define CLKDM_CAN_FORCE_SLEEP			(1 << 0)
>  #define CLKDM_CAN_FORCE_WAKEUP			(1 << 1)
> @@ -41,6 +53,7 @@
>  #define CLKDM_CAN_DISABLE_AUTO			(1 << 3)
>  #define CLKDM_NO_AUTODEPS			(1 << 4)
>  #define CLKDM_ACTIVE_WITH_MPU			(1 << 5)
> +#define CLKDM_MISSING_IDLE_REPORTING		(1 << 6)
>  
>  #define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
>  #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
> @@ -188,6 +201,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
>  void clkdm_allow_idle(struct clockdomain *clkdm);
>  void clkdm_deny_idle(struct clockdomain *clkdm);
>  bool clkdm_in_hwsup(struct clockdomain *clkdm);
> +bool clkdm_missing_idle_reporting(struct clockdomain *clkdm);
>  
>  int clkdm_wakeup(struct clockdomain *clkdm);
>  int clkdm_sleep(struct clockdomain *clkdm);
> diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> index a0d68db..09385a9 100644
> --- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> @@ -162,6 +162,37 @@ static void _disable_hwsup(struct clockdomain *clkdm)
>  						clkdm->clktrctrl_mask);
>  }
>  
> +static int omap3_clkdm_sleep(struct clockdomain *clkdm)
> +{
> +	omap3xxx_cm_clkdm_force_sleep(clkdm->pwrdm.ptr->prcm_offs,
> +				      clkdm->clktrctrl_mask);
> +	return 0;
> +}
> +
> +static int omap3_clkdm_wakeup(struct clockdomain *clkdm)
> +{
> +	omap3xxx_cm_clkdm_force_wakeup(clkdm->pwrdm.ptr->prcm_offs,
> +				       clkdm->clktrctrl_mask);
> +	return 0;
> +}
> +
> +static void omap3_clkdm_allow_idle(struct clockdomain *clkdm)
> +{
> +	if (atomic_read(&clkdm->usecount) > 0)
> +		_clkdm_add_autodeps(clkdm);
> +
> +	omap3xxx_cm_clkdm_enable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
> +				       clkdm->clktrctrl_mask);
> +}
> +
> +static void omap3_clkdm_deny_idle(struct clockdomain *clkdm)
> +{
> +	omap3xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
> +					clkdm->clktrctrl_mask);
> +
> +	if (atomic_read(&clkdm->usecount) > 0)
> +		_clkdm_del_autodeps(clkdm);
> +}
>  
>  static int omap2_clkdm_clk_enable(struct clockdomain *clkdm)
>  {
> @@ -170,6 +201,18 @@ static int omap2_clkdm_clk_enable(struct clockdomain *clkdm)
>  	if (!clkdm->clktrctrl_mask)
>  		return 0;
>  
> +	/*
> +	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
> +	 * more details on the unpleasant problem this is working
> +	 * around
> +	 */
> +	if (clkdm->flags & (CLKDM_MISSING_IDLE_REPORTING |
> +			    CLKDM_CAN_FORCE_WAKEUP)) {
> +		(cpu_is_omap24xx()) ? omap2_clkdm_wakeup(clkdm) :
> +			omap3_clkdm_wakeup(clkdm);
> +		return 0;
> +	}
> +
>  	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
>  				clkdm->clktrctrl_mask);
>  
> @@ -193,6 +236,17 @@ static int omap2_clkdm_clk_disable(struct clockdomain *clkdm)
>  	if (!clkdm->clktrctrl_mask)
>  		return 0;
>  
> +	/*
> +	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
> +	 * more details on the unpleasant problem this is working
> +	 * around
> +	 */
> +	if (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING &&
> +	    !(clkdm->flags & CLKDM_CAN_FORCE_SLEEP)) {
> +		_enable_hwsup(clkdm);
> +		return 0;
> +	}
> +
>  	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
>  				clkdm->clktrctrl_mask);
>  
> @@ -209,38 +263,6 @@ static int omap2_clkdm_clk_disable(struct clockdomain *clkdm)
>  	return 0;
>  }
>  
> -static int omap3_clkdm_sleep(struct clockdomain *clkdm)
> -{
> -	omap3xxx_cm_clkdm_force_sleep(clkdm->pwrdm.ptr->prcm_offs,
> -				clkdm->clktrctrl_mask);
> -	return 0;
> -}
> -
> -static int omap3_clkdm_wakeup(struct clockdomain *clkdm)
> -{
> -	omap3xxx_cm_clkdm_force_wakeup(clkdm->pwrdm.ptr->prcm_offs,
> -				clkdm->clktrctrl_mask);
> -	return 0;
> -}
> -
> -static void omap3_clkdm_allow_idle(struct clockdomain *clkdm)
> -{
> -	if (atomic_read(&clkdm->usecount) > 0)
> -		_clkdm_add_autodeps(clkdm);
> -
> -	omap3xxx_cm_clkdm_enable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
> -				clkdm->clktrctrl_mask);
> -}
> -
> -static void omap3_clkdm_deny_idle(struct clockdomain *clkdm)
> -{
> -	omap3xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
> -				clkdm->clktrctrl_mask);
> -
> -	if (atomic_read(&clkdm->usecount) > 0)
> -		_clkdm_del_autodeps(clkdm);
> -}
> -
>  struct clkdm_ops omap2_clkdm_operations = {
>  	.clkdm_add_wkdep	= omap2_clkdm_add_wkdep,
>  	.clkdm_del_wkdep	= omap2_clkdm_del_wkdep,
> diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
> index 762f2cc..6fc6155 100644
> --- a/arch/arm/mach-omap2/clockdomain44xx.c
> +++ b/arch/arm/mach-omap2/clockdomain44xx.c
> @@ -113,6 +113,17 @@ static int omap4_clkdm_clk_disable(struct clockdomain *clkdm)
>  	if (!clkdm->prcm_partition)
>  		return 0;
>  
> +	/*
> +	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
> +	 * more details on the unpleasant problem this is working
> +	 * around
> +	 */
> +	if (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING &&
> +	    !(clkdm->flags & CLKDM_CAN_FORCE_SLEEP)) {
> +		omap4_clkdm_allow_idle(clkdm);
> +		return 0;
> +	}
> +
>  	hwsup = omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
>  					clkdm->cm_inst, clkdm->clkdm_offs);
>  
> diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> index 56089c4..933a35c 100644
> --- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> @@ -387,14 +387,11 @@ static struct clockdomain per_am35x_clkdm = {
>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
>  };
>  
> -/*
> - * Disable hw supervised mode for emu_clkdm, because emu_pwrdm is
> - * switched of even if sdti is in use
> - */
>  static struct clockdomain emu_clkdm = {
>  	.name		= "emu_clkdm",
>  	.pwrdm		= { .name = "emu_pwrdm" },
> -	.flags		= /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
> +	.flags		= (CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_SWSUP |
> +			   CLKDM_MISSING_IDLE_REPORTING),
>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_EMU_MASK,
>  };
>  
> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
> index 63d60a7..b56d06b 100644
> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
> @@ -390,7 +390,8 @@ static struct clockdomain emu_sys_44xx_clkdm = {
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.cm_inst	  = OMAP4430_PRM_EMU_CM_INST,
>  	.clkdm_offs	  = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
> -	.flags		  = CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_FORCE_WAKEUP,
> +	.flags		  = (CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_FORCE_WAKEUP |
> +			     CLKDM_MISSING_IDLE_REPORTING),
>  };
>  
>  static struct clockdomain l3_dma_44xx_clkdm = {
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 6ca8e51..36f0603 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1857,7 +1857,8 @@ static int _enable(struct omap_hwmod *oh)
>  		 * completely the module. The clockdomain can be set
>  		 * in HW_AUTO only when the module become ready.
>  		 */
> -		hwsup = clkdm_in_hwsup(oh->clkdm);
> +		hwsup = clkdm_in_hwsup(oh->clkdm) &&
> +			!clkdm_missing_idle_reporting(oh->clkdm);
>  		r = clkdm_hwmod_enable(oh->clkdm, oh);
>  		if (r) {
>  			WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
> 

Thanks for the detailed suggestion! Adding a flag to prevent programming
the HW_AUTO while the CLKDM is active could definitely work (although I
may change the name/description of the flag a little).

Another proposal I also thought of is re-working the flags to describe
the HW mode to be used when turning on the CLKDM, when the CLKDM is
active and when the CLKDM is shut down. So instead of saying what modes
the CLKDM supports, specify what modes should be used for pre-ON (i.e.
turn ON), ON and OFF. Right now software is trying to decide for us by
what is available (which is ideal) but makes working around such nuances
a little more painful.

By the way, I did do some testing on OMAP3, but I don't recall now
whether I was having such problems with OMAP3. I need to go back and
test perf again on OMAP3 to see if such a flag is needed.

Cheers
Jon
