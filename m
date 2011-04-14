From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v9 4/9] OMAP3: PM: TWL4030 power scripts for OMAP3 boards
Date: Thu, 14 Apr 2011 17:57:52 +0530
Message-ID: <1302784077-16697-5-git-send-email-leslyam@ti.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42250 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757163Ab1DNM1x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Apr 2011 08:27:53 -0400
In-Reply-To: <1302784077-16697-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_reset.

TWL4030 power scripts which can be used by different OMAP3 boards
with the power companion chip (TWL4030 series).

The twl4030 generic script can be used by any board file to update
the power data in twl4030_platform_data.

http://omapedia.org/wiki/TWL4030_power_scripts

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/twl4030-script.c |  331 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030-script.h |   23 +++
 include/linux/i2c/twl.h              |   33 +++-
 3 files changed, 384 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030-script.c
 create mode 100644 arch/arm/mach-omap2/twl4030-script.h

diff --git a/arch/arm/mach-omap2/twl4030-script.c b/arch/arm/mach-omap2/twl4030-script.c
new file mode 100644
index 0000000..aa5afbd
--- /dev/null
+++ b/arch/arm/mach-omap2/twl4030-script.c
@@ -0,0 +1,331 @@
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
+#include <linux/i2c/twl.h>
+
+#include "twl4030-script.h"
+
+/*
+ * power management signal connections for OMAP3430 with TWL5030
+ *
+ *                          TWL5030                             OMAP3430
+ *                     ______________________             _____________________
+ *                    |                      |           |                     |
+ *                    |          (P1) NSLEEP1|<----------|SYS_OFFMODE          |
+ *                    |              NRESWARM|<----------|NWARMRESET           |
+ *                    |          (P2) NSLEEP2|---|       |                     |
+ *                    |                      |  ===      |                     |
+ *                    |                      |   -       |                     |
+ *                    |                      |           |                     |
+ *                    |                 VDD1 |---------->| VDD1                |
+ *                    |                 VDD2 |---------->| VDD2                |
+ *                    |                  VIO |---------->| VDDS                |
+ *  ________          |                VAUX1 |           |                     |
+ * |        |         |                 ...  |           |                     |
+ * |  ENABLE|<--------|CLKEN           CLKREQ|<----------|SYS_CLKREQ           |
+ * |  CLKOUT|-------->|HFCLKIN  (P3) HFCLKOUT|---------->|XTALIN               |
+ * |________|         |______________________|           |_____________________|
+ *
+ *
+ *	Signal descriptions:
+ *
+ * SYS_OFFMODE - OMAP drives this signal low only when the OMAP is in the
+ *	OFF idle mode. It is driven high when a wake up event is detected.
+ *	This signal should control the P1 device group in the PMIC.
+ *
+ * SYS_CLKREQ - OMAP should drive this signal low when the OMAP goes into
+ *	any idle mode. This signal should control the P3 device group
+ *	in the PMIC. It is used to notify PMIC when XTALIN is no longer needed.
+ *
+ * NSLEEP1(P1) - When this signal goes low the P1 sleep sequence is executed
+ *	in the PMIC turning off certain resources. When this signal goes high
+ *	the P1 active sequence is executed turning back on certain resources.
+ *
+ * NSLEEP2(P2) - This signal controls the P2 device group of the PMIC.
+ *	It is not used in this setup and should be tied to ground.
+ *	This can be used for connecting a different processor or MODEM chip.
+ *
+ * CLKREQ(P3) - When this signal goes low the P3 sleep sequence is executed
+ *	in the PMIC turning off HFCLKOUT. When this signal goes high
+ *	the P3 active sequence is executed turning back on HFCLKOUT and other
+ *	resources.
+ *
+ * CLKEN - Enable signal for oscillator. Should only go low when OMAP is
+ *	in the OFF idle mode due to long oscillator startup times.
+ *
+ * HFCLKIN - Oscillator output clock into PMIC.
+ *
+ * HFCLKOUT - System clock output from PMIC to OMAP.
+ *
+ * XTALIN - OMAP system clock input(HFCLKOUT).
+ */
+
+/*
+ * Recommended sleep and active sequences for TWL5030 when connected to OMAP3
+ *
+ * WARNING: If the board is using NSLEEP2(P2), should modify this script and
+ * setuptime values accordingly.
+ *
+ * Chip Retention/Off (using i2c for scaling voltage):
+ *	When OMAP de-assert the SYS_CLKREQ signal, only HFCLKOUT is affected
+ *	since it is the only resource assigned to P3 only.
+ *
+ * Sysoff (using sys_off signal):
+ *	When OMAP de-assert the SYS_OFFMODE signal A2S(active to sleep sequence)
+ *	on the PMIC is executed. This will put resources of TYPE2=1 and TYPE2=2
+ *	into sleep. At this point only resources assigned to P1 only will be
+ *	affected (VDD1, VDD2 & VPLL1).
+ *
+ *	Next the OMAP will lower SYS_CLKREQ which will allow the A2S sequence
+ *	in PMIC to execute again. This will put resources of TYPE2=1 and TYPE2=2
+ *	into sleep but will affect resources that are assigned to P3(HFCLKOUT)
+ *	only or assigned to P1 and P3.
+ *
+ *	On wakeup event OMAP goes active and pulls the SYS_CLKREQ high,
+ *	which will execute the P3 S2A sequence on the PMIC. This will turn on
+ *	resources assigned to P3 or assigned to P1 and P3 and of TYPE2=2.
+ *
+ *	Next the OMAP will wait the PRM_VOLTOFFSET time and then de-assert
+ *	the SYS_OFFMODE pin allowing the PMIC to execute the P1 S2A active
+ *	sequence. This will turn on resources assigned to P1 or assigned to
+ *	P1 and P3 and of TYPE2=1.
+ *
+ *	Timing diagram for OMAP wakeup from OFFMODE using sys_off signal
+ *                 _____________________________________________________________
+ * OMAP active  __/
+ *                       |<--------------------PRM_CLKSETP-------------------->|
+ *                        ______________________________________________________
+ * SYS_CLKREQ   _________/
+ *                           ___________________________________________________
+ * CLKEN        ____________/
+ *
+ * HFCLKIN      _______________________________________________/////////////////
+ *
+ * HFCLKOUT     __________________________________________________//////////////
+ *                       |<---PRM_VOLTOFFSET-->|
+ *                                              ________________________________
+ * SYS_OFFMODE  _______________________________/
+ *                                             |<--------PRM_VOLTSETUP2------->|
+ *                                                                   ___________
+ * VPLL1        ____________________________________________________/
+ *                                                                            __
+ * VDD1         _____________________________________________________________/
+ *                                                                            __
+ * VDD2         _____________________________________________________________/
+ *
+ *	Other resources which are not handled by this script should be
+ *	controlled by the respective drivers using them (VAUX1, VAUX2, VAUX3,
+ *	VAUX4, VMMC1, VMMC2, VPLL2, VSIM, VDAC, VUSB1V5, VUSB1V8 & VUSB3V1).
+ *
+ * More info:
+ *	http://omapedia.org/wiki/TWL4030_power_scripts
+ */
+
+/**
+ * DOC: Sleep to active sequence for P1/P2
+ *
+ * Sequence to control the TWL4030 Power resources,
+ * when the system wakeup from sleep.
+ * Executed upon P1_P2 transition for wakeup
+ * (sys_offmode signal de-asserted on OMAP).
+ */
+static struct twl4030_ins wakeup_p12_seq[] __initdata = {
+	/*
+	 * Broadcast message to put resources to active
+	 *
+	 * Since we are not using TYPE, resources which have TYPE2 configured
+	 * as 1 will be targeted (VPLL1, VDD1, VDD2, REGEN, NRES_PWRON, SYSEN).
+	 */
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
+/**
+ * DOC: Sleep to active sequence for P3
+ *
+ * Sequence to control the TWL4030 Power resources,
+ * when the system wakeup from sleep.
+ * Executed upon P3 transition for wakeup
+ * (clkreq signal asserted on OMAP).
+ */
+static struct twl4030_ins wakeup_p3_seq[] __initdata = {
+	/*
+	 * Broadcast message to put resources to active
+	 *
+	 * Since we are not using TYPE, resources which have TYPE2 configured
+	 * as 2 will be targeted
+	 * (VINTANA1, VINTANA2, VINTDIG, VIO, CLKEN, HFCLKOUT).
+	 */
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
+/**
+ * DOC: Active to sleep sequence for P1/P2/P3
+ *
+ * Sequence to control the TWL4030 Power resources,
+ * when the system goes into sleep.
+ * Executed upon P1_P2/P3 transition for sleep.
+ * (sys_offmode signal asserted/clkreq de-asserted on OMAP).
+ */
+static struct twl4030_ins sleep_on_seq[] __initdata = {
+	/* Broadcast message to put res to sleep (TYPE2 = 1, 2) */
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
+/**
+ * DOC: Warm reset sequence
+ *
+ * Sequence to reset the TWL4030 Power resources,
+ * when the system gets warm reset.
+ * Executed upon warm reset signal.
+ *
+ * First the device is put in reset, then the system clock is requested to
+ * the external oscillator, and default ON power reference and power providers
+ * are enabled. Next some additional resources which are software controlled
+ * are enabled. Finally sequence is ended by the release of TWL5030 reset.
+ */
+static struct twl4030_ins wrst_seq[] __initdata = {
+	/*
+	 * As a workaround for OMAP Erratum  (ID: i537 - OMAP HS devices are
+	 * not recovering from warm reset while in OFF mode)
+	 * NRESPWRON is toggled to force a power on reset condition to OMAP
+	 */
+	/* Trun OFF NRES_PWRON */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_NRES_PWRON, RES_STATE_OFF), 2},
+	/* Reset twl4030 */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_OFF), 2},
+	/* Reset MAIN_REF */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_MAIN_REF, RES_STATE_WRST), 2},
+	/* Reset All type2_group2 */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_WRST), 2},
+	/* Reset VUSB_3v1 */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_VUSB_3V1, RES_STATE_WRST), 2},
+	/* Reset All type2_group1 */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
+							RES_STATE_WRST), 2},
+	/* Reset the Reset & Contorl_signals */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
+							RES_STATE_WRST), 2},
+	/* Re-enable twl4030 */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_ACTIVE), 2},
+	/* Trun ON NRES_PWRON */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_NRES_PWRON, RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script wrst_script __initdata = {
+	.script = wrst_seq,
+	.size   = ARRAY_SIZE(wrst_seq),
+	.flags  = TWL4030_WRST_SCRIPT,
+};
+
+/* TWL4030 script for sleep, wakeup & warm_reset */
+static struct twl4030_script *twl4030_scripts[] __initdata = {
+	&wakeup_p12_script,
+	&wakeup_p3_script,
+	&sleep_on_script,
+	&wrst_script,
+};
+
+/**
+ * DOC: TWL4030 resource configuration
+ *
+ * Resource which are attached to P1 device group alone
+ * will go to sleep state, when sys_off signal from OMAP is de-asserted.
+ *	(VPLL1, VDD1, VDD2)
+ *
+ * None of the resources are attached to P2 device group alone.
+ * (WARNING: If MODEM or connectivity chip is connected to NSLEEP2 PIN on
+ * TWL4030, should modify the resource configuration accordingly).
+ *
+ * Resource which are attached to P3 device group alone
+ * will go to sleep state, when clk_req signal from OMAP is de-asserted.
+ *	(HFCLKOUT)
+ *
+ * Resource which are attached to more than one device group
+ * will go to sleep state, when corresponding signals are de-asserted.
+ *	(VINTANA1, VINTANA2, VINTDIG, VIO, REGEN, NRESPWRON, CLKEN, SYSEN)
+ *
+ * REGEN is an output of the device which can be connected to slave power ICs
+ * or external LDOs that power on before voltage for the IO interface (VIO).
+ *
+ * SYSEN is a bidirectional signal of the device that controls slave power ICs.
+ * In master mode, the device sets SYSEN high to enable the slave power ICs.
+ * In slave mode, when one of the power ICs drives the SYSEN signal low,
+ * all devices of the platform stay in the wait-on state.
+ *
+ * Resource which are attached to none of the device group by default
+ * will be in sleep state. These resource should be controlled by
+ * the respective drivers using them.
+ * Resource which are controlled by drivers are not modified here.
+ *	(VAUX1, VAUX2, VAUX3, VAUX4, VMMC1, VMMC2, VPLL2, VSIM, VDAC,
+ *	VUSB1V5, VUSB1V8, VUSB3V1)
+ *
+ * Resource using reset values.
+ *	(32KCLKOUT, TRITON_RESET, MAINREF)
+ */
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
+struct twl4030_power_data twl4030_generic_script __initdata = {
+	.scripts	= twl4030_scripts,
+	.num		= ARRAY_SIZE(twl4030_scripts),
+	.resource_config = twl4030_rconfig,
+};
diff --git a/arch/arm/mach-omap2/twl4030-script.h b/arch/arm/mach-omap2/twl4030-script.h
new file mode 100644
index 0000000..3611318
--- /dev/null
+++ b/arch/arm/mach-omap2/twl4030-script.h
@@ -0,0 +1,23 @@
+/*
+ * OMAP TWL4030 power scripts header file
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
+#ifndef __ARCH_ARM_MACH_OMAP3_TWL4030_SCRIPT_H
+#define __ARCH_ARM_MACH_OMAP3_TWL4030_SCRIPT_H
+
+#ifdef CONFIG_TWL4030_POWER
+extern struct twl4030_power_data twl4030_generic_script;
+#else
+#define twl4030_generic_script	NULL;
+#endif
+
+#endif
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index dcc2998..bb28d33 100644
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
+ * NSLEEP1 pin of TWL4030, which is connected to sys_off signal from OMAP
+ *
+ * Resources attached to device group P2 is managed depending on the state of
+ * NSLEEP2 pin of TWL4030, which is can be connected to a modem or
+ * connectivity chip
+ *
+ * Resources attached to device group P3 is managed depending on the state of
+ * CLKREQ pin of TWL4030, which is connected to clk request signal from OMAP
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
+ * The 27 power resources in TWL4030 is again divided into
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

