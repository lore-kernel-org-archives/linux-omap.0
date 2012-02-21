From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 03/14] arm: omap3+: voltage: parameter segregation
Date: Tue, 21 Feb 2012 16:04:47 +0200
Message-ID: <1329833098-19900-4-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51346 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755377Ab2BUOFz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:05:55 -0500
In-Reply-To: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Introduced two new voltage domain specific parameter structures,
omap_vp_param and omap_vc_param. These are used to describe the minimum
and maximum voltages for the voltagedomains, and also the sleep voltage
levels. Existing voltage levels are also moved into these new structures,
and the voltage domain code is changed to use these.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c                |   25 ---
 arch/arm/mach-omap2/vc.c                      |  241 ++++++++++++++++++++++---
 arch/arm/mach-omap2/vc.h                      |    8 +-
 arch/arm/mach-omap2/vc3xxx_data.c             |   22 +++
 arch/arm/mach-omap2/vc44xx_data.c             |   28 +++
 arch/arm/mach-omap2/voltage.h                 |   18 ++-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    5 +
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    8 +
 arch/arm/mach-omap2/vp.h                      |    7 +
 arch/arm/mach-omap2/vp3xxx_data.c             |   10 +
 arch/arm/mach-omap2/vp44xx_data.c             |   15 ++
 11 files changed, 331 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 5224fbd..2f20242 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -141,11 +141,6 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
 static struct omap_voltdm_pmic omap3_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt		= 1200000,
