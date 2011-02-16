From: Shweta Gulati <shweta.gulati@ti.com>
Subject: [PATCH 2/3] OMAP2+: Replace Voltage values with Macros.
Date: Wed, 16 Feb 2011 11:47:53 +0530
Message-ID: <1297837073-8874-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60971 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab1BPGR6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 01:17:58 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1G6HtQv004111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 00:17:57 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Shweta Gulati <shweta.gulati@ti.com>

From: Vishwanath BS <vishwanath.bs@ti.com>

Currently voltage values on opp tables are hardcoded. As these voltage values
are anyway defined in voltage.h as macros, opp table can reuse these values.
This will avoid opp table and voltage layer having conflicting values.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---
 arch/arm/mach-omap2/opp3xxx_data.c |   47 ++++++++++++++++++-----------------
 arch/arm/mach-omap2/opp4xxx_data.c |   13 +++++----
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
index fd3a1af..e3ea9ba 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -19,21 +19,22 @@
 #include <linux/module.h>
 
 #include <plat/cpu.h>
+#include <plat/voltage.h>
 
 #include "omap_opp_data.h"
 #include "pm.h"
 
 static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
 	/* MPU OPP1 */
-	OPP_INITIALIZER("mpu", true, 125000000, 975000),
+	OPP_INITIALIZER("mpu", true, 125000000, OMAP3430_VDD_MPU_OPP1_UV),
 	/* MPU OPP2 */
-	OPP_INITIALIZER("mpu", true, 250000000, 1075000),
+	OPP_INITIALIZER("mpu", true, 250000000, OMAP3430_VDD_MPU_OPP2_UV),
 	/* MPU OPP3 */
-	OPP_INITIALIZER("mpu", true, 500000000, 1200000),
+	OPP_INITIALIZER("mpu", true, 500000000, OMAP3430_VDD_MPU_OPP3_UV),
 	/* MPU OPP4 */
-	OPP_INITIALIZER("mpu", true, 550000000, 1270000),
+	OPP_INITIALIZER("mpu", true, 550000000, OMAP3430_VDD_MPU_OPP4_UV),
 	/* MPU OPP5 */
-	OPP_INITIALIZER("mpu", true, 600000000, 1350000),
+	OPP_INITIALIZER("mpu", true, 600000000, OMAP3430_VDD_MPU_OPP5_UV),
 
 	/*
 	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
@@ -43,47 +44,47 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
 	 * impact that frequency will do to the MPU and the whole system in
 	 * general.
 	 */
-	OPP_INITIALIZER("l3_main", false, 41500000, 975000),
+	OPP_INITIALIZER("l3_main", false, 41500000, OMAP3430_VDD_CORE_OPP1_UV),
 	/* L3 OPP2 */
-	OPP_INITIALIZER("l3_main", true, 83000000, 1050000),
+	OPP_INITIALIZER("l3_main", true, 83000000, OMAP3430_VDD_CORE_OPP2_UV),
 	/* L3 OPP3 */
-	OPP_INITIALIZER("l3_main", true, 166000000, 1150000),
+	OPP_INITIALIZER("l3_main", true, 166000000, OMAP3430_VDD_CORE_OPP3_UV),
 
 	/* DSP OPP1 */
-	OPP_INITIALIZER("iva", true, 90000000, 975000),
+	OPP_INITIALIZER("iva", true, 90000000, OMAP3430_VDD_MPU_OPP1_UV),
 	/* DSP OPP2 */
-	OPP_INITIALIZER("iva", true, 180000000, 1075000),
+	OPP_INITIALIZER("iva", true, 180000000, OMAP3430_VDD_MPU_OPP2_UV),
 	/* DSP OPP3 */
-	OPP_INITIALIZER("iva", true, 360000000, 1200000),
+	OPP_INITIALIZER("iva", true, 360000000, OMAP3430_VDD_MPU_OPP3_UV),
 	/* DSP OPP4 */
-	OPP_INITIALIZER("iva", true, 400000000, 1270000),
+	OPP_INITIALIZER("iva", true, 400000000, OMAP3430_VDD_MPU_OPP4_UV),
 	/* DSP OPP5 */
