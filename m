From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 10/14] omap4: Update id.c and cpu.h for es2.0
Date: Fri, 17 Sep 2010 15:17:54 +0530
Message-ID: <1284716878-27667-11-git-send-email-santosh.shilimkar@ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-5-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-6-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-7-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-8-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-9-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-10-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54847 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab0IQJsO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 05:48:14 -0400
In-Reply-To: <1284716878-27667-10-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch updates the id.c and cpu.h files to support
omap4 ES2.0 silicon detection.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/id.c              |   29 ++++++++++++++++++++++-------
 arch/arm/plat-omap/include/plat/cpu.h |    5 ++++-
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 4808bc9..ae70ae9 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -298,7 +298,6 @@ static void __init omap4_check_revision(void)
 	u32 idcode;
 	u16 hawkeye;
 	u8 rev;
-	char *rev_name = "ES1.0";
 
 	/*
 	 * The IC rev detection is done with hawkeye and rev.
@@ -309,14 +308,30 @@ static void __init omap4_check_revision(void)
 	hawkeye = (idcode >> 12) & 0xffff;
 	rev = (idcode >> 28) & 0xff;
 
-	if ((hawkeye == 0xb852) && (rev == 0x0)) {
-		omap_revision = OMAP4430_REV_ES1_0;
-		omap_chip.oc |= CHIP_IS_OMAP4430ES1;
-		pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
-		return;
+	switch (hawkeye) {
+	case 0xb852:
+		switch (rev) {
+		case 0:
+			omap_revision = OMAP4430_REV_ES1_0;
+			omap_chip.oc |= CHIP_IS_OMAP4430ES1;
+			break;
+		case 1:
+			omap_revision = OMAP4430_REV_ES2_0;
+			omap_chip.oc |= CHIP_IS_OMAP4430ES2;
+			break;
+		default:
+			omap_revision = OMAP4430_REV_ES2_0;
+			omap_chip.oc |= CHIP_IS_OMAP4430ES2;
+	}
+	break;
+	default:
+		/* Unknown default to latest silicon rev as default*/
+		omap_revision = OMAP4430_REV_ES2_0;
+		omap_chip.oc |= CHIP_IS_OMAP4430ES2;
 	}
 
-	pr_err("Unknown OMAP4 CPU id\n");
+	pr_info("OMAP%04x ES%d.0\n",
+			omap_rev() >> 16, ((omap_rev() >> 12) & 0xf) + 1);
 }
 
 #define OMAP3_SHOW_FEATURE(feat)		\
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 2e2ae53..9b38e4b 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -391,6 +391,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	0x44300044
+#define OMAP4430_REV_ES2_0	0x44301044
 
 /*
  * omap_chip bits
@@ -417,10 +418,12 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define CHIP_IS_OMAP4430ES1		(1 << 8)
 #define CHIP_IS_OMAP3630ES1_1           (1 << 9)
 #define CHIP_IS_OMAP3630ES1_2           (1 << 10)
+#define CHIP_IS_OMAP4430ES2		(1 << 11)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
-#define CHIP_IS_OMAP4430		(CHIP_IS_OMAP4430ES1)
+#define CHIP_IS_OMAP4430		(CHIP_IS_OMAP4430ES1 | \
+						 CHIP_IS_OMAP4430ES2)
 
 /*
  * "GE" here represents "greater than or equal to" in terms of ES
-- 
1.6.0.4

