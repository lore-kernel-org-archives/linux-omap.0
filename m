From: Shweta Gulati <shweta.gulati@ti.com>
Subject: [PATCH] OMAP4: Add IVA OPP enteries with Updated Voltage Rail Values.
Date: Thu,  3 Mar 2011 14:57:09 +0530
Message-ID: <1299144429-20942-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41752 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945Ab1CCJ1P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 04:27:15 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p239RCdU001063
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 03:27:14 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shweta Gulati <shweta.gulati@ti.com>

This Patch adds OPP enteries for IVA  in OMAP4 OPP Table
and updates IVA voltage Rail values obtained from latest
OMAP4430 Data Manual Operating Condition Addendum.

Tested on OMAP4430 SDP Board.

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---
 arch/arm/mach-omap2/opp4xxx_data.c        |    8 +++++++-
 arch/arm/plat-omap/include/plat/voltage.h |    6 +++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 48d79e5..3e0fbdc 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -38,7 +38,13 @@ static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
 	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4430_VDD_CORE_OPP50_UV),
 	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
 	OPP_INITIALIZER("l3_main_1", true, 200000000, OMAP4430_VDD_CORE_OPP100_UV),
-	/* TODO: add IVA, DSP, aess, fdif, gpu */
+	/* IVA OPP1 - OPP50 */
+	OPP_INITIALIZER("iva", true, 133000000, OMAP4430_VDD_IVA_OPP50_UV),
+	/* IVA OPP2 - OPP100 */
+	OPP_INITIALIZER("iva", true, 266100000, OMAP4430_VDD_IVA_OPP100_UV),
+	/* IVA OPP3 - OPP-Turbo */
+	OPP_INITIALIZER("iva", false, 332000000, OMAP4430_VDD_IVA_OPPTURBO_UV),
+	/* TODO: add DSP, aess, fdif, gpu */
 };
 
 /**
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 4d9bab1..27555ce 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -51,9 +51,9 @@
 #define OMAP4430_VDD_MPU_OPPTURBO_UV		1313000
 #define OMAP4430_VDD_MPU_OPPNITRO_UV		1375000
 
-#define OMAP4430_VDD_IVA_OPP50_UV		930000
-#define OMAP4430_VDD_IVA_OPP100_UV		1100000
-#define OMAP4430_VDD_IVA_OPPTURBO_UV		1260000
+#define OMAP4430_VDD_IVA_OPP50_UV		1013000
+#define OMAP4430_VDD_IVA_OPP100_UV		1188000
+#define OMAP4430_VDD_IVA_OPPTURBO_UV		1300000
 
 #define OMAP4430_VDD_CORE_OPP50_UV		930000
 #define OMAP4430_VDD_CORE_OPP100_UV		1100000
-- 
1.7.0.4

