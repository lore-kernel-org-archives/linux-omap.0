From: x0080970@ti.com
Subject: [PATCH v2 4/6] omap3: pm: Generic TRITON power scripts for OMAP3 based boards
Date: Tue, 19 Jan 2010 23:06:17 +0530
Message-ID: <1263922577-13830-1-git-send-email-x0080970@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54804 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab0ASRYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 12:24:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

From: Lesly A M <x0080970@ti.com>

omap3: pm: Generic TRITON power scripts for OMAP3 based boards

Copying the sleep/wakeup/warm_rest sequence & voltsetup_time to a new
twl430 script file, since these changes are specific to the power companion chip.
This can be used by different OMAP3 boards with the same power companion chip
(TWL4030 series).

Added the api(use_generic_twl4030_script) to update
the sleep/wakeup/warm_rest sequence & voltsetup_time in the board file.

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>

---
 arch/arm/mach-omap2/twl4030-script.c |  143 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030-script.h |   17 ++++
 2 files changed, 160 insertions(+)

Index: linux-omap-pm/arch/arm/mach-omap2/twl4030-script.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-pm/arch/arm/mach-omap2/twl4030-script.c	2010-01-19 21:42:57.000000000 +0530
@@ -0,0 +1,143 @@
+/*
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Lesly A M <x0080970@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifdef CONFIG_TWL4030_POWER
+
+#include "twl4030-script.h"
+
+static struct prm_setup_vc twl4030_voltsetup_time = {
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0x005B,
+	.voltsetup_time2_ret = 0x0055,
+	.voltsetup_time1_off = 0x00B3,
+	.voltsetup_time2_off = 0x00A0,
+	.voltoffset = 0x118,
+	.voltsetup2 = 0x32,
+};
+
+/*
+ * Sequence to control the TRITON Power resources,
+ * when the system goes into sleep.
+ * Executed upon P1_P2/P3 transition for sleep.
+ */
+static struct twl4030_ins __initdata sleep_on_seq[] = {
+	/* Broadcast message to put res to sleep */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
+							RES_STATE_SLEEP), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_SLEEP), 2},
+};
+
+static struct twl4030_script sleep_on_script __initdata = {
+	.script	= sleep_on_seq,
+	.size	= ARRAY_SIZE(sleep_on_seq),
+	.flags	= TWL4030_SLEEP_SCRIPT,
+};
+
+/*
+ * Sequence to control the TRITON Power resources,
+ * when the system wakeup from sleep.
+ * Executed upon P1_P2 transition for wakeup.
+ */
+static struct twl4030_ins wakeup_p12_seq[] __initdata = {
+	/* Broadcast message to put res to active */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
+							RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script wakeup_p12_script __initdata = {
+	.script	= wakeup_p12_seq,
+	.size	= ARRAY_SIZE(wakeup_p12_seq),
+	.flags	= TWL4030_WAKEUP12_SCRIPT,
+};
+
+/*
+ * Sequence to control the TRITON Power resources,
+ * when the system wakeup from sleep.
+ * Executed upon P3 transition for wakeup.
+ */
+static struct twl4030_ins wakeup_p3_seq[] __initdata = {
+	/* Broadcast message to put res to active */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script wakeup_p3_script __initdata = {
+	.script = wakeup_p3_seq,
+	.size   = ARRAY_SIZE(wakeup_p3_seq),
+	.flags  = TWL4030_WAKEUP3_SCRIPT,
+};
+
+/*
+ * Sequence to reset the TRITON Power resources,
+ * when the system gets warm reset.
+ * Executed upon warm reset signal.
+ */
+static struct twl4030_ins wrst_seq[] __initdata = {
+/*
+ * Reset twl4030.
+ * Reset Main_Ref.
+ * Reset All type2_group2.
+ * Reset VUSB_3v1.
+ * Reset All type2_group1.
+ * Reset RC.
+ * Reenable twl4030.
+ */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_OFF), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_Main_Ref, RES_STATE_WRST), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_WRST), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_VUSB_3V1, RES_STATE_WRST), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
+							RES_STATE_WRST), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
+							RES_STATE_WRST), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script wrst_script __initdata = {
+	.script = wrst_seq,
+	.size   = ARRAY_SIZE(wrst_seq),
+	.flags  = TWL4030_WRST_SCRIPT,
+};
+
+/* TRITON script for sleep, wakeup & warm_reset */
+static struct twl4030_script *twl4030_scripts[] __initdata = {
+	&sleep_on_script,
+	&wakeup_p12_script,
+	&wakeup_p3_script,
+	&wrst_script,
+};
+
+static struct twl4030_power_data twl4030_generic_script __initdata = {
+	.scripts	= twl4030_scripts,
+	.num		= ARRAY_SIZE(twl4030_scripts),
+};
+
+void use_generic_twl4030_script(
+		struct twl4030_power_data *t2scripts_data,
+		struct prm_setup_vc *setup_vc)
+{
+	setup_vc->voltsetup_time1_ret =
+				twl4030_voltsetup_time.voltsetup_time1_ret;
+	setup_vc->voltsetup_time2_ret =
+				twl4030_voltsetup_time.voltsetup_time2_ret;
+	setup_vc->voltsetup_time1_off =
+				twl4030_voltsetup_time.voltsetup_time1_off;
+	setup_vc->voltsetup_time2_off =
+				twl4030_voltsetup_time.voltsetup_time1_off;
+
+	setup_vc->voltoffset = twl4030_voltsetup_time.voltoffset;
+	setup_vc->voltsetup2 = twl4030_voltsetup_time.voltsetup2;
+
+	t2scripts_data->scripts = twl4030_generic_script.scripts;
+	t2scripts_data->num = twl4030_generic_script.num;
+}
+
+#endif
Index: linux-omap-pm/arch/arm/mach-omap2/twl4030-script.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-pm/arch/arm/mach-omap2/twl4030-script.h	2010-01-19 21:41:57.000000000 +0530
@@ -0,0 +1,17 @@
+#ifndef __ARCH_ARM_MACH_OMAP3_TWL4030_SCRIPT_H
+#define __ARCH_ARM_MACH_OMAP3_TWL4030_SCRIPT_H
+
+#include <linux/i2c/twl.h>
+#include "pm.h"
+
+#ifdef CONFIG_TWL4030_POWER
+extern void use_generic_twl4030_script(
+		struct twl4030_power_data *t2scripts_data,
+		struct prm_setup_vc *setup_vc);
+#else
+static inline void use_generic_twl4030_script(
+		struct twl4030_power_data *t2scripts_data,
+		struct prm_setup_vc *setup_vc) {}
+#endif
+
+#endif
