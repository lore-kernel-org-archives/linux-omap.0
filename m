From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 01/05] OMAP3: Basic Cpuidle with support for C0-C2
Date: Thu, 23 Oct 2008 14:47:51 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE39430AC7FE6@vaebe110.NOE.Nokia.com>
References: <001701c9293d$869c3da0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26534 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYJWLsU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Oct 2008 07:48:20 -0400
Content-class: urn:content-classes:message
In-Reply-To: <001701c9293d$869c3da0$LocalHost@wipultra1382>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rnayak@ti.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

Hi Rajendra,

Currently cpuidle is not taking enable_off_mode variable (from pm.c)
into account, it only controls suspend / dynamic idle behavior.

-Tero 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext 
>Rajendra Nayak
>Sent: 08 October, 2008 15:01
>To: linux-omap@vger.kernel.org
>Cc: 'Kevin Hilman'
>Subject: [PATCH 01/05] OMAP3: Basic Cpuidle with support for C0-C2
>
>Basic cpuidle driver for OMAP3 with deepest sleep state 
>supported being MPU CSWR.
>
>Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>---
> arch/arm/mach-omap2/Makefile         |    2 
> arch/arm/mach-omap2/cpuidle34xx.c    |  274 
>+++++++++++++++++++++++++++++++++++
> arch/arm/mach-omap2/pm34xx.c         |    4 
> arch/arm/plat-omap/include/mach/pm.h |    1 
> 4 files changed, 279 insertions(+), 2 deletions(-)
>
>Index: linux-omap-2.6/arch/arm/mach-omap2/Makefile
>===================================================================
>--- linux-omap-2.6.orig/arch/arm/mach-omap2/Makefile	
>2008-10-08 16:49:07.000000000 +0530
>+++ linux-omap-2.6/arch/arm/mach-omap2/Makefile	
>2008-10-08 16:49:10.000000000 +0530
>@@ -23,7 +23,7 @@ ifeq ($(CONFIG_PM),y)
> obj-y					+= pm.o
> obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
> obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
>-obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
>+obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o 
>cpuidle34xx.o
> obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
> endif
> 
>Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
>===================================================================
>--- /dev/null	1970-01-01 00:00:00.000000000 +0000
>+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	
>2008-10-08 16:50:02.000000000 +0530
>@@ -0,0 +1,274 @@
>+/*
>+ * linux/arch/arm/mach-omap2/cpuidle34xx.c
>+ *
>+ * OMAP3 CPU IDLE Routines
>+ *
>+ * Copyright (C) 2008 Texas Instruments, Inc.
>+ * Rajendra Nayak <rnayak@ti.com>
>+ *
>+ * Copyright (C) 2007 Texas Instruments, Inc.
>+ * Karthik Dasu <karthik-dp@ti.com>
>+ *
>+ * Copyright (C) 2006 Nokia Corporation
>+ * Tony Lindgren <tony@atomide.com>
>+ *
>+ * Copyright (C) 2005 Texas Instruments, Inc.
>+ * Richard Woodruff <r-woodruff2@ti.com>
>+ *
>+ * Based on pm.c for omap2
>+ *
>+ * This program is free software; you can redistribute it 
>and/or modify
>+ * it under the terms of the GNU General Public License version 2 as
>+ * published by the Free Software Foundation.
>+ */
>+
>+#include <linux/cpuidle.h>
>+#include <mach/pm.h>
>+#include <mach/prcm.h>
>+#include <mach/powerdomain.h>
>+
>+#ifdef CONFIG_CPU_IDLE
>+
>+#define OMAP3_MAX_STATES 7
>+#define OMAP3_STATE_C0 0 /* C0 - System executing code */ #define 
>+OMAP3_STATE_C1 1 /* C1 - MPU WFI + Core active */ #define 
>+OMAP3_STATE_C2 2 /* C2 - MPU CSWR + Core active */ #define 
>+OMAP3_STATE_C3 3 /* C3 - MPU OFF + Core active */ #define 
>+OMAP3_STATE_C4 4 /* C4 - MPU RET + Core RET */ #define 
>OMAP3_STATE_C5 5 
>+/* C5 - MPU OFF + Core RET */ #define OMAP3_STATE_C6 6 /* C6 
>- MPU OFF 
>++ Core OFF */
>+
>+struct omap3_processor_cx {
>+	u8 valid;
>+	u8 type;
>+	u32 sleep_latency;
>+	u32 wakeup_latency;
>+	u32 mpu_state;
>+	u32 core_state;
>+	u32 threshold;
>+	u32 flags;
>+};
>+
>+struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
>+struct omap3_processor_cx current_cx_state; struct 
>powerdomain *mpu_pd;
>+
>+static int omap3_idle_bm_check(void)
>+{
>+	return 0;
>+}
>+
>+/**
>+ * omap3_enter_idle - Programs OMAP3 to enter the specified state
>+ * @dev: cpuidle device
>+ * @state: The target state to be programmed
>+ *
>+ * Called from the CPUidle framework to program the device to the
>+ * specified target state selected by the governor.
>+ */
>+static int omap3_enter_idle(struct cpuidle_device *dev,
>+			struct cpuidle_state *state)
>+{
>+	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
>+	struct timespec ts_preidle, ts_postidle, ts_idle;
>+
>+	current_cx_state = *cx;
>+
>+	/* Used to keep track of the total time in idle */
>+	getnstimeofday(&ts_preidle);
>+
>+	local_irq_disable();
>+	local_fiq_disable();
>+
>+	/* Program MPU to target state */
>+	if (cx->mpu_state < PWRDM_POWER_ON)
>+		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
>+
>+	/* Execute ARM wfi */
>+	omap_sram_idle();
>+
>+	/* Program MPU to ON */
>+	if (cx->mpu_state < PWRDM_POWER_ON)
>+		pwrdm_set_next_pwrst(mpu_pd, PWRDM_POWER_ON);
>+
>+	getnstimeofday(&ts_postidle);
>+	ts_idle = timespec_sub(ts_postidle, ts_preidle);
>+
>+	local_irq_enable();
>+	local_fiq_enable();
>+
>+	return timespec_to_ns(&ts_idle);
>+}
>+
>+/**
>+ * omap3_enter_idle_bm - Checks for any bus activity
>+ * @dev: cpuidle device
>+ * @state: The target state to be programmed
>+ *
>+ * Called from the CPUidle framework for C states with 
>+CPUIDLE_FLAG_CHECK_BM
>+ * flag set. This function checks for any pending bus 
>activity and then
>+ * programs the device to the specified or a lower possible state  */ 
>+static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>+			       struct cpuidle_state *state)
>+{
>+	struct cpuidle_state *new_state = NULL;
>+	int i, j;
>+
>+	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && 
>omap3_idle_bm_check()) {
>+
>+		/* Find current state in list */
>+		for (i = 0; i < OMAP3_MAX_STATES; i++)
>+			if (state == &dev->states[i])
>+				break;
>+		BUG_ON(i == OMAP3_MAX_STATES);
>+
>+		/* Back up to non 'CHECK_BM' state */
>+		for (j = i - 1;  j > 0; j--) {
>+			struct cpuidle_state *s = &dev->states[j];
>+
>+			if (!(s->flags & CPUIDLE_FLAG_CHECK_BM)) {
>+				new_state = s;
>+				break;
>+			}
>+		}
>+
>+		pr_debug("%s: Bus activity: Entering %s 
>(instead of %s)\n",
>+			__func__, new_state->name, state->name);
>+	}
>+
>+	return omap3_enter_idle(dev, new_state ? : state); }
>+
>+DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
>+
>+/* omap3_init_power_states - Initialises the OMAP3 specific C states.
>+ *
>+ * Below is the desciption of each C state.
>+ *	C0 . System executing code (Not an idle state)
>+ *	C1 . MPU WFI + Core active
>+ *	C2 . MPU CSWR + Core active
>+ *	C3 . MPU OFF + Core active
>+ *	C4 . MPU CSWR + Core CSWR
>+ *	C5 . MPU OFF + Core CSWR
>+ *	C6 . MPU OFF + Core OFF
>+ */
>+void omap_init_power_states(void)
>+{
>+	/* C1 . MPU WFI + Core active */
>+	omap3_power_states[OMAP3_STATE_C1].valid = 1;
>+	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
>+	omap3_power_states[OMAP3_STATE_C1].sleep_latency = 10;
>+	omap3_power_states[OMAP3_STATE_C1].wakeup_latency = 10;
>+	omap3_power_states[OMAP3_STATE_C1].threshold = 30;
>+	omap3_power_states[OMAP3_STATE_C1].mpu_state = PWRDM_POWER_ON;
>+	omap3_power_states[OMAP3_STATE_C1].core_state = PWRDM_POWER_ON;
>+	omap3_power_states[OMAP3_STATE_C1].flags = 
>CPUIDLE_FLAG_TIME_VALID;
>+
>+	/* C2 . MPU CSWR + Core active */
>+	omap3_power_states[OMAP3_STATE_C2].valid = 1;
>+	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
>+	omap3_power_states[OMAP3_STATE_C2].sleep_latency = 50;
>+	omap3_power_states[OMAP3_STATE_C2].wakeup_latency = 50;
>+	omap3_power_states[OMAP3_STATE_C2].threshold = 300;
>+	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_RET;
>+	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
>+	omap3_power_states[OMAP3_STATE_C2].flags = 
>CPUIDLE_FLAG_TIME_VALID;
>+
>+	/* C3 . MPU OFF + Core active */
>+	omap3_power_states[OMAP3_STATE_C3].valid = 0;
>+	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
>+	omap3_power_states[OMAP3_STATE_C3].sleep_latency = 1500;
>+	omap3_power_states[OMAP3_STATE_C3].wakeup_latency = 1800;
>+	omap3_power_states[OMAP3_STATE_C3].threshold = 4000;
>+	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_OFF;
>+	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
>+	omap3_power_states[OMAP3_STATE_C3].flags = 
>CPUIDLE_FLAG_TIME_VALID;
>+
>+	/* C4 . MPU CSWR + Core CSWR*/
>+	omap3_power_states[OMAP3_STATE_C4].valid = 0;
>+	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
>+	omap3_power_states[OMAP3_STATE_C4].sleep_latency = 2500;
>+	omap3_power_states[OMAP3_STATE_C4].wakeup_latency = 7500;
>+	omap3_power_states[OMAP3_STATE_C4].threshold = 12000;
>+	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_RET;
>+	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_RET;
>+	omap3_power_states[OMAP3_STATE_C4].flags = 
>CPUIDLE_FLAG_TIME_VALID |
>+				CPUIDLE_FLAG_CHECK_BM;
>+
>+	/* C5 . MPU OFF + Core CSWR */
>+	omap3_power_states[OMAP3_STATE_C5].valid = 0;
>+	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
>+	omap3_power_states[OMAP3_STATE_C5].sleep_latency = 3000;
>+	omap3_power_states[OMAP3_STATE_C5].wakeup_latency = 8500;
>+	omap3_power_states[OMAP3_STATE_C5].threshold = 15000;
>+	omap3_power_states[OMAP3_STATE_C5].mpu_state = PWRDM_POWER_OFF;
>+	omap3_power_states[OMAP3_STATE_C5].core_state = PWRDM_POWER_RET;
>+	omap3_power_states[OMAP3_STATE_C5].flags = 
>CPUIDLE_FLAG_TIME_VALID |
>+				CPUIDLE_FLAG_CHECK_BM;
>+
>+	/* C6 . MPU OFF + Core OFF */
>+	omap3_power_states[OMAP3_STATE_C6].valid = 0;
>+	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
>+	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 10000;
>+	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 30000;
>+	omap3_power_states[OMAP3_STATE_C6].threshold = 300000;
>+	omap3_power_states[OMAP3_STATE_C6].mpu_state = PWRDM_POWER_OFF;
>+	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_OFF;
>+	omap3_power_states[OMAP3_STATE_C6].flags = 
>CPUIDLE_FLAG_TIME_VALID |
>+				CPUIDLE_FLAG_CHECK_BM;
>+}
>+
>+struct cpuidle_driver omap3_idle_driver = {
>+	.name = 	"omap3_idle",
>+	.owner = 	THIS_MODULE,
>+};
>+
>+/**
>+ * omap3_idle_init - Init routine for OMAP3 idle
>+ *
>+ * Registers the OMAP3 specific cpuidle driver with the cpuidle
>+ * framework with the valid set of states.
>+ */
>+int omap3_idle_init(void)
>+{
>+	int i, count = 0;
>+	struct omap3_processor_cx *cx;
>+	struct cpuidle_state *state;
>+	struct cpuidle_device *dev;
>+
>+	omap_init_power_states();
>+	cpuidle_register_driver(&omap3_idle_driver);
>+
>+	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
>+
>+	for (i = 1; i < OMAP3_MAX_STATES; i++) {
>+		cx = &omap3_power_states[i];
>+		state = &dev->states[count];
>+
>+		if (!cx->valid)
>+			continue;
>+		cpuidle_set_statedata(state, cx);
>+		state->exit_latency = cx->sleep_latency + 
>cx->wakeup_latency;
>+		state->target_residency = cx->threshold;
>+		state->flags = cx->flags;
>+		state->enter = (state->flags & CPUIDLE_FLAG_CHECK_BM) ?
>+			omap3_enter_idle_bm : omap3_enter_idle;
>+		sprintf(state->name, "C%d", count+1);
>+		count++;
>+	}
>+
>+	if (!count)
>+		return -EINVAL;
>+	dev->state_count = count;
>+
>+	if (cpuidle_register_device(dev)) {
>+		printk(KERN_ERR "%s: CPUidle register device failed\n",
>+		       __func__);
>+		return -EIO;
>+	}
>+	mpu_pd = pwrdm_lookup("mpu_pwrdm");
>+	return 0;
>+}
>+device_initcall(omap3_idle_init);
>+#endif /* CONFIG_CPU_IDLE */
>Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
>===================================================================
>--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	
>2008-10-08 10:51:48.000000000 +0530
>+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	
>2008-10-08 16:49:10.000000000 +0530
>@@ -226,7 +226,7 @@ static void restore_table_entry(void)
> 	restore_control_register(control_reg_value);
> }
> 
>-static void omap_sram_idle(void)
>+void omap_sram_idle(void)
> {
> 	/* Variable to tell what needs to be saved and restored
> 	 * in omap_sram_idle*/
>@@ -777,7 +777,9 @@ int __init omap3_pm_init(void)
> 	omap_push_sram_idle();
> 	suspend_set_ops(&omap_pm_ops);
> 
>+#ifndef CONFIG_CPU_IDLE
> 	pm_idle = omap3_pm_idle;
>+#endif
> 
> 	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
> 	/*
>Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/pm.h
>===================================================================
>--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/pm.h	
>2008-10-08 10:51:48.000000000 +0530
>+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/pm.h	
>2008-10-08 16:49:10.000000000 +0530
>@@ -135,6 +135,7 @@ void clk_allow_idle(struct clk *clk);
> 
> extern void omap_pm_idle(void);
> extern void omap_pm_suspend(void);
>+extern void omap_sram_idle(void);
> #ifdef CONFIG_PM
> extern void omap2_block_sleep(void);
> extern void omap2_allow_sleep(void);
>
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in the body of a message to 
>majordomo@vger.kernel.org More majordomo info at  
>http://vger.kernel.org/majordomo-info.html
>
