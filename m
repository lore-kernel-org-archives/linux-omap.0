From: Lesly A M <leslyam@ti.com>
Subject: [PATCH] MFD: TWL4030: changes for TRITON glitch fix
Date: Fri,  9 Apr 2010 16:03:11 +0530
Message-ID: <1270809191-17007-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41959 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754050Ab0DIKJR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Apr 2010 06:09:17 -0400
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
version check may not be correct. So if someone want to disable the
glitch fix changes during menuconfig, the changes are done under the macro
CONFIG_TWL5030_GLITCH_FIX.

Changes taken from Nishanth Menons gaia glitch fix patch.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---

This patch series is based off Kevin's tree origin/pm branch.

This patch has dependency on:
	SmartReflex patch series from Thara.
	Update TRITON power scripts from Lesly.

This changes are tested on OMAP3430 SDP board with:
	enable_off_mode
	voltage_off_while_idle
	sleep_while_idle (VDD1/VDD2 voltage scaling to 0v) enabled in cpuidle and suspned path.

Also tested for reboot and dvfs.

 arch/arm/mach-omap2/board-3430sdp.c          |   51 +++++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c |   51 +++++++++++++
 arch/arm/mach-omap2/twl4030-script.c         |   87 ++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030-script.h         |    9 ++
 arch/arm/mach-omap2/voltage.c                |   10 +++
 arch/arm/mach-omap2/voltage.h                |   10 +++
 arch/arm/plat-omap/Kconfig                   |   12 +++
 drivers/mfd/twl-core.c                       |    4 +
 drivers/mfd/twl4030-power.c                  |  103 ++++++++++++++++++++++++++
 include/linux/i2c/twl.h                      |    9 ++
 10 files changed, 346 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index c14b89c..f440627 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -465,6 +465,41 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
 	{ 0, 0},
 };
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+/* VDD1/VDD2/VPLL are assigned to P1 and P3, to have better control
+ * during OFFMODE. HFCLKOUT is assigned to P1 and P3 (*p2) to trun off
+ * only during OFFMODE.
+ * (*P2 is included if the platform uses it for modem/some other processor)
+ */
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
@@ -618,6 +653,19 @@ static struct twl4030_codec_data sdp3430_codec = {
 	.audio = &sdp3430_audio,
 };
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+/* Updating the TWL resource configuration, script and vc setuptime to
+ * avoid VDD collapse when TWL DCDCs switches between HFCLKIN and
+ * internal oscillator.
+ */
+void sdp3430_twl5030_glitchfix(void)
+{
+	sdp3430_t2scripts_data.resource_config = twl4030_rconfig_glitchfix;
+	use_twl4030_script_glitchfix(&sdp3430_t2scripts_data);
+	omap_voltage_vcsetup_glitchfix();
+}
+#endif
+
 static struct twl4030_platform_data sdp3430_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -628,6 +676,9 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.madc		= &sdp3430_madc_data,
 	.keypad		= &sdp3430_kp_data,
 	.power		= &sdp3430_t2scripts_data,
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+	.twl5030_glitchfix	= sdp3430_twl5030_glitchfix,
+#endif
 	.usb		= &sdp3430_usb_data,
 	.codec		= &sdp3430_codec,
 
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 5c7bef7..967c74f 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -123,6 +123,41 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
 	{ 0, 0},
 };
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+/* VDD1/VDD2/VPLL are assigned to P1 and P3, to have better control
+ * during OFFMODE. HFCLKOUT is assigned to P1 and P3 (*p2) to trun off
+ * only during OFFMODE.
+ * (*P2 is included if the platform uses it for modem/some other processor)
+ */
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
@@ -262,6 +297,19 @@ static struct twl4030_codec_data zoom_codec_data = {
 	.audio = &zoom_audio_data,
 };
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+/* Updating the TWL resource configuration, script and vc setuptime to
+ * avoid VDD collapse when TWL DCDCs switches between HFCLKIN and
+ * internal oscillator.
+ */
+void zoom_twl5030_glitchfix(void)
+{
+	zoom_t2scripts_data.resource_config = twl4030_rconfig_glitchfix;
+	use_twl4030_script_glitchfix(&zoom_t2scripts_data);
+	omap_voltage_vcsetup_glitchfix();
+}
+#endif
+
 static struct twl4030_platform_data zoom_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -273,6 +321,9 @@ static struct twl4030_platform_data zoom_twldata = {
 	.gpio		= &zoom_gpio_data,
 	.keypad		= &zoom_kp_twl4030_data,
 	.power		= &zoom_t2scripts_data,
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+	.twl5030_glitchfix	= zoom_twl5030_glitchfix,
+#endif
 	.codec		= &zoom_codec_data,
 	.vmmc1          = &zoom_vmmc1,
 	.vmmc2          = &zoom_vmmc2,
diff --git a/arch/arm/mach-omap2/twl4030-script.c b/arch/arm/mach-omap2/twl4030-script.c
index b3088c3..228e705 100644
--- a/arch/arm/mach-omap2/twl4030-script.c
+++ b/arch/arm/mach-omap2/twl4030-script.c
@@ -81,6 +81,71 @@ static struct twl4030_script wakeup_p3_script __initdata = {
 	.flags  = TWL4030_WAKEUP3_SCRIPT,
 };
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+/*
+ * Active to Sleep sequence, which is executed upon P1/P2/P3
+ * transition for sleep.
+ *
+ * The sleep sequence is adjusted to do the switching of VDD1/VDD2/VIO OSC from
+ * HFCLKIN to internal oscillator when the HFCLKIN is stable.
+ */
+static struct twl4030_ins __initdata sleep_on_seq_glitchfix[] = {
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
+static struct twl4030_script sleep_on_script_glitchfix __initdata = {
+	.script	= sleep_on_seq_glitchfix,
+	.size	= ARRAY_SIZE(sleep_on_seq_glitchfix),
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
+static struct twl4030_ins wakeup_seq_glitchfix[] __initdata = {
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
@@ -151,4 +216,26 @@ void twl4030_get_vc_timings(struct prm_setup_vc *setup_vc)
 	setup_vc->off.voltsetup2 = twl4030_voltsetup_time.off.voltsetup2;
 	setup_vc->off.voltoffset = twl4030_voltsetup_time.off.voltoffset;
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
index 3a7da2d..aafbe76 100644
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
index 90a307e..864bb7b 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -553,6 +553,16 @@ void __init omap_voltage_init_vc(struct prm_setup_vc *setup_vc)
 	memcpy(&vc_config, setup_vc, 2 * sizeof(struct setuptime_vc));
 }
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+void omap_voltage_vcsetup_glitchfix(void)
+{
+	vc_config.off.clksetup = CLKSETUP_GLITCHFIX;
+
+	vc_config.off.voltoffset = VOLTOFFSET_GLITCHFIX;
+	vc_config.off.voltsetup2 = VOLTSETUP2_GLITCHFIX;
+}
+#endif
+
 void update_voltsetup_time(int core_next_state)
 {
 	/* update voltsetup time */
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index c8bbea3..eb05c5f 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -102,6 +102,16 @@ void omap_voltageprocessor_enable(int vp_id);
 void omap_voltageprocessor_disable(int vp_id);
 void omap_voltage_init_vc(struct prm_setup_vc *setup_vc);
 void update_voltsetup_time(int core_next_state);
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+/* The clk/volt setuptime is adjusted to do the VDD1/VDD2 voltage rampup
+ * only after HFCLKIN is stabilized and the HFCLKOUT is enabled
+ */
+#define CLKSETUP_GLITCHFIX 0x17B
+#define VOLTOFFSET_GLITCHFIX 0x10
+#define VOLTSETUP2_GLITCHFIX 0x16B
+void omap_voltage_vcsetup_glitchfix(void);
+#endif
+
 void omap_voltage_init(void);
 int omap_voltage_scale(int vdd, u8 target_vsel, u8 current_vsel);
 void omap_reset_voltage(int vdd);
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 232fd9e..3ab24e6 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -84,6 +84,18 @@ config OMAP_SMARTREFLEX_TESTING
 
 	  WARNING: Enabling this option may cause your device to hang!
 
+config TWL5030_GLITCH_FIX
+	bool "TWL5030 glitch fix"
+	depends on TWL4030_CORE
+	default n
+	help
+	  Say Y if you want to enable TWL5030 glitch fix.
+
+	  Fix for TWL5030 Silicon Errata 27 & 28:
+		27 - VDD1, VDD2, may have glitches when their output value is updated.
+		28 - VDD1 and / or VDD2 DCDC clock may stop working when internal clock
+		     is switched from internal to external.
+
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 562cd49..0f6aa9a 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1010,7 +1010,11 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	/* load power event scripts */
 	if (twl_has_power() && pdata->power)
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+		twl4030_power_init(pdata->power, pdata->twl5030_glitchfix);
+#else
 		twl4030_power_init(pdata->power);
+#endif
 
 	/* Maybe init the T2 Interrupt subsystem */
 	if (client->irq
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index bd98733..8778534 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -32,6 +32,9 @@
 #include <asm/mach-types.h>
 
 static u8 twl4030_start_script_address = 0x2b;
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+static u32 twl4030_rev;
+#endif
 
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
@@ -505,7 +525,80 @@ int twl4030_remove_script(u8 flags)
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
+
+void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts,
+					void (*twl5030_glitchfix)(void))
+#else
 void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
+#endif
 {
 	int err = 0;
 	int i;
@@ -522,6 +615,16 @@ void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 	if (err)
 		goto unlock;
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+	/* Applying TWL5030 glitch fix based on Si revision */
+	if (is_twl5030_glitchfix_required()) {
+		pr_err("TWL5030: Enabling workaround for rev 0x%04X\n",
+				twl4030_rev);
+		twl_workaround();
+		twl5030_glitchfix();
+	}
+#endif
+
 	for (i = 0; i < twl4030_scripts->num; i++) {
 		err = load_twl4030_script(twl4030_scripts->scripts[i], address);
 		if (err)
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 2e00e83..1f56200 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -553,7 +553,13 @@ struct twl4030_power_data {
 #define TWL4030_RESCONFIG_UNDEF	((u8)-1)
 };
 
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts,
+					void (*twl5030_glitchfix)(void));
+#else
 extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts);
+#endif
+
 extern int twl4030_remove_script(u8 flags);
 
 struct twl4030_codec_audio_data {
@@ -587,6 +593,9 @@ struct twl4030_platform_data {
 	struct twl4030_keypad_data		*keypad;
 	struct twl4030_usb_data			*usb;
 	struct twl4030_power_data		*power;
+#ifdef CONFIG_TWL5030_GLITCH_FIX
+	void (*twl5030_glitchfix)(void);
+#endif
 	struct twl4030_codec_data		*codec;
 
 	/* Common LDO regulators for TWL4030/TWL6030 */
-- 
1.6.0.4

