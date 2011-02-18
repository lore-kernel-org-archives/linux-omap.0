From: Lesly A M <leslyam@ti.com>
Subject: [PATCH 10/12] mfd: TWL4030: changes for TRITON Errata 27 workaround
Date: Fri, 18 Feb 2011 22:38:56 +0530
Message-ID: <1298048938-1480-11-git-send-email-leslyam@ti.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52164 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213Ab1BRRJX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 12:09:23 -0500
In-Reply-To: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Workaround for TWL5030 Silicon Errata 27 & 28:
	27 - VDD1, VDD2, may have glitches when their output value is updated.
	28 - VDD1 and / or VDD2 DCDC clock may stop working when internal clock
		is switched from internal to external.

Errata 27:
	If the DCDC regulators is running on their internal oscillator,
	negative glitches may occur on VDD1, VDD2 output when voltage is changed.
	The OMAP device may reboot if the VDD1 or VDD2 go below the
	core minimum operating voltage.

	WORKAROUND
	Set up the TWL5030 DC-DC power supplies to use the HFCLKIN instead of
	the internal oscillator.

Errata 28:
	VDD1/VDD2 clock system may hang during switching the clock source from
	internal oscillator to external. VDD1/VDD2 output voltages may collapse
	if clock stops.

	WORKAROUND
	If HFCLK is disabled in OFFMODE, modify the sleep/wakeup sequence and
	setuptimes to make sure the switching will happen only when HFCLKIN is stable.
	Also use the TWL5030 watchdog to safeguard the first switching from
	internal oscillator to HFCLKIN during the TWL5030 init.

	IMPACT
	setup time and the power sequence is changed.
	sleep/wakeup time values will be changed.

The workaround changes are called from twl4030_power_init(), since we have to
make some i2c_read calls to check the TRITON version & the i2c will not be
initialized in the early stage.

This workaround is required for TWL5030 Silicon version less than ES1.2
The power script & setup time changes are recommended by TI HW team.

http://omapedia.org/wiki/TWL4030_power_scripts

Changes taken from TRITON Errata27 workaround patch by Nishanth Menon.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/omap_twl.c            |   35 +++++++++
 arch/arm/mach-omap2/twl4030.c             |  115 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/voltage.h |    2 +
 drivers/mfd/twl4030-power.c               |   74 ++++++++++++++++++
 include/linux/i2c/twl.h                   |    2 +
 5 files changed, 228 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index f0feab9..d6984b8 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -176,6 +176,14 @@
 #define OMAP3_CLKSETUP_RET		31	/* 30.5 uS */
 #define OMAP3_CLKSETUP_OFF		10000	/* 10 mS */
 
+/*
+ * The clk/volt setuptime is adjusted to do the VDD1/VDD2 voltage rampup
+ * only after HFCLKIN is stabilized and the HFCLKOUT is enabled
+ */
+#define CLKSETUP_TWL5030_ERRATA27	11567	/* 11.567 mS */
+#define VOLTOFFSET_TWL5030_ERRATA27	516	/* 516 uS */
+#define VOLTSETUP2_TWL5030_ERRATA27	11079	/* 11.079 mS */
+
 static bool is_offset_valid;
 static u8 smps_offset;
 
