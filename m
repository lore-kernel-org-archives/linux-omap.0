From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/11] ARM: OMAP3: Fix voltage control for deeper idle states
Date: Thu, 10 Apr 2014 16:47:12 -0700
Message-ID: <1397173639-29587-5-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48970 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbaDJXr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 19:47:26 -0400
In-Reply-To: <1397173639-29587-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

Currently we're attempting to use a static value for the
voltctrl register that only works for controlling the PMIC
over I2C4. For using sys_off_mode signaling, we need to update
update clksetup, voltsetup1, voltsetup2 and voltctrl registers
dynamically depending on the idle state.

So let's fix this by configuring things for I2C4 controlled idle
and sys_off_mode pin controlled idle, and then write the
configured register values depending on the idle state. This
is similar what N900 kernel is doing too.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/vc.c | 99 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 73 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index dee4cee..63662e1 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -220,8 +220,18 @@ static inline u32 omap_usec_to_32k(u32 usec)
 	return DIV_ROUND_UP_ULL(32768ULL * (u64)usec, 1000000ULL);
 }
 
+struct omap3_vc_config {
+	u32 clksetup;
+	u32 voltsetup1;
+	u32 voltsetup2;
+	u32 voltctrl;
+};
+
+static struct omap3_vc_config omap3_vc_timings[2];
+
 void omap3_vc_set_pmic_signaling(int core_next_state)
 {
+	struct omap3_vc_config *c = omap3_vc_timings;
 	u32 voltctrl;
 
 	voltctrl = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
@@ -231,11 +241,20 @@ void omap3_vc_set_pmic_signaling(int core_next_state)
 		voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_RET |
 			      OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP);
 		voltctrl |= OMAP3430_PRM_VOLTCTRL_AUTO_OFF;
+		if (voltctrl & OMAP3430_PRM_VOLTCTRL_SEL_OFF)
+			omap2_prm_write_mod_reg(c->voltsetup2, OMAP3430_GR_MOD,
+						OMAP3_PRM_VOLTSETUP2_OFFSET);
+		else
+			omap2_prm_write_mod_reg(c->voltsetup1, OMAP3430_GR_MOD,
+						OMAP3_PRM_VOLTSETUP1_OFFSET);
 		break;
 	case PWRDM_POWER_RET:
+		c++;
 		voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_OFF |
 			      OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP);
 		voltctrl |= OMAP3430_PRM_VOLTCTRL_AUTO_RET;
+		omap2_prm_write_mod_reg(c->voltsetup1, OMAP3430_GR_MOD,
+					OMAP3_PRM_VOLTSETUP1_OFFSET);
 		break;
 	default:
 		voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_OFF |
@@ -292,6 +311,18 @@ static void __init omap3_vc_init_pmic_signaling(void)
 	omap3_vc_set_pmic_signaling(PWRDM_POWER_ON);
 }
 
+static void omap3_init_voltsetup1(struct voltagedomain *voltdm,
+				  struct omap3_vc_config *c, u32 idle)
+{
+	unsigned long val;
+
+	val = (voltdm->vc_param->on - idle) / voltdm->pmic->slew_rate;
+	val *= voltdm->sys_clk.rate / 8 / 1000000 + 1;
+	val <<= __ffs(voltdm->vfsm->voltsetup_mask);
+	c->voltsetup1 &= ~voltdm->vfsm->voltsetup_mask;
+	c->voltsetup1 |= val;
+}
+
 /**
  * omap3_set_i2c_timings - sets i2c sleep timings for a channel
  * @voltdm: channel to configure
@@ -302,31 +333,21 @@ static void __init omap3_vc_init_pmic_signaling(void)
  * or retention. Off mode has additionally an option to use sys_off_mode
  * pad, which uses a global signal to program the whole power IC to
  * off-mode.
+ *
+ * Note that pmic is not controlling the voltage scaling during
+ * retention signaled over I2C4, so we can keep voltsetup2 as 0.
+ * And the oscillator is not shut off over I2C4, so no need to
+ * set clksetup.
  */
