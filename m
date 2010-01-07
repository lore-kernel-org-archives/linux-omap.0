From: Lesly A M <x0080970@ti.com>
Subject: [PATCH] Update Triton2 scripts
Date: Thu,  7 Jan 2010 16:02:04 +0530
Message-ID: <1262860324-28075-1-git-send-email-x0080970@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52342 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434Ab0AGKUJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 05:20:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, nm@ti.com, dderrick@ti.com, sameo@linux.intel.com

Updated the sleep,wakeup & warm_reset sequence as recommended by David Derrick.
Used broadcast command and changed the TYPE2 register, REMAP register for 3430SDP board,
added the new script in zoom2 board file.

VDD1, VDD2 and VPLL1 are remapped to turn off during sleep state.

Changed RES_TYPE2 of VPLL1, VDD1, VDD2, REGEN, NRESPWRON & SYSEN to '1'
and VINTANA1, VINTANA2, VINTDIG, VIO, CLKEN & HFCLKOUT to '2'

HFCLKOUT is attached to P3, to dissable HFCLK when clk_req signal is toggled.
Modified the clksetup, volsetup_time for RET & OFF states.

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: nm@ti.com
Cc: dderrick@ti.com
Cc: sameo@linux.intel.com
---
 arch/arm/mach-omap2/board-3430sdp.c          |   93 +++++++++++-------
 arch/arm/mach-omap2/board-zoom-peripherals.c |  132 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h                     |   11 ++-
 arch/arm/mach-omap2/pm34xx.c                 |   54 +++++++++--
 drivers/mfd/twl4030-power.c                  |   30 +++++--
 include/linux/i2c/twl.h                      |    4 +
 6 files changed, 269 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 7d68445..7ded90f 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -75,13 +75,19 @@ static struct cpuidle_params omap3_cpuidle_params_table[] = {
 	{1, 10000, 30000, 300000},
 };
 
-/* FIXME: These are not the optimal setup values to be used on 3430sdp*/
+/* FIXME: These are not the optimal setup values to be used on 3430sdp */
 static struct prm_setup_vc omap3_setuptime_table = {
-	.clksetup = 0xff,
-	.voltsetup_time1 = 0xfff,
-	.voltsetup_time2 = 0xfff,
+	/* CLK SETUPTIME for RET & OFF */
+	.clksetup_ret = 0xff,
+	.clksetup_off = 0xff,
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0xfff,
+	.voltsetup_time2_ret = 0xfff,
+	.voltsetup_time1_off = 0xfff,
+	.voltsetup_time2_off = 0xfff,
 	.voltoffset = 0xff,
 	.voltsetup2 = 0xff,
+	/* VC COMMAND VALUES for VDD1/VDD2 */
 	.vdd0_on = 0x30,
 	.vdd0_onlp = 0x20,
 	.vdd0_ret = 0x1e,
@@ -442,14 +448,11 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
 
 
 static struct twl4030_ins __initdata sleep_on_seq[] = {
-	/* Turn off HFCLKOUT */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_OFF), 2},
-	/* Turn OFF VDD1 */
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_OFF), 2},
-	/* Turn OFF VDD2 */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_OFF), 2},
-	/* Turn OFF VPLL1 */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_OFF), 2},
+	/* Broadcast message to put res to sleep */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
+							RES_STATE_SLEEP), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_SLEEP), 2},
 };
 
 static struct twl4030_script sleep_on_script __initdata = {
@@ -459,14 +462,9 @@ static struct twl4030_script sleep_on_script __initdata = {
 };
 
 static struct twl4030_ins wakeup_p12_seq[] __initdata = {
-	/* Turn on HFCLKOUT */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
-	/* Turn ON VDD1 */
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_ACTIVE), 2},
-	/* Turn ON VDD2 */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_ACTIVE), 2},
-	/* Turn ON VPLL1 */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_ACTIVE), 2},
+	/* Broadcast message to put res to active */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
+							RES_STATE_ACTIVE), 2},
 };
 
 static struct twl4030_script wakeup_p12_script __initdata = {
@@ -476,7 +474,9 @@ static struct twl4030_script wakeup_p12_script __initdata = {
 };
 
 static struct twl4030_ins wakeup_p3_seq[] __initdata = {
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
+	/* Broadcast message to put res to active */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_ACTIVE), 2},
 };
 
 static struct twl4030_script wakeup_p3_script __initdata = {
@@ -488,17 +488,22 @@ static struct twl4030_script wakeup_p3_script __initdata = {
 static struct twl4030_ins wrst_seq[] __initdata = {
 /*
  * Reset twl4030.
- * Reset VDD1 regulator.
- * Reset VDD2 regulator.
- * Reset VPLL1 regulator.
- * Enable sysclk output.
+ * Reset Main_Ref.
+ * Reset All type2_group2.
+ * Reset VUSB_3v1.
+ * Reset All type2_group1.
+ * Reset RC.
  * Reenable twl4030.
  */
 	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x1c, RES_STATE_WRST), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_WRST), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x13, RES_STATE_WRST), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
