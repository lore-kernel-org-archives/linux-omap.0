From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 10/13] OMAP3: Add voltage dependency table for VDD1.
Date: Fri, 21 Jan 2011 19:31:02 +0530
Message-ID: <1295618465-15234-11-git-send-email-vishwanath.bs@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52511 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab1AUN5r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 08:57:47 -0500
In-Reply-To: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: patches@linaro.org, Thara Gopinath <thara@ti.com>

From: Thara Gopinath <thara@ti.com>

In OMAP3, for perfomrance reasons when VDD1 is at voltage above
1.075V, VDD2 should be at 1.15V for perfomrance reasons. This
patch introduce this cross VDD dependency for OMAP3 VDD1.

Signed-off-by: Thara Gopinath <thara@ti.com>

This patch has checkpatch warnings for line over 80 chars. It is not fixed for
code readability.
---
 arch/arm/mach-omap2/voltage.c |   42 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 92fe20d..8881c0c 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -191,6 +191,39 @@ static struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+/* OMAP 3430 MPU Core VDD dependency table */
+static struct omap_vdd_dep_volt omap34xx_vdd1_vdd2_data[] = {
+	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP1_UV, .dep_vdd_volt = OMAP4430_VDD_CORE_OPP50_UV},
+	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP2_UV, .dep_vdd_volt = OMAP4430_VDD_CORE_OPP50_UV},
+	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP3_UV, .dep_vdd_volt = OMAP4430_VDD_CORE_OPP100_UV},
+	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP4_UV, .dep_vdd_volt = OMAP4430_VDD_CORE_OPP100_UV},
+	{.main_vdd_volt = OMAP3430_VDD_MPU_OPP5_UV, .dep_vdd_volt = OMAP4430_VDD_CORE_OPP100_UV},
+	{.main_vdd_volt = 0, .dep_vdd_volt = 0},
+};
+
+static struct omap_vdd_dep_info omap34xx_vdd1_dep_info[] = {
+	{
+		.name	= "core",
+		.dep_table = omap34xx_vdd1_vdd2_data,
+	},
+};
+
+/* OMAP 3630 MPU Core VDD dependency table */
+static struct omap_vdd_dep_volt omap36xx_vdd1_vdd2_data[] = {
+	{.main_vdd_volt = OMAP3630_VDD_MPU_OPP50_UV, .dep_vdd_volt = OMAP3630_VDD_CORE_OPP50_UV},
+	{.main_vdd_volt = OMAP3630_VDD_MPU_OPP100_UV, .dep_vdd_volt = OMAP3630_VDD_CORE_OPP100_UV},
+	{.main_vdd_volt = OMAP3630_VDD_MPU_OPP120_UV, .dep_vdd_volt = OMAP3630_VDD_CORE_OPP100_UV},
+	{.main_vdd_volt = OMAP3630_VDD_MPU_OPP1G_UV, .dep_vdd_volt = OMAP3630_VDD_CORE_OPP100_UV},
+	{.main_vdd_volt = 0, .dep_vdd_volt = 0},
+};
+
+static struct omap_vdd_dep_info omap36xx_vdd1_dep_info[] = {
+	{
+		.name	= "core",
+		.dep_table = omap36xx_vdd1_vdd2_data,
+	},
+};
+
 static struct dentry *voltage_dir;
 
 /* Init function pointers */
@@ -696,10 +729,15 @@ static int __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 	}
 
 	if (!strcmp(vdd->voltdm.name, "mpu")) {
-		if (cpu_is_omap3630())
+		if (cpu_is_omap3630()) {
 			vdd->volt_data = omap36xx_vddmpu_volt_data;
-		else
+			vdd->dep_vdd_info = omap36xx_vdd1_dep_info;
+			vdd->nr_dep_vdd = ARRAY_SIZE(omap36xx_vdd1_dep_info);
+		} else {
 			vdd->volt_data = omap34xx_vddmpu_volt_data;
+			vdd->dep_vdd_info = omap34xx_vdd1_dep_info;
+			vdd->nr_dep_vdd = ARRAY_SIZE(omap34xx_vdd1_dep_info);
+		}
 
 		vdd->vp_reg.tranxdone_status = OMAP3430_VP1_TRANXDONE_ST_MASK;
 		vdd->vc_reg.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET;
-- 
1.7.0.4