@@ -482,6 +490,33 @@ static struct omap_volt_pmic_info omap4_core_volt_info = {
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
 
+/**
+ * omap3_twl5030_errata27() - update the clk & volt setup time.
+ *
+ * Api to update the clk & volt setup time for TWL5030 errata 27.
+ */
+void omap3_twl5030_errata27(void)
+{
+	if (!cpu_is_omap34xx())
+		return;
+
+	if (cpu_is_omap3630()) {
+		omap3630_mpu_volt_info.voltsetup_off.voltsetup2 =
+					VOLTSETUP2_TWL5030_ERRATA27;
+		omap3630_mpu_volt_info.voltsetup_off.voltoffset =
+					VOLTOFFSET_TWL5030_ERRATA27;
+		omap3630_mpu_volt_info.clksetup_off.clksetup =
+					CLKSETUP_TWL5030_ERRATA27;
+	} else {
+		omap3430_mpu_volt_info.voltsetup_off.voltsetup2 =
+					VOLTSETUP2_TWL5030_ERRATA27;
+		omap3430_mpu_volt_info.voltsetup_off.voltoffset =
+					VOLTOFFSET_TWL5030_ERRATA27;
+		omap3430_mpu_volt_info.clksetup_off.clksetup =
+					CLKSETUP_TWL5030_ERRATA27;
+	}
+}
+
 int __init omap4_twl_init(void)
 {
 	struct voltagedomain *voltdm;
diff --git a/arch/arm/mach-omap2/twl4030.c b/arch/arm/mach-omap2/twl4030.c
index f3d05e5..b5fb496 100644
--- a/arch/arm/mach-omap2/twl4030.c
+++ b/arch/arm/mach-omap2/twl4030.c
@@ -137,10 +137,125 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
 	{ 0, 0},
 };
 
+/*
+ * Active to Sleep sequence, which is executed upon P1/P2/P3
+ * transition for sleep.
+ *
+ * The sleep sequence is adjusted to do the switching of VDD1/VDD2/VIO OSC from
+ * HFCLKIN to internal oscillator when the HFCLKIN is stable.
+ */
+static struct twl4030_ins __initdata sleep_on_seq_errata27[] = {
+	/*
+	 * Singular message to disable HCLKOUT.
+	 * Wait for ~488.32 uS to do the switching of VDD1/VDD2/VIO OSC from
+	 * HFCLKIN to internal oscillator before disabling HFCLKIN.
+	 */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RES_STATE_SLEEP), 20},
+	/* Broadcast message to put res(TYPE2 = 1) to sleep */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
+							RES_STATE_SLEEP), 2},
+	/* Broadcast message to put res(TYPE2 = 2) to sleep, disable HFCLKIN */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_SLEEP), 2},
+};
+
+static struct twl4030_script sleep_on_script_errata27 __initdata = {
+	.script	= sleep_on_seq_errata27,
+	.size	= ARRAY_SIZE(sleep_on_seq_errata27),
+	.flags	= TWL4030_SLEEP_SCRIPT,
+};
+
+/*
+ * Sleep to Active sequence, which is executed upon P1/P2/P3
+ * transition for wakeup.
+ *
+ * The wakeup sequence is adjusted to do the VDD1/VDD2 voltage rampup
+ * only after HFCLKIN is stabilized and the HFCLKOUT is enabled.
+ */
+static struct twl4030_ins wakeup_seq_errata27[] __initdata = {
+	/*
+	 * Broadcast message to put res(TYPE2 = 2) to active.
+	 * Wait for ~10 mS (rampup time for OSC on the board)
+	 * after HFCLKIN is enabled
+	 */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_ACTIVE), 55},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_ACTIVE), 55},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_ACTIVE), 54},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
+							RES_STATE_ACTIVE), 1},
+	/* Singular message to enable HCLKOUT after HFCLKIN is stabilized */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RES_STATE_ACTIVE), 1},
+	/*
+	 * Broadcast message to put res(TYPE2 = 1) to active.
+	 * VDD1/VDD2 rampup after HFCLKIN is stable and HFCLKOUT is enabled.
+	 */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
+							RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script wakeup_script_errata27 __initdata = {
+	.script	= wakeup_seq_errata27,
+	.size	= ARRAY_SIZE(wakeup_seq_errata27),
+	.flags	= TWL4030_WAKEUP12_SCRIPT | TWL4030_WAKEUP3_SCRIPT,
+};
+
+/* TRITON script for sleep, wakeup & warm_reset */
+static struct twl4030_script *twl4030_scripts_errata27[] __initdata = {
+	&sleep_on_script_errata27,
+	&wakeup_script_errata27,
+	&wrst_script,
+};
+
+/*
+ * VDD1/VDD2/VPLL are assigned to P1 and P3, to have better control
+ * during OFFMODE. HFCLKOUT is assigned to P1 and P3 (*p2) to turn off
+ * only during OFFMODE.
+ * (*P2 is included if the platform uses it for modem/some other processor)
+ */
+static struct twl4030_resconfig twl4030_rconfig_errata27[] = {
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
+
+void twl5030_script_errata27(void)
+{
+	twl4030_generic_script.scripts = twl4030_scripts_errata27;
+	twl4030_generic_script.num = ARRAY_SIZE(twl4030_scripts_errata27);
+	twl4030_generic_script.resource_config = twl4030_rconfig_errata27;
+}
+
 struct twl4030_power_data twl4030_generic_script = {
 	.scripts	= twl4030_scripts,
 	.num		= ARRAY_SIZE(twl4030_scripts),
 	.resource_config = twl4030_rconfig,
+	.twl5030_errata27wa_vcsetup = omap3_twl5030_errata27,
+	.twl5030_errata27wa_script = twl5030_script_errata27,
 };
 EXPORT_SYMBOL(twl4030_generic_script);
 #endif
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 2d737b9..c9d899b 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -152,6 +152,7 @@ struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm);
 int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 		struct omap_volt_pmic_info *pmic_info);
 void omap3_voltage_vc_update(int core_next_state);
