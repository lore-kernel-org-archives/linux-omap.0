From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 13/13] OMAP3: Add voltage dependency table for VDD1.
Date: Wed, 18 Aug 2010 16:50:12 +0530
Message-ID: <1282130412-12027-14-git-send-email-thara@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43018 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab0HRLU1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 07:20:27 -0400
In-Reply-To: <1282130412-12027-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

In OMAP3, for perfomrance reasons when VDD1 is at voltage above
1.075V, VDD2 should be at 1.15V for perfomrance reasons. This
patch introduce this cross VDD dependency for OMAP3 VDD1.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/voltage.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 2fd644a..3c990d0 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -348,6 +348,23 @@ static struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
 	{.volt_nominal = 1100000, .sr_errminlimit = 0xF9, .vp_errgain = 0x16},
 };
 
+/* OMAP 3430 MPU Core VDD dependency table */
+static struct omap_vdd_dep_volt omap34xx_vdd1_vdd2_data[] = {
+	{.main_vdd_volt = 975000, .dep_vdd_volt = 1050000},
+	{.main_vdd_volt = 1075000, .dep_vdd_volt = 1050000},
+	{.main_vdd_volt = 1200000, .dep_vdd_volt = 1150000},
+	{.main_vdd_volt = 1270000, .dep_vdd_volt = 1150000},
+	{.main_vdd_volt = 1350000, .dep_vdd_volt = 1150000},
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
 /* By default VPFORCEUPDATE is the chosen method of voltage scaling */
 static bool voltscale_vpforceupdate = true;
 
@@ -523,6 +540,8 @@ static void __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 			vdd->volt_data = omap34xx_vdd1_volt_data;
 			vdd->volt_data_count =
 					ARRAY_SIZE(omap34xx_vdd1_volt_data);
+			vdd->dep_vdd_info = omap34xx_vdd1_dep_info;
+			vdd->nr_dep_vdd = ARRAY_SIZE(omap34xx_vdd1_dep_info);
 		}
 		vdd->volt_clk = clk_get(NULL, "dpll1_ck");
 		vdd->opp_dev = omap2_get_mpuss_device();
-- 
1.7.1.GIT

