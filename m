From: jean.pihet@newoldbits.com
Subject: [PATCH 12/13] OMAP2+: PM: export functions and variables to PM modules
Date: Wed, 18 May 2011 19:32:29 +0200
Message-ID: <1305739950-11695-13-git-send-email-j-pihet@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64844 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933340Ab1ERRdD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:33:03 -0400
Received: by gxk21 with SMTP id 21so621800gxk.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:33:02 -0700 (PDT)
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Addition of EXPORT_SYMBOL for functions and variables used by
the code in PM modules.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/kernel/setup.c            |    1 +
 arch/arm/kernel/smp_tlb.c          |    2 ++
 arch/arm/mach-omap2/clockdomain.c  |    7 +++++++
 arch/arm/mach-omap2/cm2xxx_3xxx.c  |    7 +++++++
 arch/arm/mach-omap2/control.c      |   13 +++++++++++++
 arch/arm/mach-omap2/gpmc.c         |    2 ++
 arch/arm/mach-omap2/id.c           |    1 +
 arch/arm/mach-omap2/irq.c          |    7 +++++++
 arch/arm/mach-omap2/pm-debug.c     |    1 +
 arch/arm/mach-omap2/pm.c           |    9 +++++++++
 arch/arm/mach-omap2/pm34xx.c       |    3 +++
 arch/arm/mach-omap2/powerdomain.c  |   16 ++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    6 ++++++
 arch/arm/mach-omap2/sdrc.c         |    2 ++
 arch/arm/mach-omap2/serial.c       |    5 +++++
 arch/arm/mach-omap2/timer-gp.c     |    1 +
 arch/arm/plat-omap/common.c        |    1 +
 arch/arm/plat-omap/dma.c           |    3 +++
 arch/arm/plat-omap/gpio.c          |    4 ++++
 arch/arm/plat-omap/omap-pm-noop.c  |    2 ++
 arch/arm/plat-omap/omap_device.c   |    1 +
 arch/arm/plat-omap/sram.c          |    2 ++
 22 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 006c1e8..73ad7ae 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -438,6 +438,7 @@ void cpu_init(void)
 	      PLC (PSR_F_BIT | PSR_I_BIT | SVC_MODE)
 	    : "r14");
 }
+EXPORT_SYMBOL(cpu_init);
 
 static struct machine_desc * __init setup_machine(unsigned int nr)
 {
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index 7dcb352..2cfdefa 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -9,6 +9,7 @@
  */
 #include <linux/preempt.h>
 #include <linux/smp.h>
+#include <linux/module.h>
 
 #include <asm/smp_plat.h>
 #include <asm/tlbflush.h>
@@ -83,6 +84,7 @@ void flush_tlb_all(void)
 	else
 		local_flush_tlb_all();
 }
+EXPORT_SYMBOL(flush_tlb_all);
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 6cb6c03..fd38dd3 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -331,6 +331,7 @@ struct clockdomain *clkdm_lookup(const char *name)
 
 	return clkdm;
 }
+EXPORT_SYMBOL(clkdm_lookup);
 
 /**
  * clkdm_for_each - call function on each registered clockdomain
@@ -363,6 +364,7 @@ int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
 
 	return ret;
 }
+EXPORT_SYMBOL(clkdm_for_each);
 
 
 /**
@@ -379,6 +381,7 @@ struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm)
 
 	return clkdm->pwrdm.ptr;
 }
+EXPORT_SYMBOL(clkdm_get_pwrdm);
 
 
 /* Hardware clockdomain control */
@@ -425,6 +428,7 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 
 	return ret;
 }
+EXPORT_SYMBOL(clkdm_add_wkdep);
 
 /**
  * clkdm_del_wkdep - remove a wakeup dependency from clkdm2 to clkdm1
@@ -706,6 +710,7 @@ int clkdm_sleep(struct clockdomain *clkdm)
 
 	return arch_clkdm->clkdm_sleep(clkdm);
 }
+EXPORT_SYMBOL(clkdm_sleep);
 
 /**
  * clkdm_wakeup - force clockdomain wakeup transition
@@ -765,6 +770,7 @@ void clkdm_allow_idle(struct clockdomain *clkdm)
 	arch_clkdm->clkdm_allow_idle(clkdm);
 	pwrdm_clkdm_state_switch(clkdm);
 }
+EXPORT_SYMBOL(clkdm_allow_idle);
 
 /**
  * clkdm_deny_idle - disable hwsup idle transitions for clkdm
@@ -794,6 +800,7 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
 
 	arch_clkdm->clkdm_deny_idle(clkdm);
 }
+EXPORT_SYMBOL(clkdm_deny_idle);
 
 
 /* Clockdomain-to-clock framework interface code */
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index 38830d8..6516e30 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -41,11 +41,13 @@ u32 omap2_cm_read_mod_reg(s16 module, u16 idx)
 {
 	return __raw_readl(cm_base + module + idx);
 }
