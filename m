From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: Add functions to save and restore clock/dpll context
 en-masse
Date: Thu, 4 May 2017 11:17:39 +0300
Message-ID: <14802c14-78fa-5f64-e375-2e1b1bbf3c37@ti.com>
References: <1492492369-19662-1-git-send-email-j-keerthy@ti.com>
 <20170504075129.GS30730@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170504075129.GS30730@tbergstrom-lnx.Nvidia.com>
Sender: linux-clk-owner@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>, Keerthy <j-keerthy@ti.com>
Cc: sboyd@codeaurora.org, mturquette@baylibre.com, linux@armlinux.org.uk, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>
List-Id: linux-omap@vger.kernel.org

On 04/05/17 10:51, Peter De Schrijver wrote:
> On Tue, Apr 18, 2017 at 10:42:49AM +0530, Keerthy wrote:
>> From: Russ Dill <Russ.Dill@ti.com>
>>
>> The clock/dpll registers are in the WKUP power domain. Under both RTC-only
>> suspend and hibernation, these registers are lost. Hence save/restore
>> them accordingly.
>>
>
> This won't work for Tegra, because we need a 2 pass restore. First restore
> rate/parents with all clocks enabled and then disable the ones which were
> disabled before entering suspend. Both passes usually go from root to leave.
> However a few clocks have to be treated separately, eg the ones related to
> SDRAM.

Do you have your own implementation in place? Is it possible to modify 
the base code here to add your requirements (drivers/clk/clk.c)?

I guess we could also just add clk_for_each() type of call that would 
allow us to iterate over clock hierarchy.

-Tero

