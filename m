From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] ARM: OMAP: Add omap34xx revision detection for ES3.1.1
Date: Wed, 26 Aug 2009 17:34:32 +0530
Message-ID: <1251288272-17209-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35107 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756485AbZHZMEi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Aug 2009 08:04:38 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7QC4Y6O025812
	for <linux-omap@vger.kernel.org>; Wed, 26 Aug 2009 07:04:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

ARM: OMAP: Add omap34xx revision detection for ES3.1.1

- Add omap34xx revision detection for ES3.1.1 silicon.
- Change default silicon to ES3.1.1

- Also minor bug-fix: ES2.0 rev field is 1, not 0.
  - This means that ES2.0 silicon would have wrongly been
    detected as unknown

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Let me know if this should be split into a bug-fix patch,
and a separate patch for adding ES 3.1.1 revision info.
I felt the change was too minor to split out, since
ES2.0 silicon is rare.

This patch is against linus' tree - so the cpu.h
change will apply with an offset

 arch/arm/mach-omap2/id.c              |    8 ++++++--
 arch/arm/plat-omap/include/mach/cpu.h |    1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a98201c..414c520 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -185,7 +185,7 @@ void __init omap34xx_check_revision(void)
 
 	if (hawkeye == 0xb7ae) {
 		switch (rev) {
-		case 0:
+		case 1:
 			omap_revision = OMAP3430_REV_ES2_0;
 			rev_name = "ES2.0";
 			break;
@@ -201,9 +201,13 @@ void __init omap34xx_check_revision(void)
 			omap_revision = OMAP3430_REV_ES3_1;
 			rev_name = "ES3.1";
 			break;
+		case 6:
+			omap_revision = OMAP3430_REV_ES3_1_1;
+			rev_name = "ES3.1.1";
+			break;
 		default:
 			/* Use the latest known revision as default */
-			omap_revision = OMAP3430_REV_ES3_1;
+			omap_revision = OMAP3430_REV_ES3_1_1;
 			rev_name = "Unknown revision\n";
 		}
 	}
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 11e73d9..22cceb8 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -392,6 +392,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3430_REV_ES2_1	0x34302034
 #define OMAP3430_REV_ES3_0	0x34303034
 #define OMAP3430_REV_ES3_1	0x34304034
+#define OMAP3430_REV_ES3_1_1	0x34306034
 
 #define OMAP443X_CLASS		0x44300034
 
