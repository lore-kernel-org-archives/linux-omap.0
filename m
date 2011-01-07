From: Sanjeev Premi <premi@ti.com>
Subject: [RFC] omap3: Enable SmartReflex calculations for 720MHz
Date: Fri,  7 Jan 2011 22:56:57 +0530
Message-ID: <1294421217-18730-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56121 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640Ab1AGR1L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 12:27:11 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p07HR73V004213
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 7 Jan 2011 11:27:09 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

The eFuse registers do not contain the nValue to be used
with 720MHz (OPP6). This patch implements procedure to
calculate the nValue(OPP6) based on the nValue(OPP5).

  [1] SPRUFF1D-June 2009 section 1.5.2.1.1

This is first attempt to fit this mechanism into new
smartreflex framework. Do note a FIXME which is added
to illustrate the calculations; and express need for
a mechanism to get nValues for each OPP.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/sr_device.c           |   54 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.c             |    1 +
 arch/arm/plat-omap/include/plat/voltage.h |    1 +
 3 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 786d685..43640a3 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -38,6 +38,51 @@ static struct omap_device_pm_latency omap_sr_latency[] = {
 	},
 };
 
+static void swcalc_opp6_RG(u32 rFuse, u32 gainFuse, u32 deltaNT,
+                               u32* rAdj, u32* gainAdj)
+{
+       u32 nAdj;
+       u32 g, r;
+
+       nAdj = ((1 << (gainFuse + 8))/rFuse) + deltaNT;
+
+       for (g = 0; g < GAIN_MAXLIMIT; g++) {
+               r = (1 << (g + 8)) / nAdj;
+               if (r < 256) {
+                       *rAdj = r;
+                       *gainAdj = g;
+               }
+       }
+}
+
+#define SWCALC_OPP6_DELTA_NNT	379
+#define SWCALC_OPP6_DELTA_PNT	227
+#define GAIN_MAXLIMIT		16
+
+static u32 swcalc_opp6_nvalue(u32 opp5_nvalue)
+{
+       u32 opp6_nvalue;
+       u32 opp5_senPgain, opp5_senNgain, opp5_senPRN, opp5_senNRN;
+       u32 opp6_senPgain, opp6_senNgain, opp6_senPRN, opp6_senNRN;
+
+       opp5_senPgain = (opp5_nvalue & 0x00f00000) >> 0x14;
+       opp5_senNgain = (opp5_nvalue & 0x000f0000) >> 0x10;
+
+       opp5_senPRN = (opp5_nvalue & 0x0000ff00) >> 0x8;
+       opp5_senNRN = (opp5_nvalue & 0x000000ff);
+
+       swcalc_opp6_RG(opp5_senNRN, opp5_senNgain, SWCALC_OPP6_DELTA_NNT,
+                               &opp6_senNRN, &opp6_senNgain);
+
+       swcalc_opp6_RG(opp5_senPRN, opp5_senPgain, SWCALC_OPP6_DELTA_PNT,
+                               &opp6_senPRN, &opp6_senPgain);
+
+       opp6_nvalue = (opp6_senPgain << 0x14) | (opp6_senNgain < 0x10) |
+                       (opp6_senPRN << 0x8) | opp6_senNRN;
+
+       return opp6_nvalue;
+}
+
 /* Read EFUSE values from control registers for OMAP3430 */
 static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 				struct omap_sr_data *sr_data)
@@ -72,6 +117,15 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 		nvalue_table[i].nvalue = v;
 	}
 
+	/*
+	 * FIXME: This is a temporary hack. Need to identify better
+	 *        mechanism to find nvalues corresponding to an OPP.
+	 */
+	if (cpu_is_omap34xx() && omap3_has_720mhz()) {
+		nvalue_table[count-1].nvalue = swcalc_opp6_nvalue(
+					nvalue_table[count-2].nvalue);
+	}
+
 	sr_data->nvalue_table = nvalue_table;
 	sr_data->nvalue_count = count;
 }
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index ed6079c..f23b6d7 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -258,6 +258,7 @@ static struct omap_volt_data omap34xx_vddmpu_volt_data[] = {
 	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP3_UV, OMAP343X_CONTROL_FUSE_OPP3_VDD1, 0xf9, 0x18),
 	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP4_UV, OMAP343X_CONTROL_FUSE_OPP4_VDD1, 0xf9, 0x18),
 	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP5_UV, OMAP343X_CONTROL_FUSE_OPP5_VDD1, 0xf9, 0x18),
+	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP6_UV, OMAP343X_CONTROL_FUSE_OPP5_VDD1, 0xf9, 0x18),
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 0ff1233..f3f87a6 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -31,6 +31,7 @@
 #define OMAP3430_VDD_MPU_OPP3_UV		1200000
 #define OMAP3430_VDD_MPU_OPP4_UV		1270000
 #define OMAP3430_VDD_MPU_OPP5_UV		1350000
+#define OMAP3430_VDD_MPU_OPP6_UV                1350000
 
 #define OMAP3430_VDD_CORE_OPP1_UV		975000
 #define OMAP3430_VDD_CORE_OPP2_UV		1050000
-- 
1.7.2.2

