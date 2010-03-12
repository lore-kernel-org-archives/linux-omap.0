From: Lesly A M <leslyam@ti.com>
Subject: [PATCH] MFD: TWL4030: changes for TRITON glitch fix
Date: Fri, 12 Mar 2010 21:41:36 +0530
Message-ID: <1268410296-28993-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40714 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab0CLPvf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 10:51:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Fix for TWL5030 Silicon Errata 27 & 28:
27 - VDD1, VDD2, may have glitches when their output value is updated.
28 - VDD1 and / or VDD2 DCDC clock may stop working when internal clock
is switched from internal to external.

Workaround requires the TWL DCDCs to use HFCLK instead of internal oscillator.
Also enable TWL watchdog before switching the osc to recover
if the VDD1/VDD2 stop working.

Fix is required for TWL5030 Silicon version less than or equal to ES1.1
Changes are done under the macro CONFIG_TWL5030_GLITCH_FIX,
since the IDCODE register on TWL5030 Si is not updated correctly.

Updated the TWL resource settings and volt, clock setuptime.

Changes taken from Nishanth Menons gaia glitch fix patch.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---

This patch has dependency on:
	SmartReflex patch series from Thara.
	Update TRITON power scripts from Lesly.

This patch series is based off Kevin's tree origin/pm branch.

This changes are tested on OMAP3430 SDP board with:
	enable_off_mode
	voltage_off_while_idle
	sleep_while_idle (VDD1/VDD2 voltage scaling to 0v) enabled in cpuidle and suspned path.

Also tested for reboot and dvfs.

 arch/arm/mach-omap2/board-3430sdp.c           |   40 +++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   40 +++++++++
 arch/arm/mach-omap2/include/mach/board-sdp.h  |    4 +
 arch/arm/mach-omap2/include/mach/board-zoom.h |    4 +
 arch/arm/mach-omap2/twl4030-script.c          |   84 +++++++++++++++++++
 arch/arm/mach-omap2/twl4030-script.h          |    9 ++
 arch/arm/mach-omap2/voltage.c                 |   10 +++
 arch/arm/mach-omap2/voltage.h                 |    4 +
 arch/arm/plat-omap/Kconfig                    |    7 ++
 drivers/mfd/twl4030-power.c                   |  106 +++++++++++++++++++++++++
 10 files changed, 308 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4f94b6f..d174d21 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -475,6 +475,36 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
 	{ 0, 0},
 };
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+static struct twl4030_resconfig twl4030_rconfig_glitchfix[] = {
+	{ .resource = RES_VPLL1, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+		.type = 3, .type2 = 1, .remap_sleep = RES_STATE_OFF },
+	{ .resource = RES_VINTANA1, .devgroup = DEV_GRP_ALL, .type = 1,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VINTANA2, .devgroup = DEV_GRP_ALL, .type = 0,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VINTDIG, .devgroup = DEV_GRP_ALL, .type = 1,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VIO, .devgroup = DEV_GRP_ALL, .type = 2,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+		.type = 4, .type2 = 1, .remap_sleep = RES_STATE_OFF },
+	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+		.type = 3, .type2 = 1, .remap_sleep = RES_STATE_OFF },
+	{ .resource = RES_REGEN, .devgroup = DEV_GRP_ALL, .type = 2,
+		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_NRES_PWRON, .devgroup = DEV_GRP_ALL, .type = 0,
+		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_CLKEN, .devgroup = DEV_GRP_ALL, .type = 3,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_SYSEN, .devgroup = DEV_GRP_ALL, .type = 6,
+		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+		.type = 0, .type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ 0, 0},
+};
+#endif
+
 static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
 	.resource_config = twl4030_rconfig,
 };
@@ -840,6 +870,16 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+void twl5030_glitchfix_changes_3430sdp(void)
+{
+	sdp3430_t2scripts_data.resource_config = twl4030_rconfig_glitchfix;
+	use_twl4030_script_glitchfix(&sdp3430_t2scripts_data);
+	omap_voltage_twl5030_glitchfix();
+}
+EXPORT_SYMBOL(twl5030_glitchfix_changes_3430sdp);
+#endif
+
 static void __init omap_3430sdp_init(void)
 {
 	twl4030_get_scripts(&sdp3430_t2scripts_data);
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 462d7ee..76f28d1 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -125,6 +125,36 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
 	{ 0, 0},
 };
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+static struct twl4030_resconfig twl4030_rconfig_glitchfix[] = {
+	{ .resource = RES_VPLL1, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+		.type = 3, .type2 = 1, .remap_sleep = RES_STATE_OFF },
+	{ .resource = RES_VINTANA1, .devgroup = DEV_GRP_ALL, .type = 1,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VINTANA2, .devgroup = DEV_GRP_ALL, .type = 0,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VINTDIG, .devgroup = DEV_GRP_ALL, .type = 1,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VIO, .devgroup = DEV_GRP_ALL, .type = 2,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+		.type = 4, .type2 = 1, .remap_sleep = RES_STATE_OFF },
+	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+		.type = 3, .type2 = 1, .remap_sleep = RES_STATE_OFF },
+	{ .resource = RES_REGEN, .devgroup = DEV_GRP_ALL, .type = 2,
+		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_NRES_PWRON, .devgroup = DEV_GRP_ALL, .type = 0,
+		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_CLKEN, .devgroup = DEV_GRP_ALL, .type = 3,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_SYSEN, .devgroup = DEV_GRP_ALL, .type = 6,
+		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+		.type = 0, .type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ 0, 0},
+};
+#endif
+
 static struct twl4030_power_data zoom_t2scripts_data __initdata = {
 	.resource_config = twl4030_rconfig,
 };
