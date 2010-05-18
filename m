From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v6 3/7] omap3: pm: re-programing the setup time based on CORE_DOMAIN target state
Date: Tue, 18 May 2010 18:05:29 +0530
Message-ID: <1274186129-23928-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54168 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756206Ab0ERMfx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 May 2010 08:35:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

This patch will add a new function omap_voltage_vc_update() to re-program
the VC parameters while entering low power mode, based on CORE_DOMAIN target state.
The voltsetup2 is used only when the device exits sys_off mode
(with PRM_VOLTCTRL[3]SEL_OFF set to 1).

Also removed the clearing of PRM_VOLTCTRL register bits, because this will be
used only when it goes to low power mode next time.

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/pm34xx.c  |   26 +++-----------------------
 arch/arm/mach-omap2/voltage.c |   41 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.h |    1 +
 3 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5039b35..1ff6293 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -439,20 +439,12 @@ void omap_sram_idle(void)
 	if (core_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(0);
 		omap_uart_prepare_idle(1);
-		if (core_next_state == PWRDM_POWER_OFF) {
-			u32 voltctrl = OMAP3430_AUTO_OFF;
+		/* Update the voltsetup time for RET/OFF */
+		omap_voltage_vc_update(core_next_state);
 
-			if (voltage_off_while_idle)
-				voltctrl |= OMAP3430_SEL_OFF;
-			prm_set_mod_reg_bits(voltctrl,
-					     OMAP3430_GR_MOD,
-					     OMAP3_PRM_VOLTCTRL_OFFSET);
+		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_prcm_save_context();
-		} else if (core_next_state == PWRDM_POWER_RET) {
-			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
-						OMAP3430_GR_MOD,
-						OMAP3_PRM_VOLTCTRL_OFFSET);
 		}
 	}
 
@@ -510,18 +502,6 @@ void omap_sram_idle(void)
 		}
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
-		if (core_next_state == PWRDM_POWER_OFF) {
-			u32 voltctrl = OMAP3430_AUTO_OFF;
-
-			if (voltage_off_while_idle)
-				voltctrl |= OMAP3430_SEL_OFF;
-			prm_clear_mod_reg_bits(voltctrl,
-					       OMAP3430_GR_MOD,
-					       OMAP3_PRM_VOLTCTRL_OFFSET);
-		} else if (core_next_state == PWRDM_POWER_RET)
-			prm_clear_mod_reg_bits(OMAP3430_AUTO_RET,
-						OMAP3430_GR_MOD,
-						OMAP3_PRM_VOLTCTRL_OFFSET);
 	}
 	omap3_intc_resume_idle();
 
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index efa16d4..f4069db 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -943,6 +943,47 @@ void __init omap_voltage_init_vc(struct prm_setup_vc *setup_vc)
 	vc_config.off.clksetup = setup_vc->off.clksetup;
 }
 
+void omap_voltage_vc_update(int core_next_state)
+{
+	u32 voltctrl = 0;
+
+	/* update voltsetup time */
+	if (core_next_state == PWRDM_POWER_OFF) {
+		voltctrl = OMAP3430_AUTO_OFF;
+		prm_write_mod_reg(vc_config.off.clksetup, OMAP3430_GR_MOD,
+				OMAP3_PRM_CLKSETUP_OFFSET);
+		prm_write_mod_reg((vc_config.off.voltsetup1_vdd2 <<
+				OMAP3430_SETUP_TIME2_SHIFT) |
+				(vc_config.off.voltsetup1_vdd1 <<
+				OMAP3430_SETUP_TIME1_SHIFT),
+				OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
+
+		if (voltage_off_while_idle) {
+			voltctrl |= OMAP3430_SEL_OFF;
+			prm_write_mod_reg(vc_config.off.voltsetup2,
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VOLTSETUP2_OFFSET);
+		}
+
+	} else if (core_next_state == PWRDM_POWER_RET) {
+		voltctrl = OMAP3430_AUTO_RET;
+		prm_write_mod_reg(vc_config.ret.clksetup, OMAP3430_GR_MOD,
+				OMAP3_PRM_CLKSETUP_OFFSET);
+		prm_write_mod_reg((vc_config.ret.voltsetup1_vdd2 <<
+				OMAP3430_SETUP_TIME2_SHIFT) |
+				(vc_config.ret.voltsetup1_vdd1 <<
+				OMAP3430_SETUP_TIME1_SHIFT),
+				OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
+
+		/* clear voltsetup2_reg if sys_off not enabled */
+		prm_write_mod_reg(vc_config.ret.voltsetup2, OMAP3430_GR_MOD,
+				OMAP3_PRM_VOLTSETUP2_OFFSET);
+	}
+
+	prm_set_mod_reg_bits(voltctrl, OMAP3430_GR_MOD,
+				OMAP3_PRM_VOLTCTRL_OFFSET);
+}
+
 /**
  * omap_get_voltage_table : API to get the voltage table associated with a
  *			    particular voltage domain.
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index cc2b355..f8462c3 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -126,6 +126,7 @@ struct omap_volt_data {
 void omap_voltageprocessor_enable(int vp_id);
 void omap_voltageprocessor_disable(int vp_id);
 void omap_voltage_init_vc(struct prm_setup_vc *setup_vc);
+void omap_voltage_vc_update(int core_next_state);
 void omap_voltage_init(void);
 int omap_voltage_scale(int vdd, unsigned long target_volt,
 					unsigned long current_volt);
-- 
1.7.0.4

