From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH v2] AM35xx: Runtime detection of the device
Date: Wed, 28 Oct 2009 19:08:52 +0530
Message-ID: <1256737132-17429-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43432 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753600AbZJ1Niw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 09:38:52 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9SDcsMn003123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 08:38:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Add support to detect AM3505/AM3517 devices at runtime.
Also updates the CPU names printed during boot.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/id.c              |   36 +++++++++++++++++++++++++++-----
 arch/arm/plat-omap/include/plat/cpu.h |   12 +++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 1c15112..f77dba1 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -242,6 +242,14 @@ void __init omap3_check_revision(void)
 			omap_revision = OMAP3630_REV_ES1_0;
 		}
 		break;
+	case 0xb868:
+		/* Handle OMAP35xx/AM35xx devices
+		 *
+		 * Set the device to be OMAP3505 here. Actual device
+		 * is identified later based on the features.
+		 */
+		omap_revision = OMAP3505_REV(rev);
+		break;
 	default:
 		/* Unknown default to latest silicon rev as default*/
 		omap_revision = OMAP3630_REV_ES1_0;
@@ -267,20 +275,36 @@ void __init omap3_cpuinfo(void)
 	 * and CPU class bits.
 	 */
 	if (cpu_is_omap3630())
-		strcpy(cpu_name, "3630");
+		strcpy(cpu_name, "OMAP3630");
+	else if (cpu_is_omap3505()) {
+		/*
+		 * AM35xx devices
+		 */
+		if (omap3_has_sgx()) {
+			omap_revision = OMAP3517_REV(rev);
+			strcpy(cpu_name, "AM3517");
+		}
+		else {
+			/* Already set in omap3_check_revision() */
+			strcpy(cpu_name, "AM3505");
+		}
+	}
+	/*
+	 * OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices
+	 */
 	else if (omap3_has_iva() && omap3_has_sgx())
-		strcpy(cpu_name, "3430/3530");
+		strcpy(cpu_name, "OMAP3430/3530");
 	else if (omap3_has_sgx()) {
 		omap_revision = OMAP3525_REV(rev);
-		strcpy(cpu_name, "3525");
+		strcpy(cpu_name, "OMAP3525");
 	}
 	else if (omap3_has_iva()) {
 		omap_revision = OMAP3515_REV(rev);
-		strcpy(cpu_name, "3515");
+		strcpy(cpu_name, "OMAP3515");
 	}
 	else {
 		omap_revision = OMAP3503_REV(rev);
-		strcpy(cpu_name, "3503");
+		strcpy(cpu_name, "OMAP3503");
 	}
 
 	switch (rev) {
@@ -307,7 +331,7 @@ void __init omap3_cpuinfo(void)
 	/*
 	 * Print verbose information
 	 */
-	pr_info("OMAP%s ES%s\n", cpu_name, cpu_rev);
+	pr_info("%s ES%s\n", cpu_name, cpu_rev);
 
 	OMAP3_SHOW_FEATURE(l2cache);
 	OMAP3_SHOW_FEATURE(iva);
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index f4f7a2f..13f74e6 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -284,6 +284,8 @@ IS_OMAP_SUBCLASS(363x, 0x363)
  * cpu_is_omap2423():	True for OMAP2423
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
+ * cpu_is_omap3505():	True for OMAP3505
+ * cpu_is_omap3517():	True for OMAP3517
  */
 #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
 
@@ -307,6 +309,8 @@ IS_OMAP_TYPE(2422, 0x2422)
 IS_OMAP_TYPE(2423, 0x2423)
 IS_OMAP_TYPE(2430, 0x2430)
 IS_OMAP_TYPE(3430, 0x3430)
+IS_OMAP_TYPE(3505, 0x3505)
+IS_OMAP_TYPE(3517, 0x3517)
 
 #define cpu_is_omap310()		0
 #define cpu_is_omap730()		0
@@ -325,6 +329,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define cpu_is_omap3515()		0
 #define cpu_is_omap3525()		0
 #define cpu_is_omap3530()		0
+#define cpu_is_omap3505()		0
+#define cpu_is_omap3517()		0
 #define cpu_is_omap3430()		0
 #define cpu_is_omap3630()		0
 
@@ -380,6 +386,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 # undef cpu_is_omap3515
 # undef cpu_is_omap3525
 # undef cpu_is_omap3530
+# undef cpu_is_omap3505
+# undef cpu_is_omap3517
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
 						(!omap3_has_iva()) &&	\
@@ -391,6 +399,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 						(omap3_has_sgx()) &&	\
 						(!omap3_has_iva()))
 # define cpu_is_omap3530()		(cpu_is_omap3430())
+# define cpu_is_omap3505()		is_omap3505()
+# define cpu_is_omap3517()		is_omap3517()
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
 #endif
@@ -430,6 +440,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3515_REV(v)		(OMAP35XX_CLASS | (0x3515 << 16) | (v << 12))
 #define OMAP3525_REV(v)		(OMAP35XX_CLASS | (0x3525 << 16) | (v << 12))
 #define OMAP3530_REV(v)		(OMAP35XX_CLASS | (0x3530 << 16) | (v << 12))
+#define OMAP3505_REV(v)		(OMAP35XX_CLASS | (0x3505 << 16) | (v << 12))
+#define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16) | (v << 12))
 
 #define OMAP443X_CLASS		0x44300034
 
-- 
1.6.2.2

