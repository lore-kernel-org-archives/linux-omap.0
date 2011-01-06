From: shweta.gulati@ti.com
Subject: [PATCH] OMAP4 PM: To correct voltages in MPU OPP Table
Date: Thu,  6 Jan 2011 11:57:02 +0530
Message-ID: <1294295222-20035-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50114 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943Ab1AFG1I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jan 2011 01:27:08 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p066R4qt000978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 6 Jan 2011 00:27:07 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shweta Gulati <shweta.gulati@ti.com>, Thara Gopinath <thara@ti.com>

From: Shweta Gulati <shweta.gulati@ti.com>

There is a mismatch in voltages specified in OPP table of MPU
and voltage specified in voltage table 'omap44xx_vdd_mpu_volt_data'
This Patch corrects MPU OPP Table as
well as enable OPP-Turbo and OPP-SB  for MPU by default.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---
The patch is generated on top of Kevin's PM branch. It's needed for SR
functionality on the current pm branch. Have tested SR with this patch
with different OPP configurations from boot loader.

 arch/arm/mach-omap2/opp4xxx_data.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index a11fa56..4f35361 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -25,13 +25,13 @@
 
 static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
 	/* MPU OPP1 - OPP50 */
-	OPP_INITIALIZER("mpu", true, 300000000, 1100000),
+	OPP_INITIALIZER("mpu", true, 300000000, 930000),
 	/* MPU OPP2 - OPP100 */
-	OPP_INITIALIZER("mpu", true, 600000000, 1200000),
+	OPP_INITIALIZER("mpu", true, 600000000, 1100000),
 	/* MPU OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("mpu", false, 800000000, 1260000),
+	OPP_INITIALIZER("mpu", true, 800000000, 1260000),
 	/* MPU OPP4 - OPP-SB */
-	OPP_INITIALIZER("mpu", false, 1008000000, 1350000),
+	OPP_INITIALIZER("mpu", true, 1008000000, 1350000),
 	/* L3 OPP1 - OPP50 */
 	OPP_INITIALIZER("l3_main_1", true, 100000000, 930000),
 	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
-- 
1.7.0.4

