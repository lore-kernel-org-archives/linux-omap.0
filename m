From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Runtime detection of Si features
Date: Thu, 13 Aug 2009 20:48:21 +0530
Message-ID: <1250176701-23998-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57593 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580AbZHMPS3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Aug 2009 11:18:29 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7DFINXH009507
	for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 10:18:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

The OMAP35x family has multiple variants differing
in the HW features. This patch detects these features
at runtime and prints information during the boot.

Since most of the code seemed repetitive, macros
have been used for readability.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/id.c |  106 ++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a98201c..4476491 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -25,9 +25,49 @@
 #include <mach/control.h>
 #include <mach/cpu.h>
 
+/*
+ * OMAP3 features
+ */
+#define OMAP3_CONTROL_OMAP_STATUS	0x044c
+
+#define OMAP3_SGX_SHIFT			13
+#define OMAP3_SGX_MASK			(3 << OMAP3_SGX_SHIFT)
+#define		FEAT_SGX_FULL		0
+#define		FEAT_SGX_HALF		1
+#define		FEAT_SGX_NONE		2
+
+#define OMAP3_IVA_SHIFT			12
+#define OMAP3_IVA_MASK			(1 << OMAP3_SGX_SHIFT)
+#define		FEAT_IVA		0
+#define		FEAT_IVA_NONE		1
+
+#define OMAP3_L2CACHE_SHIFT		10
+#define OMAP3_L2CACHE_MASK		(3 << OMAP3_L2CACHE_SHIFT)
+#define		FEAT_L2CACHE_NONE	0
+#define		FEAT_L2CACHE_64KB	1
+#define		FEAT_L2CACHE_128KB	2
+#define		FEAT_L2CACHE_256KB	3
+
+#define OMAP3_ISP_SHIFT			5
+#define OMAP3_ISP_MASK			(1<< OMAP3_ISP_SHIFT)
+#define		FEAT_ISP		0
+#define		FEAT_ISP_NONE		1
+
+#define OMAP3_NEON_SHIFT		4
+#define OMAP3_NEON_MASK			(1<< OMAP3_NEON_SHIFT)
+#define		FEAT_NEON		0
+#define		FEAT_NEON_NONE		1
+
+
+#define OMAP_HAS_L2CACHE		1
+#define OMAP_HAS_IVA			(1 << 1)
+#define OMAP_HAS_SGX			(1 << 2)
+#define OMAP_HAS_NEON			(1 << 3)
+#define OMAP_HAS_ISP			(1 << 4)
+
 static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
-
+static u32 omap_features ;
 
 unsigned int omap_rev(void)
 {
@@ -35,6 +75,19 @@ unsigned int omap_rev(void)
 }
 EXPORT_SYMBOL(omap_rev);
 
+#define OMAP3_HAS_FEATURE(feat,flag)				\
+	unsigned int omap3_has_ ##feat(void)			\
+	{							\
+		return (omap_features & OMAP_HAS_ ##flag);	\
+	}							\
+	EXPORT_SYMBOL(omap3_has_ ##feat);
+
+OMAP3_HAS_FEATURE(l2cache, L2CACHE);
+OMAP3_HAS_FEATURE(sgx, SGX);
+OMAP3_HAS_FEATURE(iva, IVA);
+OMAP3_HAS_FEATURE(neon, NEON);
+OMAP3_HAS_FEATURE(isp, ISP);
+
 /**
  * omap_chip_is - test whether currently running OMAP matches a chip type
  * @oc: omap_chip_t to test against
@@ -155,7 +208,33 @@ void __init omap24xx_check_revision(void)
 	pr_info("\n");
 }
 
-void __init omap34xx_check_revision(void)
+#define OMAP3_CHECK_FEATURE(status,feat)				\
+	if (((status & OMAP3_ ##feat## _MASK) 				\
+		>> OMAP3_ ##feat## _SHIFT) != FEAT_ ##feat## _NONE) { 	\
+		omap_features |= OMAP_HAS_ ##feat;			\
+	}
+
+void __init omap3_check_features(void)
+{
+	u32 status, temp;
+
+	omap_features = 0;
+
+	status = omap_ctrl_readl(OMAP3_CONTROL_OMAP_STATUS);
+
+	OMAP3_CHECK_FEATURE(status, L2CACHE);
+	OMAP3_CHECK_FEATURE(status, IVA);
+	OMAP3_CHECK_FEATURE(status, SGX);
+	OMAP3_CHECK_FEATURE(status, NEON);
+	OMAP3_CHECK_FEATURE(status, ISP);
+
+	/*
+	 * TODO: Get additional info (where applicable)
+	 *       e.g. Size of L2 cache.
+	 */
+}
+
+void __init omap3_check_revision(void)
 {
 	u32 cpuid, idcode;
 	u16 hawkeye;
@@ -212,6 +291,22 @@ out:
 	pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
 }
 
+#define OMAP3_SHOW_FEATURE(feat)		\
+	if (omap3_has_ ##feat()) {		\
+		pr_info (" - "#feat" : Y");	\
+	} else {				\
+		pr_info (" - "#feat" : N");	\
+	}
+
+void __init omap3_cpuinfo(void)
+{
+	OMAP3_SHOW_FEATURE(l2cache);
+	OMAP3_SHOW_FEATURE(iva);
+	OMAP3_SHOW_FEATURE(sgx);
+	OMAP3_SHOW_FEATURE(neon);
+	OMAP3_SHOW_FEATURE(isp);
+}
+
 /*
  * Try to detect the exact revision of the omap we're running on
  */
@@ -223,8 +318,11 @@ void __init omap2_check_revision(void)
 	 */
 	if (cpu_is_omap24xx())
 		omap24xx_check_revision();
-	else if (cpu_is_omap34xx())
-		omap34xx_check_revision();
+	else if (cpu_is_omap34xx()) {
+		omap3_check_features();
+		omap3_check_revision();
+		omap3_cpuinfo();
+	}
 	else if (cpu_is_omap44xx()) {
 		printk(KERN_INFO "FIXME: CPU revision = OMAP4430\n");
 		return;
-- 
1.6.2.2

