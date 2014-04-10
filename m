From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/11] ARM: OMAP3: Fix idle mode signaling for sys_clkreq and sys_off_mode
Date: Thu, 10 Apr 2014 16:47:10 -0700
Message-ID: <1397173639-29587-3-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48893 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbaDJXrY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 19:47:24 -0400
In-Reply-To: <1397173639-29587-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

While debugging legacy mode vs device tree booted PM regressions,
I noticed that omap3 is not toggling sys_clkreq and sys_off_mode
pins like it should.

The sys_clkreq and sys_off_mode pins are not toggling because of
the following issues:

1. The default polarity for the sys_off_mode pin is wrong.
   OFFMODE_POL needs to be cleared for sys_off_mode to go down when
   hitting off-idle, while CLKREQ_POL needs to be set so sys_clkreq
   goes down when hitting retention.

2. The values for voltctrl register need to be updated dynamically.
   We need to set either the retention idle bits, or off idle bits
   in the voltctrl register depending the idle mode we're targeting
   to hit.

Let's fix these two issues as otherwise the system will just
hang if any twl4030 PMIC idle scripts are loaded. The only case
where the system does not hang is if only retention idle over I2C4
is configured by the bootloader.

Note that even without the twl4030 PMIC scripts, these fixes will
do the proper signaling of sys_clkreq and sys_off_mode pins, so
the fixes are needed to fix monitoring of PM states with LEDs or
an oscilloscope.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm34xx.c           |  2 +
 arch/arm/mach-omap2/prm-regbits-34xx.h | 11 ++++-
 arch/arm/mach-omap2/vc.c               | 75 +++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/vc.h               |  2 +
 4 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 87099bb..3119ec2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -50,6 +50,7 @@
 #include "sdrc.h"
 #include "sram.h"
 #include "control.h"
+#include "vc.h"
 
 /* pm34xx errata defined in pm.h */
 u16 pm34xx_errata;
@@ -282,6 +283,7 @@ void omap_sram_idle(void)
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
+		omap3_vc_set_pmic_signaling(core_next_state);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_cm_save_context();
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index cebad56..106132d 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -123,8 +123,15 @@
 #define OMAP3430_GLOBAL_SW_RST_SHIFT			1
 #define OMAP3430_GLOBAL_COLD_RST_SHIFT			0
 #define OMAP3430_GLOBAL_COLD_RST_MASK			(1 << 0)
-#define OMAP3430_SEL_OFF_MASK				(1 << 3)
-#define OMAP3430_AUTO_OFF_MASK				(1 << 2)
+#define OMAP3430_PRM_VOLTCTRL_SEL_VMODE			(1 << 4)
+#define OMAP3430_PRM_VOLTCTRL_SEL_OFF			(1 << 3)
+#define OMAP3430_PRM_VOLTCTRL_AUTO_OFF			(1 << 2)
+#define OMAP3430_PRM_VOLTCTRL_AUTO_RET			(1 << 1)
+#define OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP		(1 << 0)
 #define OMAP3430_SETUP_TIME2_MASK			(0xffff << 16)
 #define OMAP3430_SETUP_TIME1_MASK			(0xffff << 0)
+#define OMAP3430_PRM_POLCTRL_OFFMODE_POL		(1 << 3)
+#define OMAP3430_PRM_POLCTRL_CLKOUT_POL			(1 << 2)
+#define OMAP3430_PRM_POLCTRL_CLKREQ_POL			(1 << 1)
+#define OMAP3430_PRM_POLCTRL_EXTVOL_POL			(1 << 0)
 #endif
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 49ac797..3d5ba5d 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -220,6 +220,78 @@ static inline u32 omap_usec_to_32k(u32 usec)
 	return DIV_ROUND_UP_ULL(32768ULL * (u64)usec, 1000000ULL);
 }
 