+EXPORT_SYMBOL(omap2_cm_read_mod_reg);
 
 void omap2_cm_write_mod_reg(u32 val, s16 module, u16 idx)
 {
 	__raw_writel(val, cm_base + module + idx);
 }
+EXPORT_SYMBOL(omap2_cm_write_mod_reg);
 
 /* Read-modify-write a register in a CM module. Caller must lock */
 u32 omap2_cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
@@ -59,16 +61,19 @@ u32 omap2_cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
 
 	return v;
 }
+EXPORT_SYMBOL(omap2_cm_rmw_mod_reg_bits);
 
 u32 omap2_cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
 	return omap2_cm_rmw_mod_reg_bits(bits, bits, module, idx);
 }
+EXPORT_SYMBOL(omap2_cm_set_mod_reg_bits);
 
 u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
 	return omap2_cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
 }
+EXPORT_SYMBOL(omap2_cm_clear_mod_reg_bits);
 
 /*
  *
@@ -431,6 +436,7 @@ void omap3_cm_save_context(void)
 		omap2_cm_read_mod_reg(OMAP3430_CCR_MOD,
 				      OMAP3_CM_CLKOUT_CTRL_OFFSET);
 }
+EXPORT_SYMBOL(omap3_cm_save_context);
 
 void omap3_cm_restore_context(void)
 {
@@ -554,4 +560,5 @@ void omap3_cm_restore_context(void)
 	omap2_cm_write_mod_reg(cm_context.cm_clkout_ctrl, OMAP3430_CCR_MOD,
 			       OMAP3_CM_CLKOUT_CTRL_OFFSET);
 }
+EXPORT_SYMBOL(omap3_cm_restore_context);
 #endif
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 23b83bd..b91aded 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -93,6 +93,7 @@ struct omap3_scratchpad_sdrc_block {
 };
 
 void *omap3_secure_ram_storage;
+EXPORT_SYMBOL(omap3_secure_ram_storage);
 
 /*
  * This is used to store ARM registers in SDRAM before attempting
@@ -101,6 +102,7 @@ void *omap3_secure_ram_storage;
  * during the restore path.
  */
 u32 omap3_arm_context[128];
