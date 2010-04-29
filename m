From: Lesly A M <leslyam@ti.com>
Subject: [PATCH/RFC v3] MFD: TWL4030: changes for TRITON Errata 27 workaround
Date: Thu, 29 Apr 2010 20:27:20 +0530
Message-ID: <1272553040-32077-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55141 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758103Ab0D3RAL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 13:00:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Fix for TWL5030 Silicon Errata 27 & 28:
        27 - VDD1, VDD2, may have glitches when their output value is updated.
        28 - VDD1 and / or VDD2 DCDC clock may stop working when internal clock
             is switched from internal to external.

Workaround requires the TWL DCDCs to use HFCLKIN instead of internal oscillator.

There is a chance for VDD1/VDD2 to collapse to 0 Volt,
if we switch the TWL DCDCs to internal oscillator form HFCLKIN
while VDD1/VDD2 is active. So during first time when we switch TWLDCDC to
HFCLKIN, TWL watchdog timer is used to recover if the VDD1/VDD2 stop working.

Using HFCLKIN for TWL DCDCs uncovers another issue when going in and
out of OFF mode, if HFCLK is disabled in OFFMODE. So the sleep/wakeup
sequence and setuptimes are modified to make sure the switching will
happen only when HFCLKIN is stable.

This fix is required for TWL5030 Silicon version less than or equal to ES1.1
Since the IDCODE register on TWL5030 Si is not updated correctly,
version check may not be correct. So the workaround is enabled based on
the flag TWL5030_ERRATA_27 & TRITON Si version.

The workaround changes are called from twl4030_power_init(), since we have to
make some i2c_read calls to check the TRITON version & the i2c will not be
initialized in the early stage.

Changes taken from Nishanth Menons TRITON Errata27 workaround  patch.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---

This patch series is based off Kevin's tree origin/pm-wip-sr branch.

This patch has dependency on:
        Updated TRITON power scripts from Lesly.

Changes to fix Kevins comments:
	Removing menuconfig option and using optional flag from board file
	to enable the workaround.

This changes are tested on OMAP3430 SDP board with:
        enable_off_mode
        voltage_off_while_idle
        sleep_while_idle (VDD1/VDD2 voltage scaling to 0v) enabled in cpuidle and suspned path.

Also tested for reboot and dvfs.

 arch/arm/mach-omap2/board-3430sdp.c          |   43 +++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c |   43 +++++++++
 arch/arm/mach-omap2/twl4030.c                |   76 ++++++++++++++++
 arch/arm/mach-omap2/voltage.c                |    8 ++
 arch/arm/mach-omap2/voltage.h                |    9 ++
 drivers/mfd/twl4030-power.c                  |  121 ++++++++++++++++++++++++-
 include/linux/i2c/twl.h                      |    6 ++
 7 files changed, 301 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 9c36de1..4f99eb2 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -51,6 +51,9 @@
 #include "omap3-opp.h"
 #include "smartreflex-class3.h"
 
+/* Enable TWL5030 Errata 27 workaround */
+#define TWL5030_ERRATA_27 1
+
 #define SDP3430_TS_GPIO_IRQ_SDPV1	3
 #define SDP3430_TS_GPIO_IRQ_SDPV2	2
 
@@ -452,8 +455,48 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
 	{ 0, 0},
 };
 
+/* VDD1/VDD2/VPLL are assigned to P1 and P3, to have better control
+ * during OFFMODE. HFCLKOUT is assigned to P1 and P3 (*p2) to trun off
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
 static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
 	.resource_config = twl4030_rconfig,
+	.resource_config_errata27 = twl4030_rconfig_errata27,
+	.twl5030_errata27wa_vcsetup = omap_vcsetup_twl5030_errata27,
+#ifdef TWL5030_ERRATA_27
+	.enable_errata27_wa = TWL5030_SI_ERRATA27,
+#else
+	.enable_errata27_wa = 0,
+#endif
 };
 
 /*
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index ce3ff8b..99aa724 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -28,6 +28,9 @@
 #include "hsmmc.h"
 #include "twl4030.h"
 
+/* Enable TWL5030 Errata 27 workaround */
+#define TWL5030_ERRATA_27 1
+
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -123,8 +126,48 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
 	{ 0, 0},
 };
 
