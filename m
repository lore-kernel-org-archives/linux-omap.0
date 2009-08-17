From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH v2] Runtime detection of Si features
Date: Mon, 17 Aug 2009 17:20:58 +0530
Message-ID: <1250509858-7951-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42576 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbZHQLvF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Aug 2009 07:51:05 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7HBp0qA011236
	for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2009 06:51:05 -0500
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
 arch/arm/mach-omap2/id.c                  |   52 +++++++++++++++++++++++++++--
 arch/arm/mach-omap2/mmc-twl4030.c         |    1 +
 arch/arm/plat-omap/include/mach/control.h |   34 +++++++++++++++++++
 arch/arm/plat-omap/include/mach/cpu.h     |   23 +++++++++++++
 4 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a98201c..03b80f2 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -28,6 +28,7 @@
 static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
 
+u32 omap3_features;
 
 unsigned int omap_rev(void)
 {
@@ -155,7 +156,33 @@ void __init omap24xx_check_revision(void)
 	pr_info("\n");
 }
 
-void __init omap34xx_check_revision(void)
+#define OMAP3_CHECK_FEATURE(status,feat)				\
+	if (((status & OMAP3_ ##feat## _MASK) 				\
+		>> OMAP3_ ##feat## _SHIFT) != FEAT_ ##feat## _NONE) { 	\
+		omap3_features |= OMAP3_HAS_ ##feat;			\
+	}
+
+void __init omap3_check_features(void)
+{
+	u32 status;
+
+	omap3_features = 0;
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
@@ -212,6 +239,22 @@ out:
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
@@ -223,8 +266,11 @@ void __init omap2_check_revision(void)
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
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 3c04c2f..d68284d 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/err.h>
+#include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 826d317..74ec2f9 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -202,6 +202,40 @@
 #define OMAP3_PADCONF_WAKEUPEVENT0	(1 << 15)
 #define OMAP3_PADCONF_WAKEUPENABLE0	(1 << 14)
 
+/*
+ * CONTROL OMAP STATUS register to identify OMAP3 features
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
 #ifndef __ASSEMBLY__
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 		defined(CONFIG_ARCH_OMAP4)
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 4fbc6a9..4a04f77 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -432,4 +432,27 @@ IS_OMAP_TYPE(3430, 0x3430)
 int omap_chip_is(struct omap_chip_id oci);
 void omap2_check_revision(void);
 
+/*
+ * Runtime detection of OMAP3 features
+ */
+extern u32 omap3_features;
+
+#define OMAP3_HAS_L2CACHE		BIT(0)
+#define OMAP3_HAS_IVA			BIT(1)
+#define OMAP3_HAS_SGX			BIT(2)
+#define OMAP3_HAS_NEON			BIT(3)
+#define OMAP3_HAS_ISP			BIT(4)
+
+#define OMAP3_HAS_FEATURE(feat,flag)			\
+static inline unsigned int omap3_has_ ##feat(void)	\
+{							\
+	return (omap3_features & OMAP3_HAS_ ##flag);	\
+}							\
+
+OMAP3_HAS_FEATURE(l2cache, L2CACHE)
+OMAP3_HAS_FEATURE(sgx, SGX)
+OMAP3_HAS_FEATURE(iva, IVA)
+OMAP3_HAS_FEATURE(neon, NEON)
+OMAP3_HAS_FEATURE(isp, ISP)
+
 #endif	/* __ASM_ARCH_OMAP_CPU_H */
-- 
1.6.2.2