+EXPORT_SYMBOL(omap3_arm_context);
 
 struct omap3_control_regs {
 	u32 sysconfig;
@@ -171,31 +173,37 @@ u8 omap_ctrl_readb(u16 offset)
 {
 	return __raw_readb(OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_readb);
 
 u16 omap_ctrl_readw(u16 offset)
 {
 	return __raw_readw(OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_readw);
 
 u32 omap_ctrl_readl(u16 offset)
 {
 	return __raw_readl(OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_readl);
 
 void omap_ctrl_writeb(u8 val, u16 offset)
 {
 	__raw_writeb(val, OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_writeb);
 
 void omap_ctrl_writew(u16 val, u16 offset)
 {
 	__raw_writew(val, OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_writew);
 
 void omap_ctrl_writel(u32 val, u16 offset)
 {
 	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_writel);
 
 /*
  * On OMAP4 control pad are not addressable from control
@@ -403,6 +411,7 @@ void omap3_save_scratchpad_contents(u32 public_restore_ptr,
 		scratchpad_contents.sdrc_block_offset +
 		sizeof(sdrc_block_contents), &arm_context_addr, 4);
 }
+EXPORT_SYMBOL(omap3_save_scratchpad_contents);
 
 void omap3_control_save_context(void)
 {
@@ -461,6 +470,7 @@ void omap3_control_save_context(void)
 		omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_SYSNIRQ);
 	return;
 }
+EXPORT_SYMBOL(omap3_control_save_context);
 
 void omap3_control_restore_context(void)
 {
@@ -519,6 +529,7 @@ void omap3_control_restore_context(void)
 			 OMAP343X_CONTROL_PADCONF_SYSNIRQ);
 	return;
 }
+EXPORT_SYMBOL(omap3_control_restore_context);
 
 void omap3630_ctrl_disable_rta(void)
 {
@@ -526,6 +537,7 @@ void omap3630_ctrl_disable_rta(void)
 		return;
 	omap_ctrl_writel(OMAP36XX_RTA_DISABLE, OMAP36XX_CONTROL_MEM_RTA_CTRL);
 }
+EXPORT_SYMBOL(omap3630_ctrl_disable_rta);
 
 /**
  * omap3_ctrl_save_padconf - save padconf registers to scratchpad RAM
@@ -553,5 +565,6 @@ int omap3_ctrl_save_padconf(void)
 
 	return 0;
 }
+EXPORT_SYMBOL(omap3_ctrl_save_padconf);
 
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 130034b..55618bb 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -804,6 +804,7 @@ void omap3_gpmc_save_context(void)
 		}
 	}
 }
+EXPORT_SYMBOL(omap3_gpmc_save_context);
 
 void omap3_gpmc_restore_context(void)
 {
@@ -835,6 +836,7 @@ void omap3_gpmc_restore_context(void)
 		}
 	}
 }
+EXPORT_SYMBOL(omap3_gpmc_restore_context);
 #endif /* CONFIG_ARCH_OMAP3 */
 
 /**
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 2537090..62cbede 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -32,6 +32,7 @@ static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
 
 u32 omap3_features;
+EXPORT_SYMBOL(omap3_features);
 
 unsigned int omap_rev(void)
 {
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 70528ea..5b52b5b 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <mach/hardware.h>
 #include <asm/mach/irq.h>
 
@@ -120,6 +121,7 @@ int omap_irq_pending(void)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(omap_irq_pending);
 
 static __init void
 omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
@@ -206,6 +208,7 @@ void omap_intc_save_context(void)
 				(0x20 * i));
 	}
 }
+EXPORT_SYMBOL(omap_intc_save_context);
 
 void omap_intc_restore_context(void)
 {
@@ -232,12 +235,14 @@ void omap_intc_restore_context(void)
 	}
 	/* MIRs are saved and restore with other PRCM registers */
 }
+EXPORT_SYMBOL(omap_intc_restore_context);
 
 void omap3_intc_suspend(void)
 {
 	/* A pending interrupt would prevent OMAP from entering suspend */
 	omap_ack_irq(0);
 }
+EXPORT_SYMBOL(omap3_intc_suspend);
 
 void omap3_intc_prepare_idle(void)
 {
@@ -247,10 +252,12 @@ void omap3_intc_prepare_idle(void)
 	 */
 	intc_bank_write_reg(0, &irq_banks[0], INTC_SYSCONFIG);
 }
+EXPORT_SYMBOL(omap3_intc_prepare_idle);
 
 void omap3_intc_resume_idle(void)
 {
 	/* Re-enable autoidle */
 	intc_bank_write_reg(1, &irq_banks[0], INTC_SYSCONFIG);
 }
+EXPORT_SYMBOL(omap3_intc_resume_idle);
 #endif /* CONFIG_ARCH_OMAP3 */
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 4e81e8d..fd93bc3 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -157,6 +157,7 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 	for (i = 0; i < reg_count; i++)
 		printk(KERN_INFO "%-20s: 0x%08x\n", regs[i].name, regs[i].val);
 }
+EXPORT_SYMBOL(omap2_pm_dump);
 
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index ab69c5a..323870f 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -31,6 +31,7 @@
 static struct omap_device_pm_latency *pm_lats;
 #if defined(CONFIG_PM) && defined(CONFIG_CPU_IDLE)
 struct cpuidle_params *cpuidle_params_override_table;
+EXPORT_SYMBOL(cpuidle_params_override_table);
 #endif
 
 #ifdef CONFIG_PM_DEBUG
@@ -38,9 +39,16 @@ u32 enable_off_mode;
 EXPORT_SYMBOL(enable_off_mode);
 
 int omap2_pm_debug;
+EXPORT_SYMBOL(omap2_pm_debug);
+
 u32 sleep_while_idle;
+EXPORT_SYMBOL(sleep_while_idle);
+
 u32 wakeup_timer_seconds;
+EXPORT_SYMBOL(wakeup_timer_seconds);
+
 u32 wakeup_timer_milliseconds;
+EXPORT_SYMBOL(wakeup_timer_milliseconds);
 #endif
 
 static struct device *mpu_dev;
@@ -176,6 +184,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 err:
 	return ret;
 }
+EXPORT_SYMBOL(omap_set_pwrdm_state);
 
 /*
  * This API is to be called during init to put the various voltage
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index dd36e6d..cd5530f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -806,6 +806,7 @@ void omap3_pm_off_mode_enable(int enable)
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 	}
 }
+EXPORT_SYMBOL(omap3_pm_off_mode_enable);
 
 int omap3_pm_get_suspend_state(struct powerdomain *pwrdm)
 {
@@ -817,6 +818,7 @@ int omap3_pm_get_suspend_state(struct powerdomain *pwrdm)
 	}
 	return -EINVAL;
 }
+EXPORT_SYMBOL(omap3_pm_get_suspend_state);
 
 int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
 {
@@ -830,6 +832,7 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
 	}
 	return -EINVAL;
 }
+EXPORT_SYMBOL(omap3_pm_set_suspend_state);
 
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 93a17c8..ec7d1b2 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -247,6 +247,7 @@ struct powerdomain *pwrdm_lookup(const char *name)
 
 	return pwrdm;
 }
+EXPORT_SYMBOL(pwrdm_lookup);
 
 /**
  * pwrdm_for_each - call function on each registered clockdomain
@@ -275,6 +276,7 @@ int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
 
 	return ret;
 }
+EXPORT_SYMBOL(pwrdm_for_each);
 
 /**
  * pwrdm_add_clkdm - add a clockdomain to a powerdomain
@@ -391,6 +393,7 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
 
 	return ret;
 }
+EXPORT_SYMBOL(pwrdm_for_each_clkdm);
 
 /**
  * pwrdm_get_mem_bank_count - get number of memory banks in this powerdomain
@@ -406,6 +409,7 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
 
 	return pwrdm->banks;
 }
+EXPORT_SYMBOL(pwrdm_get_mem_bank_count);
 
 /**
  * pwrdm_set_next_pwrst - set next powerdomain power state
@@ -441,6 +445,7 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 
 	return ret;
 }
+EXPORT_SYMBOL(pwrdm_set_next_pwrst);
 
 /**
  * pwrdm_read_next_pwrst - get next powerdomain power state
@@ -462,6 +467,7 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 
 	return ret;
 }
+EXPORT_SYMBOL(pwrdm_read_next_pwrst);
 
 /**
  * pwrdm_read_pwrst - get current powerdomain power state
@@ -483,6 +489,7 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
 
 	return ret;
 }
+EXPORT_SYMBOL(pwrdm_read_pwrst);
 
 /**
  * pwrdm_read_prev_pwrst - get previous powerdomain power state
@@ -504,6 +511,7 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 
 	return ret;
 }
+EXPORT_SYMBOL(pwrdm_read_prev_pwrst);
 
 /**
  * pwrdm_set_logic_retst - set powerdomain logic power state upon retention
@@ -534,6 +542,7 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 
 	return ret;
 }
+EXPORT_SYMBOL(pwrdm_set_logic_retst);
 
 /**
  * pwrdm_set_mem_onst - set memory power state while powerdomain ON
@@ -609,6 +618,7 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 
 	return ret;
 }
+EXPORT_SYMBOL(pwrdm_set_mem_retst);
 
 /**
  * pwrdm_read_logic_pwrst - get current powerdomain logic retention power state
@@ -788,6 +798,7 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 
 	return ret;
 }
+EXPORT_SYMBOL(pwrdm_clear_all_prev_pwrst);
 
 /**
  * pwrdm_enable_hdwr_sar - enable automatic hardware SAR for a pwrdm
@@ -818,6 +829,7 @@ int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
 
 	return ret;
 }
+EXPORT_SYMBOL(pwrdm_enable_hdwr_sar);
 
 /**
  * pwrdm_disable_hdwr_sar - disable automatic hardware SAR for a pwrdm
@@ -860,6 +872,7 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
 {
 	return (pwrdm && pwrdm->flags & PWRDM_HAS_HDWR_SAR) ? 1 : 0;
 }
+EXPORT_SYMBOL(pwrdm_has_hdwr_sar);
 
 /**
  * pwrdm_set_lowpwrstchange - Request a low power state change
@@ -917,6 +930,7 @@ int pwrdm_state_switch(struct powerdomain *pwrdm)
 {
 	return _pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
 }
+EXPORT_SYMBOL(pwrdm_state_switch);
 
 int pwrdm_clkdm_state_switch(struct clockdomain *clkdm)
 {
@@ -933,12 +947,14 @@ int pwrdm_pre_transition(void)
 	pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
 	return 0;
 }
+EXPORT_SYMBOL(pwrdm_pre_transition);
 
 int pwrdm_post_transition(void)
 {
 	pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
 	return 0;
 }
+EXPORT_SYMBOL(pwrdm_post_transition);
 
 /**
  * pwrdm_get_context_loss_count - get powerdomain's context loss count
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 051213f..009f393 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -29,11 +29,13 @@ u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
 {
 	return __raw_readl(prm_base + module + idx);
 }
+EXPORT_SYMBOL(omap2_prm_read_mod_reg);
 
 void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
 {
 	__raw_writel(val, prm_base + module + idx);
 }
+EXPORT_SYMBOL(omap2_prm_write_mod_reg);
 
 /* Read-modify-write a register in a PRM module. Caller must lock */
 u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
@@ -47,6 +49,7 @@ u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
 
 	return v;
 }
+EXPORT_SYMBOL(omap2_prm_rmw_mod_reg_bits);
 
 /* Read a PRM register, AND it, and shift the result down to bit 0 */
 u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
@@ -59,16 +62,19 @@ u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
 
 	return v;
 }
+EXPORT_SYMBOL(omap2_prm_read_mod_bits_shift);
 
 u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
 	return omap2_prm_rmw_mod_reg_bits(bits, bits, module, idx);
 }