+void omap3_vc_set_pmic_signaling(int core_next_state)
+{
+	u32 voltctrl;
+
+	voltctrl = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
+					  OMAP3_PRM_VOLTCTRL_OFFSET);
+	switch (core_next_state) {
+	case PWRDM_POWER_OFF:
+		voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_RET |
+			      OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP);
+		voltctrl |= OMAP3430_PRM_VOLTCTRL_AUTO_OFF;
+		break;
+	case PWRDM_POWER_RET:
+		voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_OFF |
+			      OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP);
+		voltctrl |= OMAP3430_PRM_VOLTCTRL_AUTO_RET;
+		break;
+	default:
+		voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_OFF |
+			      OMAP3430_PRM_VOLTCTRL_AUTO_RET);
+		voltctrl |= OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP;
+		break;
+	}
+	omap2_prm_write_mod_reg(voltctrl, OMAP3430_GR_MOD,
+				OMAP3_PRM_VOLTCTRL_OFFSET);
+}
+
+/*
+ * Configure signal polarity for sys_clkreq and sys_off_mode pins
+ * as the default values are wrong and can cause the system to hang
+ * if any twl4030 sccripts are loaded.
+ */
+static void __init omap3_vc_init_pmic_signaling(void)
+{
+	u32 val, old;
+
+	val = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
+				     OMAP3_PRM_POLCTRL_OFFSET);
+	old = val;
+
+	if (old & OMAP3430_PRM_POLCTRL_CLKREQ_POL)
+		val |= OMAP3430_PRM_POLCTRL_CLKREQ_POL;
+	if (old & OMAP3430_PRM_POLCTRL_OFFMODE_POL)
+		val &= ~OMAP3430_PRM_POLCTRL_OFFMODE_POL;
+
+	if (val != old) {
+		pr_debug("PM: fixing sys_clkreq and sys_off_mode polarity 0x%x -> 0x%x\n",
+			 old, val);
+	}
+	omap2_prm_write_mod_reg(val, OMAP3430_GR_MOD,
+				OMAP3_PRM_POLCTRL_OFFSET);
+
+	/*
+	 * By default let's use I2C4 signaling for retention idle
+	 * and sys_off_mode pin signaling for off idle. This way we
+	 * have sys_clk_req pin go down for retention and both
+	 * sys_clk_req and sys_off_mode pins will go down for off
+	 * idle. And we can also scale voltages to zero for off-idle.
+	 * Note that no actual voltage scaling will happen unless the
+	 * board specific twl4030 PMIC scripts are loaded.
+	 */
+	val = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
+				     OMAP3_PRM_VOLTCTRL_OFFSET);
+	old = val;
+	val |= OMAP3430_PRM_VOLTCTRL_SEL_OFF;
+	pr_debug("PM: enabling voltctrl sys_off_mode signaling 0x%x -> 0x%x\n",
+		 old, val);
+	omap2_prm_write_mod_reg(val, OMAP3430_GR_MOD,
+				OMAP3_PRM_VOLTCTRL_OFFSET);
+	omap3_vc_set_pmic_signaling(PWRDM_POWER_ON);
+}
+
 /* Set oscillator setup time for omap3 */
 static void omap3_set_clksetup(u32 usec, struct voltagedomain *voltdm)
 {
@@ -292,7 +364,7 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 
 	/* check if sys_off_mode is used to control off-mode voltages */
 	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
-	if (!(val & OMAP3430_SEL_OFF_MASK)) {
+	if (!(val & OMAP3430_PRM_VOLTCTRL_SEL_OFF)) {
 		/* No, omap is controlling them over I2C */
 		omap3_set_i2c_timings(voltdm, true);
 		return;
@@ -337,6 +409,7 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 
 static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
 {
+	omap3_vc_init_pmic_signaling();
 	omap3_set_off_timings(voltdm);
 }
 
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 91c8d75..6351f62 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -117,6 +117,8 @@ extern struct omap_vc_param omap4_mpu_vc_data;
 extern struct omap_vc_param omap4_iva_vc_data;
 extern struct omap_vc_param omap4_core_vc_data;
 
+void omap3_vc_set_pmic_signaling(int core_next_state);
+
 void omap_vc_init_channel(struct voltagedomain *voltdm);
 int omap_vc_pre_scale(struct voltagedomain *voltdm,
 		      unsigned long target_volt,
-- 
1.8.1.1

