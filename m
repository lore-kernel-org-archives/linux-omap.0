From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 06/10] OMAP: PM debug: Add PRCM register dump support
Date: Mon, 17 Aug 2009 11:03:00 +0300
Message-ID: <20090817080259.GI7278@atomide.com>
References: <1250182359-18830-1-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-2-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-3-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-4-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-5-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-6-git-send-email-khilman@deeprootsystems.com> <1250182359-18830-7-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1250182359-18830-7-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> [090813 19:53]:
> From: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> 
> Allows dumping out current register contents from the debug filesystem, and
> also allows user to add arbitrary register save points into code. Current
> register contents are available under debugfs at:
> 
> [debugfs]/pm_debug/registers/current
> 
> To add a save point, do following:
> 
> From module init (or somewhere before the save call, called only once):
>   pm_dbg_init_regset(n); // n=1..4, allocates memory for dump area #n
> 
> From arbitrary code location:
>   pm_dbg_regset_save(n); // n=1..4, saves registers to dump area #n
> 
> After this, the register dump can be seen under [debugfs]/pm_debug/registers/n
> 
> Signed-off-by: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> ---
>  arch/arm/mach-omap2/pm-debug.c |  208 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.h       |    4 +
>  2 files changed, 212 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 arch/arm/mach-omap2/pm-debug.c
>  mode change 100644 => 100755 arch/arm/mach-omap2/pm.h
> 
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> old mode 100644
> new mode 100755
> index 9199c17..37b883b
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -157,6 +157,8 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
>  
> +static void pm_dbg_regset_store(u32 *ptr);
> +
>  struct dentry *pm_dbg_dir;
>  
>  static int pm_dbg_init_done;
> @@ -166,6 +168,159 @@ enum {
>  	DEBUG_FILE_TIMERS,
>  };
>  
> +struct pm_module_def {
> +	char name[8]; /* Name of the module */
> +	short type; /* CM or PRM */
> +	unsigned short offset;
> +	int low; /* First register address on this module */
> +	int high; /* Last register address on this module */
> +};
> +
> +#define MOD_CM 0
> +#define MOD_PRM 1
> +
> +static const struct pm_module_def pm_dbg_reg_modules[] = {
> +	{ "IVA2", MOD_CM, OMAP3430_IVA2_MOD, 0, 0x4c },
> +	{ "OCP", MOD_CM, OCP_MOD, 0, 0x10 },
> +	{ "MPU", MOD_CM, MPU_MOD, 4, 0x4c },
> +	{ "CORE", MOD_CM, CORE_MOD, 0, 0x4c },
> +	{ "SGX", MOD_CM, OMAP3430ES2_SGX_MOD, 0, 0x4c },
> +	{ "WKUP", MOD_CM, WKUP_MOD, 0, 0x40 },
> +	{ "CCR", MOD_CM, PLL_MOD, 0, 0x70 },
> +	{ "DSS", MOD_CM, OMAP3430_DSS_MOD, 0, 0x4c },
> +	{ "CAM", MOD_CM, OMAP3430_CAM_MOD, 0, 0x4c },
> +	{ "PER", MOD_CM, OMAP3430_PER_MOD, 0, 0x4c },
> +	{ "EMU", MOD_CM, OMAP3430_EMU_MOD, 0x40, 0x54 },
> +	{ "NEON", MOD_CM, OMAP3430_NEON_MOD, 0x20, 0x48 },
> +	{ "USB", MOD_CM, OMAP3430ES2_USBHOST_MOD, 0, 0x4c },
> +
> +	{ "IVA2", MOD_PRM, OMAP3430_IVA2_MOD, 0x50, 0xfc },
> +	{ "OCP", MOD_PRM, OCP_MOD, 4, 0x1c },
> +	{ "MPU", MOD_PRM, MPU_MOD, 0x58, 0xe8 },
> +	{ "CORE", MOD_PRM, CORE_MOD, 0x58, 0xf8 },
> +	{ "SGX", MOD_PRM, OMAP3430ES2_SGX_MOD, 0x58, 0xe8 },
> +	{ "WKUP", MOD_PRM, WKUP_MOD, 0xa0, 0xb0 },
> +	{ "CCR", MOD_PRM, PLL_MOD, 0x40, 0x70 },
> +	{ "DSS", MOD_PRM, OMAP3430_DSS_MOD, 0x58, 0xe8 },
> +	{ "CAM", MOD_PRM, OMAP3430_CAM_MOD, 0x58, 0xe8 },
> +	{ "PER", MOD_PRM, OMAP3430_PER_MOD, 0x58, 0xe8 },
> +	{ "EMU", MOD_PRM, OMAP3430_EMU_MOD, 0x58, 0xe4 },
> +	{ "GLBL", MOD_PRM, OMAP3430_GR_MOD, 0x20, 0xe4 },
> +	{ "NEON", MOD_PRM, OMAP3430_NEON_MOD, 0x58, 0xe8 },
> +	{ "USB", MOD_PRM, OMAP3430ES2_USBHOST_MOD, 0x58, 0xe8 },
> +	{ "", 0, 0, 0, 0 },
> +};

