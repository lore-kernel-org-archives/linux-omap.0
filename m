From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/4] Sysfs interface for controlling suspend states +
 set_pwrdm_state fix
Date: Fri, 5 Sep 2008 07:30:21 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809050641591.5763@utopia.booyaka.com>
References: <> <1219851962-28972-1-git-send-email-tero.kristo@nokia.com> <1219851962-28972-2-git-send-email-tero.kristo@nokia.com> <1219851962-28972-3-git-send-email-tero.kristo@nokia.com> <1219851962-28972-4-git-send-email-tero.kristo@nokia.com>
 <1219851962-28972-5-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33670 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbYIENaX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 09:30:23 -0400
In-Reply-To: <1219851962-28972-5-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Hello Tero,

On Wed, 27 Aug 2008, Tero Kristo wrote:

> Target states for each powerdomain can now be set via sysfs interface.
> E.g. "echo 0 > /sys/power/suspend/mpu_pwrdm" will program MPU suspend
> state to be OFF.

Is this all debugging code, or is there a broader use in mind?

If it is debugging code, the directory should probably go to debugfs, and 
all of this code should be wrapped in #ifdef CONFIG_PM_DEBUG.

Either way, let's change the directory structure, so we can add 
other files for other powerdomain parameters later.  How about:

/sys/power/domain/mpu_pwrdm/next_power_state

or 

/debug/powerdomain/mpu_pwrdm/next_power_state

?

> Also, set_pwrdm_state() should now work when pwrdm is currently in
> power save state.
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   97 +++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 96 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index e0d1b1f..4b42031 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -82,6 +82,8 @@ static void per_gpio_clk_disable(void)
>  		clk_disable(gpio_fcks[i-1]);
>  }
>  
> +static struct kobject *suspend_dir_kobj;
> +
>  /* XXX This is for gpio fclk hack. Will be removed as gpio driver
>   * handles fcks correctly */
>  static void gpio_fclk_mask(u32 *fclk)
> @@ -306,6 +308,7 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  {
>  	u32 cur_state;
>  	int ret = 0;
> +	int sleep_switch = 0;
>  
>  	if (pwrdm == NULL || IS_ERR(pwrdm))
>  		return -EINVAL;
> @@ -315,6 +318,16 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  	if (cur_state == state)
>  		return ret;
>  
> +	/* Check if we need to wake-up the pwrdm for state switch */
> +	/* MPU, core and per are never in sleep states when we are here*/

Please make sure your comments follow CodingStyle - in this case, add a 
space after "here"

> +	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
> +		if ((cm_read_mod_reg(pwrdm->prcm_offs, 0x48) & 0x3) == 0x3) {

Please use preprocessor macros, not these bare numbers.  This sort of 
thing is just backsliding.

> +			sleep_switch = 1;
> +			cm_rmw_mod_reg_bits(0x3, 0x2, pwrdm->prcm_offs, 0x48);

As above.

> +			pwrdm_wait_transition(pwrdm);
> +		}
> +	}
> +
>  	pwrdm_for_each_clkdm(pwrdm, _clkdm_deny_idle);
>  
>  	ret = pwrdm_set_next_pwrst(pwrdm, state);
> @@ -326,6 +339,12 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  
>  	pwrdm_for_each_clkdm(pwrdm, _clkdm_allow_idle);
>  
> +	if (sleep_switch) {
> +		cm_rmw_mod_reg_bits(0x3, 0x3, pwrdm->prcm_offs, 0x48);

As above.

> +		pwrdm_wait_transition(pwrdm);
> +		pm_dbg_pwrdm_state_switch(pwrdm);
> +	}
> +
>  err:
>  	return ret;
>  }
> @@ -380,7 +399,6 @@ static int omap3_pm_suspend(void)
>  restore:
>  	/* Restore next_pwrsts */
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
 > -		set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
>  		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
>  		if (state != pwrst->next_state) {
>  			printk(KERN_INFO "Powerdomain (%s) didn't enter "
> @@ -388,6 +406,7 @@ restore:
>  			       pwrst->pwrdm->name, pwrst->next_state);
>  			ret = -1;
>  		}
> +		set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
>  	}
>  	if (ret)
>  		printk(KERN_ERR "Could not enter target state in pm_suspend\n");
> @@ -584,9 +603,67 @@ static void __init prcm_setup_regs(void)
>  			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
>  }
>  
> +static struct power_state *get_pwrst_node(const char *name)
> +{
> +	struct powerdomain *pwrdm;
> +	struct power_state *pwrst_tmp;
> +	struct power_state *pwrst = NULL;
> +
> +	pwrdm = pwrdm_lookup(name);
> +
> +	if (pwrdm == NULL) {
> +		printk(KERN_ERR "pwrdm not found %s\n", name);
> +		return NULL;
> +	}
> +
> +	list_for_each_entry(pwrst_tmp, &pwrst_list, node)
> +		if (pwrst_tmp->pwrdm == pwrdm)
> +			pwrst = pwrst_tmp;
> +
> +	if (pwrst == NULL)
> +		printk(KERN_ERR "pwrdm not in suspend list %s\n", name);
> +
> +	return pwrst;
> +}
> +
> +static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	struct power_state *pwrst;
> +
> +	pwrst = get_pwrst_node(attr->attr.name);
> +
> +	if (pwrst == NULL)
> +		return -EINVAL;
> +
> +	return sprintf(buf, "%hu\n", pwrst->next_state);
> +}
> +
> +static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
> +			  const char *buf, size_t n)
> +{
> +	struct power_state *pwrst;
> +	unsigned short value;
> +
> +	if (sscanf(buf, "%hu", &value) != 1 || value > PWRDM_POWER_ON) {
> +		printk(KERN_ERR "state_store: Invalid value\n");
> +		return -EINVAL;
> +	}
> +
> +	pwrst = get_pwrst_node(attr->attr.name);
> +
> +	if (pwrst == NULL)
> +		return -EINVAL;
> +
> +	pwrst->next_state = value;
> +
> +	return n;
> +}
> +
>  static int __init pwrdms_setup(struct powerdomain *pwrdm)
>  {
>  	struct power_state *pwrst;
> +	struct kobj_attribute *attr;
>  
>  	if (!pwrdm->pwrsts)
>  		return 0;
> @@ -601,6 +678,18 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
>  	if (pwrdm_has_hdwr_sar(pwrdm))
>  		pwrdm_enable_hdwr_sar(pwrdm);
>  
> +	attr = kmalloc(sizeof(struct kobj_attribute), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	attr->attr.name = pwrdm->name;
> +	attr->attr.mode = 0644;
> +	attr->show = state_show;
> +	attr->store = state_store;
> +
> +	if (sysfs_create_file(suspend_dir_kobj, &(attr->attr)))
> +		return -ENOMEM;
> +
>  	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
>  }
>  
> @@ -625,6 +714,12 @@ int __init omap3_pm_init(void)
>  		goto err1;
>  	}
>  
> +	suspend_dir_kobj = kobject_create_and_add("suspend_config", power_kobj);
> +	if (!suspend_dir_kobj) {
> +		ret = -ENOMEM;
> +		goto err2;
> +	}
> +
>  	ret = pwrdm_for_each(pwrdms_setup);
>  	if (ret) {
>  		printk(KERN_ERR "Failed to setup powerdomains\n");
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