-	OPP_INITIALIZER("iva", true, 430000000, 1350000),
+	OPP_INITIALIZER("iva", true, 430000000, OMAP3430_VDD_MPU_OPP5_UV),
 };
 
 static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
 	/* MPU OPP1 - OPP50 */
-	OPP_INITIALIZER("mpu", true,  300000000, 1012500),
+	OPP_INITIALIZER("mpu", true,  300000000, OMAP3630_VDD_MPU_OPP50_UV),
 	/* MPU OPP2 - OPP100 */
-	OPP_INITIALIZER("mpu", true,  600000000, 1200000),
+	OPP_INITIALIZER("mpu", true,  600000000, OMAP3630_VDD_MPU_OPP100_UV),
 	/* MPU OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("mpu", false, 800000000, 1325000),
+	OPP_INITIALIZER("mpu", false, 800000000, OMAP3630_VDD_MPU_OPP120_UV),
 	/* MPU OPP4 - OPP-SB */
-	OPP_INITIALIZER("mpu", false, 1000000000, 1375000),
+	OPP_INITIALIZER("mpu", false, 1000000000, OMAP3630_VDD_MPU_OPP1G_UV),
 
 	/* L3 OPP1 - OPP50 */
-	OPP_INITIALIZER("l3_main", true, 100000000, 1000000),
+	OPP_INITIALIZER("l3_main", true, 100000000, OMAP3630_VDD_CORE_OPP50_UV),
 	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
-	OPP_INITIALIZER("l3_main", true, 200000000, 1200000),
+	OPP_INITIALIZER("l3_main", true, 200000000, OMAP3630_VDD_CORE_OPP100_UV),
 
 	/* DSP OPP1 - OPP50 */
-	OPP_INITIALIZER("iva", true,  260000000, 1012500),
+	OPP_INITIALIZER("iva", true,  260000000, OMAP3630_VDD_MPU_OPP50_UV),
 	/* DSP OPP2 - OPP100 */
-	OPP_INITIALIZER("iva", true,  520000000, 1200000),
+	OPP_INITIALIZER("iva", true,  520000000, OMAP3630_VDD_MPU_OPP100_UV),
 	/* DSP OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("iva", false, 660000000, 1325000),
+	OPP_INITIALIZER("iva", false, 660000000, OMAP3630_VDD_MPU_OPP120_UV),
 	/* DSP OPP4 - OPP-SB */
-	OPP_INITIALIZER("iva", false, 800000000, 1375000),
+	OPP_INITIALIZER("iva", false, 800000000, OMAP3630_VDD_MPU_OPP1G_UV),
 };
 
 /**
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index f0e9939..705fe9a 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -20,23 +20,24 @@
 #include <linux/module.h>
 
 #include <plat/cpu.h>
+#include <plat/voltage.h>
 
 #include "omap_opp_data.h"
 #include "pm.h"
 
 static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
 	/* MPU OPP1 - OPP50 */
-	OPP_INITIALIZER("mpu", true, 300000000, 1100000),
+	OPP_INITIALIZER("mpu", true, 300000000, OMAP4430_VDD_MPU_OPP50_UV),
 	/* MPU OPP2 - OPP100 */
-	OPP_INITIALIZER("mpu", true, 600000000, 1200000),
+	OPP_INITIALIZER("mpu", true, 600000000, OMAP4430_VDD_MPU_OPP100_UV),
 	/* MPU OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("mpu", false, 800000000, 1260000),
+	OPP_INITIALIZER("mpu", false, 800000000, OMAP4430_VDD_MPU_OPPTURBO_UV),
 	/* MPU OPP4 - OPP-SB */
-	OPP_INITIALIZER("mpu", false, 1008000000, 1350000),
+	OPP_INITIALIZER("mpu", false, 1008000000, OMAP4430_VDD_MPU_OPPNITRO_UV),
 	/* L3 OPP1 - OPP50 */
-	OPP_INITIALIZER("l3_main_1", true, 100000000, 930000),
+	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4430_VDD_CORE_OPP50_UV),
 	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
-	OPP_INITIALIZER("l3_main_1", true, 200000000, 1100000),
+	OPP_INITIALIZER("l3_main_1", true, 200000000, OMAP4430_VDD_CORE_OPP100_UV),
 	/* TODO: add IVA, DSP, aess, fdif, gpu */
 };
 
-- 
1.7.0.4

