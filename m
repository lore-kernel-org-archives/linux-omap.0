From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 12/14] arm: omap3: vc: auto_ret / auto_off support
Date: Tue, 21 Feb 2012 16:04:56 +0200
Message-ID: <1329833098-19900-13-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43959 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab2BUOGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 09:06:07 -0500
In-Reply-To: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Voltage code will now enable / disable auto_ret / auto_off dynamically
according to the voltagedomain usecounts. This is accomplished via
the usage of the voltdm callback functions for sleep / wakeup.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |  139 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 120 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 0971221..49df835 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/string.h>
 
 #include <asm/div64.h>
 
@@ -243,12 +244,6 @@ static void omap3_set_i2c_timings(struct voltagedomain *voltdm, bool off_mode)
 	unsigned long voltsetup1;
 	u32 tgt_volt;
 
-	/*
-	 * Oscillator is shut down only if we are using sys_off_mode pad,
-	 * thus we set a minimal setup time here
-	 */
-	omap3_set_clksetup(1, voltdm);
-
 	if (off_mode)
 		tgt_volt = voltdm->vc_param->off;
 	else
@@ -262,12 +257,6 @@ static void omap3_set_i2c_timings(struct voltagedomain *voltdm, bool off_mode)
 	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
 		voltsetup1 << __ffs(voltdm->vfsm->voltsetup_mask),
 		voltdm->vfsm->voltsetup_reg);
-
-	/*
-	 * pmic is not controlling the voltage scaling during retention,
-	 * thus set voltsetup2 to 0
-	 */
-	voltdm->write(0, OMAP3_PRM_VOLTSETUP2_OFFSET);
 }
 
 /**
@@ -289,7 +278,6 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 	unsigned long voltsetup2;
 	unsigned long voltsetup2_old;
 	u32 val;
-	u32 tstart, tshut;
 
 	/* check if sys_off_mode is used to control off-mode voltages */
 	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
@@ -299,9 +287,6 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 		return;
 	}
 
-	omap_pm_get_oscillator(&tstart, &tshut);
-	omap3_set_clksetup(tstart, voltdm);
-
 	clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
 
 	/* voltsetup 2 in us */
@@ -331,17 +316,133 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 	 */
 	voltdm->rmw(voltdm->vfsm->voltsetup_mask, 0,
 		voltdm->vfsm->voltsetup_reg);
+}
 
-	/* voltoffset must be clksetup minus voltsetup2 according to TRM */
-	voltdm->write(clksetup - voltsetup2, OMAP3_PRM_VOLTOFFSET_OFFSET);
+/**
+ * omap3_set_core_ret_timings - set retention timings for core domain
+ * @voltdm: pointer for core voltagedomain struct
+ *
+ * This function is called once core domain is ready to enter
+ * retention. This sets the values for the global setup variables like
+ * oscillator setup time, and the ramp times for voltages.
+ */
+static void omap3_set_core_ret_timings(struct voltagedomain *voltdm)
+{
+	/*
+	 * Oscillator is not shut down in retention, thus set minimal
+	 * clock setup time
+	 */
+	omap3_set_clksetup(1, voltdm);
+
+	/*
+	 * Reset voltsetup 2 and voltoffset when entering retention
+	 * as they are only used when pmic is controlling voltages
+	 */
+	voltdm->write(0, OMAP3_PRM_VOLTSETUP2_OFFSET);
+	voltdm->write(0, OMAP3_PRM_VOLTOFFSET_OFFSET);
+	omap3_set_i2c_timings(voltdm, false);
 }
 
-static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
+/**
+ * omap3_set_core_off_timings - set off timings for core domain
+ * @voltdm: pointer for core voltagedomain struct
+ *
+ * This function is called once core domain is ready to enter off-mode.
+ * This sets the values for the global setup variables like oscillator
+ * setup time, and the ramp times for voltages.
+ */
+static void omap3_set_core_off_timings(struct voltagedomain *voltdm)
 {
+	u32 tstart, tshut;
+
+	omap_pm_get_oscillator(&tstart, &tshut);
+	omap3_set_clksetup(tstart, voltdm);
 	omap3_set_off_timings(voltdm);
 }
 
 /**
+ * omap3_vc_channel_sleep - idle callback for a voltagedomain
+ * @voltdm: voltage channel that is entering idle
+ *
+ * Prepares voltage channel for entering idle. This gets called from
+ * the voltagedomain code once the usecount for the domain reaches zero.
+ * Function checks the target sleep mode and configures the channel
+ * accordingly.
+ */
+static void omap3_vc_channel_sleep(struct voltagedomain *voltdm)
+{
+	/* Set off timings if entering off */
+	if (voltdm->target_state == PWRDM_POWER_OFF)
+		omap3_set_off_timings(voltdm);
+	else
+		omap3_set_i2c_timings(voltdm, false);
+}
+
+/**
+ * omap3_vc_core_sleep - idle callback for core voltagedomain
+ * @voltdm: pointer to core voltagedomain struct
+ *
+ * Prepares core voltagedomain for idle. This checks the target sleep
+ * mode of the device (highest sleep mode of all powerdomains), and
+ * sets up the device according to this either for retention, sleep
+ * or off-mode.
+ */
+static void omap3_vc_core_sleep(struct voltagedomain *voltdm)
+{
+	u8 mode;
+
+	switch (voltdm->target_state) {
+	case PWRDM_POWER_OFF:
+		mode = OMAP3430_AUTO_OFF_MASK;
+		break;
+	case PWRDM_POWER_RET:
+		mode = OMAP3430_AUTO_RET_MASK;
+		break;
+	default:
+		mode = OMAP3430_AUTO_SLEEP_MASK;
+		break;
+	}
+
+	if (mode == OMAP3430_AUTO_OFF_MASK)
+		omap3_set_core_off_timings(voltdm);
+	else
+		omap3_set_core_ret_timings(voltdm);
+
+	voltdm->rmw(OMAP3430_AUTO_OFF_MASK | OMAP3430_AUTO_RET_MASK |
+		    OMAP3430_AUTO_SLEEP_MASK, mode,
+		    OMAP3_PRM_VOLTCTRL_OFFSET);
+}
+
+/**
+ * omap3_vc_core_wakeup - wakeup callback for core domain
+ * @voltdm: pointer to core voltagedomain struct
+ *
+ * Resumes core voltagedomain from idle. Callback from voltagedomain
+ * code once usecount reaches non-zero value.
+ */
+static void omap3_vc_core_wakeup(struct voltagedomain *voltdm)
+{
+	voltdm->rmw(OMAP3430_AUTO_OFF_MASK | OMAP3430_AUTO_RET_MASK |
+		    OMAP3430_AUTO_SLEEP_MASK, 0, OMAP3_PRM_VOLTCTRL_OFFSET);
+}
+
+static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
+{
+	/*
+	 * Set up voltagedomain callbacks for idle / resume and init
+	 * channel for retention voltage levels.
+	 */
+	if (!strcmp(voltdm->name, "core")) {
+		voltdm->sleep = omap3_vc_core_sleep;
+		voltdm->wakeup = omap3_vc_core_wakeup;
+		omap3_set_core_ret_timings(voltdm);
+	} else {
+		voltdm->sleep = omap3_vc_channel_sleep;
+		omap3_set_i2c_timings(voltdm, false);
+	}
+}
+
+/**
  * omap4_calc_volt_ramp - calculates voltage ramping delays on omap4
  * @voltdm: channel to calculate values for
  * @voltage_diff: voltage difference in microvolts
-- 
1.7.4.1

