From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v7 6/8] omap3: pm: Generic TRITON power scripts for OMAP3 based boards
Date: Thu,  1 Jul 2010 15:42:11 +0530
Message-ID: <1277979131-2145-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33638 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755078Ab0GAKPj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Jul 2010 06:15:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

This patch will create the generic TRITON power scripts which can be used
by different OMAP3 boards with the same power companion chip (TWL4030 series).

Added the api(twl4030_get_scripts/twl4030_get_vc_timings) to update the
sleep/wakeup/warm_reset sequence, resource configuration & voltsetup_time
in the board file.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/twl4030.c |  185 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030.h |   23 +++++
 arch/arm/mach-omap2/voltage.c |    5 +-
 3 files changed, 210 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030.c
 create mode 100644 arch/arm/mach-omap2/twl4030.h

diff --git a/arch/arm/mach-omap2/twl4030.c b/arch/arm/mach-omap2/twl4030.c
new file mode 100644
index 0000000..c493e5f
--- /dev/null
+++ b/arch/arm/mach-omap2/twl4030.c
@@ -0,0 +1,185 @@
+/*
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Lesly A M <leslyam@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifdef CONFIG_TWL4030_POWER
+
+#include "twl4030.h"
+
+static struct prm_setup_vc twl4030_voltsetup_time = {
+	/* VOLT SETUPTIME for RET */
+	.ret = {
+		.voltsetup1_vdd1 = 0x005B,
+		.voltsetup1_vdd2 = 0x0055,
+		.voltsetup2 = 0x0,
+		.voltoffset = 0x0,
+	},
+	/* VOLT SETUPTIME for OFF */
+	.off = {
+		.voltsetup1_vdd1 = 0x00B3,
+		.voltsetup1_vdd2 = 0x00A0,
+		.voltsetup2 = 0x118,
+		.voltoffset = 0x32,
+	},
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
+	&wakeup_p12_script,
+	&wakeup_p3_script,
+	&sleep_on_script,
+	&wrst_script,
+};
+
+static struct twl4030_resconfig twl4030_rconfig[] = {
+	{ .resource = RES_VPLL1, .devgroup = DEV_GRP_P1, .type = 3,
+		.type2 = 1, .remap_sleep = RES_STATE_OFF },
+	{ .resource = RES_VINTANA1, .devgroup = DEV_GRP_ALL, .type = 1,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VINTANA2, .devgroup = DEV_GRP_ALL, .type = 0,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VINTDIG, .devgroup = DEV_GRP_ALL, .type = 1,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VIO, .devgroup = DEV_GRP_ALL, .type = 2,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1,
+		.type = 4, .type2 = 1, .remap_sleep = RES_STATE_OFF },
+	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1,
+		.type = 3, .type2 = 1, .remap_sleep = RES_STATE_OFF },
+	{ .resource = RES_REGEN, .devgroup = DEV_GRP_ALL, .type = 2,
+		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_NRES_PWRON, .devgroup = DEV_GRP_ALL, .type = 0,
+		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_CLKEN, .devgroup = DEV_GRP_ALL, .type = 3,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_SYSEN, .devgroup = DEV_GRP_ALL, .type = 6,
+		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3,
+		.type = 0, .type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ 0, 0},
+};
+
+static struct twl4030_power_data twl4030_generic_script __initdata = {
+	.scripts	= twl4030_scripts,
+	.num		= ARRAY_SIZE(twl4030_scripts),
+	.resource_config = twl4030_rconfig,
+};
+
+void twl4030_get_scripts(struct twl4030_power_data *t2scripts_data)
+{
+	t2scripts_data->scripts = twl4030_generic_script.scripts;
+	t2scripts_data->num = twl4030_generic_script.num;
+	t2scripts_data->resource_config =
+			twl4030_generic_script.resource_config;
+}
+
+void twl4030_get_vc_timings(struct prm_setup_vc *setup_vc)
+{
+	/* copies new voltsetup time for RERT */
+	setup_vc->ret.voltsetup1_vdd1 =
+				twl4030_voltsetup_time.ret.voltsetup1_vdd1;
+	setup_vc->ret.voltsetup1_vdd2 =
+				twl4030_voltsetup_time.ret.voltsetup1_vdd2;
+	setup_vc->ret.voltsetup2 = twl4030_voltsetup_time.ret.voltsetup2;
+	setup_vc->ret.voltoffset = twl4030_voltsetup_time.ret.voltoffset;
+
+	/* copies new voltsetup time for OFF */
+	setup_vc->off.voltsetup1_vdd1 =
+				twl4030_voltsetup_time.off.voltsetup1_vdd1;
+	setup_vc->off.voltsetup1_vdd2 =
+				twl4030_voltsetup_time.off.voltsetup1_vdd2;
+	setup_vc->off.voltsetup2 = twl4030_voltsetup_time.off.voltsetup2;
+	setup_vc->off.voltoffset = twl4030_voltsetup_time.off.voltoffset;
+}
+#endif
diff --git a/arch/arm/mach-omap2/twl4030.h b/arch/arm/mach-omap2/twl4030.h
new file mode 100644
index 0000000..5e298c1
--- /dev/null
+++ b/arch/arm/mach-omap2/twl4030.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Lesly A M <leslyam@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ARCH_ARM_MACH_OMAP3_TWL4030_SCRIPT_H
+#define __ARCH_ARM_MACH_OMAP3_TWL4030_SCRIPT_H
+
+#include <linux/i2c/twl.h>
+#include "voltage.h"
+
+#ifdef CONFIG_TWL4030_POWER
+extern void twl4030_get_scripts(struct twl4030_power_data *t2scripts_data);
+extern void twl4030_get_vc_timings(struct prm_setup_vc *setup_vc);
+#else
+extern void twl4030_get_scripts(struct twl4030_power_data *t2scripts_data) {}
+extern void twl4030_get_vc_timings(struct prm_setup_vc *setup_vc) {}
+#endif
+
+#endif
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index a496d19..7362082 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -938,9 +938,8 @@ void __init omap_voltage_init_vc(struct prm_setup_vc *setup_vc)
 	if (!setup_vc)
 		return;
 
-	/* CLK SETUPTIME for RET & OFF */
-	vc_config.ret.clksetup = setup_vc->ret.clksetup;
-	vc_config.off.clksetup = setup_vc->off.clksetup;
+	/* CLK & VOLT SETUPTIME for RET & OFF */
+	memcpy(&vc_config, setup_vc, 2 * sizeof(struct setuptime_vc));
 }
 
 void omap_voltage_vc_update(int core_next_state)
-- 
1.7.0.4

