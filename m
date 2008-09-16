From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM debug support for 34xx
Date: Tue, 16 Sep 2008 19:26:05 +0300
Message-ID: <87prn4hxb6.fsf@deeprootsystems.com>
References: <1221220151-12812-1-git-send-email-tero.kristo@nokia.com>
	<B71CE868F2BC2847B3F23C5A8EE3943081BA7F@vaebe110.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:13448 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339AbYIPQ0S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 12:26:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1743199fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 09:26:15 -0700 (PDT)
In-Reply-To: <B71CE868F2BC2847B3F23C5A8EE3943081BA7F@vaebe110.NOE.Nokia.com> (Tero Kristo's message of "Tue\, 16 Sep 2008 17\:55\:18 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org

<Tero.Kristo@nokia.com> writes:

> Any comments to this? I have already a new version available of this
> stuff where I have integrated the suspend / next state control to this
> also, and the file structure modified a bit.

Could you mind sending your updated version?  This one no longer
applies cleanly to HEAD.  I would like to give it a test run, then
I'll give you some more feedback.

> Should this be split into several patches for easier handling or
> something? It is getting rather big already (as a patch.)

For me, it's OK as a single patch for now.

Kevin

>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org 
>>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext Tero Kristo
>>Sent: 12 September, 2008 14:49
>>To: linux-omap@vger.kernel.org
>>Subject: [PATCH] PM debug support for 34xx
>>
>>This patch adds a few files to the debug file system for PM 
>>debugging purposes. Enabled with kernel config options 
>>CONFIG_PM_DEBUG and CONFIG_DEBUG_FS. Data available in debug 
>>filesystem after this patch:
>>- State enter counters for power domains (OFF, RET, ON)
>>- State timers for the above (in ns)
>>- PM register dumps with programmable save points
>>- Current power domain states
>>- Interface to set_pwrdm_state()
>>
>>Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>>---
>> arch/arm/mach-omap2/clock.c                   |    2 +
>> arch/arm/mach-omap2/clockdomain.c             |   27 ++
>> arch/arm/mach-omap2/pm-debug.c                |  406 
>>+++++++++++++++++++++++++
>> arch/arm/mach-omap2/pm.c                      |    2 +
>> arch/arm/mach-omap2/pm.h                      |   33 ++-
>> arch/arm/mach-omap2/pm34xx.c                  |    6 +-
>> arch/arm/mach-omap2/powerdomain.c             |   69 +++++
>> arch/arm/plat-omap/include/mach/powerdomain.h |    7 +-
>> 8 files changed, 548 insertions(+), 4 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/clock.c 
>>b/arch/arm/mach-omap2/clock.c index 88c8ef4..a5fc5b0 100644
>>--- a/arch/arm/mach-omap2/clock.c
>>+++ b/arch/arm/mach-omap2/clock.c
>>@@ -39,6 +39,7 @@
>> #include "cm.h"
>> #include "cm-regbits-24xx.h"
>> #include "cm-regbits-34xx.h"
>>+#include "pm.h"
>> 
>> #define MAX_CLOCK_ENABLE_WAIT		100000
>> 
>>@@ -1025,5 +1026,6 @@ void omap2_clk_disable_unused(struct clk *clk)
>> 
>> 	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
>> 	_omap2_clk_disable(clk);
>>+	pm_dbg_clk_state_switch(clk);
>> }
>> #endif
>>diff --git a/arch/arm/mach-omap2/clockdomain.c 
>>b/arch/arm/mach-omap2/clockdomain.c
>>index fa62f14..9670ed1 100644
>>--- a/arch/arm/mach-omap2/clockdomain.c
>>+++ b/arch/arm/mach-omap2/clockdomain.c
>>@@ -36,6 +36,8 @@
>> #include <mach/powerdomain.h>
>> #include <mach/clockdomain.h>
>> 
>>+#include "pm.h"
>>+
>> /* clkdm_list contains all registered struct clockdomains */  
>>static LIST_HEAD(clkdm_list);
>> 
>>@@ -567,6 +569,8 @@ int omap2_clkdm_clk_enable(struct 
>>clockdomain *clkdm, struct clk *clk)
>> 	else
>> 		omap2_clkdm_wakeup(clkdm);
>> 
>>+	pm_dbg_clkdm_state_switch(clkdm);
>>+
>> 	return 0;
>> }
>> 
>>@@ -618,6 +622,29 @@ int omap2_clkdm_clk_disable(struct 
>>clockdomain *clkdm, struct clk *clk)
>> 	else
>> 		omap2_clkdm_sleep(clkdm);
>> 
>>+	pm_dbg_clkdm_state_switch(clkdm);
>>+
>>+	return 0;
>>+}
>>+
>>+#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) #include 
>>+<linux/debugfs.h> #include <linux/seq_file.h> int 
>>+clkdm_dbg_show_counters(struct seq_file *s, void *unused) {
>>+	struct clockdomain *clkdm;
>>+
>>+	list_for_each_entry(clkdm, &clkdm_list, node) {
>>+		if (strcmp(clkdm->name, "emu_clkdm") == 0 ||
>>+			strcmp(clkdm->name, "wkup_clkdm") == 0)
>>+			continue;
>>+		seq_printf(s, "%s->%s (%d)", clkdm->name,
>>+			   clkdm->pwrdm.ptr->name,
>>+			   atomic_read(&clkdm->usecount));
>>+		seq_printf(s, "\n");
>>+	}
>>+
>> 	return 0;
>> }
>> 
>>+#endif
>>diff --git a/arch/arm/mach-omap2/pm-debug.c 
>>b/arch/arm/mach-omap2/pm-debug.c index b00f5f4..380a2a0 100644
>>--- a/arch/arm/mach-omap2/pm-debug.c
>>+++ b/arch/arm/mach-omap2/pm-debug.c
>>@@ -30,6 +30,9 @@
>> #include <mach/clock.h>
>> #include <mach/board.h>
>> 
>>+#include <mach/powerdomain.h>
>>+#include <mach/clockdomain.h>
>>+#include <mach/common.h>
>> #include "prm.h"
>> #include "cm.h"
>> #include "pm.h"
>>@@ -153,4 +156,407 @@ void omap2_pm_dump(int mode, int resume, 
>>unsigned int us)
>> 		printk("%-20s: 0x%08x\n", regs[i].name, regs[i].val);  }
>> 
>>+#ifdef CONFIG_DEBUG_FS
>>+#include <linux/debugfs.h>
>>+#include <linux/seq_file.h>
>>+
>>+static void pm_dbg_regset_store(u32 *ptr);
>>+
>>+struct dentry *pm_dbg_dir;
>>+
>>+static int pm_dbg_init_done;
>>+
>>+enum {
>>+	PM_DBG_STATE_NOW = 0,
>>+	PM_DBG_STATE_PREV,
>>+};
>>+
>>+struct pm_module_def {
>>+	char name[8]; /* Name of the module */
>>+	short type; /* CM or PRM */
>>+	unsigned short offset;
>>+	int low; /* First register address on this module */
>>+	int high; /* Last register address on this module */ };
>>+
>>+#define MOD_CM 0
>>+#define MOD_PRM 1
>>+
>>+static const struct pm_module_def pm_dbg_reg_modules[] = {
>>+	{ "IVA2", MOD_CM, OMAP3430_IVA2_MOD, 0, 0x4c },
>>+	{ "OCP", MOD_CM, OCP_MOD, 0, 0x10 },
>>+	{ "MPU", MOD_CM, MPU_MOD, 4, 0x4c },
>>+	{ "CORE", MOD_CM, CORE_MOD, 0, 0x4c },
>>+	{ "SGX", MOD_CM, OMAP3430ES2_SGX_MOD, 0, 0x4c },
>>+	{ "WKUP", MOD_CM, WKUP_MOD, 0, 0x40 },
>>+	{ "CCR", MOD_CM, PLL_MOD, 0, 0x70 },
>>+	{ "DSS", MOD_CM, OMAP3430_DSS_MOD, 0, 0x4c },
>>+	{ "CAM", MOD_CM, OMAP3430_CAM_MOD, 0, 0x4c },
>>+	{ "PER", MOD_CM, OMAP3430_PER_MOD, 0, 0x4c },
>>+	{ "EMU", MOD_CM, OMAP3430_EMU_MOD, 0x40, 0x54 },
>>+	{ "NEON", MOD_CM, OMAP3430_NEON_MOD, 0x20, 0x48 },
>>+	{ "USB", MOD_CM, OMAP3430ES2_USBHOST_MOD, 0, 0x4c },
>>+
>>+	{ "IVA2", MOD_PRM, OMAP3430_IVA2_MOD, 0x50, 0xfc },
>>+	{ "OCP", MOD_PRM, OCP_MOD, 4, 0x1c },
>>+	{ "MPU", MOD_PRM, MPU_MOD, 0x58, 0xe8 },
>>+	{ "CORE", MOD_PRM, CORE_MOD, 0x58, 0xf8 },
>>+	{ "SGX", MOD_PRM, OMAP3430ES2_SGX_MOD, 0x58, 0xe8 },
>>+	{ "WKUP", MOD_PRM, WKUP_MOD, 0xa0, 0xb0 },
>>+	{ "CCR", MOD_PRM, PLL_MOD, 0x40, 0x70 },
>>+	{ "DSS", MOD_PRM, OMAP3430_DSS_MOD, 0x58, 0xe8 },
>>+	{ "CAM", MOD_PRM, OMAP3430_CAM_MOD, 0x58, 0xe8 },
>>+	{ "PER", MOD_PRM, OMAP3430_PER_MOD, 0x58, 0xe8 },
>>+	{ "EMU", MOD_PRM, OMAP3430_EMU_MOD, 0x58, 0xe4 },
>>+	{ "GLBL", MOD_PRM, OMAP3430_GR_MOD, 0x20, 0xe4 },
>>+	{ "NEON", MOD_PRM, OMAP3430_NEON_MOD, 0x58, 0xe8 },
>>+	{ "USB", MOD_PRM, OMAP3430ES2_USBHOST_MOD, 0x58, 0xe8 },
>>+	{ "", 0, 0, 0, 0 },
>>+};
>>+
>>+#define PM_DBG_MAX_REG_SETS 4
>>+
>>+static void *pm_dbg_reg_set[PM_DBG_MAX_REG_SETS];
>>+
>>+static int pm_dbg_get_regset_size(void) {
>>+	static int regset_size;
>>+
>>+	if (regset_size == 0) {
>>+		int i = 0;
>>+
>>+		while (pm_dbg_reg_modules[i].name[0] != 0) {
>>+			regset_size += pm_dbg_reg_modules[i].high +
>>+				4 - pm_dbg_reg_modules[i].low;
>>+			i++;
>>+		}
>>+	}
>>+	return regset_size;
>>+}
>>+
>>+static int pm_dbg_show_regs(struct seq_file *s, void *unused) {
>>+	int i, j;
>>+	unsigned long val;
>>+	int reg_set = (int)s->private;
>>+	u32 *ptr;
>>+	void *store = NULL;
>>+	int regs;
>>+
>>+	if (reg_set == 0) {
>>+		store = kmalloc(pm_dbg_get_regset_size(), GFP_KERNEL);
>>+		ptr = store;
>>+		pm_dbg_regset_store(ptr);
>>+	} else {
>>+		ptr = pm_dbg_reg_set[reg_set - 1];
>>+	}
>>+
>>+	i = 0;
>>+
>>+	while (pm_dbg_reg_modules[i].name[0] != 0) {
>>+		regs = 0;
>>+		if (pm_dbg_reg_modules[i].type == MOD_CM)
>>+			seq_printf(s, "MOD: CM_%s (%08x)\n",
>>+				pm_dbg_reg_modules[i].name,
>>+				(u32)(OMAP2_CM_BASE +
>>+				pm_dbg_reg_modules[i].offset));
>>+		else
>>+			seq_printf(s, "MOD: PRM_%s (%08x)\n",
>>+				pm_dbg_reg_modules[i].name,
>>+				(u32)(OMAP2_PRM_BASE +
>>+				pm_dbg_reg_modules[i].offset));
>>+
>>+		for (j = pm_dbg_reg_modules[i].low;
>>+			j <= pm_dbg_reg_modules[i].high; j += 4) {
>>+			val = *(ptr++);
>>+			if (val != 0) {
>>+				regs++;
>>+				seq_printf(s, "  %02x => 
>>%08lx", j, val);
>>+				if (regs % 4 == 0)
>>+					seq_printf(s, "\n");
>>+			}
>>+		}
>>+		seq_printf(s, "\n");
>>+		i++;
>>+	}
>>+
>>+	if (store != NULL)
>>+		kfree(store);
>>+
>>+	return 0;
>>+}
>>+
>>+static void pm_dbg_regset_store(u32 *ptr) {
>>+	int i, j;
>>+	u32 val;
>>+
>>+	i = 0;
>>+
>>+	while (pm_dbg_reg_modules[i].name[0] != 0) {
>>+		for (j = pm_dbg_reg_modules[i].low;
>>+			j <= pm_dbg_reg_modules[i].high; j += 4) {
>>+			if (pm_dbg_reg_modules[i].type == MOD_CM)
>>+				val = cm_read_mod_reg(
>>+					
>>pm_dbg_reg_modules[i].offset, j);
>>+			else
>>+				val = prm_read_mod_reg(
>>+					
>>pm_dbg_reg_modules[i].offset, j);
>>+			*(ptr++) = val;
>>+		}
>>+		i++;
>>+	}
>>+}
>>+
>>+int pm_dbg_regset_save(int reg_set)
>>+{
>>+	if (pm_dbg_reg_set[reg_set-1] == NULL)
>>+		return -EINVAL;
>>+
>>+	pm_dbg_regset_store(pm_dbg_reg_set[reg_set-1]);
>>+
>>+	return 0;
>>+}
>>+
>>+static int _pm_dbg_state_switch(struct powerdomain *pwrdm, int flag) {
>>+	s64 t;
>>+	struct timespec now;
>>+	int prev;
>>+	int state;
>>+
>>+	if (pwrdm == NULL)
>>+		return -EINVAL;
>>+
>>+	state = pwrdm_read_pwrst(pwrdm);
>>+
>>+	switch (flag) {
>>+	case PM_DBG_STATE_NOW:
>>+		prev = pwrdm->state;
>>+		break;
>>+	case PM_DBG_STATE_PREV:
>>+		prev = pwrdm_read_prev_pwrst(pwrdm);
>>+		if (pwrdm->state != prev)
>>+			pwrdm->state_counter[prev]++;
>>+		break;
>>+	default:
>>+		return -EINVAL;
>>+	}
>>+
>>+	if (pm_dbg_init_done) {
>>+		/* Update timer for previous state */
>>+		getnstimeofday(&now);
>>+		t = timespec_to_ns(&now);
>>+
>>+		pwrdm->state_timer[prev] += t - pwrdm->timer;
>>+
>>+		pwrdm->timer = t;
>>+
>>+		if (state != prev)
>>+			pwrdm->state_counter[state]++;
>>+	}
>>+
>>+	pwrdm->state = state;
>>+
>>+	return 0;
>>+}
>>+
>>+int pm_dbg_pwrdm_state_switch(struct powerdomain *pwrdm) {
>>+	return _pm_dbg_state_switch(pwrdm, PM_DBG_STATE_NOW); }
>>+
>>+int pm_dbg_clkdm_state_switch(struct clockdomain *clkdm) {
>>+	if (clkdm != NULL && clkdm->pwrdm.ptr != NULL) {
>>+		pwrdm_wait_transition(clkdm->pwrdm.ptr);
>>+		return pm_dbg_pwrdm_state_switch(clkdm->pwrdm.ptr);
>>+	}
>>+
>>+	return -EINVAL;
>>+}
>>+
>>+int pm_dbg_clk_state_switch(struct clk *clk) {
>>+	if (clk != NULL && clk->clkdm.ptr != NULL)
>>+		return pm_dbg_clkdm_state_switch(clk->clkdm.ptr);
>>+	return -EINVAL;
>>+}
>>+
>>+static int pm_dbg_pre_suspend_cb(struct powerdomain *pwrdm) {
>>+	pwrdm_clear_all_prev_pwrst(pwrdm);
>>+	_pm_dbg_state_switch(pwrdm, PM_DBG_STATE_NOW);
>>+	return 0;
>>+}
>>+
>>+static int pm_dbg_post_suspend_cb(struct powerdomain *pwrdm) {
>>+	_pm_dbg_state_switch(pwrdm, PM_DBG_STATE_PREV);
>>+	return 0;
>>+}
>>+
>>+int pm_dbg_pre_suspend(void)
>>+{
>>+	pwrdm_for_each(pm_dbg_pre_suspend_cb);
>>+	return 0;
>>+}
>>+
>>+int pm_dbg_post_suspend(void)
>>+{
>>+	pwrdm_for_each(pm_dbg_post_suspend_cb);
>>+	return 0;
>>+}
>>+
>>+enum {
>>+	DEBUG_FILE_COUNTERS = 0,
>>+	DEBUG_FILE_TIMERS,
>>+};
>>+
>>+int pm_dbg_show_counters(struct seq_file *s, void *unused) {
>>+	pwrdm_dbg_show_counters(s, unused);
>>+	clkdm_dbg_show_counters(s, unused);
>>+
>>+	return 0;
>>+}
>>+
>>+static int pm_dbg_open(struct inode *inode, struct file *file) {
>>+	switch ((int)inode->i_private) {
>>+	case DEBUG_FILE_COUNTERS:
>>+		return single_open(file, pm_dbg_show_counters,
>>+			&inode->i_private);
>>+	case DEBUG_FILE_TIMERS:
>>+	default:
>>+		return single_open(file, pwrdm_dbg_show_timers,
>>+			&inode->i_private);
>>+	};
>>+}
>>+
>>+static int pm_dbg_reg_open(struct inode *inode, struct file *file) {
>>+	return single_open(file, pm_dbg_show_regs, inode->i_private); }
>>+
>>+static const struct file_operations debug_fops = {
>>+	.open           = pm_dbg_open,
>>+	.read           = seq_read,
>>+	.llseek         = seq_lseek,
>>+	.release        = single_release,
>>+};
>>+
>>+static const struct file_operations debug_reg_fops = {
>>+	.open           = pm_dbg_reg_open,
>>+	.read           = seq_read,
>>+	.llseek         = seq_lseek,
>>+	.release        = single_release,
>>+};
>>+
>>+static int pm_dbg_get_state(void *data, u64 *val) {
>>+	*val = pwrdm_read_pwrst((struct powerdomain *)data);
>>+	return 0;
>>+}
>>+static int pm_dbg_set_state(void *data, u64 val) {
>>+	set_pwrdm_state((struct powerdomain *)data, val);
>>+	return 0;
>>+}
>>+DEFINE_SIMPLE_ATTRIBUTE(debug_pwrdm_fops, pm_dbg_get_state, 
>>+pm_dbg_set_state, "%llu\n");
>>+
>>+int pm_dbg_regset_init(int reg_set)
>>+{
>>+	char name[2];
>>+
>>+	if (reg_set < 1 || reg_set > PM_DBG_MAX_REG_SETS ||
>>+		pm_dbg_reg_set[reg_set-1] != NULL)
>>+		return -EINVAL;
>>+
>>+	pm_dbg_reg_set[reg_set-1] =
>>+		kmalloc(pm_dbg_get_regset_size(), GFP_KERNEL);
>>+
>>+	if (pm_dbg_reg_set[reg_set-1] == NULL)
>>+		return -ENOMEM;
>>+
>>+	if (pm_dbg_dir != NULL) {
>>+		sprintf(name, "%d", reg_set);
>>+
>>+		(void) debugfs_create_file(name, S_IRUGO,
>>+			pm_dbg_dir, (void *)reg_set, &debug_reg_fops);
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+static int __init pwrdms_setup(struct powerdomain *pwrdm) {
>>+	s64 t;
>>+	int i;
>>+	struct timespec now;
>>+
>>+	getnstimeofday(&now);
>>+	t = timespec_to_ns(&now);
>>+
>>+	for (i = 0; i < 4; i++) {
>>+		pwrdm->state_counter[i] = 0;
>>+		pwrdm->state_timer[i] = 0;
>>+	}
>>+
>>+	pwrdm_wait_transition(pwrdm);
>>+	pwrdm->state = pwrdm_read_pwrst(pwrdm);
>>+	pwrdm->state_counter[pwrdm->state] = 1;
>>+	pwrdm->timer = t;
>>+
>>+	(void) debugfs_create_file(pwrdm->name, S_IRUGO|S_IWUSR,
>>+		pm_dbg_dir, pwrdm, &debug_pwrdm_fops);
>>+
>>+	return 0;
>>+}
>>+
>>+static int __init pm_dbg_init(void)
>>+{
>>+	int i;
>>+	struct dentry *d;
>>+	char name[2];
>>+
>>+	printk(KERN_INFO "pm_dbg_init()\n");
>>+
>>+	d = debugfs_create_dir("pm_debug", NULL);
>>+	if (IS_ERR(d))
>>+		return PTR_ERR(d);
>>+
>>+	(void) debugfs_create_file("count", S_IRUGO,
>>+		d, (void *)DEBUG_FILE_COUNTERS, &debug_fops);
>>+	(void) debugfs_create_file("time", S_IRUGO,
>>+		d, (void *)DEBUG_FILE_TIMERS, &debug_fops);
>>+
>>+	pm_dbg_dir = debugfs_create_dir("pwrdm_ctrl", d);
>>+	if (IS_ERR(pm_dbg_dir))
>>+		return PTR_ERR(pm_dbg_dir);
>>+
>>+	pwrdm_for_each(pwrdms_setup);
>>+
>>+	pm_dbg_dir = debugfs_create_dir("registers", d);
>>+	if (IS_ERR(pm_dbg_dir))
>>+		return PTR_ERR(pm_dbg_dir);
>>+
>>+	(void) debugfs_create_file("current", S_IRUGO,
>>+		pm_dbg_dir, (void *)0, &debug_reg_fops);
>>+
>>+	for (i = 0; i < PM_DBG_MAX_REG_SETS; i++)
>>+		if (pm_dbg_reg_set[i] != NULL) {
>>+			sprintf(name, "%d", i+1);
>>+			(void) debugfs_create_file(name, S_IRUGO,
>>+				pm_dbg_dir, (void *)(i+1), 
>>&debug_reg_fops);
>>+
>>+		}
>>+
>>+	pm_dbg_init_done = 1;
>>+
>>+	return 0;
>>+}
>>+late_initcall(pm_dbg_init);
>>+#endif
>>+
>> #endif
>>diff --git a/arch/arm/mach-omap2/pm.c 
>>b/arch/arm/mach-omap2/pm.c index b8aae08..c063565 100644
>>--- a/arch/arm/mach-omap2/pm.c
>>+++ b/arch/arm/mach-omap2/pm.c
>>@@ -28,6 +28,8 @@
>> #include <asm/mach/time.h>
>> #include <asm/atomic.h>
>> 
>>+#include <mach/powerdomain.h>
>>+
>> #include <mach/pm.h>
>> #include "pm.h"
>> 
>>diff --git a/arch/arm/mach-omap2/pm.h 
>>b/arch/arm/mach-omap2/pm.h index 60a386d..19da5c7 100644
>>--- a/arch/arm/mach-omap2/pm.h
>>+++ b/arch/arm/mach-omap2/pm.h
>>@@ -28,7 +28,36 @@ extern void omap2_allow_sleep(void);  
>>extern void omap2_pm_dump(int mode, int resume, unsigned int 
>>us);  extern int omap2_pm_debug;  #else
>>-#define omap2_pm_dump(mode, resume, us)		do {} while (0);
>>-#define omap2_pm_debug				0
>>+#define omap2_pm_dump(mode, resume, us) do {} while (0); #define 
>>+omap2_pm_debug 0 #endif
>>+
>>+#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) struct 
>>+seq_file; struct clk; struct clockdomain; struct powerdomain; extern 
>>+int pm_dbg_pwrdm_state_switch(struct powerdomain *pwrdm); extern int 
>>+pm_dbg_clkdm_state_switch(struct clockdomain *clkdm); extern int 
>>+pm_dbg_clk_state_switch(struct clk *clk); extern int 
>>+pm_dbg_pre_suspend(void); extern int 
>>pm_dbg_post_suspend(void); extern 
>>+int pm_dbg_regset_save(int reg_set); extern int 
>>pm_dbg_regset_init(int 
>>+reg_set); extern int pwrdm_dbg_show_counters(struct seq_file *s, void 
>>+*unused); extern int pwrdm_dbg_show_timers(struct seq_file *s, void 
>>+*unused); extern int clkdm_dbg_show_counters(struct seq_file *s, void 
>>+*unused); extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 
>>+state); #else #define pm_dbg_pwrdm_state_switch(domain) do; while (0) 
>>+#define pm_dbg_clkdm_state_switch(domain) do; while (0) #define 
>>+pm_dbg_clk_state_switch(domain) do; while (0) #define 
>>+pm_dbg_pre_suspend() do; while (0) #define pm_dbg_post_suspend() do; 
>>+while (0) #define pm_dbg_regset_save(reg_set) do; while (0) #define 
>>+pm_dbg_regset_init(reg_set) do; while (0) #define 
>>+pwrdm_dbg_show_counters(s,unused) do; while (0) #define 
>>+pwrdm_dbg_show_timers(s,unused) do; while (0) #define 
>>+clkdm_dbg_show_counters(s,unused) do; while (0)
>> #endif /* CONFIG_PM_DEBUG */
>> #endif
>>diff --git a/arch/arm/mach-omap2/pm34xx.c 
>>b/arch/arm/mach-omap2/pm34xx.c index 8b12812..d2694f2 100644
>>--- a/arch/arm/mach-omap2/pm34xx.c
>>+++ b/arch/arm/mach-omap2/pm34xx.c
>>@@ -212,6 +212,8 @@ static void omap_sram_idle(void)
>> 	disable_smartreflex(SR1);
>> 	disable_smartreflex(SR2);
>> 
>>+	pm_dbg_pre_suspend();
>>+
>> 	omap2_gpio_prepare_for_retention();
>> 
>> 	/* Disable GPIO clocks if allowed */
>>@@ -230,6 +232,8 @@ static void omap_sram_idle(void)
>> 
>> 	omap2_gpio_resume_after_retention();
>> 
>>+	pm_dbg_post_suspend();
>>+
>> 	/* Enable smartreflex after WFI */
>> 	enable_smartreflex(SR1);
>> 	enable_smartreflex(SR2);
>>@@ -306,7 +310,7 @@ static int _clkdm_allow_idle(struct 
>>powerdomain *pwrdm,
>> /* This sets pwrdm state (other than mpu & core. Currently only ON &
>>  * RET are supported. Function is assuming that clkdm doesn't have
>>  * hw_sup mode enabled. */
>>-static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>>+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>> {
>> 	u32 cur_state;
>> 	int ret = 0;
>>diff --git a/arch/arm/mach-omap2/powerdomain.c 
>>b/arch/arm/mach-omap2/powerdomain.c
>>index 73e2971..097d5c4 100644
>>--- a/arch/arm/mach-omap2/powerdomain.c
>>+++ b/arch/arm/mach-omap2/powerdomain.c
>>@@ -1110,4 +1110,73 @@ int pwrdm_wait_transition(struct 
>>powerdomain *pwrdm)
>> 	return 0;
>> }
>> 
>>+#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
>> 
>>+#include <linux/debugfs.h>
>>+#include <linux/seq_file.h>
>>+#include "pm.h"
>>+
>>+static const char pwrdm_state_names[][4] = {
>>+	"OFF",
>>+	"RET",
>>+	"INA",
>>+	"ON"
>>+};
>>+
>>+int pwrdm_dbg_show_counters(struct seq_file *s, void *unused) {
>>+	int i;
>>+	struct powerdomain *pwrdm;
>>+	unsigned long flags;
>>+
>>+	read_lock_irqsave(&pwrdm_rwlock, flags);
>>+	list_for_each_entry(pwrdm, &pwrdm_list, node) {
>>+		if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
>>+			strcmp(pwrdm->name, "wkup_pwrdm") == 0)
>>+			continue;
>>+		if (pwrdm->state != pwrdm_read_pwrst(pwrdm))
>>+			printk(KERN_ERR "pwrdm state 
>>mismatch(%s) %d != %d\n",
>>+			       pwrdm->name, pwrdm->state,
>>+			       pwrdm_read_pwrst(pwrdm));
>>+		seq_printf(s, "%s (%s)", pwrdm->name,
>>+			   pwrdm_state_names[pwrdm->state]);
>>+		for (i = 0; i < 4; i++) {
>>+			seq_printf(s, ",%s:%d", pwrdm_state_names[i],
>>+				pwrdm->state_counter[i]);
>>+		}
>>+		seq_printf(s, "\n");
>>+	}
>>+	read_unlock_irqrestore(&pwrdm_rwlock, flags);
>>+
>>+	return 0;
>>+}
>>+
>>+int pwrdm_dbg_show_timers(struct seq_file *s, void *unused) {
>>+	int i;
>>+	struct powerdomain *pwrdm;
>>+	unsigned long flags;
>>+
>>+	read_lock_irqsave(&pwrdm_rwlock, flags);
>>+	list_for_each_entry(pwrdm, &pwrdm_list, node) {
>>+		if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
>>+			strcmp(pwrdm->name, "wkup_pwrdm") == 0)
>>+			continue;
>>+
>>+		/* Update timer for current state */
>>+		pm_dbg_pwrdm_state_switch(pwrdm);
>>+
>>+		seq_printf(s, "%s (%s)", pwrdm->name,
>>+			pwrdm_state_names[pwrdm->state]);
>>+		for (i = 0; i < 4; i++) {
>>+			seq_printf(s, ",%s:%lld", pwrdm_state_names[i],
>>+				pwrdm->state_timer[i]);
>>+		}
>>+		seq_printf(s, "\n");
>>+	}
>>+	read_unlock_irqrestore(&pwrdm_rwlock, flags);
>>+
>>+	return 0;
>>+}
>>+
>>+#endif
>>diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h 
>>b/arch/arm/plat-omap/include/mach/powerdomain.h
>>index 4948cb7..8785cb7 100644
>>--- a/arch/arm/plat-omap/include/mach/powerdomain.h
>>+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
>>@@ -116,7 +116,12 @@ struct powerdomain {
>> 	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
>> 
>> 	struct list_head node;
>>-
>>+#ifdef CONFIG_PM_DEBUG
>>+	int state;
>>+	int state_counter[4];
>>+	s64 timer;
>>+	s64 state_timer[4];
>>+#endif
>> };
>> 
>> 
>>--
>>1.5.4.3
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe 
>>linux-omap" in the body of a message to 
>>majordomo@vger.kernel.org More majordomo info at  
>>http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
