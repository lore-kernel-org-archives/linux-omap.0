From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v8 3/7] omap3: pm: TWL4030 power scripts for OMAP3 boards
Date: Wed,  2 Mar 2011 19:00:49 +0530
Message-ID: <1299072653-13414-4-git-send-email-leslyam@ti.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51140 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704Ab1CBNbJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 08:31:09 -0500
In-Reply-To: <1299072653-13414-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_reset.

TWL4030 power scripts which can be used by different OMAP3 boards
with the power companion chip (TWL4030 series).

The twl4030 generic script is exported and can be used by any other
boardfile to update the power data in twl4030_platform_data.

http://omapedia.org/wiki/TWL4030_power_scripts

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/twl4030.c |  145 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030.h |   20 ++++++
 include/linux/i2c/twl.h       |   33 +++++++++-
 3 files changed, 195 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030.c
 create mode 100644 arch/arm/mach-omap2/twl4030.h

diff --git a/arch/arm/mach-omap2/twl4030.c b/arch/arm/mach-omap2/twl4030.c
new file mode 100644
index 0000000..ff344b3
--- /dev/null
+++ b/arch/arm/mach-omap2/twl4030.c
@@ -0,0 +1,145 @@
+/*
+ * OMAP power script for PMIC TWL4030
+ *
+ * Author: Lesly A M <leslyam@ti.com>
+ *
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
+struct twl4030_power_data __initdata twl4030_generic_script = {
+	.scripts	= twl4030_scripts,
+	.num		= ARRAY_SIZE(twl4030_scripts),
+	.resource_config = twl4030_rconfig,
+};
+#endif
diff --git a/arch/arm/mach-omap2/twl4030.h b/arch/arm/mach-omap2/twl4030.h
new file mode 100644
index 0000000..ee66e7d
--- /dev/null
+++ b/arch/arm/mach-omap2/twl4030.h
@@ -0,0 +1,20 @@
+/*
+ * OMAP TWL4030 power scripts header file
+ *
+ * Author: Lesly A M <x0080970@ti.com>
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Lesly A M <x0080970@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP3_TWL4030_SCRIPT_H
+#define __ARCH_ARM_MACH_OMAP3_TWL4030_SCRIPT_H
+
+#include <linux/i2c/twl.h>
+
+extern struct twl4030_power_data twl4030_generic_script;
+#endif
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 61b9609..f4bd475 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -436,9 +436,23 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
 
 /* Power bus message definitions */
 
-/* The TWL4030/5030 splits its power-management resources (the various
- * regulators, clock and reset lines) into 3 processor groups - P1, P2 and
- * P3. These groups can then be configured to transition between sleep, wait-on
+/*
+ * The TWL4030/5030 splits its power-management resources (the various
+ * regulators, clock and reset lines) into 3 processor groups - P1, P2 and P3.
+ *
+ * Resources attached to device group P1 is managed depending on the state of
+ * NSLEEP1 pin of TRITON, which is connected to sys_off signal from OMAP
+ *
+ * Resources attached to device group P2 is managed depending on the state of
+ * NSLEEP2 pin of TRITON, which is can be connected to a modem or
+ * some other processor
+ *
+ * Resources attached to device group P3 is managed depending on the state of
+ * CLKREQ pin of TRITON, which is connected to clk request signal from OMAP
+ *
+ * If required these resources can be attached to combination of P1/P2/P3.
+ *
+ * These groups can then be configured to transition between sleep, wait-on
  * and active states by sending messages to the power bus.  See Section 5.4.2
  * Power Resources of TWL4030 TRM
  */
@@ -448,7 +462,17 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
 #define DEV_GRP_P1		0x1	/* P1: all OMAP devices */
 #define DEV_GRP_P2		0x2	/* P2: all Modem devices */
 #define DEV_GRP_P3		0x4	/* P3: all peripheral devices */
+#define DEV_GRP_ALL		0x7	/* P1/P2/P3: all devices */
 
+/*
+ * The 27 power resources in TRITON is again divided into
+ * analog resources:
+ *	Power Providers - LDO regulators, dc-to-dc regulators
+ *	Power Reference - analog reference
+ *
+ * and digital resources:
+ *	Reset & Clock - reset and clock signals.
+ */
 /* Resource groups */
 #define RES_GRP_RES		0x0	/* Reserved */
 #define RES_GRP_PP		0x1	/* Power providers */
@@ -460,7 +484,10 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
 #define RES_GRP_ALL		0x7	/* All resource groups */
 
 #define RES_TYPE2_R0		0x0
+#define RES_TYPE2_R1		0x1
+#define RES_TYPE2_R2		0x2
 
+#define RES_TYPE_R0		0x0
 #define RES_TYPE_ALL		0x7
 
 /* Resource states */
-- 
1.7.1