+/* VDD1/VDD2/VPLL are assigned to P1 and P3, to have better control
+ * during OFFMODE. HFCLKOUT is assigned to P1 and P3 (*p2) to trun off
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
 static struct twl4030_power_data zoom_t2scripts_data __initdata = {
 	.resource_config = twl4030_rconfig,
+	.resource_config_errata27 = twl4030_rconfig_errata27,
+	.twl5030_errata27wa_vcsetup = omap_vcsetup_twl5030_errata27,
+#ifdef TWL5030_ERRATA_27
+	.enable_errata27_wa = TWL5030_SI_ERRATA27,
+#else
+	.enable_errata27_wa = 0,
+#endif
 };
 
 static struct regulator_consumer_supply zoom_vmmc1_supply = {
diff --git a/arch/arm/mach-omap2/twl4030.c b/arch/arm/mach-omap2/twl4030.c
index 6647156..afc4a5b 100644
--- a/arch/arm/mach-omap2/twl4030.c
+++ b/arch/arm/mach-omap2/twl4030.c
@@ -82,6 +82,68 @@ static struct twl4030_script wakeup_p3_script __initdata = {
 };
 
 /*
+ * Active to Sleep sequence, which is executed upon P1/P2/P3
+ * transition for sleep.
+ *
+ * The sleep sequence is adjusted to do the switching of VDD1/VDD2/VIO OSC from
+ * HFCLKIN to internal oscillator when the HFCLKIN is stable.
+ */
+static struct twl4030_ins __initdata sleep_on_seq_errata27[] = {
+	/* Singular message to disable HCLKOUT.
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
+	/* Broadcast message to put res(TYPE2 = 2) to active.
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
+	/* Broadcast message to put res(TYPE2 = 1) to active.
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
+/*
  * Sequence to reset the TRITON Power resources,
  * when the system gets warm reset.
  * Executed upon warm reset signal.
@@ -127,10 +189,24 @@ static struct twl4030_power_data twl4030_generic_script __initdata = {
 	.num		= ARRAY_SIZE(twl4030_scripts),
 };
 
+/* TRITON script for sleep, wakeup & warm_reset */
+static struct twl4030_script *twl4030_scripts_errata27[] __initdata = {
+	&sleep_on_script_errata27,
+	&wakeup_script_errata27,
+	&wrst_script,
+};
+
+struct twl4030_power_data twl4030_script_errata27 __initdata = {
+	.scripts	= twl4030_scripts_errata27,
+	.num		= ARRAY_SIZE(twl4030_scripts_errata27),
+};
+
 void twl4030_get_scripts(struct twl4030_power_data *t2scripts_data)
 {
 	t2scripts_data->scripts = twl4030_generic_script.scripts;
 	t2scripts_data->num = twl4030_generic_script.num;
+	t2scripts_data->scripts_errata27 = twl4030_script_errata27.scripts;
+	t2scripts_data->num_errata27 = twl4030_script_errata27.num;
 }
 
 void twl4030_get_vc_timings(struct prm_setup_vc *setup_vc)
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index c1c52dc..bd49844 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -949,6 +949,14 @@ void __init omap_voltage_init_vc(struct prm_setup_vc *setup_vc)
 	memcpy(&vc_config, setup_vc, 2 * sizeof(struct setuptime_vc));
 }
 