This seems 34xx specific and might easily confuse things for other
processors.

To me it seems you should initialize these registers during init
for the processor type.

Regards,

Tony


> +
> +#define PM_DBG_MAX_REG_SETS 4
> +
> +static void *pm_dbg_reg_set[PM_DBG_MAX_REG_SETS];
> +
> +static int pm_dbg_get_regset_size(void)
> +{
> +	static int regset_size;
> +
> +	if (regset_size == 0) {
> +		int i = 0;
> +
> +		while (pm_dbg_reg_modules[i].name[0] != 0) {
> +			regset_size += pm_dbg_reg_modules[i].high +
> +				4 - pm_dbg_reg_modules[i].low;
> +			i++;
> +		}
> +	}
> +	return regset_size;
> +}
> +
> +static int pm_dbg_show_regs(struct seq_file *s, void *unused)
> +{
> +	int i, j;
> +	unsigned long val;
> +	int reg_set = (int)s->private;
> +	u32 *ptr;
> +	void *store = NULL;
> +	int regs;
> +	int linefeed;
> +
> +	if (reg_set == 0) {
> +		store = kmalloc(pm_dbg_get_regset_size(), GFP_KERNEL);
> +		ptr = store;
> +		pm_dbg_regset_store(ptr);
> +	} else {
> +		ptr = pm_dbg_reg_set[reg_set - 1];
> +	}
> +
> +	i = 0;
> +
> +	while (pm_dbg_reg_modules[i].name[0] != 0) {
> +		regs = 0;
> +		linefeed = 0;
> +		if (pm_dbg_reg_modules[i].type == MOD_CM)
> +			seq_printf(s, "MOD: CM_%s (%08x)\n",
> +				pm_dbg_reg_modules[i].name,
> +				(u32)(OMAP3430_CM_BASE +
> +				pm_dbg_reg_modules[i].offset));
> +		else
> +			seq_printf(s, "MOD: PRM_%s (%08x)\n",
> +				pm_dbg_reg_modules[i].name,
> +				(u32)(OMAP3430_PRM_BASE +
> +				pm_dbg_reg_modules[i].offset));
> +
> +		for (j = pm_dbg_reg_modules[i].low;
> +			j <= pm_dbg_reg_modules[i].high; j += 4) {
> +			val = *(ptr++);
> +			if (val != 0) {
> +				regs++;
> +				if (linefeed) {
> +					seq_printf(s, "\n");
> +					linefeed = 0;
> +				}
> +				seq_printf(s, "  %02x => %08lx", j, val);
> +				if (regs % 4 == 0)
> +					linefeed = 1;
> +			}
> +		}
> +		seq_printf(s, "\n");
> +		i++;
> +	}
> +
> +	if (store != NULL)
> +		kfree(store);
> +
> +	return 0;
> +}
> +
> +static void pm_dbg_regset_store(u32 *ptr)
> +{
> +	int i, j;
> +	u32 val;
> +
> +	i = 0;
> +
> +	while (pm_dbg_reg_modules[i].name[0] != 0) {
> +		for (j = pm_dbg_reg_modules[i].low;
> +			j <= pm_dbg_reg_modules[i].high; j += 4) {
> +			if (pm_dbg_reg_modules[i].type == MOD_CM)
> +				val = cm_read_mod_reg(
> +					pm_dbg_reg_modules[i].offset, j);
> +			else
> +				val = prm_read_mod_reg(
> +					pm_dbg_reg_modules[i].offset, j);
> +			*(ptr++) = val;
> +		}
> +		i++;
> +	}
> +}
> +
> +int pm_dbg_regset_save(int reg_set)
> +{
> +	if (pm_dbg_reg_set[reg_set-1] == NULL)
> +		return -EINVAL;
> +
> +	pm_dbg_regset_store(pm_dbg_reg_set[reg_set-1]);
> +
> +	return 0;
> +}
> +
>  static const char pwrdm_state_names[][4] = {
>  	"OFF",
>  	"RET",
> @@ -280,6 +435,11 @@ static int pm_dbg_open(struct inode *inode, struct file *file)
>  	};
>  }
>  
> +static int pm_dbg_reg_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, pm_dbg_show_regs, inode->i_private);
> +}
> +
>  static const struct file_operations debug_fops = {
>  	.open           = pm_dbg_open,
>  	.read           = seq_read,
> @@ -287,6 +447,37 @@ static const struct file_operations debug_fops = {
>  	.release        = single_release,
>  };
>  
> +static const struct file_operations debug_reg_fops = {
> +	.open           = pm_dbg_reg_open,
> +	.read           = seq_read,
> +	.llseek         = seq_lseek,
> +	.release        = single_release,
> +};
> +
> +int pm_dbg_regset_init(int reg_set)
> +{
> +	char name[2];
> +
> +	if (reg_set < 1 || reg_set > PM_DBG_MAX_REG_SETS ||
> +		pm_dbg_reg_set[reg_set-1] != NULL)
> +		return -EINVAL;
> +
> +	pm_dbg_reg_set[reg_set-1] =
> +		kmalloc(pm_dbg_get_regset_size(), GFP_KERNEL);
> +
> +	if (pm_dbg_reg_set[reg_set-1] == NULL)
> +		return -ENOMEM;
> +
> +	if (pm_dbg_dir != NULL) {
> +		sprintf(name, "%d", reg_set);
> +
> +		(void) debugfs_create_file(name, S_IRUGO,
> +			pm_dbg_dir, (void *)reg_set, &debug_reg_fops);
> +	}
> +
> +	return 0;
> +}
> +
>  static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  {
>  	int i;
> @@ -304,7 +495,9 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  
>  static int __init pm_dbg_init(void)
>  {
> +	int i;
>  	struct dentry *d;
> +	char name[2];
>  
>  	d = debugfs_create_dir("pm_debug", NULL);
>  	if (IS_ERR(d))
> @@ -317,6 +510,21 @@ static int __init pm_dbg_init(void)
>  
>  	pwrdm_for_each(pwrdms_setup, NULL);
>  
> +	pm_dbg_dir = debugfs_create_dir("registers", d);
> +	if (IS_ERR(pm_dbg_dir))
> +		return PTR_ERR(pm_dbg_dir);
> +
> +	(void) debugfs_create_file("current", S_IRUGO,
> +		pm_dbg_dir, (void *)0, &debug_reg_fops);
> +
> +	for (i = 0; i < PM_DBG_MAX_REG_SETS; i++)
> +		if (pm_dbg_reg_set[i] != NULL) {
> +			sprintf(name, "%d", i+1);
> +			(void) debugfs_create_file(name, S_IRUGO,
> +				pm_dbg_dir, (void *)(i+1), &debug_reg_fops);
> +
> +		}
> +
>  	pm_dbg_init_done = 1;
>  
>  	return 0;
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> old mode 100644
> new mode 100755
> index 4589db1..8fa8567
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -17,10 +17,14 @@
>  extern void omap2_pm_dump(int mode, int resume, unsigned int us);
>  extern int omap2_pm_debug;
>  extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
> +extern int pm_dbg_regset_save(int reg_set);
> +extern int pm_dbg_regset_init(int reg_set);
>  #else
>  #define omap2_pm_dump(mode, resume, us)		do {} while (0);
>  #define omap2_pm_debug				0
>  #define pm_dbg_update_time(pwrdm, prev) do {} while (0);
> +#define pm_dbg_regset_save(reg_set) do {} while (0);
> +#define pm_dbg_regset_init(reg_set) do {} while (0);
>  #endif /* CONFIG_PM_DEBUG */
>  
>  extern void omap24xx_idle_loop_suspend(void);
> -- 
> 1.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
