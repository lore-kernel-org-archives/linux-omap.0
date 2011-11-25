From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 12/15] vc: omap3: auto_ret / auto_off support
Date: Fri, 25 Nov 2011 17:49:45 +0200
Message-ID: <1322236188-19456-13-git-send-email-t-kristo@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51405 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab1KYPuR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 10:50:17 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAPFoGvN005774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:17 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAPFoG75005600
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:16 -0600 (CST)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFoGdN017980
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:16 -0600 (CST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com

Voltage code will now enable / disable auto_ret / auto_off dynamically
according to the voltagedomain usecounts. This is accomplished via
the usage of the voltdm callback functions for sleep / wakeup.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |   91 ++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 1562aa9..ec74c68 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/string.h>
 
 #include <asm/div64.h>
 
@@ -230,9 +231,6 @@ static void omap3_set_i2c_timings(struct voltagedomain *voltdm, int off_mode)
 	unsigned long voltsetup1;
 	u32 tgt_volt;
 
-	/* Oscillator is not shut down if omap is controlling voltages */
-	omap3_set_clksetup(1, voltdm);
-
 	if (off_mode)
 		tgt_volt = voltdm->vc_param->off;
 	else
@@ -246,12 +244,6 @@ static void omap3_set_i2c_timings(struct voltagedomain *voltdm, int off_mode)
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
 
 static void omap3_set_off_timings(struct voltagedomain *voltdm)
@@ -260,7 +252,6 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 	unsigned long voltsetup2;
 	unsigned long voltsetup2_old;
 	u32 val;
-	u32 tstart, tshut;
 
 	/* check if pmic is controlling off-mode voltages */
 	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
@@ -270,9 +261,6 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 		return;
 	}
 
-	omap_pm_get_oscillator(&tstart, &tshut);
-	omap3_set_clksetup(tstart, voltdm);
-
 	clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
 
 	/* voltsetup 2 in us */
@@ -302,16 +290,87 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 	 */
 	voltdm->rmw(voltdm->vfsm->voltsetup_mask, 0,
 		voltdm->vfsm->voltsetup_reg);
+}
 
-	/* voltoffset must be clksetup minus voltsetup2 according to TRM */
-	voltdm->write(clksetup - voltsetup2, OMAP3_PRM_VOLTOFFSET_OFFSET);
+static void omap3_set_core_ret_timings(struct voltagedomain *voltdm)
+{
+	omap3_set_clksetup(1, voltdm);
+
+	/*
+	 * Reset voltsetup 2 and voltoffset when entering retention
+	 * as they are only used when pmic is controlling voltages
+	 */
+	voltdm->write(0, OMAP3_PRM_VOLTSETUP2_OFFSET);
+	voltdm->write(0, OMAP3_PRM_VOLTOFFSET_OFFSET);
+	omap3_set_i2c_timings(voltdm, 0);
 }
 
-static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
+static void omap3_set_core_off_timings(struct voltagedomain *voltdm)
 {
+	u32 tstart, tshut;
+	omap_pm_get_oscillator(&tstart, &tshut);
+	omap3_set_clksetup(tstart, voltdm);
 	omap3_set_off_timings(voltdm);
 }
 
+static void omap3_vc_channel_sleep(struct voltagedomain *voltdm)
+{
+	/* Set off timings if entering off */
+	if (voltdm->target_state == PWRDM_POWER_OFF)
+		omap3_set_off_timings(voltdm);
+	else
+		omap3_set_i2c_timings(voltdm, 0);
+}
+
+static void omap3_vc_channel_wakeup(struct voltagedomain *voltdm)
+{
+}
+
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
+	if (mode & OMAP3430_AUTO_OFF_MASK)
+		omap3_set_core_off_timings(voltdm);
+	else
+		omap3_set_core_ret_timings(voltdm);
+
+	voltdm->rmw(OMAP3430_AUTO_OFF_MASK | OMAP3430_AUTO_RET_MASK |
+		    OMAP3430_AUTO_SLEEP_MASK, mode,
+		    OMAP3_PRM_VOLTCTRL_OFFSET);
+}
+
+static void omap3_vc_core_wakeup(struct voltagedomain *voltdm)
+{
+	voltdm->rmw(OMAP3430_AUTO_OFF_MASK | OMAP3430_AUTO_RET_MASK |
+		    OMAP3430_AUTO_SLEEP_MASK, 0, OMAP3_PRM_VOLTCTRL_OFFSET);
+}
+
+static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
+{
+	if (!strcmp(voltdm->name, "core")) {
+		voltdm->sleep = omap3_vc_core_sleep;
+		voltdm->wakeup = omap3_vc_core_wakeup;
+		omap3_set_core_ret_timings(voltdm);
+	} else {
+		voltdm->sleep = omap3_vc_channel_sleep;
+		voltdm->wakeup = omap3_vc_channel_wakeup;
+		omap3_set_i2c_timings(voltdm, 0);
+	}
+}
+
 static u32 omap4_calc_volt_ramp(struct voltagedomain *voltdm, u32 voltage_diff,
 		u32 clk_rate)
 {
-- 
1.7.4.1

