From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 1/2] ARM: OMAP2+: hwmod: Add refcounting for modulemode
 shared by multiple hwmods
Date: Tue, 27 May 2014 15:50:33 +0530
Message-ID: <538466F1.3070806@ti.com>
References: <alpine.DEB.2.02.1405141939030.21921@utopia.booyaka.com> <1401101095-27181-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50914 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaE0KWb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2014 06:22:31 -0400
In-Reply-To: <1401101095-27181-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: paul@pwsan.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org

On Monday 26 May 2014 04:14 PM, Archit Taneja wrote:
> Generally, IP blocks/modules within a clock domain each have their own
> CM_x_CLKCTRL register, each having it's own MODULEMODE field to manage the
> module.
> 
> DSS clockdoain, however, has multiple modules in it, but only one register
> named CM_DSS_DSS_CLKCTRL, which contains one MODULEMODE register field.
> 
> Until now, we defined '.prcm.omap4.modulemode' only for the top level DSS
> hwmod("dss_core") and didn't define it for other DSS hwmods(like "dss_dispc",
> "dss_dsi1" and so on). This made the omapdss driver work as the top level DSS
> platform device and the rest had a parent-child relationship. This ensured that
> the parent hwmod("dss_core") is enabled if any of the children hwmods are
> enabled while using omapdss.
> 
> This method, however, doesn't work when each hwmod is enabled individually.
> This happens early in boot in omap_hwmod_setup_all, where each hwmod is enabled,
> and then reset and idled. All the 'children' DSS hwmods fail to enable and
> reset, since they don't enable modulemode.
> 
> The way to make such modules work both during initialization and when used by
> pm runtime API in the driver would be to add refcounting for enabling/disabling
> the modulemode field.
> 
> We add a new flag bit for the flag in omap_hwmod_omap4_prcm, which tells
> omap_hwmod that this hwmod uses a modulemode field shared by other hwmods.
> 
> We create a struct called 'modulemode_shared'. The hwmod data file should define
> a static instance of this struct. Each hwmod that uses this modulemode field
> should hold a pointer to this instance.
> 
> omap_hwmod's soc enable_module and disable_module ops set the MODULEMODE
> reigster bits only when the first module using it is enabled, or the last module
> using it is disabled. We serialize accesses to the struct with a spinlock.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c | 123 +++++++++++++++++++++++++++++++++------
>  arch/arm/mach-omap2/omap_hwmod.h |  38 +++++++++---
>  2 files changed, 133 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 66c60fe..b42718d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -973,17 +973,33 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
>   */
>  static void _omap4_enable_module(struct omap_hwmod *oh)
>  {
> +	unsigned long flags;
> +	struct modulemode_shared *mmode = NULL;
> +	bool enable = true;
> +
>  	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
>  		return;
>  
>  	pr_debug("omap_hwmod: %s: %s: %d\n",
>  		 oh->name, __func__, oh->prcm.omap4.modulemode);
>  
> -	omap4_cminst_module_enable(oh->prcm.omap4.modulemode,
> -				   oh->clkdm->prcm_partition,
> -				   oh->clkdm->cm_inst,
> -				   oh->clkdm->clkdm_offs,
> -				   oh->prcm.omap4.clkctrl_offs);
> +	if (oh->prcm.omap4.flags & HWMOD_OMAP4_MODULEMODE_SHARED) {
> +		mmode = oh->prcm.omap4.modulemode_ref;
> +
> +		spin_lock_irqsave(&mmode->lock, flags);
> +
> +		enable = mmode->refcnt++ == 0;
> +	}
> +
> +	if (enable)
> +		omap4_cminst_module_enable(oh->prcm.omap4.modulemode,
> +					   oh->clkdm->prcm_partition,
> +					   oh->clkdm->cm_inst,
> +					   oh->clkdm->clkdm_offs,
> +					   oh->prcm.omap4.clkctrl_offs);
> +
> +	if (mmode)
> +		spin_unlock_irqrestore(&mmode->lock, flags);
>  }
>  
>  /**
> @@ -995,15 +1011,32 @@ static void _omap4_enable_module(struct omap_hwmod *oh)
>   */
>  static void _am33xx_enable_module(struct omap_hwmod *oh)
>  {
> +	unsigned long flags;
> +	struct modulemode_shared *mmode = NULL;
> +	bool enable = true;
> +
>  	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
>  		return;
>  
>  	pr_debug("omap_hwmod: %s: %s: %d\n",
>  		 oh->name, __func__, oh->prcm.omap4.modulemode);
>  
> -	am33xx_cm_module_enable(oh->prcm.omap4.modulemode, oh->clkdm->cm_inst,
> -				oh->clkdm->clkdm_offs,
> -				oh->prcm.omap4.clkctrl_offs);
> +	if (oh->prcm.omap4.flags & HWMOD_OMAP4_MODULEMODE_SHARED) {
> +		mmode = oh->prcm.omap4.modulemode_ref;
> +
> +		spin_lock_irqsave(&mmode->lock, flags);
> +
> +		enable = mmode->refcnt++ == 0;
> +	}
> +
> +	if (enable)
> +		am33xx_cm_module_enable(oh->prcm.omap4.modulemode,
> +					oh->clkdm->cm_inst,
> +					oh->clkdm->clkdm_offs,
> +					oh->prcm.omap4.clkctrl_offs);
> +
> +	if (mmode)
> +		spin_unlock_irqrestore(&mmode->lock, flags);
>  }
>  
>  /**
> @@ -1846,6 +1879,9 @@ static bool _are_any_hardreset_lines_asserted(struct omap_hwmod *oh)
>  static int _omap4_disable_module(struct omap_hwmod *oh)
>  {
>  	int v;
> +	unsigned long flags;
> +	struct modulemode_shared *mmode = NULL;
> +	bool disable = true;
>  
>  	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
>  		return -EINVAL;
> @@ -1859,15 +1895,30 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
>  
>  	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
>  
> -	omap4_cminst_module_disable(oh->clkdm->prcm_partition,
> +	if (oh->prcm.omap4.flags & HWMOD_OMAP4_MODULEMODE_SHARED) {
> +		mmode = oh->prcm.omap4.modulemode_ref;
> +
> +		spin_lock_irqsave(&mmode->lock, flags);
> +
> +		WARN_ON(mmode->refcnt == 0);
> +
> +		disable = --mmode->refcnt == 0;
> +	}
> +
> +	if (disable) {
> +		omap4_cminst_module_disable(oh->clkdm->prcm_partition,
>  				    oh->clkdm->cm_inst,
>  				    oh->clkdm->clkdm_offs,
>  				    oh->prcm.omap4.clkctrl_offs);
>  
> -	v = _omap4_wait_target_disable(oh);
> -	if (v)
> -		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
> -			oh->name);
> +		v = _omap4_wait_target_disable(oh);
> +		if (v)
> +			pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
> +				oh->name);
> +	}
> +
> +	if (mmode)
> +		spin_unlock_irqrestore(&mmode->lock, flags);
>  
>  	return 0;
>  }
> @@ -1882,6 +1933,9 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
>  static int _am33xx_disable_module(struct omap_hwmod *oh)
>  {
>  	int v;
> +	unsigned long flags;
> +	struct modulemode_shared *mmode = NULL;
> +	bool disable = true;
>  
>  	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
>  		return -EINVAL;
> @@ -1891,13 +1945,28 @@ static int _am33xx_disable_module(struct omap_hwmod *oh)
>  	if (_are_any_hardreset_lines_asserted(oh))
>  		return 0;
>  
> -	am33xx_cm_module_disable(oh->clkdm->cm_inst, oh->clkdm->clkdm_offs,
> -				 oh->prcm.omap4.clkctrl_offs);
> +	if (oh->prcm.omap4.flags & HWMOD_OMAP4_MODULEMODE_SHARED) {
> +		mmode = oh->prcm.omap4.modulemode_ref;
>  
> -	v = _am33xx_wait_target_disable(oh);
> -	if (v)
> -		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
> -			oh->name);
> +		spin_lock_irqsave(&mmode->lock, flags);
> +
> +		WARN_ON(mmode->refcnt == 0);
> +
> +		disable = --mmode->refcnt == 0;
> +	}
> +
> +	if (disable) {
> +		am33xx_cm_module_disable(oh->clkdm->cm_inst, oh->clkdm->clkdm_offs,
> +					 oh->prcm.omap4.clkctrl_offs);
> +
> +		v = _am33xx_wait_target_disable(oh);
> +		if (v)
> +			pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
> +				oh->name);
> +	}
> +
> +	if (mmode)
> +		spin_unlock_irqrestore(&mmode->lock, flags);
>  
>  	return 0;
>  }
> @@ -2751,6 +2820,13 @@ static int __init _register(struct omap_hwmod *oh)
>  	if (_lookup(oh->name))
>  		return -EEXIST;
>  
> +	if (oh->prcm.omap4.flags & HWMOD_OMAP4_MODULEMODE_SHARED &&
> +			!oh->prcm.omap4.modulemode_ref) {

You might also want to check for someone populating a modulemode_ref but
failing to populate the flag?

Alternatively, Since you expect a modulemode_ref to be always available for all modules which
share modulemode, that in itself can be used to identify such modules without the
need of an additional flag?

> +		pr_err("omap_hwmod: %s shares modulemode, but doesn't hold a ref to it\n",
> +			oh->name);
> +		return -EINVAL;
> +	}
> +
>  	list_add_tail(&oh->node, &omap_hwmod_list);
>  
>  	INIT_LIST_HEAD(&oh->master_ports);
> @@ -2759,6 +2835,15 @@ static int __init _register(struct omap_hwmod *oh)
>  
>  	oh->_state = _HWMOD_STATE_REGISTERED;
>  
> +	if (oh->prcm.omap4.flags & HWMOD_OMAP4_MODULEMODE_SHARED) {
> +		struct modulemode_shared *mmode = oh->prcm.omap4.modulemode_ref;
> +
> +		if (!mmode->registered) {
> +			spin_lock_init(&mmode->lock);
> +			mmode->registered = true;

If this is only used to keep track of the spin_lock being initialized, maybe it'll be
more readable if you just call it mmode->spin_lock_init = true.

> +		}
> +	}
> +
>  	/*
>  	 * XXX Rather than doing a strcmp(), this should test a flag
>  	 * set in the hwmod data, inserted by the autogenerator code.
> diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
> index 0f97d63..64c2af6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.h
> +++ b/arch/arm/mach-omap2/omap_hwmod.h
> @@ -432,13 +432,31 @@ struct omap_hwmod_omap2_prcm {
>  };
>  
>  /*
> + * struct for managing modulemode field shared accross IP blocks
> + * @lock: spinlock to searilze enables/disables performed by different
> + *     hwmods sharing the same modulemode field
> + * @refcnt: keep a refcount of the enabled hwmods using this modulemode
> + *     field
> + * @registered: a flag to track whether the struct has been registered
> + */
> +struct modulemode_shared {
> +	spinlock_t	lock;
> +	unsigned	refcnt;
> +	bool		registered;
> +};
> +
> +/*
>   * Possible values for struct omap_hwmod_omap4_prcm.flags
>   *
>   * HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT: Some IP blocks don't have a PRCM
>   *     module-level context loss register associated with them; this
>   *     flag bit should be set in those cases
> + * HWMOD_OMAP4_MODULEMODE_SHARED: Some IP blocks belonging to the same
> + *     clock domain may have a shared MODULEMODE field; this flag bit
> + *     should be set in those cases
>   */
>  #define HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT		(1 << 0)
> +#define HWMOD_OMAP4_MODULEMODE_SHARED		(1 << 1)
>  
>  /**
>   * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
> @@ -450,6 +468,7 @@ struct omap_hwmod_omap2_prcm {
>   * @submodule_wkdep_bit: bit shift of the WKDEP range
>   * @flags: PRCM register capabilities for this IP block
>   * @modulemode: allowable modulemodes
> + * @modulemode_ref: pointer to modulemode struct shared by multiple hwmods
>   * @context_lost_counter: Count of module level context lost
>   *
>   * If @lostcontext_mask is not defined, context loss check code uses
> @@ -458,15 +477,16 @@ struct omap_hwmod_omap2_prcm {
>   * more hwmods.
>   */
>  struct omap_hwmod_omap4_prcm {
> -	u16		clkctrl_offs;
> -	u16		rstctrl_offs;
> -	u16		rstst_offs;
> -	u16		context_offs;
> -	u32		lostcontext_mask;
> -	u8		submodule_wkdep_bit;
> -	u8		modulemode;
> -	u8		flags;
> -	int		context_lost_counter;
> +	u16				clkctrl_offs;
> +	u16				rstctrl_offs;
> +	u16				rstst_offs;
> +	u16				context_offs;
> +	u32				lostcontext_mask;
> +	u8				submodule_wkdep_bit;
> +	u8				modulemode;
> +	struct modulemode_shared	*modulemode_ref;
> +	u8				flags;
> +	int				context_lost_counter;
>  };
>  
>  
> 