+void omap3_twl5030_errata27(void);
 void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		int voltscale_method);
 /* API to get the voltagedomain pointer */
@@ -165,6 +166,7 @@ static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 	return -EINVAL;
 }
 void omap3_voltage_vc_update(int core_next_state) {}
+void omap3_twl5030_errata27(void) {}
 static inline  void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		int voltscale_method) {}
 static inline int omap_voltage_late_init(void)
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 8373d79..cc8a137 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -63,6 +63,14 @@ static u8 twl4030_start_script_address = 0x2b;
 #define R_MEMORY_ADDRESS	PHY_TO_OFF_PM_MASTER(0x59)
 #define R_MEMORY_DATA		PHY_TO_OFF_PM_MASTER(0x5a)
 
+#define R_VDD1_OSC		0x5C
+#define R_VDD2_OSC		0x6A
+#define R_VIO_OSC		0x52
+#define EXT_FS_CLK_EN		(0x1 << 6)
+
+#define R_WDT_CFG		0x03
+#define WDT_WRK_TIMEOUT		0x03
+
 /* resource configuration registers
    <RESOURCE>_DEV_GRP   at address 'n+0'
    <RESOURCE>_TYPE      at address 'n+1'
@@ -511,6 +519,60 @@ int twl4030_remove_script(u8 flags)
 	return err;
 }
 
+/**
+ * twl_errata27_workaround() - Workaround for TWL5030 Silicon Errata 27 & 28:
+ * 27 - VDD1, VDD2, may have glitches when their output value is updated.
+ * 28 - VDD1 and / or VDD2 DCDC clock may stop working when internal clock is
+ * switched from internal to external.
+ *
+ * Workaround requires the TWL DCDCs to use HFCLK instead of
+ * internal oscillator. Also enable TWL watchdog before switching the osc
+ * to recover if the VDD1/VDD2 stop working.
+ */
+static void __init twl_errata27_workaround(void)
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
+bool is_twl5030_errata27wa_required(void)
+{
+	u32 twl5030_si_ver;
+	int ret = 0;
+
+	ret = twl5030_get_si_ver(&twl5030_si_ver);
+	if (ret)
+		pr_warning("TWL4030: Unable to get the Si version\n");
+
+	if (twl5030_si_ver < TWL5030_REV_1_2)
+		return true;
+	else
+		return false;
+}
+
 void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 {
 	int err = 0;
@@ -530,6 +592,18 @@ void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 	if (err)
 		goto unlock;
 
+	/* Applying TWL5030 Errata 27 WA based on Si revision &
+	 * flag updated from board file*/
+	if (is_twl5030_errata27wa_required()) {
+		pr_info("TWL5030: Enabling workaround for Si Errata 27\n");
+		twl_errata27_workaround();
+		if (twl4030_scripts->twl5030_errata27wa_vcsetup)
+			twl4030_scripts->twl5030_errata27wa_vcsetup();
+
+		if (twl4030_scripts->twl5030_errata27wa_script)
+			twl4030_scripts->twl5030_errata27wa_script();
+	}
+
 	for (i = 0; i < twl4030_scripts->num; i++) {
 		err = load_twl4030_script(twl4030_scripts->scripts[i], address);
 		if (err)
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 5d3f2bf..26232f3 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -667,6 +667,8 @@ struct twl4030_power_data {
 	struct twl4030_script **scripts;
 	unsigned num;
 	struct twl4030_resconfig *resource_config;
+	void (*twl5030_errata27wa_vcsetup)(void);
+	void (*twl5030_errata27wa_script)(void);
 #define TWL4030_RESCONFIG_UNDEF	((u8)-1)
 };
 
-- 
1.7.1