@@ -313,6 +343,16 @@ static void enable_board_wakeup_source(void)
 		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+void twl5030_glitchfix_changes_zoom(void)
+{
+	zoom_t2scripts_data.resource_config = twl4030_rconfig_glitchfix;
+	use_twl4030_script_glitchfix(&zoom_t2scripts_data);
+	omap_voltage_twl5030_glitchfix();
+}
+EXPORT_SYMBOL(twl5030_glitchfix_changes_zoom);
+#endif
+
 void __init zoom_peripherals_init(void *peripheral_data)
 {
 	struct prm_setup_vc *omap3_setuptime =
diff --git a/arch/arm/mach-omap2/include/mach/board-sdp.h b/arch/arm/mach-omap2/include/mach/board-sdp.h
index 465169c..145237a 100644
--- a/arch/arm/mach-omap2/include/mach/board-sdp.h
+++ b/arch/arm/mach-omap2/include/mach/board-sdp.h
@@ -19,3 +19,7 @@ struct flash_partitions {
 };
 
 extern void sdp_flash_init(struct flash_partitions []);
+
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+extern void twl5030_glitchfix_changes_3430sdp(void);
+#endif
diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h b/arch/arm/mach-omap2/include/mach/board-zoom.h
index ed20b26..0ccef2e 100644
--- a/arch/arm/mach-omap2/include/mach/board-zoom.h
+++ b/arch/arm/mach-omap2/include/mach/board-zoom.h
@@ -3,3 +3,7 @@
  */
 extern int __init zoom_debugboard_init(void);
 extern void __init zoom_peripherals_init(void *);
+
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+extern void twl5030_glitchfix_changes_zoom(void);
+#endif
diff --git a/arch/arm/mach-omap2/twl4030-script.c b/arch/arm/mach-omap2/twl4030-script.c
index cfa623b..90117b6 100644
--- a/arch/arm/mach-omap2/twl4030-script.c
+++ b/arch/arm/mach-omap2/twl4030-script.c
@@ -74,6 +74,68 @@ static struct twl4030_script wakeup_p3_script __initdata = {
 	.flags  = TWL4030_WAKEUP3_SCRIPT,
 };
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+struct prm_setup_vc twl4030_voltsetup_time_glitchfix = {
+	/* VOLT SETUPTIME for RET & OFF */
+	.voltsetup_time1_ret = 0x005B,
+	.voltsetup_time2_ret = 0x0055,
+	.voltsetup_time1_off = 0x00B3,
+	.voltsetup_time2_off = 0x00A0,
+	.voltoffset = 0x10,
+	.voltsetup2 = 0x16B,
+};
+
+/*
+ * Sequence to controll the TRITON Power resources,
+ * when the system goes into sleep.
+ * Executed upon P1_P2/P3 transition for sleep.
+ */
+static struct twl4030_ins __initdata sleep_on_seq_glitchfix[] = {
+	/* Singular message to disable HCLKOUT */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RES_STATE_SLEEP), 20},
+	/* Broadcast message to put res to sleep */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
+							RES_STATE_SLEEP), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_SLEEP), 2},
+};
+
+static struct twl4030_script sleep_on_script_glitchfix __initdata = {
+	.script	= sleep_on_seq_glitchfix,
+	.size	= ARRAY_SIZE(sleep_on_seq_glitchfix),
+	.flags	= TWL4030_SLEEP_SCRIPT,
+};
+
+/*
+ * Sequence to controll the TRITON Power resources,
+ * when the system wakeup from sleep.
+ * Executed upon P1/P2/P3 transition for wakeup.
+ */
+static struct twl4030_ins wakeup_seq_glitchfix[] __initdata = {
+	/* Broadcast message to put res(TYPE2 =1) to active */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_ACTIVE), 55},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_ACTIVE), 55},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_ACTIVE), 54},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_ACTIVE), 1},
+	/* Singular message to enable HCLKOUT */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RES_STATE_ACTIVE), 1},
+	/* Broadcast message to put res(TYPE2 =1) to active */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
+							RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script wakeup_script_glitchfix __initdata = {
+	.script	= wakeup_seq_glitchfix,
+	.size	= ARRAY_SIZE(wakeup_seq_glitchfix),
+	.flags	= TWL4030_WAKEUP12_SCRIPT | TWL4030_WAKEUP3_SCRIPT,
+};
+
+#endif
+
 /*
  * Sequence to reset the TRITON Power resources,
  * when the system gets warm reset.
@@ -140,4 +202,26 @@ void twl4030_get_vc_timings(struct prm_setup_vc *setup_vc)
 	setup_vc->voltoffset = twl4030_voltsetup_time.voltoffset;
 	setup_vc->voltsetup2 = twl4030_voltsetup_time.voltsetup2;
 }
+
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+/* TRITON script for sleep, wakeup & warm_reset */
+static struct twl4030_script *twl4030_scripts_glitchfix[] __initdata = {
+	&sleep_on_script_glitchfix,
+	&wakeup_script_glitchfix,
+	&wrst_script,
+};
+
+struct twl4030_power_data twl4030_script_glitchfix __initdata = {
+	.scripts	= twl4030_scripts_glitchfix,
+	.num		= ARRAY_SIZE(twl4030_scripts_glitchfix),
+};
+
+void use_twl4030_script_glitchfix(
+		struct twl4030_power_data *t2scripts_data)
+{
+	t2scripts_data->scripts = twl4030_script_glitchfix.scripts;
+	t2scripts_data->num = twl4030_script_glitchfix.num;
+}
+#endif
+
 #endif
