From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 10/12] OMAP: voltage: update to new device-based OPP API
Date: Wed, 16 Jun 2010 17:17:11 -0700
Message-ID: <1276733833-18510-11-git-send-email-khilman@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60806 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759607Ab0FQARq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:46 -0400
Received: by pva4 with SMTP id 4so937573pva.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:38 -0700 (PDT)
In-Reply-To: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

The OPP API has changed to a device-based API.  This patch updates
the usage of that API in the voltage layer.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/voltage.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 6e84ea1..d289691 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -102,7 +102,7 @@ struct vp_reg_val {
  * @vp_reg		: the register values, shifts, masks for various
  *			  vp registers
  * @volt_clk		: the clock associated with the vdd.
- * @opp_type		: the type of OPP associated with this vdd.
+ * @opp_dev		: the 'struct device' associated with this vdd.
  * @volt_data_count	: Number of distinct voltages supported by this vdd.
  * @nominal_volt	: Nominal voltaged for this vdd.
  * cmdval_reg		: Voltage controller cmdval register.
@@ -113,7 +113,7 @@ struct omap_vdd_info{
 	struct vp_reg_offs vp_offs;
 	struct vp_reg_val vp_reg;
 	struct clk *volt_clk;
-	int opp_type;
+	struct device *opp_dev;
 	int volt_data_count;
 	int id;
 	unsigned long nominal_volt;
@@ -385,7 +385,7 @@ static void __init omap3_vdd_data_configure(int vdd)
 		vdd_info[vdd].volt_clk = clk_get(NULL, "dpll1_ck");
 		WARN(IS_ERR(vdd_info[vdd].volt_clk),
 				"unable to get clock for VDD%d\n", vdd + 1);
-		vdd_info[vdd].opp_type = OPP_MPU;
+		vdd_info[vdd].opp_dev = omap_get_mpu_device();
 		vdd_info[vdd].vp_reg.tranxdone_status =
 				OMAP3430_VP1_TRANXDONE_ST_MASK;
 		vdd_info[vdd].cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET;
@@ -411,7 +411,7 @@ static void __init omap3_vdd_data_configure(int vdd)
 		vdd_info[vdd].volt_clk = clk_get(NULL, "l3_ick");
 		WARN(IS_ERR(vdd_info[vdd].volt_clk),
 				"unable to get clock for VDD%d\n", vdd + 1);
-		vdd_info[vdd].opp_type = OPP_L3;
+		vdd_info[vdd].opp_dev = omap_get_l3_device();
 		vdd_info[vdd].vp_reg.tranxdone_status =
 					OMAP3430_VP2_TRANXDONE_ST_MASK;
 		vdd_info[vdd].cmdval_reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET;
@@ -843,7 +843,7 @@ unsigned long get_curr_voltage(int vdd)
 	}
 
 	freq = vdd_info[vdd].volt_clk->rate;
-	opp = opp_find_freq_ceil(vdd_info[vdd].opp_type, &freq);
+	opp = opp_find_freq_ceil(vdd_info[vdd].opp_dev, &freq);
 	if (IS_ERR(opp)) {
 		pr_warning("%s: Unable to find OPP for VDD%d freq%ld\n",
 			__func__, vdd + 1, freq);
-- 
1.7.0.2

