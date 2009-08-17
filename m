From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 10/10] OMAP: PM: Added suspend target state control to
	debugfs for OMAP3
Date: Mon, 17 Aug 2009 11:10:16 +0300
Message-ID: <20090817081016.GL7278@atomide.com>
References: <1250182359-18830-2-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-3-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-4-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-5-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-6-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-7-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-8-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-9-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-10-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-11-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1250182359-18830-11-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> [090813 19:54]:
> From: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> 
> Target state can be read / programmed via files under:
>   [debugfs]/pm_debug/[pwrdm]/suspend


Does this compile when CONFIG_DEBUG_FS is not set?

Tony


> 
> Signed-off-by: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> ---
>  arch/arm/mach-omap2/pm-debug.c |   31 +++++++++++++++++++++++++++++--
>  arch/arm/mach-omap2/pm.h       |    3 +++
>  arch/arm/mach-omap2/pm34xx.c   |   24 ++++++++++++++++++++++++
>  3 files changed, 56 insertions(+), 2 deletions(-)
>  mode change 100755 => 100644 arch/arm/mach-omap2/pm-debug.c
> 
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> old mode 100755
> new mode 100644
> index 37b883b..eded6a4
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -24,6 +24,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
>  
>  #include <mach/clock.h>
>  #include <mach/board.h>
> @@ -478,10 +479,28 @@ int pm_dbg_regset_init(int reg_set)
>  	return 0;
>  }
>  
> -static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
> +static int pwrdm_suspend_get(void *data, u64 *val)
> +{
> +	*val = omap3_pm_get_suspend_state((struct powerdomain *)data);
> +
> +	if (*val >= 0)
> +		return 0;
> +	return *val;
> +}
> +
> +static int pwrdm_suspend_set(void *data, u64 val)
> +{
> +	return omap3_pm_set_suspend_state((struct powerdomain *)data, (int)val);
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(pwrdm_suspend_fops, pwrdm_suspend_get,
> +			pwrdm_suspend_set, "%llu\n");
> +
> +static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
>  {
>  	int i;
>  	s64 t;
> +	struct dentry *d;
>  
>  	t = sched_clock();
>  
> @@ -490,6 +509,14 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  
>  	pwrdm->timer = t;
>  
> +	if (strncmp(pwrdm->name, "dpll", 4) == 0)
> +		return 0;
> +
> +	d = debugfs_create_dir(pwrdm->name, (struct dentry *)dir);
> +
> +	(void) debugfs_create_file("suspend", S_IRUGO|S_IWUSR, d,
> +			(void *)pwrdm, &pwrdm_suspend_fops);
> +
>  	return 0;
>  }
>  
> @@ -508,7 +535,7 @@ static int __init pm_dbg_init(void)
>  	(void) debugfs_create_file("time", S_IRUGO,
>  		d, (void *)DEBUG_FILE_TIMERS, &debug_fops);
>  
> -	pwrdm_for_each(pwrdms_setup, NULL);
> +	pwrdm_for_each(pwrdms_setup, (void *)d);
>  
>  	pm_dbg_dir = debugfs_create_dir("registers", d);
>  	if (IS_ERR(pm_dbg_dir))
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 8fa8567..8400f57 100755
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -13,6 +13,9 @@
>  
>  #include <mach/powerdomain.h>
>  
> +extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
> +extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
> +
>  #ifdef CONFIG_PM_DEBUG
>  extern void omap2_pm_dump(int mode, int resume, unsigned int us);
>  extern int omap2_pm_debug;
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 331dfca..26f2aca 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -664,6 +664,30 @@ static void __init prcm_setup_regs(void)
>  	omap3_d2d_idle();
>  }
>  
> +int omap3_pm_get_suspend_state(struct powerdomain *pwrdm)
> +{
> +	struct power_state *pwrst;
> +
> +	list_for_each_entry(pwrst, &pwrst_list, node) {
> +		if (pwrst->pwrdm == pwrdm)
> +			return pwrst->next_state;
> +	}
> +	return -EINVAL;
> +}
> +
> +int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
> +{
> +	struct power_state *pwrst;
> +
> +	list_for_each_entry(pwrst, &pwrst_list, node) {
> +		if (pwrst->pwrdm == pwrdm) {
> +			pwrst->next_state = state;
> +			return 0;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
>  static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  {
>  	struct power_state *pwrst;
> -- 
> 1.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
