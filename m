From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 08/16] OMAP3: PM: Disabling Smartreflex across both frequency and voltage scaling during DVFS.
Date: Wed, 24 Feb 2010 14:59:09 +0530
Message-ID: <1267003757-22456-9-git-send-email-thara@ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
 <1267003757-22456-2-git-send-email-thara@ti.com>
 <1267003757-22456-3-git-send-email-thara@ti.com>
 <1267003757-22456-4-git-send-email-thara@ti.com>
 <1267003757-22456-5-git-send-email-thara@ti.com>
 <1267003757-22456-6-git-send-email-thara@ti.com>
 <1267003757-22456-7-git-send-email-thara@ti.com>
 <1267003757-22456-8-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51621 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756144Ab0BXJ3c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Feb 2010 04:29:32 -0500
In-Reply-To: <1267003757-22456-8-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch disables smartreflex across both frequency and voltage
scaling instead of just across voltage scaling as before.
This is the hardware recommended practice.
This bug was first reported and solved on Nokia Rover
code base by Nishanth Menon and Paul Walmsley.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |    3 +++
 arch/arm/mach-omap2/smartreflex.c  |   10 ----------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index db5f40e..7c0bb0e 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -348,6 +348,8 @@ static int program_opp(int res, enum opp_t opp_type, int target_level,
 	else
 		raise = 0;
 
+	omap_smartreflex_disable(res);
+
 	for (i = 0; i < 2; i++) {
 		if (i == raise)
 			ret = program_opp_freq(res, target_level,
@@ -379,6 +381,7 @@ static int program_opp(int res, enum opp_t opp_type, int target_level,
 #endif
 	}
 
+	omap_smartreflex_enable(res);
 	return ret;
 }
 
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index ba9f899..ac935e2 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -696,7 +696,6 @@ void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
 int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 					u8 target_vsel, u8 current_vsel)
 {
-	int sr_status = 0;
 	u32 vdd, target_opp_no, current_opp_no;
 	u32 vc_bypass_value;
 	u32 reg_addr = 0;
@@ -709,7 +708,6 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 	current_opp_no = get_opp_no(current_opp);
 
 	if (vdd == VDD1_OPP) {
-		sr_status = sr_stop_vddautocomap(SR1);
 		t2_smps_steps = abs(target_vsel - current_vsel);
 
 		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
@@ -719,7 +717,6 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 		reg_addr = R_VDD1_SR_CONTROL;
 
 	} else if (vdd == VDD2_OPP) {
-		sr_status = sr_stop_vddautocomap(SR2);
 		t2_smps_steps =  abs(target_vsel - current_vsel);
 
 		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
@@ -762,13 +759,6 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 	t2_smps_delay = ((t2_smps_steps * 125) / 40) + 2;
 	udelay(t2_smps_delay);
 
-	if (sr_status) {
-		if (vdd == VDD1_OPP)
-			sr_start_vddautocomap(SR1);
-		else if (vdd == VDD2_OPP)
-			sr_start_vddautocomap(SR2);
-	}
-
 	return 0;
 }
 
-- 
1.7.0.rc1.33.g07cf0f

