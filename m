From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2 1/1] omap2/3: Update revision identification
Date: Fri, 24 Sep 2010 19:34:33 +0530
Message-ID: <1285337073-11759-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47752 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932218Ab0IXOEj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 10:04:39 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8OE4axH008241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 09:04:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

The existing definitions for cpu revision used
upper nibble in the bits[15:08]. With OMAP3630,
definitions use lower nibble.

This patch unifies the definitions to start
at lower nibble.

  [1] http://marc.info/?t=128161739100005&r=1&w=2

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/id.c              |   72 ++++++++++++++++++++++-----------
 arch/arm/plat-omap/include/plat/cpu.h |   36 ++++++++--------
 2 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 9a879f9..196f3ee 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -361,30 +361,54 @@ static void __init omap3_cpuinfo(void)
 		strcpy(cpu_name, "OMAP3503");
 	}
 
-	switch (rev) {
-	case OMAP_REVBITS_00:
-		strcpy(cpu_rev, "1.0");
-		break;
-	case OMAP_REVBITS_01:
-		strcpy(cpu_rev, "1.1");
-		break;
-	case OMAP_REVBITS_02:
-		strcpy(cpu_rev, "1.2");
-		break;
-	case OMAP_REVBITS_10:
-		strcpy(cpu_rev, "2.0");
-		break;
-	case OMAP_REVBITS_20:
-		strcpy(cpu_rev, "2.1");
-		break;
-	case OMAP_REVBITS_30:
-		strcpy(cpu_rev, "3.0");
-		break;
-	case OMAP_REVBITS_40:
-	/* FALLTHROUGH */
-	default:
-		/* Use the latest known revision as default */
-		strcpy(cpu_rev, "3.1");
+	if (cpu_is_omap3630()) {
+		switch (rev) {
+		case OMAP_REVBITS_00:
+			strcpy(cpu_rev, "1.0");
+			break;
+		case OMAP_REVBITS_01:
+			strcpy(cpu_rev, "1.1");
+			break;
+		case OMAP_REVBITS_02:
+			/* FALLTHROUGH */
+		default:
+			/* Use the latest known revision as default */
+			strcpy(cpu_rev, "1.2");
+		}
+	} else if (cpu_is_omap3505() || cpu_is_omap3517()) {
+		switch (rev) {
+		case OMAP_REVBITS_00:
+			strcpy(cpu_rev, "1.0");
+			break;
+		case OMAP_REVBITS_01:
+			/* FALLTHROUGH */
+		default:
+			/* Use the latest known revision as default */
+			strcpy(cpu_rev, "1.1");
+		}
+	} else {
+		switch (rev) {
+		case OMAP_REVBITS_00:
+			strcpy(cpu_rev, "1.0");
+			break;
+		case OMAP_REVBITS_01:
+			strcpy(cpu_rev, "2.0");
+			break;
+		case OMAP_REVBITS_02:
+			strcpy(cpu_rev, "2.1");
+			break;
+		case OMAP_REVBITS_03:
+			strcpy(cpu_rev, "3.0");
+			break;
+		case OMAP_REVBITS_04:
+			strcpy(cpu_rev, "3.1");
+			break;
+		case OMAP_REVBITS_05:
+			/* FALLTHROUGH */
+		default:
+			/* Use the latest known revision as default */
+			strcpy(cpu_rev, "3.1.2");
+		}
 	}
 
 	/* Print verbose information */
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 2e2ae53..6e23c9e 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -68,10 +68,9 @@ unsigned int omap_rev(void);
 #define OMAP_REVBITS_00		0x00
 #define OMAP_REVBITS_01		0x01
 #define OMAP_REVBITS_02		0x02
-#define OMAP_REVBITS_10		0x10
-#define OMAP_REVBITS_20		0x20
-#define OMAP_REVBITS_30		0x30
-#define OMAP_REVBITS_40		0x40
+#define OMAP_REVBITS_03		0x03
+#define OMAP_REVBITS_04		0x04
+#define OMAP_REVBITS_05		0x05
 
 /*
  * Get the CPU revision for OMAP devices
@@ -363,23 +362,24 @@ IS_OMAP_TYPE(3517, 0x3517)
 
 /* Various silicon revisions for omap2 */
 #define OMAP242X_CLASS		0x24200024
-#define OMAP2420_REV_ES1_0	0x24200024
-#define OMAP2420_REV_ES2_0	0x24201024
+#define OMAP2420_REV_ES1_0	OMAP242X_CLASS
+#define OMAP2420_REV_ES2_0	(OMAP242X_CLASS | (OMAP_REVBITS_01 << 8))
 
 #define OMAP243X_CLASS		0x24300024
-#define OMAP2430_REV_ES1_0	0x24300024
+#define OMAP2430_REV_ES1_0	OMAP243X_CLASS
 
 #define OMAP343X_CLASS		0x34300034
-#define OMAP3430_REV_ES1_0	0x34300034
-#define OMAP3430_REV_ES2_0	0x34301034
-#define OMAP3430_REV_ES2_1	0x34302034
-#define OMAP3430_REV_ES3_0	0x34303034
-#define OMAP3430_REV_ES3_1	0x34304034
-#define OMAP3430_REV_ES3_1_2	0x34305034
-
-#define OMAP3630_REV_ES1_0	0x36300034
-#define OMAP3630_REV_ES1_1	0x36300134
-#define OMAP3630_REV_ES1_2	0x36300234
+#define OMAP3430_REV_ES1_0	OMAP343X_CLASS
+#define OMAP3430_REV_ES2_0	(OMAP343X_CLASS | (OMAP_REVBITS_01 << 8))
+#define OMAP3430_REV_ES2_1	(OMAP343X_CLASS | (OMAP_REVBITS_02 << 8))
+#define OMAP3430_REV_ES3_0	(OMAP343X_CLASS | (OMAP_REVBITS_03 << 8))
+#define OMAP3430_REV_ES3_1	(OMAP343X_CLASS | (OMAP_REVBITS_04 << 8))
+#define OMAP3430_REV_ES3_1_2	(OMAP343X_CLASS | (OMAP_REVBITS_05 << 8))
+
+#define OMAP363X_CLASS		0x36300034
+#define OMAP3630_REV_ES1_0	OMAP363X_CLASS
+#define OMAP3630_REV_ES1_1	(OMAP363X_CLASS | (OMAP_REVBITS_01 << 8))
+#define OMAP3630_REV_ES1_2	(OMAP363X_CLASS | (OMAP_REVBITS_02 << 8))
 
 #define OMAP35XX_CLASS		0x35000034
 #define OMAP3503_REV(v)		(OMAP35XX_CLASS | (0x3503 << 16) | (v << 8))
@@ -390,7 +390,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16) | (v << 8))
 
 #define OMAP443X_CLASS		0x44300044
-#define OMAP4430_REV_ES1_0	0x44300044
+#define OMAP4430_REV_ES1_0	OMAP443X_CLASS
 
 /*
  * omap_chip bits
-- 
1.7.2.2