>
>
>> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  drivers/clk/clk.c            |  70 ++++++++++++++++++++++++
>>  drivers/clk/ti/divider.c     |  36 +++++++++++++
>>  drivers/clk/ti/dpll.c        |   6 +++
>>  drivers/clk/ti/dpll3xxx.c    | 124 +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/ti/gate.c        |   3 ++
>>  drivers/clk/ti/mux.c         |  29 ++++++++++
>>  include/linux/clk-provider.h |  11 ++++
>>  include/linux/clk.h          |  25 +++++++++
>>  include/linux/clk/ti.h       |   6 +++
>>  9 files changed, 310 insertions(+)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index cddddbe..1ca87f4 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -687,6 +687,76 @@ static int clk_core_enable_lock(struct clk_core *core)
>>  	return ret;
>>  }
>>
>> +void clk_dflt_restore_context(struct clk_hw *hw)
>> +{
>> +	if (hw->clk->core->enable_count)
>> +		hw->clk->core->ops->enable(hw);
>> +	else
>> +		hw->clk->core->ops->disable(hw);
>> +}
>> +EXPORT_SYMBOL_GPL(clk_dflt_restore_context);
>> +
>> +static int clk_save_context(struct clk_core *clk)
>> +{
>> +	struct clk_core *child;
>> +	int ret = 0;
>> +
>> +	hlist_for_each_entry(child, &clk->children, child_node) {
>> +		ret = clk_save_context(child);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	if (clk->ops && clk->ops->save_context)
>> +		ret = clk->ops->save_context(clk->hw);
>> +
>> +	return ret;
>> +}
>> +
>> +static void clk_restore_context(struct clk_core *clk)
>> +{
>> +	struct clk_core *child;
>> +
>> +	if (clk->ops && clk->ops->restore_context)
>> +		clk->ops->restore_context(clk->hw);
>> +
>> +	hlist_for_each_entry(child, &clk->children, child_node)
>> +		clk_restore_context(child);
>> +}
>> +
>> +int clks_save_context(void)
>> +{
>> +	struct clk_core *clk;
>> +	int ret;
>> +
>> +	hlist_for_each_entry(clk, &clk_root_list, child_node) {
>> +		ret = clk_save_context(clk);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	hlist_for_each_entry(clk, &clk_orphan_list, child_node) {
>> +		ret = clk_save_context(clk);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(clks_save_context);
>> +
>> +void clks_restore_context(void)
>> +{
>> +	struct clk_core *clk;
>> +
>> +	hlist_for_each_entry(clk, &clk_root_list, child_node)
>> +		clk_restore_context(clk);
>> +
>> +	hlist_for_each_entry(clk, &clk_orphan_list, child_node)
>> +		clk_restore_context(clk);
>> +}
>> +EXPORT_SYMBOL_GPL(clks_restore_context);
>> +
>>  /**
>>   * clk_enable - ungate a clock
>>   * @clk: the clk being ungated
>> diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
>> index d6dcb28..350a58a 100644
>> --- a/drivers/clk/ti/divider.c
>> +++ b/drivers/clk/ti/divider.c
>> @@ -266,10 +266,46 @@ static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
>>  	return 0;
>>  }
>>
>> +/**
>> + * clk_divider_save_context - Save the divider value
>> + * @hw: pointer  struct clk_hw
>> + *
>> + * Save the divider value
>> + */
>> +static int clk_divider_save_context(struct clk_hw *hw)
>> +{
>> +	struct clk_divider *divider = to_clk_divider(hw);
>> +	u32 val;
>> +
>> +	val = ti_clk_ll_ops->clk_readl(divider->reg) >> divider->shift;
>> +	divider->context = val & div_mask(divider);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * clk_divider_restore_context - restore the saved the divider value
>> + * @hw: pointer  struct clk_hw
>> + *
>> + * Restore the saved the divider value
>> + */
>> +static void clk_divider_restore_context(struct clk_hw *hw)
>> +{
>> +	struct clk_divider *divider = to_clk_divider(hw);
>> +	u32 val;
>> +
>> +	val = ti_clk_ll_ops->clk_readl(divider->reg);
>> +	val &= ~(div_mask(divider) << divider->shift);
>> +	val |= divider->context << divider->shift;
>> +	ti_clk_ll_ops->clk_writel(val, divider->reg);
>> +}
>> +
>>  const struct clk_ops ti_clk_divider_ops = {
>>  	.recalc_rate = ti_clk_divider_recalc_rate,
>>  	.round_rate = ti_clk_divider_round_rate,
>>  	.set_rate = ti_clk_divider_set_rate,
>> +	.save_context = clk_divider_save_context,
>> +	.restore_context = clk_divider_restore_context,
>>  };
>>
>>  static struct clk *_register_divider(struct device *dev, const char *name,
>> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
>> index 96d8488..791dd31 100644
>> --- a/drivers/clk/ti/dpll.c
>> +++ b/drivers/clk/ti/dpll.c
>> @@ -39,6 +39,8 @@
>>  	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
>>  	.determine_rate	= &omap4_dpll_regm4xen_determine_rate,
>>  	.get_parent	= &omap2_init_dpll_parent,
>> +	.save_context	= &omap3_core_dpll_save_context,
>> +	.restore_context = &omap3_core_dpll_restore_context,
>>  };
>>  #else
>>  static const struct clk_ops dpll_m4xen_ck_ops = {};
>> @@ -62,6 +64,8 @@
>>  	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
>>  	.determine_rate	= &omap3_noncore_dpll_determine_rate,
>>  	.get_parent	= &omap2_init_dpll_parent,
>> +	.save_context	= &omap3_noncore_dpll_save_context,
>> +	.restore_context = &omap3_noncore_dpll_restore_context,
>>  };
>>
>>  static const struct clk_ops dpll_no_gate_ck_ops = {
>> @@ -72,6 +76,8 @@
>>  	.set_parent	= &omap3_noncore_dpll_set_parent,
>>  	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
>>  	.determine_rate	= &omap3_noncore_dpll_determine_rate,
>> +	.save_context	= &omap3_noncore_dpll_save_context,
>> +	.restore_context = &omap3_noncore_dpll_restore_context
>>  };
>>  #else
>>  static const struct clk_ops dpll_core_ck_ops = {};
>> diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
>> index 4534de2..44b6b64 100644
>> --- a/drivers/clk/ti/dpll3xxx.c
>> +++ b/drivers/clk/ti/dpll3xxx.c
>> @@ -782,6 +782,130 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
>>  	return rate;
>>  }
>>
>> +/**
>> + * omap3_core_dpll_save_context - Save the m and n values of the divider
>> + * @hw: pointer  struct clk_hw
>> + *
>> + * Before the dpll registers are lost save the last rounded rate m and n
>> + * and the enable mask.
>> + */
>> +int omap3_core_dpll_save_context(struct clk_hw *hw)
>> +{
>> +	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>> +	struct dpll_data *dd;
>> +	u32 v;
>> +
>> +	dd = clk->dpll_data;
>> +
>> +	v = ti_clk_ll_ops->clk_readl(&dd->control_reg);
>> +	clk->context = (v & dd->enable_mask) >> __ffs(dd->enable_mask);
>> +
>> +	if (clk->context == DPLL_LOCKED) {
>> +		v = ti_clk_ll_ops->clk_readl(&dd->mult_div1_reg);
>> +		dd->last_rounded_m = (v & dd->mult_mask) >>
>> +						__ffs(dd->mult_mask);
>> +		dd->last_rounded_n = ((v & dd->div1_mask) >>
>> +						__ffs(dd->div1_mask)) + 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * omap3_core_dpll_restore_context - restore the m and n values of the divider
>> + * @hw: pointer  struct clk_hw
>> + *
>> + * Restore the last rounded rate m and n
>> + * and the enable mask.
>> + */
>> +void omap3_core_dpll_restore_context(struct clk_hw *hw)
>> +{
>> +	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>> +	const struct dpll_data *dd;
>> +	u32 v;
>> +
>> +	dd = clk->dpll_data;
>> +
>> +	if (clk->context == DPLL_LOCKED) {
>> +		_omap3_dpll_write_clken(clk, 0x4);
>> +		_omap3_wait_dpll_status(clk, 0);
>> +
>> +		v = ti_clk_ll_ops->clk_readl(&dd->mult_div1_reg);
>> +		v &= ~(dd->mult_mask | dd->div1_mask);
>> +		v |= dd->last_rounded_m << __ffs(dd->mult_mask);
>> +		v |= (dd->last_rounded_n - 1) << __ffs(dd->div1_mask);
>> +		ti_clk_ll_ops->clk_writel(v, &dd->mult_div1_reg);
>> +
>> +		_omap3_dpll_write_clken(clk, DPLL_LOCKED);
>> +		_omap3_wait_dpll_status(clk, 1);
>> +	} else {
>> +		_omap3_dpll_write_clken(clk, clk->context);
>> +	}
>> +}
>> +
>> +/**
>> + * omap3_non_core_dpll_save_context - Save the m and n values of the divider
>> + * @hw: pointer  struct clk_hw
>> + *
>> + * Before the dpll registers are lost save the last rounded rate m and n
>> + * and the enable mask.
>> + */
>> +int omap3_noncore_dpll_save_context(struct clk_hw *hw)
>> +{
>> +	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>> +	struct dpll_data *dd;
>> +	u32 v;
>> +
>> +	dd = clk->dpll_data;
>> +
>> +	v = ti_clk_ll_ops->clk_readl(&dd->control_reg);
>> +	clk->context = (v & dd->enable_mask) >> __ffs(dd->enable_mask);
>> +
>> +	if (clk->context == DPLL_LOCKED) {
>> +		v = ti_clk_ll_ops->clk_readl(&dd->mult_div1_reg);
>> +		dd->last_rounded_m = (v & dd->mult_mask) >>
>> +						__ffs(dd->mult_mask);
>> +		dd->last_rounded_n = ((v & dd->div1_mask) >>
>> +						__ffs(dd->div1_mask)) + 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * omap3_core_dpll_restore_context - restore the m and n values of the divider
>> + * @hw: pointer  struct clk_hw
>> + *
>> + * Restore the last rounded rate m and n
>> + * and the enable mask.
>> + */
>> +void omap3_noncore_dpll_restore_context(struct clk_hw *hw)
>> +{
>> +	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>> +	const struct dpll_data *dd;
>> +	u32 ctrl, mult_div1;
>> +
>> +	dd = clk->dpll_data;
>> +
>> +	ctrl = ti_clk_ll_ops->clk_readl(&dd->control_reg);
>> +	mult_div1 = ti_clk_ll_ops->clk_readl(&dd->mult_div1_reg);
>> +
>> +	if (clk->context == ((ctrl & dd->enable_mask) >>
>> +			     __ffs(dd->enable_mask)) &&
>> +	    dd->last_rounded_m == ((mult_div1 & dd->mult_mask) >>
>> +				   __ffs(dd->mult_mask)) &&
>> +	    dd->last_rounded_n == ((mult_div1 & dd->div1_mask) >>
>> +				   __ffs(dd->div1_mask)) + 1) {
>> +		/* nothing to be done */
>> +		return;
>> +	}
>> +
>> +	if (clk->context == DPLL_LOCKED)
>> +		omap3_noncore_dpll_program(clk, 0);
>> +	else
>> +		_omap3_dpll_write_clken(clk, clk->context);
>> +}
>> +
>>  /* OMAP3/4 non-CORE DPLL clkops */
>>  const struct clk_hw_omap_ops clkhwops_omap3_dpll = {
>>  	.allow_idle	= omap3_dpll_allow_idle,
>> diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
>> index 7151ec3..098db66 100644
>> --- a/drivers/clk/ti/gate.c
>> +++ b/drivers/clk/ti/gate.c
>> @@ -33,6 +33,7 @@
>>  	.init		= &omap2_init_clk_clkdm,
>>  	.enable		= &omap2_clkops_enable_clkdm,
>>  	.disable	= &omap2_clkops_disable_clkdm,
>> +	.restore_context = clk_dflt_restore_context,
>>  };
>>
>>  const struct clk_ops omap_gate_clk_ops = {
>> @@ -40,6 +41,7 @@
>>  	.enable		= &omap2_dflt_clk_enable,
>>  	.disable	= &omap2_dflt_clk_disable,
>>  	.is_enabled	= &omap2_dflt_clk_is_enabled,
>> +	.restore_context = clk_dflt_restore_context,
>>  };
>>
>>  static const struct clk_ops omap_gate_clk_hsdiv_restore_ops = {
>> @@ -47,6 +49,7 @@
>>  	.enable		= &omap36xx_gate_clk_enable_with_hsdiv_restore,
>>  	.disable	= &omap2_dflt_clk_disable,
>>  	.is_enabled	= &omap2_dflt_clk_is_enabled,
>> +	.restore_context = clk_dflt_restore_context,
>>  };
>>
>>  /**
>> diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
>> index 18c267b..e73764a 100644
>> --- a/drivers/clk/ti/mux.c
>> +++ b/drivers/clk/ti/mux.c
>> @@ -90,10 +90,39 @@ static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>>  	return 0;
>>  }
>>
>> +/**
>> + * clk_mux_save_context - Save the parent selcted in the mux
>> + * @hw: pointer  struct clk_hw
>> + *
>> + * Save the parent mux value.
>> + */
>> +static int clk_mux_save_context(struct clk_hw *hw)
>> +{
>> +	struct clk_mux *mux = to_clk_mux(hw);
>> +
>> +	mux->saved_parent = ti_clk_mux_get_parent(hw);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * clk_mux_restore_context - Restore the parent in the mux
>> + * @hw: pointer  struct clk_hw
>> + *
>> + * Restore the saved parent mux value.
>> + */
>> +static void clk_mux_restore_context(struct clk_hw *hw)
>> +{
>> +	struct clk_mux *mux = to_clk_mux(hw);
>> +
>> +	ti_clk_mux_set_parent(hw, mux->saved_parent);
>> +}
>> +
>>  const struct clk_ops ti_clk_mux_ops = {
>>  	.get_parent = ti_clk_mux_get_parent,
>>  	.set_parent = ti_clk_mux_set_parent,
>>  	.determine_rate = __clk_mux_determine_rate,
>> +	.save_context = clk_mux_save_context,
>> +	.restore_context = clk_mux_restore_context,
>>  };
>>
>>  static struct clk *_register_mux(struct device *dev, const char *name,
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index a428aec..2a8f636 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -103,6 +103,11 @@ struct clk_rate_request {
>>   *		Called with enable_lock held.  This function must not
>>   *		sleep.
>>   *
>> + * @save_context: Save the context of the clock in prepration for poweroff.
>> + *
>> + * @restore_context: Restore the context of the clock after a restoration
>> + *		of power.
>> + *
>>   * @recalc_rate	Recalculate the rate of this clock, by querying hardware. The
>>   *		parent rate is an input parameter.  It is up to the caller to
>>   *		ensure that the prepare_mutex is held across this call.
>> @@ -198,6 +203,8 @@ struct clk_ops {
>>  	void		(*disable)(struct clk_hw *hw);
>>  	int		(*is_enabled)(struct clk_hw *hw);
>>  	void		(*disable_unused)(struct clk_hw *hw);
>> +	int		(*save_context)(struct clk_hw *hw);
>> +	void		(*restore_context)(struct clk_hw *hw);
>>  	unsigned long	(*recalc_rate)(struct clk_hw *hw,
>>  					unsigned long parent_rate);
>>  	long		(*round_rate)(struct clk_hw *hw, unsigned long rate,
>> @@ -394,6 +401,7 @@ struct clk_divider {
>>  	u8		flags;
>>  	const struct clk_div_table	*table;
>>  	spinlock_t	*lock;
>> +	u32		context;
>>  };
>>
>>  #define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
>> @@ -471,6 +479,7 @@ struct clk_mux {
>>  	u8		shift;
>>  	u8		flags;
>>  	spinlock_t	*lock;
>> +	u8		saved_parent;
>>  };
>>
>>  #define to_clk_mux(_hw) container_of(_hw, struct clk_mux, hw)
>> @@ -912,5 +921,7 @@ struct dentry *clk_debugfs_add_file(struct clk_hw *hw, char *name, umode_t mode,
>>  				void *data, const struct file_operations *fops);
>>  #endif
>>
>> +void clk_dflt_restore_context(struct clk_hw *hw);
>> +
>>  #endif /* CONFIG_COMMON_CLK */
>>  #endif /* CLK_PROVIDER_H */
>> diff --git a/include/linux/clk.h b/include/linux/clk.h
>> index 024cd07..d071a65 100644
>> --- a/include/linux/clk.h
>> +++ b/include/linux/clk.h
>> @@ -438,6 +438,23 @@ struct clk *devm_get_clk_from_child(struct device *dev,
>>   */
>>  struct clk *clk_get_sys(const char *dev_id, const char *con_id);
>>
>> +/**
>> + * clks_save_context - save clock context for poweroff
>> + *
>> + * Saves the context of the clock register for powerstates in which the
>> + * contents of the registers will be lost. Occurs deep within the suspend
>> + * code so locking is not necessary.
>> + */
>> +int clks_save_context(void);
>> +
>> +/**
>> + * clks_restore_context - restore clock context after poweroff
>> + *
>> + * This occurs with all clocks enabled. Occurs deep within the resume code
>> + * so locking is not necessary.
>> + */
>> +void clks_restore_context(void);
>> +
>>  #else /* !CONFIG_HAVE_CLK */
>>
>>  static inline struct clk *clk_get(struct device *dev, const char *id)
>> @@ -501,6 +518,14 @@ static inline struct clk *clk_get_sys(const char *dev_id, const char *con_id)
>>  {
>>  	return NULL;
>>  }
>> +
>> +static inline int clks_save_context(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void clks_restore_context(void) {}
>> +
>>  #endif
>>
>>  /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
>> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
>> index d18da83..f604936 100644
>> --- a/include/linux/clk/ti.h
>> +++ b/include/linux/clk/ti.h
>> @@ -159,6 +159,7 @@ struct clk_hw_omap {
>>  	const char		*clkdm_name;
>>  	struct clockdomain	*clkdm;
>>  	const struct clk_hw_omap_ops	*ops;
>> +	u32			context;
>>  };
>>
>>  /*
>> @@ -290,6 +291,11 @@ struct ti_clk_features {
>>
>>  void ti_clk_setup_features(struct ti_clk_features *features);
>>  const struct ti_clk_features *ti_clk_get_features(void);
>> +int omap3_noncore_dpll_save_context(struct clk_hw *hw);
>> +void omap3_noncore_dpll_restore_context(struct clk_hw *hw);
>> +
>> +int omap3_core_dpll_save_context(struct clk_hw *hw);
>> +void omap3_core_dpll_restore_context(struct clk_hw *hw);
>>
>>  extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
>>
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

