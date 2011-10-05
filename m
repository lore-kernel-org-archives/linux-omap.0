From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 10/11] omap3+: use lp params for calculating clock setup times
Date: Wed, 5 Oct 2011 20:17:10 +0300
Message-ID: <1317835031-8201-11-git-send-email-t-kristo@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35069 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935151Ab1JERRk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:17:40 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p95HHexS017471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:40 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p95HHeY4003324
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:40 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p95HHdM9001828
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:39 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |   47 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index c50e598..ee0edf3 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -4,6 +4,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <asm/div64.h>
+
 #include <plat/cpu.h>
 #include <plat/prcm.h>
 
@@ -13,6 +15,7 @@
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 #include "scrm44xx.h"
+#include "pm.h"
 
 /**
  * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
@@ -198,12 +201,28 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
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
+static void omap3_set_clksetup(u32 usec)
+{
+	omap3_prm_vcvp_write(omap_usec_to_32k(usec), OMAP3_PRM_CLKSETUP_OFFSET);
+}
+
 static void omap3_set_ret_timings(struct voltagedomain *voltdm)
 {
 	unsigned long voltsetup1;
 	struct clk *sys_ck;
 	u32 sys_clk_rate;
 
+	/* In retention oscillator is not shut down */
+	omap3_set_clksetup(1);
+
 	sys_ck = clk_get(NULL, "sys_ck");
 	if (IS_ERR(sys_ck)) {
 		pr_warning("%s: unable to get sys_ck to calculate "
@@ -229,6 +248,10 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 {
 	unsigned long clksetup;
 	unsigned long voltsetup2;
+	u32 tstart, tshut;
+
+	omap_pm_get_osc_lp_time(&tstart, &tshut);
+	omap3_set_clksetup(tstart);
 
 	clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
 
@@ -236,7 +259,7 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 	voltsetup2 = voltdm->vc_param->on / voltdm->pmic->slew_rate;
 
 	/* convert to 32k clk cycles */
-	voltsetup2 = voltsetup2 * 32768 / 1000000 + 1;
+	voltsetup2 = DIV_ROUND_UP(voltsetup2 * 32768, 1000000);
 
 	voltdm->write(voltsetup2, OMAP3_PRM_VOLTSETUP2_OFFSET);
 
@@ -300,12 +323,25 @@ static u32 omap4_calc_volt_ramp(struct voltagedomain *voltdm, u32 voltage_diff,
 		(cycles << OMAP4430_RAMP_UP_COUNT_SHIFT);
 }
 
+static u32 omap4_usec_to_val_scrm(u32 usec, int shift, u32 mask)
+{
+	u32 val;
+
+	val = omap_usec_to_32k(usec) << shift;
+
+	if (val > mask)
+		val = mask;
+
+	return val;
+}
+
 static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 {
 	struct clk *sys_ck;
 	u32 sys_clk_rate;
 	u32 val;
 	u32 ramp;
+	u32 tstart, tshut;
 
 	sys_ck = clk_get(NULL, "sys_clkin_ck");
 	if (IS_ERR(sys_ck)) {
@@ -336,6 +372,15 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 	val |= ramp << OMAP4430_RAMP_UP_COUNT_SHIFT;
 
 	voltdm->write(val, voltdm->vfsm->voltsetup_reg);
+
+	omap_pm_get_osc_lp_time(&tstart, &tshut);
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


Texas Instruments Oy, Porkkalankatu 22, 00180 Helsinki, Finland. Business ID: 0115040-6. Domicile: Helsinki
 