-	.onlp_volt		= 1000000,
-	.ret_volt		= 975000,
-	.off_volt		= 600000,
-	.volt_setup_time	= 0xfff,
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
@@ -162,11 +157,6 @@ static struct omap_voltdm_pmic omap3_mpu_pmic = {
 static struct omap_voltdm_pmic omap3_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt                = 1200000,
-	.onlp_volt              = 1000000,
-	.ret_volt               = 975000,
-	.off_volt               = 600000,
-	.volt_setup_time        = 0xfff,
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
@@ -183,11 +173,6 @@ static struct omap_voltdm_pmic omap3_core_pmic = {
 static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1375000,
-	.onlp_volt		= 1375000,
-	.ret_volt		= 830000,
-	.off_volt		= 0,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
@@ -205,11 +190,6 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
 static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1188000,
-	.onlp_volt		= 1188000,
-	.ret_volt		= 830000,
-	.off_volt		= 0,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
@@ -227,11 +207,6 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 static struct omap_voltdm_pmic omap4_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1200000,
-	.onlp_volt		= 1200000,
-	.ret_volt		= 830000,
-	.off_volt		= 0,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 031d116..af061c3 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -10,14 +10,18 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/io.h>
 
 #include <plat/cpu.h>
+#include <plat/prcm.h>
 
 #include "voltage.h"
 #include "vc.h"
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
+#include "scrm44xx.h"
 
 /**
  * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
@@ -136,6 +140,8 @@ int omap_vc_pre_scale(struct voltagedomain *voltdm,
 	vc_cmdval |= (*target_vsel << vc->common->cmd_on_shift);
 	voltdm->write(vc_cmdval, vc->cmdval_reg);
 
+	voltdm->vc_param->on = target_volt;
+
 	omap_vp_update_errorgain(voltdm, target_volt);
 
 	return 0;
@@ -203,44 +209,208 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
 	return 0;
 }
 
-static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
+/**
+ * omap3_set_i2c_timings - sets i2c sleep timings for a channel
+ * @voltdm: channel to configure
+ * @off_mode: select whether retention or off mode values used
+ *
+ * Calculates and sets up voltage controller to use I2C based
+ * voltage scaling for sleep modes. This can be used for either off mode
+ * or retention. Off mode has additionally an option to use sys_off_mode
+ * pad, which uses a global signal to program the whole power IC to
+ * off-mode.
+ */
+static void omap3_set_i2c_timings(struct voltagedomain *voltdm, bool off_mode)
 {
+	unsigned long voltsetup1;
+	u32 tgt_volt;
+
+	if (off_mode)
+		tgt_volt = voltdm->vc_param->off;
+	else
+		tgt_volt = voltdm->vc_param->ret;
+
+	voltsetup1 = (voltdm->vc_param->on - tgt_volt) /
+			voltdm->pmic->slew_rate;
+
+	voltsetup1 = voltsetup1 * voltdm->sys_clk.rate / 8 / 1000000 + 1;
+
+	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
+		voltsetup1 << __ffs(voltdm->vfsm->voltsetup_mask),
+		voltdm->vfsm->voltsetup_reg);
+
 	/*
-	 * Voltage Manager FSM parameters init
-	 * XXX This data should be passed in from the board file
+	 * pmic is not controlling the voltage scaling during retention,
+	 * thus set voltsetup2 to 0
 	 */
-	voltdm->write(OMAP3_CLKSETUP, OMAP3_PRM_CLKSETUP_OFFSET);
-	voltdm->write(OMAP3_VOLTOFFSET, OMAP3_PRM_VOLTOFFSET_OFFSET);
-	voltdm->write(OMAP3_VOLTSETUP2, OMAP3_PRM_VOLTSETUP2_OFFSET);
+	voltdm->write(0, OMAP3_PRM_VOLTSETUP2_OFFSET);
 }
 
-static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
+/**
+ * omap3_set_off_timings - sets off-mode timings for a channel
+ * @voltdm: channel to configure
+ *
+ * Calculates and sets up off-mode timings for a channel. Off-mode
+ * can use either I2C based voltage scaling, or alternatively
+ * sys_off_mode pad can be used to send a global command to power IC.
+ * This function first checks which mode is being used, and calls
+ * omap3_set_i2c_timings() if the system is using I2C control mode.
+ * sys_off_mode has the additional benefit that voltages can be
+ * scaled to zero volt level with TWL4030 / TWL5030, I2C can only
+ * scale to 600mV.
+ */
+static void omap3_set_off_timings(struct voltagedomain *voltdm)
 {
-	static bool is_initialized;
+	unsigned long clksetup;
+	unsigned long voltsetup2;
+	unsigned long voltsetup2_old;
+	u32 val;
 
-	if (is_initialized)
+	/* check if sys_off_mode is used to control off-mode voltages */
+	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
+	if (!(val & OMAP3430_SEL_OFF_MASK)) {
+		/* No, omap is controlling them over I2C */
+		omap3_set_i2c_timings(voltdm, true);
 		return;
+	}
+
+	clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
+
+	/* voltsetup 2 in us */
+	voltsetup2 = voltdm->vc_param->on / voltdm->pmic->slew_rate;
+
+	/* convert to 32k clk cycles */
+	voltsetup2 = DIV_ROUND_UP(voltsetup2 * 32768, 1000000);
 
-	omap3_vfsm_init(voltdm);
+	voltsetup2_old = voltdm->read(OMAP3_PRM_VOLTSETUP2_OFFSET);
 
-	is_initialized = true;
+	/*
+	 * Update voltsetup2 if higher than current value (needed because
+	 * we have multiple channels with different ramp times), also
+	 * update voltoffset always to value recommended by TRM
+	 */
+	if (voltsetup2 > voltsetup2_old) {
+		voltdm->write(voltsetup2, OMAP3_PRM_VOLTSETUP2_OFFSET);
+		voltdm->write(clksetup - voltsetup2,
+			OMAP3_PRM_VOLTOFFSET_OFFSET);
+	} else
+		voltdm->write(clksetup - voltsetup2_old,
+			OMAP3_PRM_VOLTOFFSET_OFFSET);
+
+	/*
+	 * omap is not controlling voltage scaling during off-mode,
+	 * thus set voltsetup1 to 0
+	 */
+	voltdm->rmw(voltdm->vfsm->voltsetup_mask, 0,
+		voltdm->vfsm->voltsetup_reg);
+
+	/* voltoffset must be clksetup minus voltsetup2 according to TRM */
+	voltdm->write(clksetup - voltsetup2, OMAP3_PRM_VOLTOFFSET_OFFSET);
 }
 
+static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
+{
+	omap3_set_off_timings(voltdm);
+}
+
+/**
+ * omap4_calc_volt_ramp - calculates voltage ramping delays on omap4
+ * @voltdm: channel to calculate values for
+ * @voltage_diff: voltage difference in microvolts
+ *
+ * Calculates voltage ramp prescaler + counter values for a voltage
+ * difference on omap4. Returns a field value suitable for writing to
+ * VOLTSETUP register for a channel in following format:
+ * bits[8:9] prescaler ... bits[0:5] counter. See OMAP4 TRM for reference.
+ */
+static u32 omap4_calc_volt_ramp(struct voltagedomain *voltdm, u32 voltage_diff)
+{
+	u32 prescaler;
+	u32 cycles;
+	u32 time;
+
+	time = voltage_diff / voltdm->pmic->slew_rate;
+
+	cycles = voltdm->sys_clk.rate / 1000 * time / 1000;
+
+	cycles /= 64;
+	prescaler = 0;
+
+	/* shift to next prescaler until no overflow */
+
+	/* scale for div 256 = 64 * 4 */
+	if (cycles > 63) {
+		cycles /= 4;
+		prescaler++;
+	}
+
+	/* scale for div 512 = 256 * 2 */
+	if (cycles > 63) {
+		cycles /= 2;
+		prescaler++;
+	}
+
+	/* scale for div 2048 = 512 * 4 */
+	if (cycles > 63) {
+		cycles /= 4;
+		prescaler++;
+	}
+
+	/* check for overflow => invalid ramp time */
+	if (cycles > 63) {
+		pr_warning("%s: invalid setuptime for vdd_%s\n", __func__,
+			voltdm->name);
+		return 0;
+	}
+
+	cycles++;
+
+	return (prescaler << OMAP4430_RAMP_UP_PRESCAL_SHIFT) |
+		(cycles << OMAP4430_RAMP_UP_COUNT_SHIFT);
+}
+
+/**
+ * omap4_set_timings - set voltage ramp timings for a channel
+ * @voltdm: channel to configure
+ * @off_mode: whether off-mode values are used
+ *
+ * Calculates and sets the voltage ramp up / down values for a channel.
+ */
+static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
+{
+	u32 val;
+	u32 ramp;
+
+	/* configure the setup times */
+	val = voltdm->read(voltdm->vfsm->voltsetup_reg);
+
+	if (off_mode)
+		ramp = omap4_calc_volt_ramp(voltdm,
+			voltdm->vc_param->on - voltdm->vc_param->off);
+	else
+		ramp = omap4_calc_volt_ramp(voltdm,
+			voltdm->vc_param->on - voltdm->vc_param->ret);
+
+	if (!ramp)
+		return;
+
+	val |= ramp << OMAP4430_RAMP_DOWN_COUNT_SHIFT;
+
+	val |= ramp << OMAP4430_RAMP_UP_COUNT_SHIFT;
+
+	voltdm->write(val, voltdm->vfsm->voltsetup_reg);
+}
 
 /* OMAP4 specific voltage init functions */
 static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
 {
-	static bool is_initialized;
 	u32 vc_val;
 
-	if (is_initialized)
-		return;
+	omap4_set_timings(voltdm, true);
 
 	/* XXX These are magic numbers and do not belong! */
 	vc_val = (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4430_SCLH_SHIFT);
 	voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
-
-	is_initialized = true;
 }
 
 /**
@@ -285,6 +455,30 @@ static void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
 	initialized = true;
 }
 
+/**
+ * omap_vc_calc_vsel - calculate vsel value for a channel
+ * @voltdm: channel to calculate value for
+ * @uvolt: microvolt value to convert to vsel
+ *
+ * Converts a microvolt value to vsel value for the used PMIC.
+ * This checks whether the microvolt value is out of bounds, and
+ * adjusts the value accordingly. If unsupported value detected,
+ * warning is thrown.
+ */
+static u8 omap_vc_calc_vsel(struct voltagedomain *voltdm, u32 uvolt)
+{
+	if (voltdm->pmic->vddmin > uvolt)
+		uvolt = voltdm->pmic->vddmin;
+	if (voltdm->pmic->vddmax < uvolt) {
+		WARN(1, "%s: voltage not supported by pmic: %u vs max %u\n",
+			__func__, uvolt, voltdm->pmic->vddmax);
+		/* Lets try maximum value anyway */
+		uvolt = voltdm->pmic->vddmax;
+	}
+
+	return voltdm->pmic->uv_to_vsel(uvolt);
+}
+
 void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
@@ -314,7 +508,6 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	vc->i2c_slave_addr = voltdm->pmic->i2c_slave_addr;
 	vc->volt_reg_addr = voltdm->pmic->volt_reg_addr;
 	vc->cmd_reg_addr = voltdm->pmic->cmd_reg_addr;
-	vc->setup_time = voltdm->pmic->volt_setup_time;
 
 	/* Configure the i2c slave address for this VC */
 	voltdm->rmw(vc->smps_sa_mask,
@@ -338,10 +531,11 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	}
 
 	/* Set up the on, inactive, retention and off voltage */
-	on_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->on_volt);
-	onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->onlp_volt);
-	ret_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->ret_volt);
-	off_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->off_volt);
+	on_vsel = omap_vc_calc_vsel(voltdm, voltdm->vc_param->on);
+	onlp_vsel = omap_vc_calc_vsel(voltdm, voltdm->vc_param->onlp);
+	ret_vsel = omap_vc_calc_vsel(voltdm, voltdm->vc_param->ret);
+	off_vsel = omap_vc_calc_vsel(voltdm, voltdm->vc_param->off);
+
 	val = ((on_vsel << vc->common->cmd_on_shift) |
 	       (onlp_vsel << vc->common->cmd_onlp_shift) |
 	       (ret_vsel << vc->common->cmd_ret_shift) |
@@ -352,11 +546,6 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	/* Channel configuration */
 	omap_vc_config_channel(voltdm);
 
-	/* Configure the setup times */
-	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
-		    vc->setup_time << __ffs(voltdm->vfsm->voltsetup_mask),
-		    voltdm->vfsm->voltsetup_reg);
-
 	omap_vc_i2c_init(voltdm);
 
 	if (cpu_is_omap34xx())
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 478bf6b..91c8d75 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -86,7 +86,6 @@ struct omap_vc_channel {
 	u16 i2c_slave_addr;
 	u16 volt_reg_addr;
 	u16 cmd_reg_addr;
-	u16 setup_time;
 	u8 cfg_channel;
 	bool i2c_high_speed;
 
@@ -111,6 +110,13 @@ extern struct omap_vc_channel omap4_vc_mpu;
 extern struct omap_vc_channel omap4_vc_iva;
 extern struct omap_vc_channel omap4_vc_core;
 
+extern struct omap_vc_param omap3_mpu_vc_data;
+extern struct omap_vc_param omap3_core_vc_data;
+
+extern struct omap_vc_param omap4_mpu_vc_data;
+extern struct omap_vc_param omap4_iva_vc_data;
+extern struct omap_vc_param omap4_core_vc_data;
+
 void omap_vc_init_channel(struct voltagedomain *voltdm);
 int omap_vc_pre_scale(struct voltagedomain *voltdm,
 		      unsigned long target_volt,
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index a5ec7f8f..0535e8e 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -70,3 +70,25 @@ struct omap_vc_channel omap3_vc_core = {
 	.smps_cmdra_mask = OMAP3430_CMDRA1_MASK,
 	.cfg_channel_sa_shift = OMAP3430_PRM_VC_SMPS_SA_SA1_SHIFT,
 };
+
+/*
+ * Voltage levels for different operating modes: on, sleep, retention and off
+ */
+#define OMAP3_ON_VOLTAGE_UV		1200000
+#define OMAP3_ONLP_VOLTAGE_UV		1000000
+#define OMAP3_RET_VOLTAGE_UV		975000
+#define OMAP3_OFF_VOLTAGE_UV		600000
+
+struct omap_vc_param omap3_mpu_vc_data = {
+	.on		= OMAP3_ON_VOLTAGE_UV,
+	.onlp		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret		= OMAP3_RET_VOLTAGE_UV,
+	.off		= OMAP3_OFF_VOLTAGE_UV,
+};
+
+struct omap_vc_param omap3_core_vc_data = {
+	.on		= OMAP3_ON_VOLTAGE_UV,
+	.onlp		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret		= OMAP3_RET_VOLTAGE_UV,
+	.off		= OMAP3_OFF_VOLTAGE_UV,
+};
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index d70b930..085e5d6 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -87,3 +87,31 @@ struct omap_vc_channel omap4_vc_core = {
 	.cfg_channel_sa_shift = OMAP4430_SA_VDD_CORE_L_SHIFT,
 };
 
+/*
+ * Voltage levels for different operating modes: on, sleep, retention and off
+ */
+#define OMAP4_ON_VOLTAGE_UV			1375000
+#define OMAP4_ONLP_VOLTAGE_UV			1375000
+#define OMAP4_RET_VOLTAGE_UV			837500
+#define OMAP4_OFF_VOLTAGE_UV			0
+
+struct omap_vc_param omap4_mpu_vc_data = {
+	.on			= OMAP4_ON_VOLTAGE_UV,
+	.onlp			= OMAP4_ONLP_VOLTAGE_UV,
+	.ret			= OMAP4_RET_VOLTAGE_UV,
+	.off			= OMAP4_OFF_VOLTAGE_UV,
+};
+
+struct omap_vc_param omap4_iva_vc_data = {
+	.on			= OMAP4_ON_VOLTAGE_UV,
+	.onlp			= OMAP4_ONLP_VOLTAGE_UV,
+	.ret			= OMAP4_RET_VOLTAGE_UV,
+	.off			= OMAP4_OFF_VOLTAGE_UV,
+};
+
+struct omap_vc_param omap4_core_vc_data = {
+	.on			= OMAP4_ON_VOLTAGE_UV,
+	.onlp			= OMAP4_ONLP_VOLTAGE_UV,
+	.ret			= OMAP4_RET_VOLTAGE_UV,
+	.off			= OMAP4_OFF_VOLTAGE_UV,
+};
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 949938d..940a0d6 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -76,6 +76,8 @@ struct voltagedomain {
 	const struct omap_vfsm_instance *vfsm;
 	struct omap_vp_instance *vp;
 	struct omap_voltdm_pmic *pmic;
+	struct omap_vp_param *vp_param;
+	struct omap_vc_param *vc_param;
 
 	atomic_t usecount;
 	int target_state;
@@ -151,10 +153,6 @@ struct omap_volt_data {
 struct omap_voltdm_pmic {
 	int slew_rate;
 	int step_size;
-	u32 on_volt;
-	u32 onlp_volt;
-	u32 ret_volt;
-	u32 off_volt;
 	u16 volt_setup_time;
 	u16 i2c_slave_addr;
 	u16 volt_reg_addr;
@@ -171,6 +169,18 @@ struct omap_voltdm_pmic {
 	u8 (*uv_to_vsel) (unsigned long uV);
 };
 
+struct omap_vp_param {
+	u32 vddmax;
+	u32 vddmin;
+};
+
+struct omap_vc_param {
+	u32 on;
+	u32 onlp;
+	u32 ret;
+	u32 off;
+};
+
 void omap_voltage_get_volttable(struct voltagedomain *voltdm,
 		struct omap_volt_data **volt_data);
 struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index c005e2f..6bcb0f3 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -116,6 +116,11 @@ void __init omap3xxx_voltagedomains_init(void)
 		omap3_voltdm_core.volt_data = omap34xx_vddcore_volt_data;
 	}
 
+	omap3_voltdm_mpu.vp_param = &omap3_mpu_vp_data;
+	omap3_voltdm_core.vp_param = &omap3_core_vp_data;
+	omap3_voltdm_mpu.vc_param = &omap3_mpu_vc_data;
+	omap3_voltdm_core.vc_param = &omap3_core_vc_data;
+
 	if (cpu_is_omap3517() || cpu_is_omap3505())
 		voltdms = voltagedomains_am35xx;
 	else
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index 4e11d02..11f43e4 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -104,6 +104,14 @@ void __init omap44xx_voltagedomains_init(void)
 	omap4_voltdm_iva.volt_data = omap44xx_vdd_iva_volt_data;
 	omap4_voltdm_core.volt_data = omap44xx_vdd_core_volt_data;
 
+	omap4_voltdm_mpu.vp_param = &omap4_mpu_vp_data;
+	omap4_voltdm_iva.vp_param = &omap4_iva_vp_data;
+	omap4_voltdm_core.vp_param = &omap4_core_vp_data;
+
+	omap4_voltdm_mpu.vc_param = &omap4_mpu_vc_data;
+	omap4_voltdm_iva.vc_param = &omap4_iva_vc_data;
+	omap4_voltdm_core.vc_param = &omap4_core_vc_data;
+
 	for (i = 0; voltdm = voltagedomains_omap4[i], voltdm; i++)
 		voltdm->sys_clk.name = sys_clk_name;
 
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 7c155d2..0fdf708 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -117,6 +117,13 @@ extern struct omap_vp_instance omap4_vp_mpu;
 extern struct omap_vp_instance omap4_vp_iva;
 extern struct omap_vp_instance omap4_vp_core;
 
+extern struct omap_vp_param omap3_mpu_vp_data;
+extern struct omap_vp_param omap3_core_vp_data;
+
+extern struct omap_vp_param omap4_mpu_vp_data;
+extern struct omap_vp_param omap4_iva_vp_data;
+extern struct omap_vp_param omap4_core_vp_data;
+
 void omap_vp_init(struct voltagedomain *voltdm);
 void omap_vp_enable(struct voltagedomain *voltdm);
 void omap_vp_disable(struct voltagedomain *voltdm);
diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
index bd89f80..1914e02 100644
--- a/arch/arm/mach-omap2/vp3xxx_data.c
+++ b/arch/arm/mach-omap2/vp3xxx_data.c
@@ -77,3 +77,13 @@ struct omap_vp_instance omap3_vp_core = {
 	.vstatus = OMAP3_PRM_VP2_STATUS_OFFSET,
 	.voltage = OMAP3_PRM_VP2_VOLTAGE_OFFSET,
 };
+
+struct omap_vp_param omap3_mpu_vp_data = {
+	.vddmin			= OMAP3430_VP1_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP3430_VP1_VLIMITTO_VDDMAX,
+};
+
+struct omap_vp_param omap3_core_vp_data = {
+	.vddmin			= OMAP3430_VP2_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP3430_VP2_VLIMITTO_VDDMAX,
+};
diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
index 8c031d1..e62f6b0 100644
--- a/arch/arm/mach-omap2/vp44xx_data.c
+++ b/arch/arm/mach-omap2/vp44xx_data.c
@@ -87,3 +87,18 @@ struct omap_vp_instance omap4_vp_core = {
 	.vstatus = OMAP4_PRM_VP_CORE_STATUS_OFFSET,
 	.voltage = OMAP4_PRM_VP_CORE_VOLTAGE_OFFSET,
 };
+
+struct omap_vp_param omap4_mpu_vp_data = {
+	.vddmin			= OMAP4_VP_MPU_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP4_VP_MPU_VLIMITTO_VDDMAX,
+};
+
+struct omap_vp_param omap4_iva_vp_data = {
+	.vddmin			= OMAP4_VP_IVA_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP4_VP_IVA_VLIMITTO_VDDMAX,
+};
+
+struct omap_vp_param omap4_core_vp_data = {
+	.vddmin			= OMAP4_VP_CORE_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP4_VP_CORE_VLIMITTO_VDDMAX,
+};
-- 
1.7.4.1