+EXPORT_SYMBOL(omap2_prm_set_mod_reg_bits);
 
 u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
 	return omap2_prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
 }
+EXPORT_SYMBOL(omap2_prm_clear_mod_reg_bits);
 
 
 /**
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index da6f3a6..6096749 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -33,6 +33,7 @@
 static struct omap_sdrc_params *sdrc_init_params_cs0, *sdrc_init_params_cs1;
 
 void __iomem *omap2_sdrc_base;
+EXPORT_SYMBOL(omap2_sdrc_base);
 void __iomem *omap2_sms_base;
 
 struct omap2_sms_regs {
@@ -65,6 +66,7 @@ void omap2_sms_restore_context(void)
 {
 	sms_write_reg(sms_context.sms_sysconfig, SMS_SYSCONFIG);
 }
+EXPORT_SYMBOL(omap2_sms_restore_context);
 
 /**
  * omap2_sdrc_get_params - return SDRC register values for a given clock rate
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 1ac361b..cd0a7e9 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -400,6 +400,7 @@ void omap_uart_prepare_idle(int num)
 		}
 	}
 }
+EXPORT_SYMBOL(omap_uart_prepare_idle);
 
 void omap_uart_resume_idle(int num)
 {
@@ -424,6 +425,7 @@ void omap_uart_resume_idle(int num)
 		}
 	}
 }
+EXPORT_SYMBOL(omap_uart_resume_idle);
 
 void omap_uart_prepare_suspend(void)
 {
@@ -433,6 +435,7 @@ void omap_uart_prepare_suspend(void)
 		omap_uart_allow_sleep(uart);
 	}
 }
+EXPORT_SYMBOL(omap_uart_prepare_suspend);
 
 int omap_uart_can_sleep(void)
 {
@@ -454,6 +457,7 @@ int omap_uart_can_sleep(void)
 
 	return can_sleep;
 }
+EXPORT_SYMBOL(omap_uart_can_sleep);
 
 /**
  * omap_uart_interrupt()
@@ -571,6 +575,7 @@ void omap_uart_enable_irqs(int enable)
 		}
 	}
 }
+EXPORT_SYMBOL(omap_uart_enable_irqs);
 
 static ssize_t sleep_timeout_show(struct device *dev,
 				  struct device_attribute *attr,
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 3b9cf85..d13656a 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -54,6 +54,7 @@ static struct clock_event_device clockevent_gpt;
 static u8 __initdata gptimer_id = 1;
 static u8 __initdata inited;
 struct omap_dm_timer *gptimer_wakeup;
+EXPORT_SYMBOL(gptimer_wakeup);
 
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index d9f10a3..036235c 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -54,6 +54,7 @@ const void *__init __omap_get_config(u16 tag, size_t len, int nr)
 {
         return get_config(tag, len, nr, NULL);
 }
+EXPORT_SYMBOL(__omap_get_config);
 
 const void *__init omap_get_var_config(u16 tag, size_t *len)
 {
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c22217c..7dd4150 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1092,6 +1092,7 @@ int omap_dma_running(void)
 
 	return 0;
 }
+EXPORT_SYMBOL(omap_dma_running);
 
 /*
  * lch_queue DMA will start right after lch_head one is finished.
@@ -1945,6 +1946,7 @@ void omap_dma_global_context_save(void)
 		p->dma_read(OCP_SYSCONFIG, 0);
 	omap_dma_global_context.dma_gcr = p->dma_read(GCR, 0);
 }
+EXPORT_SYMBOL(omap_dma_global_context_save);
 
 void omap_dma_global_context_restore(void)
 {
@@ -1963,6 +1965,7 @@ void omap_dma_global_context_restore(void)
 		if (dma_chan[ch].dev_id != -1)
 			omap_clear_dma(ch);
 }
+EXPORT_SYMBOL(omap_dma_global_context_restore);
 
 static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 {
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d2adcdd..8a7368f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1925,6 +1925,7 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 	}
 	workaround_enabled = 1;
 }
+EXPORT_SYMBOL(omap2_gpio_prepare_for_idle);
 
 void omap2_gpio_resume_after_idle(void)
 {
@@ -2022,6 +2023,7 @@ void omap2_gpio_resume_after_idle(void)
 	}
 
 }
+EXPORT_SYMBOL(omap2_gpio_resume_after_idle);
 
 #endif
 
@@ -2056,6 +2058,7 @@ void omap_gpio_save_context(void)
 			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
 	}
 }
+EXPORT_SYMBOL(omap_gpio_save_context);
 
 /* restore the required registers of bank 2-6 */
 void omap_gpio_restore_context(void)