-static void omap3_set_i2c_timings(struct voltagedomain *voltdm, bool off_mode)
+static void omap3_set_i2c_timings(struct voltagedomain *voltdm)
 {
-	unsigned long voltsetup1;
-	u32 tgt_volt;
-
-	if (off_mode)
-		tgt_volt = voltdm->vc_param->off;
-	else
-		tgt_volt = voltdm->vc_param->ret;
-
-	voltsetup1 = (voltdm->vc_param->on - tgt_volt) /
-			voltdm->pmic->slew_rate;
-
-	voltsetup1 = voltsetup1 * voltdm->sys_clk.rate / 8 / 1000000 + 1;
+	struct omap3_vc_config *c = omap3_vc_timings;
 
-	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
-		voltsetup1 << __ffs(voltdm->vfsm->voltsetup_mask),
-		voltdm->vfsm->voltsetup_reg);
-
-	/*
-	 * pmic is not controlling the voltage scaling during retention,
-	 * thus set voltsetup2 to 0
-	 */
-	voltdm->write(0, OMAP3_PRM_VOLTSETUP2_OFFSET);
+	/* Configure PRWDM_POWER_OFF over I2C4 */
+	omap3_init_voltsetup1(voltdm, c, voltdm->vc_param->off);
+	c++;
+	/* Configure PRWDM_POWER_RET over I2C4 */
+	omap3_init_voltsetup1(voltdm, c, voltdm->vc_param->ret);
 }
 
 /**
@@ -335,22 +356,48 @@ static void omap3_set_i2c_timings(struct voltagedomain *voltdm, bool off_mode)
  *
  * Calculates and sets up off-mode timings for a channel. Off-mode
  * can use either I2C based voltage scaling, or alternatively
- * sys_off_mode pad can be used to send a global command to power IC.
- * This function first checks which mode is being used, and calls
- * omap3_set_i2c_timings() if the system is using I2C control mode.
+ * sys_off_mode pad can be used to send a global command to power IC.n,
  * sys_off_mode has the additional benefit that voltages can be
  * scaled to zero volt level with TWL4030 / TWL5030, I2C can only
  * scale to 600mV.
+ *
+ * Note that omap is not controlling the voltage scaling during
+ * off idle signaled by sys_off_mode, so we can keep voltsetup1
+ * as 0.
  */
 static void omap3_set_off_timings(struct voltagedomain *voltdm)
 {
+	struct omap3_vc_config *c = omap3_vc_timings;
+	u32 tstart, tshut, voltoffset;
+
+	if (c->clksetup)
+		return;
+
+	omap_pm_get_oscillator(&tstart, &tshut);
+	if (tstart == ULONG_MAX) {
+		pr_debug("PM: oscillator start-up time not initialized, using 10ms\n");
+		c->clksetup = omap_usec_to_32k(10000);
+	} else {
+		c->clksetup = omap_usec_to_32k(tstart);
+	}
+
+	/*
+	 * For twl4030 errata 27, we need to allow minimum ~488.32 us wait to
+	 * switch from HFCLKIN to internal oscillator. That means timings
+	 * have voltoffset fixed to 0xa in rounded up 32 KiHz cycles. And
+	 * that means we can calculate the value based on the oscillator
+	 * start-up time since voltoffset2 = clksetup - voltoffset.
+	 */
+	voltoffset = omap_usec_to_32k(488);
+	c->voltsetup2 = c->clksetup - voltoffset;
+	voltdm->write(voltoffset, OMAP3_PRM_VOLTOFFSET_OFFSET);
 }
 
 static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
 {
 	omap3_vc_init_pmic_signaling();
 	omap3_set_off_timings(voltdm);
-	omap3_set_i2c_timings(voltdm, true);
+	omap3_set_i2c_timings(voltdm);
 }
 
 /**
-- 
1.8.1.1

