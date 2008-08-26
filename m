From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 01/06] Basic cpuidle driver - enables C0-C2
Date: Tue, 26 Aug 2008 18:33:30 +0530 (IST)
Message-ID: <64305.192.168.10.89.1219755810.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41192 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbYHZNDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 09:03:36 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7QD3VgH003412
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 08:03:36 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7QD3T8i021954
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 08:03:30 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Basic cpuidle driver for omap34xx based platforms.
Enables states C0-C2.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    2
 arch/arm/mach-omap2/cpuidle34xx.c |  245 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cpuidle34xx.h |   53 ++++++++
 arch/arm/mach-omap2/pm34xx.c      |    5
 4 files changed, 303 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-08-26
13:30:45.000000000 +0530
@@ -0,0 +1,245 @@
+/*
+ * linux/arch/arm/mach-omap2/cpuidle34xx.c
+ *
+ * OMAP3 CPU IDLE Routines
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Karthik Dasu <karthik-dp@ti.com>
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ * Tony Lindgren <tony@atomide.com>
+ *
+ * Copyright (C) 2005 Texas Instruments, Inc.
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * Based on pm.c for omap2
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpuidle.h>
+#include <mach/pm.h>
+#include <mach/prcm.h>
+#include <mach/powerdomain.h>
+#include "cpuidle34xx.h"
+
+#ifdef CONFIG_CPU_IDLE
+
+struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
+struct omap3_processor_cx current_cx_state;
+
+static int omap3_idle_bm_check(void)
+{
+	return 0;
+}
+
+/* omap3_enter_idle - Programs OMAP3 to enter the specified state.
+ * returns the total time during which the system was idle.
+ */
+static int omap3_enter_idle(struct cpuidle_device *dev,
+			struct cpuidle_state *state)
+{
+	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
+	struct timespec ts_preidle, ts_postidle, ts_idle;
+	struct powerdomain *mpu_pd;
+
+	current_cx_state = *cx;
+
+	/* Used to keep track of the total time in idle */
+	getnstimeofday(&ts_preidle);
+
+
+	if (cx->type == OMAP3_STATE_C0) {
+		/* Do nothing for C0, not even a wfi */
+		return 0;
+	}
+
+	mpu_pd = pwrdm_lookup("mpu_pwrdm");
+	/* Program MPU to target state */
+	if (cx->mpu_state < PWRDM_POWER_ON)
+		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
+
+	/* Execute ARM wfi */
+	omap_sram_idle();
+
+	/* Program MPU to ON */
+	if (cx->mpu_state < PWRDM_POWER_ON)
+		pwrdm_set_next_pwrst(mpu_pd, PWRDM_POWER_ON);
+
+	getnstimeofday(&ts_postidle);
+	ts_idle = timespec_sub(ts_postidle, ts_preidle);
+	return timespec_to_ns(&ts_idle);
+}
+
+static int omap3_enter_idle_bm(struct cpuidle_device *dev,
+			       struct cpuidle_state *state)
+{
+	struct cpuidle_state *new_state = NULL;
+	int i, j;
+
+	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
+
+		/* Find current state in list */
+		for (i = 0; i < OMAP3_MAX_STATES; i++)
+			if (state == &dev->states[i])
+				break;
+		BUG_ON(i == OMAP3_MAX_STATES);
+
+		/* Back up to non 'CHECK_BM' state */
+		for (j = i - 1;  j > 0; j--) {
+			struct cpuidle_state *s = &dev->states[j];
+
+			if (!(s->flags & CPUIDLE_FLAG_CHECK_BM)) {
+				new_state = s;
+				break;
+			}
+		}
+
+		pr_debug("%s: Bus activity: Entering %s (instead of %s)\n",
+			__func__, new_state->name, state->name);
+	}
+
+	return omap3_enter_idle(dev, new_state ? : state);
+}
+
+DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
+
+/* omap3_init_power_states - Initialises the OMAP3 specific C states.
+ * Below is the desciption of each C state.
+ *
+	C0 . System executing code
+	C1 . MPU WFI + Core active
+	C2 . MPU CSWR + Core active
+	C3 . MPU OFF + Core active
+	C4 . MPU CSWR + Core CSWR
+	C5 . MPU OFF + Core CSWR
+	C6 . MPU OFF + Core OFF
+ */
+void omap_init_power_states(void)
+{
+	/* C0 . System executing code */
+	omap3_power_states[0].valid = 1;
+	omap3_power_states[0].type = OMAP3_STATE_C0;
+	omap3_power_states[0].sleep_latency = 0;
+	omap3_power_states[0].wakeup_latency = 0;
+	omap3_power_states[0].threshold = 0;
+	omap3_power_states[0].mpu_state = PWRDM_POWER_ON;
+	omap3_power_states[0].core_state = PWRDM_POWER_ON;
+	omap3_power_states[0].flags = CPUIDLE_FLAG_TIME_VALID;
+
+	/* C1 . MPU WFI + Core active */
+	omap3_power_states[1].valid = 1;
+	omap3_power_states[1].type = OMAP3_STATE_C1;
+	omap3_power_states[1].sleep_latency = 10;
+	omap3_power_states[1].wakeup_latency = 10;
+	omap3_power_states[1].threshold = 30;
+	omap3_power_states[1].mpu_state = PWRDM_POWER_ON;
+	omap3_power_states[1].core_state = PWRDM_POWER_ON;
+	omap3_power_states[1].flags = CPUIDLE_FLAG_TIME_VALID;
+
+	/* C2 . MPU CSWR + Core active */
+	omap3_power_states[2].valid = 1;
+	omap3_power_states[2].type = OMAP3_STATE_C2;
+	omap3_power_states[2].sleep_latency = 50;
+	omap3_power_states[2].wakeup_latency = 50;
+	omap3_power_states[2].threshold = 300;
+	omap3_power_states[2].mpu_state = PWRDM_POWER_RET;
+	omap3_power_states[2].core_state = PWRDM_POWER_ON;
+	omap3_power_states[2].flags = CPUIDLE_FLAG_TIME_VALID;
+
+	/* C3 . MPU OFF + Core active */
+	omap3_power_states[3].valid = 0;
+	omap3_power_states[3].type = OMAP3_STATE_C3;
+	omap3_power_states[3].sleep_latency = 1500;
+	omap3_power_states[3].wakeup_latency = 1800;
+	omap3_power_states[3].threshold = 4000;
+	omap3_power_states[3].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[3].core_state = PWRDM_POWER_RET;
+	omap3_power_states[3].flags = CPUIDLE_FLAG_TIME_VALID;
+
+	/* C4 . MPU CSWR + Core CSWR*/
+	omap3_power_states[4].valid = 0;
+	omap3_power_states[4].type = OMAP3_STATE_C4;
+	omap3_power_states[4].sleep_latency = 2500;
+	omap3_power_states[4].wakeup_latency = 7500;
+	omap3_power_states[4].threshold = 12000;
+	omap3_power_states[4].mpu_state = PWRDM_POWER_RET;
+	omap3_power_states[4].core_state = PWRDM_POWER_RET;
+	omap3_power_states[4].flags = CPUIDLE_FLAG_TIME_VALID;
+
+	/* C5 . MPU OFF + Core CSWR */
+	omap3_power_states[5].valid = 0;
+	omap3_power_states[5].type = OMAP3_STATE_C5;
+	omap3_power_states[5].sleep_latency = 3000;
+	omap3_power_states[5].wakeup_latency = 8500;
+	omap3_power_states[5].threshold = 15000;
+	omap3_power_states[5].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[5].core_state = PWRDM_POWER_RET;
+	omap3_power_states[5].flags = CPUIDLE_FLAG_TIME_VALID;
+
+	/* C6 . MPU OFF + Core OFF */
+	omap3_power_states[6].valid = 0;
+	omap3_power_states[6].type = OMAP3_STATE_C6;
+	omap3_power_states[6].sleep_latency = 10000;
+	omap3_power_states[6].wakeup_latency = 30000;
+	omap3_power_states[6].threshold = 300000;
+	omap3_power_states[6].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[6].core_state = PWRDM_POWER_OFF;
+	omap3_power_states[6].flags = CPUIDLE_FLAG_TIME_VALID;
+}
+
+struct cpuidle_driver omap3_idle_driver = {
+	.name = 	"omap3_idle",
+	.owner = 	THIS_MODULE,
+};
+/*
+ * omap3_idle_init - Init routine for OMAP3 idle. Registers the OMAP3 specific
+ * cpuidle driver with the cpuidle f/w with the valid set of states.
+ */
+int omap3_idle_init(void)
+{
+	int i, count = 0;
+	struct omap3_processor_cx *cx;
+	struct cpuidle_state *state;
+	struct cpuidle_device *dev;
+
+	omap_init_power_states();
+	cpuidle_register_driver(&omap3_idle_driver);
+
+	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
+
+	for (i = 0; i < OMAP3_MAX_STATES; i++) {
+		cx = &omap3_power_states[i];
+		state = &dev->states[count];
+
+		if (!cx->valid)
+			continue;
+		cpuidle_set_statedata(state, cx);
+		state->exit_latency = cx->sleep_latency + cx->wakeup_latency;
+		state->target_residency = cx->threshold;
+		state->flags = cx->flags;
+		state->enter = (state->flags & CPUIDLE_FLAG_CHECK_BM) ?
+			omap3_enter_idle_bm : omap3_enter_idle;
+		sprintf(state->name, "C%d", count+1);
+		count++;
+	}
+
+	if (!count)
+		return -EINVAL;
+	dev->state_count = count;
+
+	if (cpuidle_register_device(dev)) {
+		printk(KERN_ERR "%s: CPUidle register device failed\n",
+		       __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+__initcall(omap3_idle_init);
+#endif /* CONFIG_CPU_IDLE */
Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h	2008-08-26
13:31:35.000000000 +0530
@@ -0,0 +1,53 @@
+/*
+ * linux/arch/arm/mach-omap2/cpuidle34xx.h
+ *
+ * OMAP3 cpuidle structure definitions
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Written by Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * History:
+ *
+ */
+
+#ifndef ARCH_ARM_MACH_OMAP2_CPUIDLE_34XX
+#define ARCH_ARM_MACH_OMAP2_CPUIDLE_34XX
+
+#define OMAP3_MAX_STATES 7
+#define OMAP3_STATE_C0 0 /* C0 - System executing code */
+#define OMAP3_STATE_C1 1 /* C1 - MPU WFI + Core active */
+#define OMAP3_STATE_C2 2 /* C2 - MPU CSWR + Core active */
+#define OMAP3_STATE_C3 3 /* C3 - MPU OFF + Core active */
+#define OMAP3_STATE_C4 4 /* C4 - MPU RET + Core RET */
+#define OMAP3_STATE_C5 5 /* C5 - MPU OFF + Core RET */
+#define OMAP3_STATE_C6 6 /* C6 - MPU OFF + Core OFF */
+
+/* Currently, we support only upto C2 */
+#define MAX_SUPPORTED_STATES 3
+
+extern void omap_sram_idle(void);
+
+struct omap3_processor_cx {
+	u8 valid;
+	u8 type;
+	u32 sleep_latency;
+	u32 wakeup_latency;
+	u32 mpu_state;
+	u32 core_state;
+	u32 threshold;
+	u32 flags;
+};
+
+void omap_init_power_states(void);
+int omap3_idle_init(void);
+
+#endif /* ARCH_ARM_MACH_OMAP2_CPUIDLE_34XX */
+
Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-08-26
12:25:26.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-08-26 13:30:45.000000000
+0530
@@ -176,7 +176,7 @@ static irqreturn_t prcm_interrupt_handle
 	return IRQ_HANDLED;
 }

-static void omap_sram_idle(void)
+void omap_sram_idle(void)
 {
 	/* Variable to tell what needs to be saved and restored
 	 * in omap_sram_idle*/
@@ -191,6 +191,7 @@ static void omap_sram_idle(void)

 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
+	case PWRDM_POWER_ON:
 	case PWRDM_POWER_RET:
 		/* No need to save context */
 		save_state = 0;
@@ -754,7 +755,9 @@ int __init omap3_pm_init(void)

 	suspend_set_ops(&omap_pm_ops);

+#ifndef CONFIG_CPU_IDLE
 	pm_idle = omap3_pm_idle;
+#endif

 	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
 	 * handles fcks correctly */
Index: linux-omap-2.6/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/Makefile	2008-08-26
12:25:26.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/Makefile	2008-08-26 12:25:29.000000000
+0530
@@ -23,7 +23,7 @@ ifeq ($(CONFIG_PM),y)
 obj-y					+= pm.o
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 endif