+void omap_vcsetup_twl5030_errata27(void)
+{
+	vc_config.off.clksetup = CLKSETUP_TWL5030_ERRATA27;
+
+	vc_config.off.voltoffset = VOLTOFFSET_TWL5030_ERRATA27;
+	vc_config.off.voltsetup2 = VOLTSETUP2_TWL5030_ERRATA27;
+}
+
 void omap_voltage_vc_update(int core_next_state)
 {
 	u32 voltctrl = 0;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index ffdfd7f..a697d69 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -132,6 +132,15 @@ void omap_voltageprocessor_disable(int vp_id);
 void omap_voltage_init_vc(struct prm_setup_vc *setup_vc);
 void omap_voltage_vc_update(int core_next_state);
 void omap_voltage_init(void);
+
+/* The clk/volt setuptime is adjusted to do the VDD1/VDD2 voltage rampup
+ * only after HFCLKIN is stabilized and the HFCLKOUT is enabled
+ */
+#define CLKSETUP_TWL5030_ERRATA27 0x17B
+#define VOLTOFFSET_TWL5030_ERRATA27 0x10
+#define VOLTSETUP2_TWL5030_ERRATA27 0x16B
+void omap_vcsetup_twl5030_errata27(void);
+
 int omap_voltage_scale(int vdd, unsigned long target_volt,
 					unsigned long current_volt);
 void omap_reset_voltage(int vdd);
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index bd98733..16748cc 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -32,6 +32,7 @@
 #include <asm/mach-types.h>
 
 static u8 twl4030_start_script_address = 0x2b;
+static u32 twl4030_rev;
 
 #define PWR_P1_SW_EVENTS	0x10
 #define PWR_DEVOFF	(1<<0)
@@ -67,6 +68,23 @@ static u8 twl4030_start_script_address = 0x2b;
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
@@ -505,12 +523,82 @@ int twl4030_remove_script(u8 flags)
 	return err;
 }
 
+/**
+ * @brief twl_errata27_workaround - Fix for TWL5030 Silicon Errata 27 & 28:
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
+
 void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 {
 	int err = 0;
-	int i;
+	int i, num;
+	struct twl4030_script **script;
 	struct twl4030_resconfig *resconfig;
 	u8 address = twl4030_start_script_address;
+	bool enable_twl5030_errata27 = false;
 
 	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, R_KEY_1,
 				R_PROTECT_KEY);
@@ -522,14 +610,37 @@ void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 	if (err)
 		goto unlock;
 
-	for (i = 0; i < twl4030_scripts->num; i++) {
-		err = load_twl4030_script(twl4030_scripts->scripts[i], address);
+	/* Applying TWL5030 Errata 27 WA based on Si revision &
+	 * flag updated from board file*/
+	if (is_twl5030_errata27wa_required() &&
+			twl4030_scripts->enable_errata27_wa) {
+		pr_err("TWL5030: Enabling workaround for rev 0x%04X\n",
+							twl4030_rev);
+		twl_errata27_workaround();
+		if (twl4030_scripts->twl5030_errata27wa_vcsetup)
+			twl4030_scripts->twl5030_errata27wa_vcsetup();
+
+		script = twl4030_scripts->scripts_errata27;
+		num = twl4030_scripts->num_errata27;
+		resconfig = twl4030_scripts->resource_config_errata27;
+		enable_twl5030_errata27 = true;
+	} else {
+		script = twl4030_scripts->scripts;
+		num = twl4030_scripts->num;
+		resconfig = twl4030_scripts->resource_config;
+	}
+
+	for (i = 0; i < num; i++) {
+		err = load_twl4030_script(script[i], address);
 		if (err)
 			goto load;
-		address += twl4030_scripts->scripts[i]->size;
+
+		if (enable_twl5030_errata27)
+			address += twl4030_scripts->scripts_errata27[i]->size;
+		else
+			address += twl4030_scripts->scripts[i]->size;
 	}
 
-	resconfig = twl4030_scripts->resource_config;
 	if (resconfig) {
 		while (resconfig->resource) {
 			err = twl4030_configure_resource(resconfig);
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 2e00e83..15d70bd 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -550,6 +550,12 @@ struct twl4030_power_data {
 	struct twl4030_script **scripts;
 	unsigned num;
 	struct twl4030_resconfig *resource_config;
+	struct twl4030_script **scripts_errata27;
+	unsigned num_errata27;
+	struct twl4030_resconfig *resource_config_errata27;
+	void (*twl5030_errata27wa_vcsetup)(void);
+	u8 enable_errata27_wa;
+#define TWL5030_SI_ERRATA27 (1<<0)
 #define TWL4030_RESCONFIG_UNDEF	((u8)-1)
 };
 
-- 
1.6.0.4

