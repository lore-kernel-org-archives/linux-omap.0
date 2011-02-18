From: Lesly A M <leslyam@ti.com>
Subject: [PATCH 07/12] omap3: pm: Re-programing the setup time based on CORE target state
Date: Fri, 18 Feb 2011 22:38:53 +0530
Message-ID: <1298048938-1480-8-git-send-email-leslyam@ti.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34026 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698Ab1BRRJU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 12:09:20 -0500
In-Reply-To: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Since the setup time values are different for each CORE_DOMAIN target state
and VDD1(MPU voltage) can not be scaled separately. Because VDD1 has
dependency with VDD2(CORE voltage)

Adding a new function omap3_voltage_vc_update() to re-program the VC setuptime
data while entering low power mode.

Also added a flag to optimize the sleep latency. This flag is checked before
calling the vc_update, and is ignored if it is already configured for
the same target state.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/pm34xx.c              |   11 ++-
 arch/arm/mach-omap2/voltage.c             |  165 ++++++++++++++++++++--------
 arch/arm/plat-omap/include/plat/voltage.h |    2 +
 3 files changed, 127 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8a7c756..0d94dc1 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -40,6 +40,7 @@
 #include <plat/gpmc.h>
 #include <plat/dma.h>
 #include <plat/usb.h>
+#include <plat/voltage.h>
 
 #include <asm/tlbflush.h>
 
@@ -356,6 +357,7 @@ void omap_sram_idle(void)
 	int core_next_state = PWRDM_POWER_ON;
 	int per_going_off;
 	int core_prev_state, per_prev_state;
+	static int core_next_state_set = PWRDM_POWER_ON;
 	u32 sdrc_pwr = 0;
 
 	if (!_omap_sram_idle)
@@ -422,6 +424,11 @@ void omap_sram_idle(void)
 			omap3_core_save_context();
 			omap3_cm_save_context();
 		}
+		/* Update the voltsetup time for RET/OFF */
+		if (core_next_state != core_next_state_set) {
+			omap3_voltage_vc_update(core_next_state);
+			core_next_state_set = core_next_state;
+		}
 	}
 
 	omap3_intc_prepare_idle();
@@ -478,10 +485,6 @@ void omap_sram_idle(void)
 		}
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
-		if (core_next_state == PWRDM_POWER_OFF)
-			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
-					       OMAP3430_GR_MOD,
-					       OMAP3_PRM_VOLTCTRL_OFFSET);
 	}
 	omap3_intc_resume_idle();
 
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 1c58f8b..43279a6 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -35,11 +35,18 @@
 #include "prcm44xx.h"
 #include "prminst44xx.h"
 #include "control.h"
+#include "powerdomain.h"
 
 #define VP_IDLE_TIMEOUT		200
 #define VP_TRANXDONE_TIMEOUT	300
 #define VOLTAGE_DIR_SIZE	16
 
+/* duration of one sys_32k clk cycle in uS */
+#define SYS_32K_CLK_CYCLE	31
+
+static u32 sys_clk_speed;
+static u32 sys_clk_cycle;
+
 /* Voltage processor register offsets */
 struct vp_reg_offs {
 	u8 vpconfig;
@@ -771,13 +778,6 @@ static void __init omap3_vc_init(struct omap_vdd_info *vdd)
 	vc_val |= vdd->pmic_info->pmic_reg << vdd->vc_reg.smps_volra_shift;
 	vdd->write_reg(vc_val, mod, vdd->vc_reg.smps_volra_reg);
 
-	/*Configure the setup times */
-	vc_val = vdd->read_reg(mod, vdd->vc_reg.voltsetup_reg);
-	vc_val &= ~vdd->vc_reg.voltsetup_mask;
-	vc_val |= vdd->pmic_info->voltsetup_ret.voltsetup <<
-			vdd->vc_reg.voltsetup_shift;
-	vdd->write_reg(vc_val, mod, vdd->vc_reg.voltsetup_reg);
-
 	/* Set up the on, inactive, retention and off voltage */
 	on_vsel = vdd->pmic_info->uv_to_vsel(vdd->pmic_info->on_volt);
 	onlp_vsel = vdd->pmic_info->uv_to_vsel(vdd->pmic_info->onlp_volt);
@@ -797,20 +797,14 @@ static void __init omap3_vc_init(struct omap_vdd_info *vdd)
 			OMAP3_PRM_VC_CH_CONF_OFFSET);
 	vdd->write_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN_MASK, mod,
 			OMAP3_PRM_VC_I2C_CFG_OFFSET);