@@ -2086,6 +2089,7 @@ void omap_gpio_restore_context(void)
 				bank->base + OMAP24XX_GPIO_DATAOUT);
 	}
 }
+EXPORT_SYMBOL(omap_gpio_restore_context);
 #endif
 
 static struct platform_driver omap_gpio_driver = {
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index b0471bb2..078d015 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -293,6 +293,7 @@ void omap_pm_enable_off_mode(void)
 {
 	off_mode_enabled = true;
 }
+EXPORT_SYMBOL(omap_pm_enable_off_mode);
 
 /**
  * omap_pm_disable_off_mode - notify OMAP PM that off-mode is disabled
@@ -304,6 +305,7 @@ void omap_pm_disable_off_mode(void)
 {
 	off_mode_enabled = false;
 }
+EXPORT_SYMBOL(omap_pm_disable_off_mode);
 
 /*
  * Device context loss tracking
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 9bbda9a..93e68ab 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -821,6 +821,7 @@ struct device omap_device_parent = {
 	.init_name	= "omap",
 	.parent         = &platform_bus,
 };
+EXPORT_SYMBOL(omap_device_parent);
 
 static int __init omap_device_init(void)
 {
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index f1a54bb..fa50c58 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -261,6 +261,7 @@ void *omap_sram_push_address(unsigned long size)
 
 	return (void *)omap_sram_ceil;
 }
+EXPORT_SYMBOL(omap_sram_push_address);
 
 #ifdef CONFIG_ARCH_OMAP1
 
@@ -391,6 +392,7 @@ void omap3_sram_restore_context(void)
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
 }
+EXPORT_SYMBOL(omap3_sram_restore_context);
 #endif /* CONFIG_PM */
 
 static int __init omap34xx_sram_init(void)
-- 
1.7.4.1

