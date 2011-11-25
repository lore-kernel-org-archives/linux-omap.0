From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 07/15] omap3+: voltage: use oscillator data to calculate setup times
Date: Fri, 25 Nov 2011 17:49:40 +0200
Message-ID: <1322236188-19456-8-git-send-email-t-kristo@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47899 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab1KYPuJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Nov 2011 10:50:09 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAPFo9w2006350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:09 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAPFo9Z2005583
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:09 -0600 (CST)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFo9c2017843
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:09 -0600 (CST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com

We now use the previously defined oscillator setup / shutdown times
to calculate the register values for CLKSETUP.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 8384b70..351319c 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -13,6 +13,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <asm/div64.h>
+
 #include <plat/cpu.h>
 #include <plat/prcm.h>
 
@@ -22,6 +24,7 @@
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 #include "scrm44xx.h"
+#include "pm.h"
 
 /**
  * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
@@ -209,11 +212,27 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
 	return 0;
 }
 
+static u32 omap_usec_to_32k(u32 usec)
+{
+	/* DIV_ROUND_UP expanded to 64bit to avoid overflow */
+	u64 val = 32768ULL * (u64)usec + 1000000ULL - 1;
+	do_div(val, 1000000ULL);
+	return val;
+}
+
+static void omap3_set_clksetup(u32 usec, struct voltagedomain *voltdm)
+{
+	voltdm->write(omap_usec_to_32k(usec), OMAP3_PRM_CLKSETUP_OFFSET);
+}
+
 static void omap3_set_i2c_timings(struct voltagedomain *voltdm, int off_mode)
 {
 	unsigned long voltsetup1;
 	u32 tgt_volt;
 
+	/* Oscillator is not shut down if omap is controlling voltages */
+	omap3_set_clksetup(1, voltdm);
+
 	if (off_mode)
 		tgt_volt = voltdm->vc_param->off;
 	else
@@ -241,6 +260,7 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 	unsigned long voltsetup2;
 	unsigned long voltsetup2_old;
 	u32 val;
+	u32 tstart, tshut;
 
 	/* check if pmic is controlling off-mode voltages */
 	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
@@ -250,6 +270,9 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 		return;
 	}
 
+	omap_pm_get_oscillator(&tstart, &tshut);
+	omap3_set_clksetup(tstart, voltdm);
+
 	clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
 
 	/* voltsetup 2 in us */
@@ -336,10 +359,24 @@ static u32 omap4_calc_volt_ramp(struct voltagedomain *voltdm, u32 voltage_diff,
 		(cycles << OMAP4430_RAMP_UP_COUNT_SHIFT);
 }
 
+static u32 omap4_usec_to_val_scrm(u32 usec, int shift, u32 mask)
+{
+	u32 val;
+
+	val = omap_usec_to_32k(usec) << shift;
+
+	/* Check for overflow, if yes, force to max value */
+	if (val > mask)
+		val = mask;
+
+	return val;
+}
+
 static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 {
 	u32 val;
 	u32 ramp;
+	u32 tstart, tshut;
 
 	/* configure the setup times */
 	val = voltdm->read(voltdm->vfsm->voltsetup_reg);
@@ -361,6 +398,15 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 	val |= ramp << OMAP4430_RAMP_UP_COUNT_SHIFT;
 
 	voltdm->write(val, voltdm->vfsm->voltsetup_reg);
+
+	omap_pm_get_oscillator(&tstart, &tshut);
+
+	val = omap4_usec_to_val_scrm(tstart, OMAP4_SETUPTIME_SHIFT,
+		OMAP4_SETUPTIME_MASK);
+	val |= omap4_usec_to_val_scrm(tshut, OMAP4_DOWNTIME_SHIFT,
+		OMAP4_DOWNTIME_MASK);
+
+	__raw_writel(val, OMAP4_SCRM_CLKSETUPTIME);
 }
 
 /* OMAP4 specific voltage init functions */
-- 
1.7.4.1