-	vdd->write_reg(vdd->pmic_info->clksetup_ret.clksetup, mod,
-			OMAP3_PRM_CLKSETUP_OFFSET);
-	vdd->write_reg(vdd->pmic_info->voltsetup_ret.voltoffset, mod,
-			vdd->vc_reg.voltoffset_reg);
-	vdd->write_reg(vdd->pmic_info->voltsetup_ret.voltsetup2, mod,
-			vdd->vc_reg.voltsetup2_reg);
+	omap3_voltage_vc_update(PWRDM_POWER_RET);
 	is_initialized = true;
 }
 
 /* Sets up all the VDD related info for OMAP3 */
 static int __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 {
-	struct clk *sys_ck;
-	u32 sys_clk_speed, timeout_val, waittime;
+	u32 timeout_val, waittime;
 
 	if (!vdd->pmic_info) {
 		pr_err("%s: PMIC info requried to configure vdd_%s not"
@@ -853,21 +847,6 @@ static int __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 		return -EINVAL;
 	}
 
-	/*
-	 * Sys clk rate is require to calculate vp timeout value and
-	 * smpswaittimemin and smpswaittimemax.
-	 */
-	sys_ck = clk_get(NULL, "sys_ck");
-	if (IS_ERR(sys_ck)) {
-		pr_warning("%s: Could not get the sys clk to calculate"
-			"various vdd_%s params\n", __func__, vdd->voltdm.name);
-		return -EINVAL;
-	}
-	sys_clk_speed = clk_get_rate(sys_ck);
-	clk_put(sys_ck);
-	/* Divide to avoid overflow */
-	sys_clk_speed /= 1000;
-
 	/* Generic voltage parameters */
 	vdd->curr_volt = 1200000;
 	vdd->ocp_mod = OCP_MOD;
@@ -989,8 +968,7 @@ static void __init omap4_vc_init(struct omap_vdd_info *vdd)
 /* Sets up all the VDD related info for OMAP4 */
 static int __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
 {
-	struct clk *sys_ck;
-	u32 sys_clk_speed, timeout_val, waittime;
+	u32 timeout_val, waittime;
 
 	if (!vdd->pmic_info) {
 		pr_err("%s: PMIC info requried to configure vdd_%s not"
@@ -1046,21 +1024,6 @@ static int __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
 		return -EINVAL;
 	}
 
-	/*
-	 * Sys clk rate is require to calculate vp timeout value and
-	 * smpswaittimemin and smpswaittimemax.
-	 */
-	sys_ck = clk_get(NULL, "sys_clkin_ck");
-	if (IS_ERR(sys_ck)) {
-		pr_warning("%s: Could not get the sys clk to calculate"
-			"various vdd_%s params\n", __func__, vdd->voltdm.name);
-		return -EINVAL;
-	}
-	sys_clk_speed = clk_get_rate(sys_ck);
-	clk_put(sys_ck);
-	/* Divide to avoid overflow */
-	sys_clk_speed /= 1000;
-
 	/* Generic voltage parameters */
 	vdd->curr_volt = 1200000;
 	vdd->ocp_mod = OMAP4430_PRM_OCP_SOCKET_INST;
@@ -1557,10 +1520,118 @@ int __init omap_voltage_late_init(void)
 }
 
 /**
+ * omap3_voltage_vc_update() - update the clk & vol setup time.
+ *
+ * @core_next_state:	next target state for CORE DOMAIN.
+ *
+ * This API is to be called to update the clk & volt setup time
+ * depending on the CORE target state.
+ */
+void omap3_voltage_vc_update(int core_next_state)
+{
+	u32 voltsetup_time;
+	u16 mod;
+	struct voltagedomain *voltdm;
+	struct omap_vdd_info *vdd_mpu, *vdd_core;
+	u16 voltsetup_vdd1, voltsetup_vdd2;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	voltdm = omap_voltage_domain_lookup("mpu");
+	vdd_mpu = container_of(voltdm, struct omap_vdd_info, voltdm);
+	mod = vdd_mpu->vc_reg.prm_mod;
+	voltdm = omap_voltage_domain_lookup("core");
+	vdd_core = container_of(voltdm, struct omap_vdd_info, voltdm);
+
+	/* update voltsetup time */
+	if (core_next_state == PWRDM_POWER_OFF) {
+		vdd_mpu->write_reg(OMAP3430_SEL_OFF_MASK |
+				OMAP3430_AUTO_OFF_MASK,
+				mod, OMAP3_PRM_VOLTCTRL_OFFSET);
+
+		/* Calculating the values with sys_32k clk */
+		vdd_mpu->write_reg(vdd_mpu->pmic_info->clksetup_off.clksetup /
+			SYS_32K_CLK_CYCLE, mod, OMAP3_PRM_CLKSETUP_OFFSET);
+
+		/* Calculating the values with sys clk */
+		voltsetup_vdd1 =
+			((vdd_mpu->pmic_info->voltsetup_off.voltsetup * 1000) /
+							sys_clk_cycle) >> 3;
+		voltsetup_vdd2 =
+			((vdd_core->pmic_info->voltsetup_off.voltsetup * 1000) /
+							sys_clk_cycle) >> 3;
+
+		voltsetup_time = (voltsetup_vdd2 <<
+				vdd_core->vc_reg.voltsetup_shift) |
+				voltsetup_vdd1;
+		vdd_mpu->write_reg(voltsetup_time, mod,
+				vdd_mpu->vc_reg.voltsetup_reg);
+
+		/* Calculating the values with sys_32k clk */
+		vdd_mpu->write_reg(
+			vdd_mpu->pmic_info->voltsetup_off.voltsetup2 /
+			SYS_32K_CLK_CYCLE, mod, vdd_mpu->vc_reg.voltsetup2_reg);
+		vdd_mpu->write_reg(
+			vdd_mpu->pmic_info->voltsetup_off.voltoffset /
+			SYS_32K_CLK_CYCLE, mod, vdd_mpu->vc_reg.voltoffset_reg);
+
+	} else if (core_next_state == PWRDM_POWER_RET) {
+		vdd_mpu->write_reg(OMAP3430_AUTO_RET_MASK, mod,
+				OMAP3_PRM_VOLTCTRL_OFFSET);
+
+		/* Calculating the values with sys_32k clk */
+		vdd_mpu->write_reg(vdd_mpu->pmic_info->clksetup_ret.clksetup /
+			SYS_32K_CLK_CYCLE, mod, OMAP3_PRM_CLKSETUP_OFFSET);
+
+		/* Calculating the values with sys clk */
+		voltsetup_vdd1 =
+			((vdd_mpu->pmic_info->voltsetup_ret.voltsetup * 1000) /
+							sys_clk_cycle) >> 3;
+		voltsetup_vdd2 =
+			((vdd_core->pmic_info->voltsetup_ret.voltsetup * 1000) /
+							sys_clk_cycle) >> 3;
+
+		voltsetup_time = (voltsetup_vdd2 <<
+				vdd_core->vc_reg.voltsetup_shift) |
+				voltsetup_vdd1;
+		vdd_mpu->write_reg(voltsetup_time, mod,
+				vdd_mpu->vc_reg.voltsetup_reg);
+		/* clear voltsetup2_reg if sys_off not enabled */
+		vdd_mpu->write_reg(
+			vdd_mpu->pmic_info->voltsetup_ret.voltsetup2 /
+			SYS_32K_CLK_CYCLE, mod, vdd_mpu->vc_reg.voltsetup2_reg);
+		vdd_mpu->write_reg(
+			vdd_mpu->pmic_info->voltsetup_ret.voltoffset /
+			SYS_32K_CLK_CYCLE, mod, vdd_mpu->vc_reg.voltoffset_reg);
+	}
+}
+
+/**
  * omap_voltage_early_init()- Volatage driver early init
  */
 static int __init omap_voltage_early_init(void)
 {
+	struct clk *sys_ck;
+
+	/*
+	 * Sys clk rate is require to calculate vp timeout value and
+	 * smpswaittimemin and smpswaittimemax.
+	 */
+	sys_ck = clk_get(NULL, "sys_ck");
+	if (IS_ERR(sys_ck)) {
+		pr_warning("%s: Could not get the sys_clk frequency.\n",
+							__func__);
+		return -EINVAL;
+	}
+	sys_clk_speed = clk_get_rate(sys_ck);
+	clk_put(sys_ck);
+
+	/* Divide to avoid overflow */
+	sys_clk_speed /= 1000;
+	/* Duration of one sys_clk cylce in nS */
+	sys_clk_cycle = 1000000 / sys_clk_speed;
+
 	if (cpu_is_omap34xx()) {
 		vdd_info = omap3_vdd_info;
 		nr_scalable_vdd = OMAP3_NR_SCALABLE_VDD;
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index c0373d0..2d737b9 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -151,6 +151,7 @@ struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm);
 #ifdef CONFIG_PM
 int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 		struct omap_volt_pmic_info *pmic_info);
+void omap3_voltage_vc_update(int core_next_state);
 void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		int voltscale_method);
 /* API to get the voltagedomain pointer */
@@ -163,6 +164,7 @@ static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 {
 	return -EINVAL;
 }
+void omap3_voltage_vc_update(int core_next_state) {}
 static inline  void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		int voltscale_method) {}
 static inline int omap_voltage_late_init(void)
-- 
1.7.1

