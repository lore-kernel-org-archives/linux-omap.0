From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 1/3] OMAP2/3: PM: push core PM code from linux-omap
Date: Tue,  3 Feb 2009 18:03:47 -0800
Message-ID: <1233713029-14904-2-git-send-email-khilman@deeprootsystems.com>
References: <1233713029-14904-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:20893 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbZBDCEB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 21:04:01 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2575471wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 18:04:00 -0800 (PST)
In-Reply-To: <1233713029-14904-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch is to sync the core linux-omap PM code with mainline.  This
code has evolved in the linux-omap tree, but the attempt here is to
start by adding the reworked PM core code from linux-omap to mainline.
Following this will be a series of patches from the 'PM branch' of the
linux-omap tree to add full PM hardware support from the linux-omap
tree.

Much of this PM core code was written by Jouni Hogander with
significant contributions from Paul Walmsley as well as many others
in the linux-omap community.

Cc: Jouni Hogander <jouni.hogander@nokia.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile         |    3 +
 arch/arm/mach-omap2/pm-debug.c       |  157 +++++++++
 arch/arm/mach-omap2/pm.c             |  154 +++++----
 arch/arm/mach-omap2/pm.h             |   32 ++
 arch/arm/mach-omap2/pm24xx.c         |  558 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c         |  608 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/sleep34xx.S      |  544 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/pm.h |   77 +----
 8 files changed, 1996 insertions(+), 137 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm-debug.c
 create mode 100644 arch/arm/mach-omap2/pm.h
 create mode 100644 arch/arm/mach-omap2/pm24xx.c
 create mode 100644 arch/arm/mach-omap2/pm34xx.c
 create mode 100644 arch/arm/mach-omap2/sleep34xx.S

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9717afc..a98057a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -21,7 +21,10 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 # Power Management
 ifeq ($(CONFIG_PM),y)
 obj-y					+= pm.o
+obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
+obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 endif
 
 # Clock framework
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
new file mode 100644
index 0000000..0ca1083
--- /dev/null
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -0,0 +1,157 @@
+/*
+ * linux/arch/arm/mach-omap2/pm_debug.c
+ *
+ * OMAP Power Management debug routines
+ *
+ * Copyright (C) 2005 Texas Instruments, Inc.
+ * Copyright (C) 2006-2008 Nokia Corporation
+ *
+ * Written by:
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Tony Lindgren
+ * Juha Yrjola
+ * Amit Kucheria <amit.kucheria@nokia.com>
+ * Igor Stoppa <igor.stoppa@nokia.com>
+ * Jouni Hogander
+ *
+ * Based on pm.c for omap2
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <mach/clock.h>
+#include <mach/board.h>
+
+#include "prm.h"
+#include "cm.h"
+#include "pm.h"
+
+#ifdef CONFIG_PM_DEBUG
+int omap2_pm_debug;
+
+#define DUMP_PRM_MOD_REG(mod, reg)    \
+	regs[reg_count].name = #mod "." #reg; \
+	regs[reg_count++].val = prm_read_mod_reg(mod, reg)
+#define DUMP_CM_MOD_REG(mod, reg)     \
+	regs[reg_count].name = #mod "." #reg; \
+	regs[reg_count++].val = cm_read_mod_reg(mod, reg)
+#define DUMP_PRM_REG(reg) \
+	regs[reg_count].name = #reg; \
+	regs[reg_count++].val = __raw_readl(reg)
+#define DUMP_CM_REG(reg) \
+	regs[reg_count].name = #reg; \
+	regs[reg_count++].val = __raw_readl(reg)
+#define DUMP_INTC_REG(reg, off) \
+	regs[reg_count].name = #reg; \
+	regs[reg_count++].val = __raw_readl(IO_ADDRESS(0x480fe000 + (off)))
+
+void omap2_pm_dump(int mode, int resume, unsigned int us)
+{
+	struct reg {
+		const char *name;
+		u32 val;
+	} regs[32];
+	int reg_count = 0, i;
+	const char *s1 = NULL, *s2 = NULL;
+
+	if (!resume) {
+#if 0
+		/* MPU */
+		DUMP_PRM_MOD_REG(OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
+		DUMP_CM_MOD_REG(MPU_MOD, CM_CLKSTCTRL);
+		DUMP_PRM_MOD_REG(MPU_MOD, PM_PWSTCTRL);
+		DUMP_PRM_MOD_REG(MPU_MOD, PM_PWSTST);
+		DUMP_PRM_MOD_REG(MPU_MOD, PM_WKDEP);
+#endif
+#if 0
+		/* INTC */
+		DUMP_INTC_REG(INTC_MIR0, 0x0084);
+		DUMP_INTC_REG(INTC_MIR1, 0x00a4);
+		DUMP_INTC_REG(INTC_MIR2, 0x00c4);
+#endif
+#if 0
+		DUMP_CM_MOD_REG(CORE_MOD, CM_FCLKEN1);
+		if (cpu_is_omap24xx()) {
+			DUMP_CM_MOD_REG(CORE_MOD, OMAP24XX_CM_FCLKEN2);
+			DUMP_PRM_MOD_REG(OMAP24XX_GR_MOD,
+					OMAP24XX_PRCM_CLKEMUL_CTRL_OFFSET);
+			DUMP_PRM_MOD_REG(OMAP24XX_GR_MOD,
+					OMAP24XX_PRCM_CLKSRC_CTRL_OFFSET);
+		}
+		DUMP_CM_MOD_REG(WKUP_MOD, CM_FCLKEN);
+		DUMP_CM_MOD_REG(CORE_MOD, CM_ICLKEN1);
+		DUMP_CM_MOD_REG(CORE_MOD, CM_ICLKEN2);
+		DUMP_CM_MOD_REG(WKUP_MOD, CM_ICLKEN);
+		DUMP_CM_MOD_REG(PLL_MOD, CM_CLKEN);
+		DUMP_CM_MOD_REG(PLL_MOD, CM_AUTOIDLE);
+		DUMP_PRM_MOD_REG(CORE_MOD, PM_PWSTST);
+#endif
+#if 0
+		/* DSP */
+		if (cpu_is_omap24xx()) {
+			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_FCLKEN);
+			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_ICLKEN);
+			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_IDLEST);
+			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_AUTOIDLE);
+			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_CLKSEL);
+			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
+			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, RM_RSTCTRL);
+			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, RM_RSTST);
+			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, PM_PWSTCTRL);
+			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, PM_PWSTST);
+		}
+#endif
+	} else {
+		DUMP_PRM_MOD_REG(CORE_MOD, PM_WKST1);
+		if (cpu_is_omap24xx())
+			DUMP_PRM_MOD_REG(CORE_MOD, OMAP24XX_PM_WKST2);
+		DUMP_PRM_MOD_REG(WKUP_MOD, PM_WKST);
+		DUMP_PRM_MOD_REG(OCP_MOD, OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+#if 1
+		DUMP_INTC_REG(INTC_PENDING_IRQ0, 0x0098);
+		DUMP_INTC_REG(INTC_PENDING_IRQ1, 0x00b8);
+		DUMP_INTC_REG(INTC_PENDING_IRQ2, 0x00d8);
+#endif
+	}
+
+	switch (mode) {
+	case 0:
+		s1 = "full";
+		s2 = "retention";
+		break;
+	case 1:
+		s1 = "MPU";
+		s2 = "retention";
+		break;
+	case 2:
+		s1 = "MPU";
+		s2 = "idle";
+		break;
+	}
+
+	if (!resume)
+#if defined(CONFIG_NO_IDLE_HZ) || defined(CONFIG_NO_HZ)
+		printk(KERN_INFO
+		       "--- Going to %s %s (next timer after %u ms)\n", s1, s2,
+		       jiffies_to_msecs(get_next_timer_interrupt(jiffies) -
+					jiffies));
+#else
+		printk(KERN_INFO "--- Going to %s %s\n", s1, s2);
+#endif
+	else
+		printk(KERN_INFO "--- Woke up (slept for %u.%03u ms)\n",
+			us / 1000, us % 1000);
+
+	for (i = 0; i < reg_count; i++)
+		printk(KERN_INFO "%-20s: 0x%08x\n", regs[i].name, regs[i].val);
+}
+
+#endif
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index ea8ceae..2cc5bfd 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -1,13 +1,16 @@
 /*
- * linux/arch/arm/mach-omap2/pm.c
- *
- * OMAP2 Power Management Routines
- *
- * Copyright (C) 2006 Nokia Corporation
- * Tony Lindgren <tony@atomide.com>
+ * OMAP2/3 Power Management Common Routines
  *
  * Copyright (C) 2005 Texas Instruments, Inc.
+ * Copyright (C) 2006-2008 Nokia Corporation
+ *
+ * Written by:
  * Richard Woodruff <r-woodruff2@ti.com>
+ * Tony Lindgren
+ * Juha Yrjola
+ * Amit Kucheria <amit.kucheria@nokia.com>
+ * Igor Stoppa <igor.stoppa@nokia.com>
+ * Jouni Hogander
  *
  * Based on pm.c for omap1
  *
@@ -17,95 +20,98 @@
  */
 
 #include <linux/suspend.h>
-#include <linux/sched.h>
-#include <linux/proc_fs.h>
-#include <linux/interrupt.h>
-#include <linux/sysfs.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include <asm/irq.h>
-#include <asm/atomic.h>
+#include <linux/time.h>
+
+#include <mach/cpu.h>
 #include <asm/mach/time.h>
-#include <asm/mach/irq.h>
+#include <asm/atomic.h>
 
-#include <mach/irqs.h>
-#include <mach/clock.h>
-#include <mach/sram.h>
 #include <mach/pm.h>
+#include "pm.h"
 
-static struct clk *vclk;
-static void (*omap2_sram_idle)(void);
-static void (*omap2_sram_suspend)(int dllctrl, int cpu_rev);
-static void (*saved_idle)(void);
-
-extern void __init pmdomain_init(void);
-extern void pmdomain_set_autoidle(void);
+unsigned short enable_dyn_sleep;
+unsigned short clocks_off_while_idle;
+atomic_t sleep_block = ATOMIC_INIT(0);
 
-static unsigned int omap24xx_sleep_save[OMAP24XX_SLEEP_SAVE_SIZE];
+static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
+static ssize_t idle_store(struct kobject *k, struct kobj_attribute *,
+			  const char *buf, size_t n);
 