+							RES_STATE_WRST), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
+							RES_STATE_WRST), 2},
 	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
 };
 static struct twl4030_script wrst_script __initdata = {
@@ -515,12 +520,30 @@ static struct twl4030_script *twl4030_scripts[] __initdata = {
 };
 
 static struct twl4030_resconfig twl4030_rconfig[] = {
-	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
-		.type2 = -1 },
-	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
-		.type2 = -1 },
-	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
-		.type2 = -1 },
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
 	{ 0, 0},
 };
 
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 64d4db0..de68cd3 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -26,6 +26,30 @@
 
 #include "mux.h"
 #include "mmc-twl4030.h"
+#include "pm.h"
+
+/* FIXME: These are not the optimal setup values */
+static struct prm_setup_vc omap3_setuptime_table = {
+	/* CLK SETUPTIME for RET & OFF */
+	.clksetup_ret = 0xff,
+	.clksetup_off = 0xff,
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0xfff,
+	.voltsetup_time2_ret = 0xfff,
+	.voltsetup_time1_off = 0xfff,
+	.voltsetup_time2_off = 0xfff,
+	.voltoffset = 0xff,
+	.voltsetup2 = 0xff,
+	/* VC COMMAND VALUES for VDD1/VDD2 */
+	.vdd0_on = 0x30,
+	.vdd0_onlp = 0x20,
+	.vdd0_ret = 0x1e,
+	.vdd0_off = 0x00,
+	.vdd1_on = 0x2c,
+	.vdd1_onlp = 0x20,
+	.vdd1_ret = 0x1e,
+	.vdd1_off = 0x00,
+};
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
@@ -94,6 +118,112 @@ static struct twl4030_keypad_data zoom_kp_twl4030_data = {
 	.rep		= 1,
 };
 
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
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x1c, RES_STATE_WRST), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_WRST), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x13, RES_STATE_WRST), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
+							RES_STATE_WRST), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
+							RES_STATE_WRST), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
+};
+static struct twl4030_script wrst_script __initdata = {
+	.script = wrst_seq,
+	.size   = ARRAY_SIZE(wrst_seq),
+	.flags  = TWL4030_WRST_SCRIPT,
+};
+
+static struct twl4030_script *twl4030_scripts[] __initdata = {
+	&sleep_on_script,
+	&wakeup_p12_script,
+	&wakeup_p3_script,
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
+static struct twl4030_power_data zoom_t2scripts_data __initdata = {
+	.scripts	= twl4030_scripts,
+	.num		= ARRAY_SIZE(twl4030_scripts),
+	.resource_config = twl4030_rconfig,
+};
+
 static struct regulator_consumer_supply zoom_vmmc1_supply = {
 	.supply		= "vmmc",
 };
@@ -239,6 +369,7 @@ static struct twl4030_platform_data zoom_twldata = {
 	.usb		= &zoom_usb_data,
 	.gpio		= &zoom_gpio_data,
 	.keypad		= &zoom_kp_twl4030_data,
+	.power		= &zoom_t2scripts_data,
 	.codec		= &zoom_codec_data,
 	.vmmc1          = &zoom_vmmc1,
 	.vmmc2          = &zoom_vmmc2,
@@ -277,4 +408,5 @@ void __init zoom_peripherals_init(void)
 	omap_serial_init();
 	usb_musb_init();
 	enable_board_wakeup_source();
+	omap3_pm_init_vc(&omap3_setuptime_table);
 }
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index e74f1c2..40c5e4d 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -41,9 +41,14 @@ inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 #endif
 
 struct prm_setup_vc {
-	u16 clksetup;
-	u16 voltsetup_time1;
-	u16 voltsetup_time2;
+/* CLK SETUPTIME for RET & OFF */
+	u16 clksetup_ret;
+	u16 clksetup_off;
+/* VOLT SETUPTIME for RET & OFF */
+	u16 voltsetup_time1_ret;
+	u16 voltsetup_time2_ret;
+	u16 voltsetup_time1_off;
+	u16 voltsetup_time2_off;
 	u16 voltoffset;
 	u16 voltsetup2;
 /* PRM_VC_CMD_VAL_0 specific bits */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c301261..e5b5433 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -96,11 +96,17 @@ static struct powerdomain *core_pwrdm, *per_pwrdm;
 static struct powerdomain *cam_pwrdm;
 
 static struct prm_setup_vc prm_setup = {
-	.clksetup = 0xff,
-	.voltsetup_time1 = 0xfff,
-	.voltsetup_time2 = 0xfff,
+	/* CLK SETUPTIME for RET & OFF */
+	.clksetup_ret = 0xff,
+	.clksetup_off = 0xff,
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0xfff,
+	.voltsetup_time2_ret = 0xfff,
+	.voltsetup_time1_off = 0xfff,
+	.voltsetup_time2_off = 0xfff,
 	.voltoffset = 0xff,
 	.voltsetup2 = 0xff,
+	/* VC COMMAND VALUES for VDD1/VDD2 */
 	.vdd0_on = 0x30,	/* 1.2v */
 	.vdd0_onlp = 0x20,	/* 1.0v */
 	.vdd0_ret = 0x1e,	/* 0.975v */
@@ -374,6 +380,9 @@ void omap_sram_idle(void)
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
 	int per_state_modified = 0;
+	u16 clksetup = 0xff;
+	u16 voltsetup_time1 = 0xfff;
+	u16 voltsetup_time2 = 0xfff;
 
 	if (!_omap_sram_idle)
 		return;
@@ -438,6 +447,11 @@ void omap_sram_idle(void)
 		omap_uart_prepare_idle(0);
 		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
+			/* VOLT & CLK SETUPTIME for OFF */
+			clksetup = prm_setup.clksetup_off;
+			voltsetup_time1 = prm_setup.voltsetup_time1_off;
+			voltsetup_time2 = prm_setup.voltsetup_time2_off;
+
 			u32 voltctrl = OMAP3430_AUTO_OFF;
 
 			if (voltage_off_while_idle)
@@ -448,10 +462,24 @@ void omap_sram_idle(void)
 			omap3_core_save_context();
 			omap3_prcm_save_context();
 		} else if (core_next_state == PWRDM_POWER_RET) {
+			/* VOLT & CLK SETUPTIME for RET */
+			clksetup = prm_setup.clksetup_ret;
+			voltsetup_time1 = prm_setup.voltsetup_time1_ret;
+			voltsetup_time2 = prm_setup.voltsetup_time2_ret;
+
 			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
 						OMAP3430_GR_MOD,
 						OMAP3_PRM_VOLTCTRL_OFFSET);
 		}
+		/* Write setup times */
+		prm_write_mod_reg(clksetup, OMAP3430_GR_MOD,
+				OMAP3_PRM_CLKSETUP_OFFSET);
+		prm_write_mod_reg((voltsetup_time2 <<
+				OMAP3430_SETUP_TIME2_SHIFT) |
+				(voltsetup_time1 <<
+				OMAP3430_SETUP_TIME1_SHIFT),
+				OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
+
 		/* Enable IO-PAD and IO-CHAIN wakeups */
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_enable_io_chain();
@@ -1071,10 +1099,16 @@ void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
 {
 	if (!setup_vc)
 		return;
-
-	prm_setup.clksetup = setup_vc->clksetup;
-	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
-	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
+	/* CLK SETUPTIME for RET & OFF */
+	prm_setup.clksetup_ret = setup_vc->clksetup_ret;
+	prm_setup.clksetup_off = setup_vc->clksetup_off;
+	/* VOLT SETUPTIME for RET & OFF */
+	prm_setup.voltsetup_time1_ret = setup_vc->voltsetup_time1_ret;
+	prm_setup.voltsetup_time2_ret = setup_vc->voltsetup_time2_ret;
+	prm_setup.voltsetup_time1_off = setup_vc->voltsetup_time1_off;
+	prm_setup.voltsetup_time2_off = setup_vc->voltsetup_time2_off;
+
+	/* VC COMMAND VALUES for VDD1/VDD2 */
 	prm_setup.voltoffset = setup_vc->voltoffset;
 	prm_setup.voltsetup2 = setup_vc->voltsetup2;
 	prm_setup.vdd0_on = setup_vc->vdd0_on;
@@ -1253,11 +1287,11 @@ static void __init configure_vc(void)
 			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
 
 	/* Write setup times */
-	prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
+	prm_write_mod_reg(prm_setup.clksetup_ret, OMAP3430_GR_MOD,
 			OMAP3_PRM_CLKSETUP_OFFSET);
-	prm_write_mod_reg((prm_setup.voltsetup_time2 <<
+	prm_write_mod_reg((prm_setup.voltsetup_time2_ret <<
 			OMAP3430_SETUP_TIME2_SHIFT) |
-			(prm_setup.voltsetup_time1 <<
+			(prm_setup.voltsetup_time1_ret <<
 			OMAP3430_SETUP_TIME1_SHIFT),
 			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
 
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 0815292..af6f60c 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -416,14 +416,35 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 		return err;
 	}
 
-	return 0;
+
+	/* Set the remap sleep cmd */
+	err = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &remap,
+					rconfig_addr + REMAP_OFFSET);
+	if (err < 0) {
+		printk(KERN_ERR "TWL4030 Resource %d remap could not read\n",
+							rconfig->resource);
+		return err;
+	}
+
+	if (rconfig->remap_sleep >= 0) {
+		remap &= ~SLEEP_STATE_MASK;
+		remap |= rconfig->remap_sleep;
+	}
+
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, remap,
+				rconfig_addr + REMAP_OFFSET);
+	if (err < 0) {
+		pr_err("TWL4030 failed to program remap sleep cmd \n");
+		return err;
+	}
+
+	return err;
 }
 
 static int __init load_twl4030_script(struct twl4030_script *tscript,
 	       u8 address)
 {
 	int err;
-	static int order;
 
 	/* Make sure the script isn't going beyond last valid address (0x3f) */
 	if ((address + tscript->size) > END_OF_SCRIPT) {
@@ -444,7 +465,6 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
 		err = twl4030_config_wakeup12_sequence(address);
 		if (err)
 			goto out;
-		order = 1;
 	}
 	if (tscript->flags & TWL4030_WAKEUP3_SCRIPT) {
 		err = twl4030_config_wakeup3_sequence(address);
@@ -452,10 +472,6 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
 			goto out;
 	}
 	if (tscript->flags & TWL4030_SLEEP_SCRIPT)
-		if (order)
-			pr_warning("TWL4030: Bad order of scripts (sleep "\
-					"script before wakeup) Leads to boot"\
-					"failure on some boards\n");
 		err = twl4030_config_sleep_sequence(address);
 out:
 	return err;
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index bf1c5be..f9202ad 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -351,6 +351,7 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
 #define DEV_GRP_P1		0x1	/* P1: all OMAP devices */
 #define DEV_GRP_P2		0x2	/* P2: all Modem devices */
 #define DEV_GRP_P3		0x4	/* P3: all peripheral devices */
+#define DEV_GRP_ALL		0x7	/* P1/P2/P3: all devices */
 
 /* Resource groups */
 #define RES_GRP_RES		0x0	/* Reserved */
@@ -363,7 +364,10 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
 #define RES_GRP_ALL		0x7	/* All resource groups */
 
 #define RES_TYPE2_R0		0x0
+#define RES_TYPE2_R1		0x1
+#define RES_TYPE2_R2		0x2
 
+#define RES_TYPE_R0		0x0
 #define RES_TYPE_ALL		0x7
 
 /* Resource states */
-- 
1.6.0.4