diff --git a/arch/arm/mach-omap2/twl4030-script.h b/arch/arm/mach-omap2/twl4030-script.h
index 5161861..418f5af 100644
--- a/arch/arm/mach-omap2/twl4030-script.h
+++ b/arch/arm/mach-omap2/twl4030-script.h
@@ -7,9 +7,18 @@
 #ifdef CONFIG_TWL4030_POWER
 extern void twl4030_get_scripts(struct twl4030_power_data *t2scripts_data);
 extern void twl4030_get_vc_timings(struct prm_setup_vc *setup_vc);
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+void use_twl4030_script_glitchfix(
+		struct twl4030_power_data *t2scripts_data);
+#endif
+
 #else
 extern void twl4030_get_scripts(struct twl4030_power_data *t2scripts_data) {}
 extern void twl4030_get_vc_timings(struct prm_setup_vc *setup_vc) {}
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+void use_twl4030_script_glitchfix(
+		struct twl4030_power_data *t2scripts_data) {}
+#endif
 #endif
 
 #endif
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 4b1dcdb..45590f3 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -525,6 +525,16 @@ void __init omap_voltage_init_vc(struct prm_setup_vc *setup_vc)
 	vc_config.vdd2_off = setup_vc->vdd2_off;
 }
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+void omap_voltage_twl5030_glitchfix(void)
+{
+	vc_config.clksetup_off = 0x17B;
+
+	vc_config.voltoffset = 0x10;
+	vc_config.voltsetup2 = 0x16B;
+}
+#endif
+
 void update_voltsetup_time(int core_next_state)
 {
 	/* update voltsetup time */
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 7bc4948..0830274 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -74,6 +74,10 @@ void omap_voltageprocessor_enable(int vp_id);
 void omap_voltageprocessor_disable(int vp_id);
 void omap_voltage_init_vc(struct prm_setup_vc *setup_vc);
 void update_voltsetup_time(int core_next_state);
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+void omap_voltage_twl5030_glitchfix(void);
+#endif
+
 void omap_voltage_init(void);
 int omap_voltage_scale(int vdd, u8 target_vsel, u8 current_vsel);
 void omap_reset_voltage(int vdd);
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 232fd9e..0e32ad2 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -84,6 +84,13 @@ config OMAP_SMARTREFLEX_TESTING
 
 	  WARNING: Enabling this option may cause your device to hang!
 
+config TWL5030_GLITCH_FIX
+	bool "TWL5030 glitch fix"
+	depends on TWL4030_CORE
+	default n
+	help
+	  Say Y if you want to enable TWL5030 glitch fix.
+
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index bd98733..86f7176 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -30,8 +30,11 @@
 #include <linux/platform_device.h>
 
 #include <asm/mach-types.h>
+#include <mach/board-sdp.h>
+#include <mach/board-zoom.h>
 
 static u8 twl4030_start_script_address = 0x2b;
+static u32 twl4030_rev;
 
 #define PWR_P1_SW_EVENTS	0x10
 #define PWR_DEVOFF	(1<<0)
@@ -67,6 +70,23 @@ static u8 twl4030_start_script_address = 0x2b;
 #define R_KEY_1			0xC0
 #define R_KEY_2			0x0C
 
+#define R_VDD1_OSC		0x5C
+#define R_VDD2_OSC		0x6A
+#define R_VIO_OSC		0x52
+#define EXT_FS_CLK_EN		(0x1 << 6)
+
+#define R_WDT_CFG		0x03
+#define WDT_WRK_TIMEOUT		0x03
+
+#define R_UNLOCK_TEST_REG	0x12
+#define TWL_EEPROM_R_UNLOCK	0x49
+
+#define TWL_SIL_TYPE(rev)	((rev) & 0x00FFFFFF)
+#define TWL_SIL_REV(rev)	((rev) >> 24)
+#define TWL_SIL_5030		0x09002F
+#define TWL_REV_1_0		0x00
+#define TWL_REV_1_1		0x10
+
 /* resource configuration registers
    <RESOURCE>_DEV_GRP   at address 'n+0'
    <RESOURCE>_TYPE      at address 'n+1'
@@ -505,6 +525,79 @@ int twl4030_remove_script(u8 flags)
 	return err;
 }
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+/**
+ * @brief twl_workaround - Fix for TWL5030 Silicon Errata 27 & 28:
+ * 27 - VDD1, VDD2, may have glitches when their output value is updated.
+ * 28 - VDD1 and / or VDD2 DCDC clock may stop working when internal clock is
+ * switched from internal to external.
+ *
+ * Workaround requires the TWL DCDCs to use HFCLK instead of
+ * internal oscillator. Also enable TWL watchdog before switching the osc
+ * to recover if the VDD1/VDD2 stop working.
+ *
+ * WARNING: Should change board dependent script file to handle
+ * RET and OFF mode sequences correctly.
+ */
+static void __init twl_workaround(void)
+{
+	u8 val;
+	u8 smps_osc_reg[] = {R_VDD1_OSC, R_VDD2_OSC, R_VIO_OSC};
+	u8 wdt_counter_val = 0;
+	int i;
+	int err;
+
+	/* Setup the twl wdt to take care of borderline failure case */
+	err = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &wdt_counter_val,
+			R_WDT_CFG);
+	err |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, WDT_WRK_TIMEOUT,
+			R_WDT_CFG);
+
+	for (i = 0; i < sizeof(smps_osc_reg); i++) {
+		err |= twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &val,
+							smps_osc_reg[i]);
+		val |= EXT_FS_CLK_EN;
+		err |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, val,
+							smps_osc_reg[i]);
+	}
+
+	/* restore the original value */
+	err |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, wdt_counter_val,
+			R_WDT_CFG);
+	if (err)
+		pr_warning("TWL4030: workaround setup failed!\n");
+}
+
+bool is_twl5030_glitchfix_required(void)
+{
+	int err = 0;
+
+	if (twl4030_rev == 0) {
+		err = twl_i2c_write_u8(TWL4030_MODULE_INTBR,
+				TWL_EEPROM_R_UNLOCK, R_UNLOCK_TEST_REG);
+		if (err)
+			pr_err("TWL4030 Unable to unlock IDCODE registers\n");
+
+		err = twl_i2c_read(TWL4030_MODULE_INTBR, (u8 *)(&twl4030_rev),
+				0x0, 4);
+		if (err)
+			pr_err("TWL4030: unable to read IDCODE-%d\n", err);
+
+		err = twl_i2c_write_u8(TWL4030_MODULE_INTBR, 0x0,
+				R_UNLOCK_TEST_REG);
+		if (err)
+			pr_err("TWL4030 Unable to relock IDCODE registers\n");
+	}
+
+	if ((TWL_SIL_TYPE(twl4030_rev) == TWL_SIL_5030) &&
+		(TWL_SIL_REV(twl4030_rev) <= TWL_REV_1_1))
+		return true;
+	else
+		return false;
+
+}
+#endif
+
 void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 {
 	int err = 0;
@@ -522,6 +615,19 @@ void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 	if (err)
 		goto unlock;
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+	/* Applying TWL5030 glitch fix based on Si revision */
+	if (is_twl5030_glitchfix_required()) {
+		pr_err("TWL5030: Enabling workaround for rev 0x%04X\n",
+				twl4030_rev);
+		twl_workaround();
+		if (machine_is_omap_3430sdp())
+			twl5030_glitchfix_changes_3430sdp();
+		else
+			twl5030_glitchfix_changes_zoom();
+	}
+#endif
+
 	for (i = 0; i < twl4030_scripts->num; i++) {
 		err = load_twl4030_script(twl4030_scripts->scripts[i], address);
 		if (err)
-- 
1.6.0.4