-void omap2_pm_idle(void)
-{
-	local_irq_disable();
-	local_fiq_disable();
-	if (need_resched()) {
-		local_fiq_enable();
-		local_irq_enable();
-		return;
-	}
+static struct kobj_attribute sleep_while_idle_attr =
+	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
 
-	omap2_sram_idle();
-	local_fiq_enable();
-	local_irq_enable();
-}
+static struct kobj_attribute clocks_off_while_idle_attr =
+	__ATTR(clocks_off_while_idle, 0644, idle_show, idle_store);
 
-static int omap2_pm_prepare(void)
+static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
 {
-	/* We cannot sleep in idle until we have resumed */
-	saved_idle = pm_idle;
-	pm_idle = NULL;
-	return 0;
+	if (attr == &sleep_while_idle_attr)
+		return sprintf(buf, "%hu\n", enable_dyn_sleep);
+	else if (attr == &clocks_off_while_idle_attr)
+		return sprintf(buf, "%hu\n", clocks_off_while_idle);
+	else
+		return -EINVAL;
 }
 
-static int omap2_pm_suspend(void)
+static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t n)
 {
-	return 0;
-}
+	unsigned short value;
 
-static int omap2_pm_enter(suspend_state_t state)
-{
-	int ret = 0;
-
-	switch (state)
-	{
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		ret = omap2_pm_suspend();
-		break;
-	default:
-		ret = -EINVAL;
+	if (sscanf(buf, "%hu", &value) != 1 ||
+	    (value != 0 && value != 1)) {
+		printk(KERN_ERR "idle_store: Invalid value\n");
+		return -EINVAL;
 	}
 
-	return ret;
+	if (attr == &sleep_while_idle_attr)
+		enable_dyn_sleep = value;
+	else if (attr == &clocks_off_while_idle_attr)
+		clocks_off_while_idle = value;
+	else
+		return -EINVAL;
+
+	return n;
 }
 
-static void omap2_pm_finish(void)
+void omap2_block_sleep(void)
 {
-	pm_idle = saved_idle;
+	atomic_inc(&sleep_block);
 }
 
-static struct platform_suspend_ops omap_pm_ops = {
-	.prepare	= omap2_pm_prepare,
-	.enter		= omap2_pm_enter,
-	.finish		= omap2_pm_finish,
-	.valid		= suspend_valid_only_mem,
-};
+void omap2_allow_sleep(void)
+{
+	int i;
 
-static int __init omap2_pm_init(void)
+	i = atomic_dec_return(&sleep_block);
+	BUG_ON(i < 0);
+}
+
+static int __init omap_pm_init(void)
 {
-	return 0;
+	int error = -1;
+
+	if (cpu_is_omap24xx())
+		error = omap2_pm_init();
+	if (cpu_is_omap34xx())
+		error = omap3_pm_init();
+	if (error) {
+		printk(KERN_ERR "omap2|3_pm_init failed: %d\n", error);
+		return error;
+	}
+
+	/* disabled till drivers are fixed */
+	enable_dyn_sleep = 0;
+	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
+	if (error)
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+	error = sysfs_create_file(power_kobj,
+				  &clocks_off_while_idle_attr.attr);
+	if (error)
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+
+	return error;
 }
 
-__initcall(omap2_pm_init);
+late_initcall(omap_pm_init);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
new file mode 100644
index 0000000..625a905
--- /dev/null
+++ b/arch/arm/mach-omap2/pm.h
@@ -0,0 +1,32 @@
+/*
+ * OMAP2/3 Power Management Routines
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Jouni Hogander
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ARCH_ARM_MACH_OMAP2_PM_H
+#define __ARCH_ARM_MACH_OMAP2_PM_H
+
+extern int omap2_pm_init(void);
+extern int omap3_pm_init(void);
+
+extern unsigned short enable_dyn_sleep;
+extern unsigned short clocks_off_while_idle;
+extern atomic_t sleep_block;
+
+extern void omap2_block_sleep(void);
+extern void omap2_allow_sleep(void);
+
+#ifdef CONFIG_PM_DEBUG
+extern void omap2_pm_dump(int mode, int resume, unsigned int us);
+extern int omap2_pm_debug;
+#else
+#define omap2_pm_dump(mode, resume, us)		do {} while (0);
+#define omap2_pm_debug				0
+#endif /* CONFIG_PM_DEBUG */
+
+#endif
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
new file mode 100644
index 0000000..b3268c5
--- /dev/null
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -0,0 +1,558 @@
+/*
+ * OMAP2 Power Management Routines
+ *
+ * Copyright (C) 2005 Texas Instruments, Inc.
+ * Copyright (C) 2006-2008 Nokia Corporation
+ *
+ * Written by:
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Tony Lindgren
+ * Juha Yrjola
+ * Amit Kucheria <amit.kucheria@nokia.com>
+ * Igor Stoppa <igor.stoppa@nokia.com>
+ *
+ * Based on pm.c for omap1
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/suspend.h>
+#include <linux/sched.h>
+#include <linux/proc_fs.h>
+#include <linux/interrupt.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/time.h>
+
+#include <asm/mach/time.h>
+#include <asm/mach/irq.h>
+#include <asm/mach-types.h>
+
+#include <mach/irqs.h>
+#include <mach/clock.h>
+#include <mach/sram.h>
+#include <mach/control.h>
+#include <mach/gpio.h>
+#include <mach/pm.h>
+#include <mach/mux.h>
+#include <mach/dma.h>
+#include <mach/board.h>
+
+#include "prm.h"
+#include "prm-regbits-24xx.h"
+#include "cm.h"
+#include "cm-regbits-24xx.h"
+#include "sdrc.h"
+#include "pm.h"
+
+#include <mach/powerdomain.h>
+#include <mach/clockdomain.h>
+
+static void (*omap2_sram_idle)(void);
+static void (*omap2_sram_suspend)(u32 dllctrl, void __iomem *sdrc_dlla_ctrl,
+				  void __iomem *sdrc_power);
+static void (*saved_idle)(void);
+
+static struct powerdomain *mpu_pwrdm;
+static struct powerdomain *core_pwrdm;
+
+static struct clockdomain *dsp_clkdm;
+static struct clockdomain *gfx_clkdm;
+
+static struct clk *osc_ck, *emul_ck;
+
+static int omap2_fclks_active(void)
+{
+	u32 f1, f2;
+
+	f1 = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	f2 = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
+	if (f1 | f2)
+		return 1;
+	return 0;
+}
+
+static int omap2_irq_pending(void)
+{
+	u32 pending_reg = 0x480fe098;
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (omap_readl(pending_reg))
+			return 1;
+		pending_reg += 0x20;
+	}
+	return 0;
+}
+
+static void omap2_enter_full_retention(void)
+{
+	u32 l;
+	struct timespec ts_preidle, ts_postidle, ts_idle;
+
+	/* There is 1 reference hold for all children of the oscillator
+	 * clock, the following will remove it. If no one else uses the
+	 * oscillator itself it will be disabled if/when we enter retention
+	 * mode.
+	 */
+	clk_disable(osc_ck);
+
+	/* Clear old wake-up events */
+	/* REVISIT: These write to reserved bits? */
+	prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
+	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+	prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
+
+	/*
+	 * Set MPU powerdomain's next power state to RETENTION;
+	 * preserve logic state during retention
+	 */
+	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
+	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
+
+	/* Workaround to kill USB */
+	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) | OMAP24XX_USBSTANDBYCTRL;
+	omap_ctrl_writel(l, OMAP2_CONTROL_DEVCONF0);
+
+	omap2_gpio_prepare_for_retention();
+
+	if (omap2_pm_debug) {
+		omap2_pm_dump(0, 0, 0);
+		getnstimeofday(&ts_preidle);
+	}
+
+	/* One last check for pending IRQs to avoid extra latency due
+	 * to sleeping unnecessarily. */
+	if (omap2_irq_pending())
+		goto no_sleep;
+
+	/* Jump to SRAM suspend code */
+	omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
+			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
+			   OMAP_SDRC_REGADDR(SDRC_POWER));
+no_sleep:
+
+	if (omap2_pm_debug) {
+		unsigned long long tmp;
+
+		getnstimeofday(&ts_postidle);
+		ts_idle = timespec_sub(ts_postidle, ts_preidle);
+		tmp = timespec_to_ns(&ts_idle) * NSEC_PER_USEC;
+		omap2_pm_dump(0, 1, tmp);
+	}
+	omap2_gpio_resume_after_retention();
+
+	clk_enable(osc_ck);
+
+	/* clear CORE wake-up events */
+	prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
+	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+
+	/* wakeup domain events - bit 1: GPT1, bit5 GPIO */
+	prm_clear_mod_reg_bits(0x4 | 0x1, WKUP_MOD, PM_WKST);
+
+	/* MPU domain wake events */
+	l = prm_read_mod_reg(OCP_MOD, OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+	if (l & 0x01)
+		prm_write_mod_reg(0x01, OCP_MOD,
+				  OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+	if (l & 0x20)
+		prm_write_mod_reg(0x20, OCP_MOD,
+				  OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+
+	/* Mask future PRCM-to-MPU interrupts */
+	prm_write_mod_reg(0x0, OCP_MOD, OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+}
+
+static int omap2_i2c_active(void)
+{
+	u32 l;
+
+	l = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	return l & (OMAP2420_EN_I2C2 | OMAP2420_EN_I2C1);
+}
+
+static int sti_console_enabled;
+
+static int omap2_allow_mpu_retention(void)
+{
+	u32 l;
+
+	if (atomic_read(&sleep_block))
+		return 0;
+
+	/* Check for MMC, UART2, UART1, McSPI2, McSPI1 and DSS1. */
+	l = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	if (l & (OMAP2420_EN_MMC | OMAP24XX_EN_UART2 |
+		 OMAP24XX_EN_UART1 | OMAP24XX_EN_MCSPI2 |
+		 OMAP24XX_EN_MCSPI1 | OMAP24XX_EN_DSS1))
+		return 0;
+	/* Check for UART3. */
+	l = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
+	if (l & OMAP24XX_EN_UART3)
+		return 0;
+	if (sti_console_enabled)
+		return 0;
+
+	return 1;
+}
+
+static void omap2_enter_mpu_retention(void)
+{
+	int only_idle = 0;
+	struct timespec ts_preidle, ts_postidle, ts_idle;
+
+	/* Putting MPU into the WFI state while a transfer is active
+	 * seems to cause the I2C block to timeout. Why? Good question. */
+	if (omap2_i2c_active())
+		return;
+
+	/* The peripherals seem not to be able to wake up the MPU when
+	 * it is in retention mode. */
+	if (omap2_allow_mpu_retention()) {
+		/* REVISIT: These write to reserved bits? */
+		prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
+		prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+		prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
+
+		/* Try to enter MPU retention */
+		prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) |
+				  OMAP_LOGICRETSTATE,
+				  MPU_MOD, PM_PWSTCTRL);
+	} else {
+		/* Block MPU retention */
+
+		prm_write_mod_reg(OMAP_LOGICRETSTATE, MPU_MOD, PM_PWSTCTRL);
+		only_idle = 1;
+	}
+
+	if (omap2_pm_debug) {
+		omap2_pm_dump(only_idle ? 2 : 1, 0, 0);
+		getnstimeofday(&ts_preidle);
+	}
+
+	omap2_sram_idle();
+
+	if (omap2_pm_debug) {
+		unsigned long long tmp;
+
+		getnstimeofday(&ts_postidle);
+		ts_idle = timespec_sub(ts_postidle, ts_preidle);
+		tmp = timespec_to_ns(&ts_idle) * NSEC_PER_USEC;
+		omap2_pm_dump(only_idle ? 2 : 1, 1, tmp);
+	}
+}
+
+static int omap2_can_sleep(void)
+{
+	if (!enable_dyn_sleep)
+		return 0;
+	if (omap2_fclks_active())
+		return 0;
+	if (atomic_read(&sleep_block) > 0)
+		return 0;
+	if (osc_ck->usecount > 1)
+		return 0;
+	if (omap_dma_running())
+		return 0;
+
+	return 1;
+}
+
+/*
+ * Note that you can use clock_event_device->min_delta_ns if you want to
+ * avoid reprogramming timer too often when using CONFIG_NO_HZ.
+ */
+static void omap2_pm_idle(void)
+{
+	local_irq_disable();
+	local_fiq_disable();
+
+	if (!omap2_can_sleep()) {
+		if (!atomic_read(&sleep_block) && omap2_irq_pending())
+			goto out;
+		omap2_enter_mpu_retention();
+		goto out;
+	}
+
+	if (omap2_irq_pending())
+		goto out;
+
+	omap2_enter_full_retention();
+
+out:
+	local_fiq_enable();
+	local_irq_enable();
+}
+
+static int omap2_pm_prepare(void)
+{
+	/* We cannot sleep in idle until we have resumed */
+	saved_idle = pm_idle;
+	pm_idle = NULL;
+
+	return 0;
+}
+
+static int omap2_pm_suspend(void)
+{
+	u32 wken_wkup, mir1;
+
+	wken_wkup = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+	prm_write_mod_reg(wken_wkup & ~OMAP24XX_EN_GPT1, WKUP_MOD, PM_WKEN);
+
+	/* Mask GPT1 */
+	mir1 = omap_readl(0x480fe0a4);
+	omap_writel(1 << 5, 0x480fe0ac);
+
+	omap2_enter_full_retention();
+
+	omap_writel(mir1, 0x480fe0a4);
+	prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
+
+	return 0;
+}
+
+static int omap2_pm_enter(suspend_state_t state)
+{
+	int ret = 0;
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		ret = omap2_pm_suspend();
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static void omap2_pm_finish(void)
+{
+	pm_idle = saved_idle;
+}
+
+static struct platform_suspend_ops omap_pm_ops = {
+	.prepare	= omap2_pm_prepare,
+	.enter		= omap2_pm_enter,
+	.finish		= omap2_pm_finish,
+	.valid		= suspend_valid_only_mem,
+};
+
+static int _pm_clkdm_enable_hwsup(struct clockdomain *clkdm)
+{
+	omap2_clkdm_allow_idle(clkdm);
+	return 0;
+}
+
+static void __init prcm_setup_regs(void)
+{
+	int i, num_mem_banks;
+	struct powerdomain *pwrdm;
+
+	/* Enable autoidle */
+	prm_write_mod_reg(OMAP24XX_AUTOIDLE, OCP_MOD,
+			  OMAP24XX_PRCM_SYSCONFIG_OFFSET);
+
+	/* Set all domain wakeup dependencies */
+	prm_write_mod_reg(OMAP_EN_WKUP_MASK, MPU_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, OMAP24XX_DSP_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, CORE_MOD, PM_WKDEP);
+	if (cpu_is_omap2430())
+		prm_write_mod_reg(0, OMAP2430_MDM_MOD, PM_WKDEP);
+
+	/*
+	 * Set CORE powerdomain memory banks to retain their contents
+	 * during RETENTION
+	 */
+	num_mem_banks = pwrdm_get_mem_bank_count(core_pwrdm);
+	for (i = 0; i < num_mem_banks; i++)
+		pwrdm_set_mem_retst(core_pwrdm, i, PWRDM_POWER_RET);
+
+	/* Set CORE powerdomain's next power state to RETENTION */
+	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
+
+	/*
+	 * Set MPU powerdomain's next power state to RETENTION;
+	 * preserve logic state during retention
+	 */
+	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
+	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
+
+	/* Force-power down DSP, GFX powerdomains */
+
+	pwrdm = clkdm_get_pwrdm(dsp_clkdm);
+	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
+	omap2_clkdm_sleep(dsp_clkdm);
+
+	pwrdm = clkdm_get_pwrdm(gfx_clkdm);
+	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
+	omap2_clkdm_sleep(gfx_clkdm);
+
+	/* Enable clockdomain hardware-supervised control for all clkdms */
+	clkdm_for_each(_pm_clkdm_enable_hwsup);
+
+	/* Enable clock autoidle for all domains */
+	cm_write_mod_reg(OMAP24XX_AUTO_CAM |
+			 OMAP24XX_AUTO_MAILBOXES |
+			 OMAP24XX_AUTO_WDT4 |
+			 OMAP2420_AUTO_WDT3 |
+			 OMAP24XX_AUTO_MSPRO |
+			 OMAP2420_AUTO_MMC |
+			 OMAP24XX_AUTO_FAC |
+			 OMAP2420_AUTO_EAC |
+			 OMAP24XX_AUTO_HDQ |
+			 OMAP24XX_AUTO_UART2 |
+			 OMAP24XX_AUTO_UART1 |
+			 OMAP24XX_AUTO_I2C2 |
+			 OMAP24XX_AUTO_I2C1 |
+			 OMAP24XX_AUTO_MCSPI2 |
+			 OMAP24XX_AUTO_MCSPI1 |
+			 OMAP24XX_AUTO_MCBSP2 |
+			 OMAP24XX_AUTO_MCBSP1 |
+			 OMAP24XX_AUTO_GPT12 |
+			 OMAP24XX_AUTO_GPT11 |
+			 OMAP24XX_AUTO_GPT10 |
+			 OMAP24XX_AUTO_GPT9 |
+			 OMAP24XX_AUTO_GPT8 |
+			 OMAP24XX_AUTO_GPT7 |
+			 OMAP24XX_AUTO_GPT6 |
+			 OMAP24XX_AUTO_GPT5 |
+			 OMAP24XX_AUTO_GPT4 |
+			 OMAP24XX_AUTO_GPT3 |
+			 OMAP24XX_AUTO_GPT2 |
+			 OMAP2420_AUTO_VLYNQ |
+			 OMAP24XX_AUTO_DSS,
+			 CORE_MOD, CM_AUTOIDLE1);
+	cm_write_mod_reg(OMAP24XX_AUTO_UART3 |
+			 OMAP24XX_AUTO_SSI |
+			 OMAP24XX_AUTO_USB,
+			 CORE_MOD, CM_AUTOIDLE2);
+	cm_write_mod_reg(OMAP24XX_AUTO_SDRC |
+			 OMAP24XX_AUTO_GPMC |
+			 OMAP24XX_AUTO_SDMA,
+			 CORE_MOD, CM_AUTOIDLE3);
+	cm_write_mod_reg(OMAP24XX_AUTO_PKA |
+			 OMAP24XX_AUTO_AES |
+			 OMAP24XX_AUTO_RNG |
+			 OMAP24XX_AUTO_SHA |
+			 OMAP24XX_AUTO_DES,
+			 CORE_MOD, OMAP24XX_CM_AUTOIDLE4);
+
+	cm_write_mod_reg(OMAP2420_AUTO_DSP_IPI, OMAP24XX_DSP_MOD, CM_AUTOIDLE);
+
+	/* Put DPLL and both APLLs into autoidle mode */
+	cm_write_mod_reg((0x03 << OMAP24XX_AUTO_DPLL_SHIFT) |
+			 (0x03 << OMAP24XX_AUTO_96M_SHIFT) |
+			 (0x03 << OMAP24XX_AUTO_54M_SHIFT),
+			 PLL_MOD, CM_AUTOIDLE);
+
+	cm_write_mod_reg(OMAP24XX_AUTO_OMAPCTRL |
+			 OMAP24XX_AUTO_WDT1 |
+			 OMAP24XX_AUTO_MPU_WDT |
+			 OMAP24XX_AUTO_GPIOS |
+			 OMAP24XX_AUTO_32KSYNC |
+			 OMAP24XX_AUTO_GPT1,
+			 WKUP_MOD, CM_AUTOIDLE);
+
+	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
+	 * stabilisation */
+	prm_write_mod_reg(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
+			  OMAP24XX_PRCM_CLKSSETUP_OFFSET);
+
+	/* Configure automatic voltage transition */
+	prm_write_mod_reg(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
+			  OMAP24XX_PRCM_VOLTSETUP_OFFSET);
+	prm_write_mod_reg(OMAP24XX_AUTO_EXTVOLT |
+			  (0x1 << OMAP24XX_SETOFF_LEVEL_SHIFT) |
+			  OMAP24XX_MEMRETCTRL |
+			  (0x1 << OMAP24XX_SETRET_LEVEL_SHIFT) |
+			  (0x0 << OMAP24XX_VOLT_LEVEL_SHIFT),
+			  OMAP24XX_GR_MOD, OMAP24XX_PRCM_VOLTCTRL_OFFSET);
+
+	/* Enable wake-up events */
+	prm_write_mod_reg(OMAP24XX_EN_GPIOS | OMAP24XX_EN_GPT1,
+			  WKUP_MOD, PM_WKEN);
+}
+
+int __init omap2_pm_init(void)
+{
+	u32 l;
+
+	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
+	l = prm_read_mod_reg(OCP_MOD, OMAP24XX_PRCM_REVISION_OFFSET);
+	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
+
+	/* Look up important powerdomains, clockdomains */
+
+	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
+	if (!mpu_pwrdm)
+		pr_err("PM: mpu_pwrdm not found\n");
+
+	core_pwrdm = pwrdm_lookup("core_pwrdm");
+	if (!core_pwrdm)
+		pr_err("PM: core_pwrdm not found\n");
+
+	dsp_clkdm = clkdm_lookup("dsp_clkdm");
+	if (!dsp_clkdm)
+		pr_err("PM: mpu_clkdm not found\n");
+
+	gfx_clkdm = clkdm_lookup("gfx_clkdm");
+	if (!gfx_clkdm)
+		pr_err("PM: gfx_clkdm not found\n");
+
+
+	osc_ck = clk_get(NULL, "osc_ck");
+	if (IS_ERR(osc_ck)) {
+		printk(KERN_ERR "could not get osc_ck\n");
+		return -ENODEV;
+	}
+
+	if (cpu_is_omap242x()) {
+		emul_ck = clk_get(NULL, "emul_ck");
+		if (IS_ERR(emul_ck)) {
+			printk(KERN_ERR "could not get emul_ck\n");
+			clk_put(osc_ck);
+			return -ENODEV;
+		}
+	}
+
+	prcm_setup_regs();
+
+	/* Hack to prevent MPU retention when STI console is enabled. */
+	{
+		const struct omap_sti_console_config *sti;
+
+		sti = omap_get_config(OMAP_TAG_STI_CONSOLE,
+				      struct omap_sti_console_config);
+		if (sti != NULL && sti->enable)
+			sti_console_enabled = 1;
+	}
+
+	/*
+	 * We copy the assembler sleep/wakeup routines to SRAM.
+	 * These routines need to be in SRAM as that's the only
+	 * memory the MPU can see when it wakes up.
+	 */
+	if (cpu_is_omap24xx()) {
+		omap2_sram_idle = omap_sram_push(omap24xx_idle_loop_suspend,
+						 omap24xx_idle_loop_suspend_sz);
+
+		omap2_sram_suspend = omap_sram_push(omap24xx_cpu_suspend,
+						    omap24xx_cpu_suspend_sz);
+	}
+
+	suspend_set_ops(&omap_pm_ops);
+	pm_idle = omap2_pm_idle;
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
new file mode 100644
index 0000000..6f50e93
--- /dev/null
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -0,0 +1,608 @@
+/*
+ * OMAP3 Power Management Routines
+ *
+ * Copyright (C) 2006-2008 Nokia Corporation
+ * Tony Lindgren <tony@atomide.com>
+ * Jouni Hogander
+ *
+ * Copyright (C) 2005 Texas Instruments, Inc.
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * Based on pm.c for omap1
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/pm.h>
+#include <linux/suspend.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/err.h>
+
+#include <mach/gpio.h>
+#include <mach/sram.h>
+#include <mach/pm.h>
+#include <mach/clockdomain.h>
+#include <mach/powerdomain.h>
+#include <mach/control.h>
+
+#include "cm.h"
+#include "cm-regbits-34xx.h"
+#include "prm-regbits-34xx.h"
+
+#include "prm.h"
+#include "pm.h"
+
+struct power_state {
+	struct powerdomain *pwrdm;
+	u32 next_state;
+	u32 saved_state;
+	struct list_head node;
+};
+
+static LIST_HEAD(pwrst_list);
+
+static void (*_omap_sram_idle)(u32 *addr, int save_state);
+
+static void (*saved_idle)(void);
+
+static struct powerdomain *mpu_pwrdm;
+
+/* PRCM Interrupt Handler for wakeups */
+static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
+{
+	u32 wkst, irqstatus_mpu;
+	u32 fclk, iclk;
+
+	/* WKUP */
+	wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
+	if (wkst) {
+		iclk = cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
+		fclk = cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
+		cm_set_mod_reg_bits(wkst, WKUP_MOD, CM_ICLKEN);
+		cm_set_mod_reg_bits(wkst, WKUP_MOD, CM_FCLKEN);
+		prm_write_mod_reg(wkst, WKUP_MOD, PM_WKST);
+		while (prm_read_mod_reg(WKUP_MOD, PM_WKST))
+			cpu_relax();
+		cm_write_mod_reg(iclk, WKUP_MOD, CM_ICLKEN);
+		cm_write_mod_reg(fclk, WKUP_MOD, CM_FCLKEN);
+	}
+
+	/* CORE */
+	wkst = prm_read_mod_reg(CORE_MOD, PM_WKST1);
+	if (wkst) {
+		iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
+		fclk = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+		cm_set_mod_reg_bits(wkst, CORE_MOD, CM_ICLKEN1);
+		cm_set_mod_reg_bits(wkst, CORE_MOD, CM_FCLKEN1);
+		prm_write_mod_reg(wkst, CORE_MOD, PM_WKST1);
+		while (prm_read_mod_reg(CORE_MOD, PM_WKST1))
+			cpu_relax();
+		cm_write_mod_reg(iclk, CORE_MOD, CM_ICLKEN1);
+		cm_write_mod_reg(fclk, CORE_MOD, CM_FCLKEN1);
+	}
+	wkst = prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3);
+	if (wkst) {
+		iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
+		fclk = cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
+		cm_set_mod_reg_bits(wkst, CORE_MOD, CM_ICLKEN3);
+		cm_set_mod_reg_bits(wkst, CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
+		prm_write_mod_reg(wkst, CORE_MOD, OMAP3430ES2_PM_WKST3);
+		while (prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3))
+			cpu_relax();
+		cm_write_mod_reg(iclk, CORE_MOD, CM_ICLKEN3);
+		cm_write_mod_reg(fclk, CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
+	}
+
+	/* PER */
+	wkst = prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST);
+	if (wkst) {
+		iclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
+		fclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
+		cm_set_mod_reg_bits(wkst, OMAP3430_PER_MOD, CM_ICLKEN);
+		cm_set_mod_reg_bits(wkst, OMAP3430_PER_MOD, CM_FCLKEN);
+		prm_write_mod_reg(wkst, OMAP3430_PER_MOD, PM_WKST);
+		while (prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST))
+			cpu_relax();
+		cm_write_mod_reg(iclk, OMAP3430_PER_MOD, CM_ICLKEN);
+		cm_write_mod_reg(fclk, OMAP3430_PER_MOD, CM_FCLKEN);
+	}
+
+	if (omap_rev() > OMAP3430_REV_ES1_0) {
+		/* USBHOST */
+		wkst = prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKST);
+		if (wkst) {
+			iclk = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+					       CM_ICLKEN);
+			fclk = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+					       CM_FCLKEN);
+			cm_set_mod_reg_bits(wkst, OMAP3430ES2_USBHOST_MOD,
+					    CM_ICLKEN);
+			cm_set_mod_reg_bits(wkst, OMAP3430ES2_USBHOST_MOD,
+					    CM_FCLKEN);
+			prm_write_mod_reg(wkst, OMAP3430ES2_USBHOST_MOD,
+					  PM_WKST);
+			while (prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+						PM_WKST))
+				cpu_relax();
+			cm_write_mod_reg(iclk, OMAP3430ES2_USBHOST_MOD,
+					 CM_ICLKEN);
+			cm_write_mod_reg(fclk, OMAP3430ES2_USBHOST_MOD,
+					 CM_FCLKEN);
+		}
+	}
+
+	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+					 OMAP3430_PRM_IRQSTATUS_MPU_OFFSET);
+	prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
+			  OMAP3430_PRM_IRQSTATUS_MPU_OFFSET);
+
+	while (prm_read_mod_reg(OCP_MOD, OMAP3430_PRM_IRQSTATUS_MPU_OFFSET))
+		cpu_relax();
+
+	return IRQ_HANDLED;
+}
+
+static void omap_sram_idle(void)
+{
+	/* Variable to tell what needs to be saved and restored
+	 * in omap_sram_idle*/
+	/* save_state = 0 => Nothing to save and restored */
+	/* save_state = 1 => Only L1 and logic lost */
+	/* save_state = 2 => Only L2 lost */
+	/* save_state = 3 => L1, L2 and logic lost */
+	int save_state = 0, mpu_next_state;
+
+	if (!_omap_sram_idle)
+		return;
+
+	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
+	switch (mpu_next_state) {
+	case PWRDM_POWER_RET:
+		/* No need to save context */
+		save_state = 0;
+		break;
+	default:
+		/* Invalid state */
+		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
+		return;
+	}
+	omap2_gpio_prepare_for_retention();
+
+	_omap_sram_idle(NULL, save_state);
+
+	omap2_gpio_resume_after_retention();
+}
+
+/*
+ * Check if functional clocks are enabled before entering
+ * sleep. This function could be behind CONFIG_PM_DEBUG
+ * when all drivers are configuring their sysconfig registers
+ * properly and using their clocks properly.
+ */
+static int omap3_fclks_active(void)
+{
+	u32 fck_core1 = 0, fck_core3 = 0, fck_sgx = 0, fck_dss = 0,
+		fck_cam = 0, fck_per = 0, fck_usbhost = 0;
+
+	fck_core1 = cm_read_mod_reg(CORE_MOD,
+				    CM_FCLKEN1);
+	if (omap_rev() > OMAP3430_REV_ES1_0) {
+		fck_core3 = cm_read_mod_reg(CORE_MOD,
+					    OMAP3430ES2_CM_FCLKEN3);
+		fck_sgx = cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
+					  CM_FCLKEN);
+		fck_usbhost = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+					      CM_FCLKEN);
+	} else
+		fck_sgx = cm_read_mod_reg(GFX_MOD,
+					  OMAP3430ES2_CM_FCLKEN3);
+	fck_dss = cm_read_mod_reg(OMAP3430_DSS_MOD,
+				  CM_FCLKEN);
+	fck_cam = cm_read_mod_reg(OMAP3430_CAM_MOD,
+				  CM_FCLKEN);
+	fck_per = cm_read_mod_reg(OMAP3430_PER_MOD,
+				  CM_FCLKEN);
+	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
+	    fck_cam | fck_per | fck_usbhost)
+		return 1;
+	return 0;
+}
+
+static int omap3_can_sleep(void)
+{
+	if (!enable_dyn_sleep)
+		return 0;
+	if (omap3_fclks_active())
+		return 0;
+	if (atomic_read(&sleep_block) > 0)
+		return 0;
+	return 1;
+}
+
+/* This sets pwrdm state (other than mpu & core. Currently only ON &
+ * RET are supported. Function is assuming that clkdm doesn't have
+ * hw_sup mode enabled. */
+static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
+{
+	u32 cur_state;
+	int sleep_switch = 0;
+	int ret = 0;
+
+	if (pwrdm == NULL || IS_ERR(pwrdm))
+		return -EINVAL;
+
+	while (!(pwrdm->pwrsts & (1 << state))) {
+		if (state == PWRDM_POWER_OFF)
+			return ret;
+		state--;
+	}
+
+	cur_state = pwrdm_read_next_pwrst(pwrdm);
+	if (cur_state == state)
+		return ret;
+
+	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
+		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
+		sleep_switch = 1;
+		pwrdm_wait_transition(pwrdm);
+	}
+
+	ret = pwrdm_set_next_pwrst(pwrdm, state);
+	if (ret) {
+		printk(KERN_ERR "Unable to set state of powerdomain: %s\n",
+		       pwrdm->name);
+		goto err;
+	}
+
+	if (sleep_switch) {
+		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+		pwrdm_wait_transition(pwrdm);
+	}
+
+err:
+	return ret;
+}
+
+static void omap3_pm_idle(void)
+{
+	local_irq_disable();
+	local_fiq_disable();
+
+	if (!omap3_can_sleep())
+		goto out;
+
+	if (omap_irq_pending())
+		goto out;
+
+	omap_sram_idle();
+
+out:
+	local_fiq_enable();
+	local_irq_enable();
+}
+
+static int omap3_pm_prepare(void)
+{
+	saved_idle = pm_idle;
+	pm_idle = NULL;
+	return 0;
+}
+
+static int omap3_pm_suspend(void)
+{
+	struct power_state *pwrst;
+	int state, ret = 0;
+
+	/* Read current next_pwrsts */
+	list_for_each_entry(pwrst, &pwrst_list, node)
+		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
+	/* Set ones wanted by suspend */
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		if (set_pwrdm_state(pwrst->pwrdm, pwrst->next_state))
+			goto restore;
+		if (pwrdm_clear_all_prev_pwrst(pwrst->pwrdm))
+			goto restore;
+	}
+
+	omap_sram_idle();
+
+restore:
+	/* Restore next_pwrsts */
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
+		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
+		if (state > pwrst->next_state) {
+			printk(KERN_INFO "Powerdomain (%s) didn't enter "
+			       "target state %d\n",
+			       pwrst->pwrdm->name, pwrst->next_state);
+			ret = -1;
+		}
+	}
+	if (ret)
+		printk(KERN_ERR "Could not enter target state in pm_suspend\n");
+	else
+		printk(KERN_INFO "Successfully put all powerdomains "
+		       "to target state\n");
+
+	return ret;
+}
+
+static int omap3_pm_enter(suspend_state_t state)
+{
+	int ret = 0;
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		ret = omap3_pm_suspend();
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static void omap3_pm_finish(void)
+{
+	pm_idle = saved_idle;
+}
+
+static struct platform_suspend_ops omap_pm_ops = {
+	.prepare	= omap3_pm_prepare,
+	.enter		= omap3_pm_enter,
+	.finish		= omap3_pm_finish,
+	.valid		= suspend_valid_only_mem,
+};
+
+static void __init prcm_setup_regs(void)
+{
+	/* reset modem */
+	prm_write_mod_reg(OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON |
+			  OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST,
+			  CORE_MOD, RM_RSTCTRL);
+	prm_write_mod_reg(0, CORE_MOD, RM_RSTCTRL);
+
+	/* XXX Reset all wkdeps. This should be done when initializing
+	 * powerdomains */
+	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, MPU_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, OMAP3430_DSS_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
+	if (omap_rev() > OMAP3430_REV_ES1_0) {
+		prm_write_mod_reg(0, OMAP3430ES2_SGX_MOD, PM_WKDEP);
+		prm_write_mod_reg(0, OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
+	} else
+		prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
+
+	/*
+	 * Enable interface clock autoidle for all modules.
+	 * Note that in the long run this should be done by clockfw
+	 */
+	cm_write_mod_reg(
+		OMAP3430ES2_AUTO_MMC3 |
+		OMAP3430ES2_AUTO_ICR |
+		OMAP3430_AUTO_AES2 |
+		OMAP3430_AUTO_SHA12 |
+		OMAP3430_AUTO_DES2 |
+		OMAP3430_AUTO_MMC2 |
+		OMAP3430_AUTO_MMC1 |
+		OMAP3430_AUTO_MSPRO |
+		OMAP3430_AUTO_HDQ |
+		OMAP3430_AUTO_MCSPI4 |
+		OMAP3430_AUTO_MCSPI3 |
+		OMAP3430_AUTO_MCSPI2 |
+		OMAP3430_AUTO_MCSPI1 |
+		OMAP3430_AUTO_I2C3 |
+		OMAP3430_AUTO_I2C2 |
+		OMAP3430_AUTO_I2C1 |
+		OMAP3430_AUTO_UART2 |
+		OMAP3430_AUTO_UART1 |
+		OMAP3430_AUTO_GPT11 |
+		OMAP3430_AUTO_GPT10 |
+		OMAP3430_AUTO_MCBSP5 |
+		OMAP3430_AUTO_MCBSP1 |
+		OMAP3430ES1_AUTO_FAC | /* This is es1 only */
+		OMAP3430_AUTO_MAILBOXES |
+		OMAP3430_AUTO_OMAPCTRL |
+		OMAP3430ES1_AUTO_FSHOSTUSB |
+		OMAP3430_AUTO_HSOTGUSB |
+		OMAP3430ES1_AUTO_D2D | /* This is es1 only */
+		OMAP3430_AUTO_SSI,
+		CORE_MOD, CM_AUTOIDLE1);
+
+	cm_write_mod_reg(
+		OMAP3430_AUTO_PKA |
+		OMAP3430_AUTO_AES1 |
+		OMAP3430_AUTO_RNG |
+		OMAP3430_AUTO_SHA11 |
+		OMAP3430_AUTO_DES1,
+		CORE_MOD, CM_AUTOIDLE2);
+
+	if (omap_rev() > OMAP3430_REV_ES1_0) {
+		cm_write_mod_reg(
+			OMAP3430ES2_AUTO_USBTLL,
+			CORE_MOD, CM_AUTOIDLE3);
+	}
+
+	cm_write_mod_reg(
+		OMAP3430_AUTO_WDT2 |
+		OMAP3430_AUTO_WDT1 |
+		OMAP3430_AUTO_GPIO1 |
+		OMAP3430_AUTO_32KSYNC |
+		OMAP3430_AUTO_GPT12 |
+		OMAP3430_AUTO_GPT1 ,
+		WKUP_MOD, CM_AUTOIDLE);
+
+	cm_write_mod_reg(
+		OMAP3430_AUTO_DSS,
+		OMAP3430_DSS_MOD,
+		CM_AUTOIDLE);
+
+	cm_write_mod_reg(
+		OMAP3430_AUTO_CAM,
+		OMAP3430_CAM_MOD,
+		CM_AUTOIDLE);
+
+	cm_write_mod_reg(
+		OMAP3430_AUTO_GPIO6 |
+		OMAP3430_AUTO_GPIO5 |
+		OMAP3430_AUTO_GPIO4 |
+		OMAP3430_AUTO_GPIO3 |
+		OMAP3430_AUTO_GPIO2 |
+		OMAP3430_AUTO_WDT3 |
+		OMAP3430_AUTO_UART3 |
+		OMAP3430_AUTO_GPT9 |
+		OMAP3430_AUTO_GPT8 |
+		OMAP3430_AUTO_GPT7 |
+		OMAP3430_AUTO_GPT6 |
+		OMAP3430_AUTO_GPT5 |
+		OMAP3430_AUTO_GPT4 |
+		OMAP3430_AUTO_GPT3 |
+		OMAP3430_AUTO_GPT2 |
+		OMAP3430_AUTO_MCBSP4 |
+		OMAP3430_AUTO_MCBSP3 |
+		OMAP3430_AUTO_MCBSP2,
+		OMAP3430_PER_MOD,
+		CM_AUTOIDLE);
+
+	if (omap_rev() > OMAP3430_REV_ES1_0) {
+		cm_write_mod_reg(
+			OMAP3430ES2_AUTO_USBHOST,
+			OMAP3430ES2_USBHOST_MOD,
+			CM_AUTOIDLE);
+	}
+
+	/*
+	 * Set all plls to autoidle. This is needed until autoidle is
+	 * enabled by clockfw
+	 */
+	cm_write_mod_reg(1 << OMAP3430_AUTO_IVA2_DPLL_SHIFT,
+			 OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
+	cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
+			 MPU_MOD,
+			 CM_AUTOIDLE2);
+	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
+			 (1 << OMAP3430_AUTO_CORE_DPLL_SHIFT),
+			 PLL_MOD,
+			 CM_AUTOIDLE);
+	cm_write_mod_reg(1 << OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT,
+			 PLL_MOD,
+			 CM_AUTOIDLE2);
+
+	/*
+	 * Enable control of expternal oscillator through
+	 * sys_clkreq. In the long run clock framework should
+	 * take care of this.
+	 */
+	prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK,
+			     1 << OMAP_AUTOEXTCLKMODE_SHIFT,
+			     OMAP3430_GR_MOD,
+			     OMAP3_PRM_CLKSRC_CTRL_OFFSET);
+
+	/* setup wakup source */
+	prm_write_mod_reg(OMAP3430_EN_IO | OMAP3430_EN_GPIO1 |
+			  OMAP3430_EN_GPT1 | OMAP3430_EN_GPT12,
+			  WKUP_MOD, PM_WKEN);
+	/* No need to write EN_IO, that is always enabled */
+	prm_write_mod_reg(OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1 |
+			  OMAP3430_EN_GPT12,
+			  WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
+	/* For some reason IO doesn't generate wakeup event even if
+	 * it is selected to mpu wakeup goup */
+	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
+			  OCP_MOD, OMAP3430_PRM_IRQENABLE_MPU_OFFSET);
+}
+
+static int __init pwrdms_setup(struct powerdomain *pwrdm)
+{
+	struct power_state *pwrst;
+
+	if (!pwrdm->pwrsts)
+		return 0;
+
+	pwrst = kmalloc(sizeof(struct power_state), GFP_KERNEL);
+	if (!pwrst)
+		return -ENOMEM;
+	pwrst->pwrdm = pwrdm;
+	pwrst->next_state = PWRDM_POWER_RET;
+	list_add(&pwrst->node, &pwrst_list);
+
+	if (pwrdm_has_hdwr_sar(pwrdm))
+		pwrdm_enable_hdwr_sar(pwrdm);
+
+	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
+}
+
+/*
+ * Enable hw supervised mode for all clockdomains if it's
+ * supported. Initiate sleep transition for other clockdomains, if
+ * they are not used
+ */
+static int __init clkdms_setup(struct clockdomain *clkdm)
+{
+	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
+		omap2_clkdm_allow_idle(clkdm);
+	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
+		 atomic_read(&clkdm->usecount) == 0)
+		omap2_clkdm_sleep(clkdm);
+	return 0;
+}
+
+int __init omap3_pm_init(void)
+{
+	struct power_state *pwrst, *tmp;
+	int ret;
+
+	printk(KERN_ERR "Power Management for TI OMAP3.\n");
+
+	/* XXX prcm_setup_regs needs to be before enabling hw
+	 * supervised mode for powerdomains */
+	prcm_setup_regs();
+
+	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
+			  (irq_handler_t)prcm_interrupt_handler,
+			  IRQF_DISABLED, "prcm", NULL);
+	if (ret) {
+		printk(KERN_ERR "request_irq failed to register for 0x%x\n",
+		       INT_34XX_PRCM_MPU_IRQ);
+		goto err1;
+	}
+
+	ret = pwrdm_for_each(pwrdms_setup);
+	if (ret) {
+		printk(KERN_ERR "Failed to setup powerdomains\n");
+		goto err2;
+	}
+
+	(void) clkdm_for_each(clkdms_setup);
+
+	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
+	if (mpu_pwrdm == NULL) {
+		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
+		goto err2;
+	}
+
+	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
+					 omap34xx_cpu_suspend_sz);
+
+	suspend_set_ops(&omap_pm_ops);
+
+	pm_idle = omap3_pm_idle;
+
+err1:
+	return ret;
+err2:
+	free_irq(INT_34XX_PRCM_MPU_IRQ, NULL);
+	list_for_each_entry_safe(pwrst, tmp, &pwrst_list, node) {
+		list_del(&pwrst->node);
+		kfree(pwrst);
+	}
+	return ret;
+}
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
new file mode 100644
index 0000000..125b75a
--- /dev/null
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -0,0 +1,544 @@
+/*
+ * linux/arch/arm/mach-omap2/sleep.S
+ *
+ * (C) Copyright 2007
+ * Texas Instruments
+ * Karthik Dasu <karthik-dp@ti.com>
+ *
+ * (C) Copyright 2004
+ * Texas Instruments, <www.ti.com>
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <mach/io.h>
+#include <mach/pm.h>
+#include <mach/control.h>
+
+#include "prm.h"
+#include "sdrc.h"
+
+#define PM_PREPWSTST_CORE_V	OMAP34XX_PRM_REGADDR(CORE_MOD, \
+				OMAP3430_PM_PREPWSTST)
+#define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
+				OMAP3430_PM_PREPWSTST)
+#define PM_PWSTCTRL_MPU_P	OMAP34XX_PRM_REGADDR(MPU_MOD, PM_PWSTCTRL)
+#define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
+				       * available */
+#define SCRATCHPAD_BASE_P	OMAP343X_CTRL_REGADDR(\
+				OMAP343X_CONTROL_MEM_WKUP +\
+				SCRATCHPAD_MEM_OFFS)
+#define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
+
+	.text
+/* Function call to get the restore pointer for resume from OFF */
+ENTRY(get_restore_pointer)
+        stmfd   sp!, {lr}     @ save registers on stack
+	adr	r0, restore
+        ldmfd   sp!, {pc}     @ restore regs and return
+ENTRY(get_restore_pointer_sz)
+        .word   . - get_restore_pointer_sz
+/*
+ * Forces OMAP into idle state
+ *
+ * omap34xx_suspend() - This bit of code just executes the WFI
+ * for normal idles.
+ *
+ * Note: This code get's copied to internal SRAM at boot. When the OMAP
+ *	 wakes up it continues execution at the point it went to sleep.
+ */
+ENTRY(omap34xx_cpu_suspend)
+	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
+loop:
+	/*b	loop*/	@Enable to debug by stepping through code
+	/* r0 contains restore pointer in sdram */
+	/* r1 contains information about saving context */
+	ldr     r4, sdrc_power          @ read the SDRC_POWER register
+	ldr     r5, [r4]                @ read the contents of SDRC_POWER
+	orr     r5, r5, #0x40           @ enable self refresh on idle req
+	str     r5, [r4]                @ write back to SDRC_POWER register
+
+	cmp	r1, #0x0
+	/* If context save is required, do that and execute wfi */
+	bne	save_context_wfi
+	/* Data memory barrier and Data sync barrier */
+	mov	r1, #0
+	mcr	p15, 0, r1, c7, c10, 4
+	mcr	p15, 0, r1, c7, c10, 5
+
+	wfi				@ wait for interrupt
+
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	bl i_dll_wait
+
+	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
+restore:
+	/* b restore*/ 	@ Enable to debug restore code
+        /* Check what was the reason for mpu reset and store the reason in r9*/
+        /* 1 - Only L1 and logic lost */
+        /* 2 - Only L2 lost - In this case, we wont be here */
+        /* 3 - Both L1 and L2 lost */
+	ldr     r1, pm_pwstctrl_mpu
+	ldr	r2, [r1]
+	and     r2, r2, #0x3
+	cmp     r2, #0x0	@ Check if target power state was OFF or RET
+        moveq   r9, #0x3        @ MPU OFF => L1 and L2 lost
+	movne	r9, #0x1	@ Only L1 and L2 lost => avoid L2 invalidation
+	bne	logic_l1_restore
+	/* Execute smi to invalidate L2 cache */
+	mov r12, #0x1                         @ set up to invalide L2
+smi:    .word 0xE1600070                @ Call SMI monitor (smieq)
+logic_l1_restore:
+	mov	r1, #0
+	/* Invalidate all instruction caches to PoU
+	 * and flush branch target cache */
+	mcr	p15, 0, r1, c7, c5, 0
+
+	ldr	r4, scratchpad_base
+	ldr	r3, [r4,#0xBC]
+	ldmia	r3!, {r4-r6}
+	mov	sp, r4
+	msr	spsr_cxsf, r5
+	mov	lr, r6
+
+	ldmia	r3!, {r4-r9}
+	/* Coprocessor access Control Register */
+	mcr p15, 0, r4, c1, c0, 2
+
+	/* TTBR0 */
+	MCR p15, 0, r5, c2, c0, 0
+	/* TTBR1 */
+	MCR p15, 0, r6, c2, c0, 1
+	/* Translation table base control register */
+	MCR p15, 0, r7, c2, c0, 2
+	/*domain access Control Register */
+	MCR p15, 0, r8, c3, c0, 0
+	/* data fault status Register */
+	MCR p15, 0, r9, c5, c0, 0
+
+	ldmia  r3!,{r4-r8}
+	/* instruction fault status Register */
+	MCR p15, 0, r4, c5, c0, 1
+	/*Data Auxiliary Fault Status Register */
+	MCR p15, 0, r5, c5, c1, 0
+	/*Instruction Auxiliary Fault Status Register*/
+	MCR p15, 0, r6, c5, c1, 1
+	/*Data Fault Address Register */
+	MCR p15, 0, r7, c6, c0, 0
+	/*Instruction Fault Address Register*/
+	MCR p15, 0, r8, c6, c0, 2
+	ldmia  r3!,{r4-r7}
+
+	/* user r/w thread and process ID */
+	MCR p15, 0, r4, c13, c0, 2
+	/* user ro thread and process ID */
+	MCR p15, 0, r5, c13, c0, 3
+	/*Privileged only thread and process ID */
+	MCR p15, 0, r6, c13, c0, 4
+	/* cache size selection */
+	MCR p15, 2, r7, c0, c0, 0
+	ldmia  r3!,{r4-r8}
+	/* Data TLB lockdown registers */
+	MCR p15, 0, r4, c10, c0, 0
+	/* Instruction TLB lockdown registers */
+	MCR p15, 0, r5, c10, c0, 1
+	/* Secure or Nonsecure Vector Base Address */
+	MCR p15, 0, r6, c12, c0, 0
+	/* FCSE PID */
+	MCR p15, 0, r7, c13, c0, 0
+	/* Context PID */
+	MCR p15, 0, r8, c13, c0, 1
+
+	ldmia  r3!,{r4-r5}
+	/* primary memory remap register */
+	MCR p15, 0, r4, c10, c2, 0
+	/*normal memory remap register */
+	MCR p15, 0, r5, c10, c2, 1
+
+	/* Restore registers for other modes from SDRAM */
+	/* Save current mode */
+	mrs	r7, cpsr
+
+	/* FIQ mode */
+	bic	r0, r7, #0x1F
+	orr	r0, r0, #0x11
+	msr	cpsr, r0
+	ldmia	r3!, {r8-r12}
+	/* load the SP and LR from SDRAM */
+	ldmia  r3!,{r4-r6}
+	mov    sp, r4	/*update the SP */
+	mov    lr, r5	/*update the LR */
+	msr    spsr, r6	/*update the SPSR*/
+
+	/* IRQ mode */
+	bic    r0, r7, #0x1F
+	orr    r0, r0, #0x12
+	msr    cpsr, r0	/*go into IRQ mode*/
+	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM*/
+	mov    sp, r4	/*update the SP */
+	mov    lr, r5	/*update the LR */
+	msr    spsr, r6	/*update the SPSR */
+
+	/* ABORT mode */
+	bic    r0, r7, #0x1F
+	orr    r0, r0, #0x17
+	msr    cpsr, r0	/* go into ABORT mode */
+	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM */
+	mov    sp, r4		/*update the SP */
+	mov    lr, r5		/*update the LR */
+	msr    spsr, r6		/*update the SPSR */
+
+	/* UNDEEF mode */
+	bic    r0, r7, #0x1F
+	orr    r0, r0, #0x1B
+	msr    cpsr, r0		/*go into UNDEF mode */
+	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM */
+	mov    sp, r4		/*update the SP*/
+	mov    lr, r5		/*update the LR*/
+	msr    spsr, r6		/*update the SPSR*/
+
+	/* SYSTEM (USER) mode */
+	bic    r0, r7, #0x1F
+	orr    r0, r0, #0x1F
+	msr    cpsr, r0		/*go into USR mode */
+	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM*/
+	mov    sp, r4		/*update the SP */
+	mov    lr, r5		/*update the LR */
+	msr    spsr, r6		/*update the SPSR */
+	msr    cpsr, r7		/*back to original mode*/
+
+	/* Restore cpsr */
+	ldmia	r3!,{r4}	/*load CPSR from SDRAM*/
+	msr	cpsr, r4	/*store cpsr */
+
+	/* Enabling MMU here */
+	mrc	p15, 0, r7, c2, c0, 2 /* Read TTBRControl */
+	/* Extract N (0:2) bits and decide whether to use TTBR0 or TTBR1*/
+	and	r7, #0x7
+	cmp	r7, #0x0
+	beq	usettbr0
+ttbr_error:
+	/* More work needs to be done to support N[0:2] value other than 0
+	* So looping here so that the error can be detected
+	*/
+	b	ttbr_error
+usettbr0:
+	mrc	p15, 0, r2, c2, c0, 0
+	ldr	r5, ttbrbit_mask
+	and	r2, r5
+	mov	r4, pc
+	ldr	r5, table_index_mask
+	and	r4, r5 /* r4 = 31 to 20 bits of pc */
+	/* Extract the value to be written to table entry */
+	ldr	r1, table_entry
+	add	r1, r1, r4 /* r1 has value to be written to table entry*/
+	/* Getting the address of table entry to modify */
+	lsr	r4, #18
+	add	r2, r4 /* r2 has the location which needs to be modified */
+	/* Storing previous entry of location being modified */
+	ldr	r5, scratchpad_base
+	ldr	r4, [r2]
+	str	r4, [r5, #0xC0]
+	/* Modify the table entry */
+	str	r1, [r2]
+	/* Storing address of entry being modified
+	 * - will be restored after enabling MMU */
+	ldr	r5, scratchpad_base
+	str	r2, [r5, #0xC4]
+
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 4	@ Flush prefetch buffer
+	mcr	p15, 0, r0, c7, c5, 6	@ Invalidate branch predictor array
+	mcr	p15, 0, r0, c8, c5, 0	@ Invalidate instruction TLB
+	mcr	p15, 0, r0, c8, c6, 0	@ Invalidate data TLB
+	/* Restore control register  but dont enable caches here*/
+	/* Caches will be enabled after restoring MMU table entry */
+	ldmia	r3!, {r4}
+	/* Store previous value of control register in scratchpad */
+	str	r4, [r5, #0xC8]
+	ldr	r2, cache_pred_disable_mask
+	and	r4, r2
+	mcr	p15, 0, r4, c1, c0, 0
+
+	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
+save_context_wfi:
+	/*b	save_context_wfi*/	@ enable to debug save code
+	mov	r8, r0 /* Store SDRAM address in r8 */
+        /* Check what that target sleep state is:stored in r1*/
+        /* 1 - Only L1 and logic lost */
+        /* 2 - Only L2 lost */
+        /* 3 - Both L1 and L2 lost */
+	cmp	r1, #0x2 /* Only L2 lost */
+	beq	clean_l2
+	cmp	r1, #0x1 /* L2 retained */
+	/* r9 stores whether to clean L2 or not*/
+	moveq	r9, #0x0 /* Dont Clean L2 */
+	movne	r9, #0x1 /* Clean L2 */
+l1_logic_lost:
+	/* Store sp and spsr to SDRAM */
+	mov	r4, sp
+	mrs	r5, spsr
+	mov	r6, lr
+	stmia	r8!, {r4-r6}
+	/* Save all ARM registers */
+	/* Coprocessor access control register */
+	mrc	p15, 0, r6, c1, c0, 2
+	stmia	r8!, {r6}
+	/* TTBR0, TTBR1 and Translation table base control */
+	mrc	p15, 0, r4, c2, c0, 0
+	mrc	p15, 0, r5, c2, c0, 1
+	mrc	p15, 0, r6, c2, c0, 2
+	stmia	r8!, {r4-r6}
+	/* Domain access control register, data fault status register,
+	and instruction fault status register */
+	mrc	p15, 0, r4, c3, c0, 0
+	mrc	p15, 0, r5, c5, c0, 0
+	mrc	p15, 0, r6, c5, c0, 1
+	stmia	r8!, {r4-r6}
+	/* Data aux fault status register, instruction aux fault status,
+	datat fault address register and instruction fault address register*/
+	mrc	p15, 0, r4, c5, c1, 0
+	mrc	p15, 0, r5, c5, c1, 1
+	mrc	p15, 0, r6, c6, c0, 0
+	mrc	p15, 0, r7, c6, c0, 2
+	stmia	r8!, {r4-r7}
+	/* user r/w thread and process ID, user r/o thread and process ID,
+	priv only thread and process ID, cache size selection */
+	mrc	p15, 0, r4, c13, c0, 2
+	mrc	p15, 0, r5, c13, c0, 3
+	mrc	p15, 0, r6, c13, c0, 4
+	mrc	p15, 2, r7, c0, c0, 0
+	stmia	r8!, {r4-r7}
+	/* Data TLB lockdown, instruction TLB lockdown registers */
+	mrc	p15, 0, r5, c10, c0, 0
+	mrc	p15, 0, r6, c10, c0, 1
+	stmia	r8!, {r5-r6}
+	/* Secure or non secure vector base address, FCSE PID, Context PID*/
+	mrc	p15, 0, r4, c12, c0, 0
+	mrc	p15, 0, r5, c13, c0, 0
+	mrc	p15, 0, r6, c13, c0, 1
+	stmia	r8!, {r4-r6}
+	/* Primary remap, normal remap registers */
+	mrc	p15, 0, r4, c10, c2, 0
+	mrc	p15, 0, r5, c10, c2, 1
+	stmia	r8!,{r4-r5}
+	/* Store SP, LR, SPSR registers for SUP, FIQ, IRQ, ABORT and USER
+	modes into SDRAM */
+
+	/* move SDRAM address to r7 as r8 is banked in FIQ*/
+	mov	r7, r8
+
+	/* Save current mode */
+	mrs	r2, cpsr
+	/* FIQ mode */
+	bic	r0, r2, #0x1F
+	orr	r0, r0, #0x11
+	msr	cpsr, r0 /* go to FIQ mode */
+	stmia	r7!, {r8-r12}
+	mov	r4, r13 /* move SP into r4*/
+	mov	r5, r14
+	mrs	r6, spsr
+	stmia	r7!, {r4-r6}
+
+	/* IRQ mode */
+	bic	r0, r2, #0x1F
+	orr	r0, r0, #0x12
+	msr	cpsr, r0
+	mov	r4, r13
+	mov	r5, r14
+	mrs	r6, spsr
+	stmia	r7!, {r4-r6}
+
+	/* Abort mode */
+	bic	r0, r2, #0x1F
+	orr	r0, r0, #0x17
+	msr	cpsr, r0
+	mov	r4, r13
+	mov	r5, r14
+	mrs	r6, spsr
+	stmia	r7!, {r4-r6}
+
+	/* UNDEF mode */
+	bic	r0, r2, #0x1F
+	orr	r0, r0, #0x1B
+	msr	cpsr, r0
+	mov	r4, r13
+	mov	r5, r14
+	mrs	r6, spsr
+	stmia	r7!, {r4-r6}
+
+	/* System (USER mode) */
+	bic	r0, r2, #0x1F
+	orr	r0, r0, #0x1F
+	msr	cpsr, r0
+	mov	r4, r13
+	mov	r5, r14
+	mrs	r6, spsr
+	stmia	r7!, {r4-r6}
+
+	/* Back to original mode */
+	msr	cpsr, r2
+
+	/* Store current cpsr*/
+	stmia	r7!, {r2}
+
+	mrc	p15, 0, r4, c1, c0, 0
+	/* save control register */
+	stmia	r7!, {r4}
+clean_caches:
+	/* Clean Data or unified cache to POU*/
+	/* How to invalidate only L1 cache???? - #FIX_ME# */
+	/* mcr	p15, 0, r11, c7, c11, 1 */
+	cmp	r9, #1 /* Check whether L2 inval is required or not*/
+	bne	skip_l2_inval
+clean_l2:
+	/* read clidr */
+	mrc     p15, 1, r0, c0, c0, 1
+	/* extract loc from clidr */
+	ands    r3, r0, #0x7000000
+	/* left align loc bit field */
+	mov     r3, r3, lsr #23
+	/* if loc is 0, then no need to clean */
+	beq     finished
+	/* start clean at cache level 0 */
+	mov     r10, #0
+loop1:
+	/* work out 3x current cache level */
+	add     r2, r10, r10, lsr #1
+	/* extract cache type bits from clidr*/
+	mov     r1, r0, lsr r2
+	/* mask of the bits for current cache only */
+	and     r1, r1, #7
+	/* see what cache we have at this level */
+	cmp     r1, #2
+	/* skip if no cache, or just i-cache */
+	blt     skip
+	/* select current cache level in cssr */
+	mcr     p15, 2, r10, c0, c0, 0
+	/* isb to sych the new cssr&csidr */
+	isb
+	/* read the new csidr */
+	mrc     p15, 1, r1, c0, c0, 0
+	/* extract the length of the cache lines */
+	and     r2, r1, #7
+	/* add 4 (line length offset) */
+	add     r2, r2, #4
+	ldr     r4, assoc_mask
+	/* find maximum number on the way size */
+	ands    r4, r4, r1, lsr #3
+	/* find bit position of way size increment */
+	clz     r5, r4
+	ldr     r7, numset_mask
+	/* extract max number of the index size*/
+	ands    r7, r7, r1, lsr #13
+loop2:
+	mov     r9, r4
+	/* create working copy of max way size*/
+loop3:
+	/* factor way and cache number into r11 */
+	orr     r11, r10, r9, lsl r5
+	/* factor index number into r11 */
+	orr     r11, r11, r7, lsl r2
+	/*clean & invalidate by set/way */
+	mcr     p15, 0, r11, c7, c10, 2
+	/* decrement the way*/
+	subs    r9, r9, #1
+	bge     loop3
+	/*decrement the index */
+	subs    r7, r7, #1
+	bge     loop2
+skip:
+	add     r10, r10, #2
+	/* increment cache number */
+	cmp     r3, r10
+	bgt     loop1
+finished:
+	/*swith back to cache level 0 */
+	mov     r10, #0
+	/* select current cache level in cssr */
+	mcr     p15, 2, r10, c0, c0, 0
+	isb
+skip_l2_inval:
+	/* Data memory barrier and Data sync barrier */
+	mov     r1, #0
+	mcr     p15, 0, r1, c7, c10, 4
+	mcr     p15, 0, r1, c7, c10, 5
+
+	wfi                             @ wait for interrupt
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	bl i_dll_wait
+	/* restore regs and return */
+	ldmfd   sp!, {r0-r12, pc}
+
+i_dll_wait:
+	ldr     r4, clk_stabilize_delay
+
+i_dll_delay:
+	subs    r4, r4, #0x1
+	bne     i_dll_delay
+	ldr     r4, sdrc_power
+	ldr     r5, [r4]
+	bic     r5, r5, #0x40
+	str     r5, [r4]
+	bx	lr
+pm_prepwstst_core:
+	.word	PM_PREPWSTST_CORE_V
+pm_prepwstst_mpu:
+	.word	PM_PREPWSTST_MPU_V
+pm_pwstctrl_mpu:
+	.word	PM_PWSTCTRL_MPU_P
+scratchpad_base:
+	.word	SCRATCHPAD_BASE_P
+sdrc_power:
+	.word SDRC_POWER_V
+context_mem:
+	.word	0x803E3E14
+clk_stabilize_delay:
+	.word 0x000001FF
+assoc_mask:
+	.word	0x3ff
+numset_mask:
+	.word	0x7fff
+ttbrbit_mask:
+	.word	0xFFFFC000
+table_index_mask:
+	.word	0xFFF00000
+table_entry:
+	.word	0x00000C02
+cache_pred_disable_mask:
+	.word	0xFFFFE7FB
+ENTRY(omap34xx_cpu_suspend_sz)
+	.word	. - omap34xx_cpu_suspend
diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/plat-omap/include/mach/pm.h
index 2a9c27a..15c19f0 100644
--- a/arch/arm/plat-omap/include/mach/pm.h
+++ b/arch/arm/plat-omap/include/mach/pm.h
@@ -107,7 +107,8 @@
 #if     !defined(CONFIG_ARCH_OMAP730) && \
 	!defined(CONFIG_ARCH_OMAP15XX) && \
 	!defined(CONFIG_ARCH_OMAP16XX) && \
-	!defined(CONFIG_ARCH_OMAP24XX)
+	!defined(CONFIG_ARCH_OMAP24XX) && \
+	!defined(CONFIG_ARCH_OMAP34XX)
 #error "Power management for this processor not implemented yet"
 #endif
 
@@ -115,6 +116,8 @@
 
 #include <linux/clk.h>
 
+extern struct kset power_subsys;
+
 extern void prevent_idle_sleep(void);
 extern void allow_idle_sleep(void);
 
@@ -132,11 +135,19 @@ void clk_allow_idle(struct clk *clk);
 
 extern void omap_pm_idle(void);
 extern void omap_pm_suspend(void);
+#ifdef CONFIG_PM
+extern void omap2_block_sleep(void);
+extern void omap2_allow_sleep(void);
+#else
+static inline void omap2_block_sleep(void) { }
+static inline void omap2_allow_sleep(void) { }
+#endif
 extern void omap730_cpu_suspend(unsigned short, unsigned short);
 extern void omap1510_cpu_suspend(unsigned short, unsigned short);
 extern void omap1610_cpu_suspend(unsigned short, unsigned short);
 extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
 					void __iomem *sdrc_power);
+extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
 extern void omap730_idle_loop_suspend(void);
 extern void omap1510_idle_loop_suspend(void);
 extern void omap1610_idle_loop_suspend(void);
@@ -146,10 +157,12 @@ extern unsigned int omap730_cpu_suspend_sz;
 extern unsigned int omap1510_cpu_suspend_sz;
 extern unsigned int omap1610_cpu_suspend_sz;
 extern unsigned int omap24xx_cpu_suspend_sz;
+extern unsigned int omap34xx_cpu_suspend_sz;
 extern unsigned int omap730_idle_loop_suspend_sz;
 extern unsigned int omap1510_idle_loop_suspend_sz;
 extern unsigned int omap1610_idle_loop_suspend_sz;
 extern unsigned int omap24xx_idle_loop_suspend_sz;
+extern unsigned int omap34xx_suspend_sz;
 
 #ifdef CONFIG_OMAP_SERIAL_WAKE
 extern void omap_serial_wake_trigger(int enable);
@@ -182,10 +195,6 @@ extern void omap_serial_wake_trigger(int enable);
 #define MPUI1610_RESTORE(x) omap_writel((mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_##x]), (x))
 #define MPUI1610_SHOW(x) mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_##x]
 
-#define OMAP24XX_SAVE(x) omap24xx_sleep_save[OMAP24XX_SLEEP_SAVE_##x] = x
-#define OMAP24XX_RESTORE(x) x = omap24xx_sleep_save[OMAP24XX_SLEEP_SAVE_##x]
-#define OMAP24XX_SHOW(x) omap24xx_sleep_save[OMAP24XX_SLEEP_SAVE_##x]
-
 /*
  * List of global OMAP registers to preserve.
  * More ones like CP and general purpose register values are preserved
@@ -295,63 +304,5 @@ enum mpui1610_save_state {
 #endif
 };
 
-enum omap24xx_save_state {
-	OMAP24XX_SLEEP_SAVE_START = 0,
-	OMAP24XX_SLEEP_SAVE_INTC_MIR0,
-	OMAP24XX_SLEEP_SAVE_INTC_MIR1,
-	OMAP24XX_SLEEP_SAVE_INTC_MIR2,
-
-	OMAP24XX_SLEEP_SAVE_CM_CLKSTCTRL_MPU,
-	OMAP24XX_SLEEP_SAVE_CM_CLKSTCTRL_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_CLKSTCTRL_GFX,
-	OMAP24XX_SLEEP_SAVE_CM_CLKSTCTRL_DSP,
-	OMAP24XX_SLEEP_SAVE_CM_CLKSTCTRL_MDM,
-
-	OMAP24XX_SLEEP_SAVE_PM_PWSTCTRL_MPU,
-	OMAP24XX_SLEEP_SAVE_PM_PWSTCTRL_CORE,
-	OMAP24XX_SLEEP_SAVE_PM_PWSTCTRL_GFX,
-	OMAP24XX_SLEEP_SAVE_PM_PWSTCTRL_DSP,
-	OMAP24XX_SLEEP_SAVE_PM_PWSTCTRL_MDM,
-
-	OMAP24XX_SLEEP_SAVE_CM_IDLEST1_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_IDLEST2_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_IDLEST3_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_IDLEST4_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_IDLEST_GFX,
-	OMAP24XX_SLEEP_SAVE_CM_IDLEST_WKUP,
-	OMAP24XX_SLEEP_SAVE_CM_IDLEST_CKGEN,
-	OMAP24XX_SLEEP_SAVE_CM_IDLEST_DSP,
-	OMAP24XX_SLEEP_SAVE_CM_IDLEST_MDM,
-
-	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE1_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE2_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE3_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE4_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE_WKUP,
-	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE_PLL,
-	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE_DSP,
-	OMAP24XX_SLEEP_SAVE_CM_AUTOIDLE_MDM,
-
-	OMAP24XX_SLEEP_SAVE_CM_FCLKEN1_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_FCLKEN2_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_ICLKEN1_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_ICLKEN2_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_ICLKEN3_CORE,
-	OMAP24XX_SLEEP_SAVE_CM_ICLKEN4_CORE,
-	OMAP24XX_SLEEP_SAVE_GPIO1_IRQENABLE1,
-	OMAP24XX_SLEEP_SAVE_GPIO2_IRQENABLE1,
-	OMAP24XX_SLEEP_SAVE_GPIO3_IRQENABLE1,
-	OMAP24XX_SLEEP_SAVE_GPIO4_IRQENABLE1,
-	OMAP24XX_SLEEP_SAVE_GPIO3_OE,
-	OMAP24XX_SLEEP_SAVE_GPIO4_OE,
-	OMAP24XX_SLEEP_SAVE_GPIO3_RISINGDETECT,
-	OMAP24XX_SLEEP_SAVE_GPIO3_FALLINGDETECT,
-	OMAP24XX_SLEEP_SAVE_CONTROL_PADCONF_SPI1_NCS2,
-	OMAP24XX_SLEEP_SAVE_CONTROL_PADCONF_MCBSP1_DX,
-	OMAP24XX_SLEEP_SAVE_CONTROL_PADCONF_SSI1_FLAG_TX,
-	OMAP24XX_SLEEP_SAVE_CONTROL_PADCONF_SYS_NIRQW0,
-	OMAP24XX_SLEEP_SAVE_SIZE
-};
-
 #endif /* ASSEMBLER */
 #endif /* __ASM_ARCH_OMAP_PM_H */
-- 
1.6.1

