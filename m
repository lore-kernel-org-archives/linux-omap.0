From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH] update omap3 features bitmap and API to generic names
Date: Mon, 10 May 2010 19:19:34 +0530
Message-ID: <k2k618f0c911005100649l8840e4f8z99478e4cda4fe4a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52339 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab0EJNtf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 09:49:35 -0400
Received: by gwj19 with SMTP id 19so1910715gwj.19
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 06:49:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>

>From ff335087b5185828ec7d2d4b4a162e3bcf528792 Mon Sep 17 00:00:00 2001
From: Venkatraman S <svenkatr@ti.com>
Date: Mon, 10 May 2010 19:01:35 +0530
Subject: [PATCH] update omap3 features bitmap and API to generic names

	OMAP3 features bitmap is used a method to check
for SoC specific features. This patch renames the global variables
and the accessor functions to use a generic name from omap3_* to
omap_*

Signed-off-by: Venkatraman S <svenkatr@ti.com>
CC:  Nishanth Menon <nm@ti.com>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c  |    2 +-
 arch/arm/mach-omap2/id.c              |   18 ++++++++--------
 arch/arm/plat-omap/include/plat/cpu.h |   34 ++++++++++++++++----------------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c
b/arch/arm/mach-omap2/clock3xxx_data.c
index 9cba556..afa481d 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3510,7 +3510,7 @@ int __init omap3xxx_clk_init(void)
 			cpu_clkflg |= CK_3430ES2;
 		}
 	}
-	if (omap3_has_192mhz_clk())
+	if (omap_has_192mhz_clk())
 		omap_96m_alwon_fck = omap_96m_alwon_fck_3630;

 	if (cpu_is_omap3630()) {
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37b8a1a..a095b87 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -28,7 +28,7 @@
 static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;

-u32 omap3_features;
+u32 omap_features;

 unsigned int omap_rev(void)
 {
@@ -161,14 +161,14 @@ void __init omap24xx_check_revision(void)
 #define OMAP3_CHECK_FEATURE(status,feat)				\
 	if (((status & OMAP3_ ##feat## _MASK) 				\
 		>> OMAP3_ ##feat## _SHIFT) != FEAT_ ##feat## _NONE) { 	\
-		omap3_features |= OMAP3_HAS_ ##feat;			\
+		omap_features |= OMAP_HAS_ ##feat;			\
 	}

 void __init omap3_check_features(void)
 {
 	u32 status;

-	omap3_features = 0;
+	omap_features = 0;

 	status = omap_ctrl_readl(OMAP3_CONTROL_OMAP_STATUS);

@@ -178,7 +178,7 @@ void __init omap3_check_features(void)
 	OMAP3_CHECK_FEATURE(status, NEON);
 	OMAP3_CHECK_FEATURE(status, ISP);
 	if (cpu_is_omap3630())
-		omap3_features |= OMAP3_HAS_192MHZ_CLK;
+		omap_features |= OMAP_HAS_192MHZ_CLK;

 	/*
 	 * TODO: Get additional info (where applicable)
@@ -294,7 +294,7 @@ void __init omap4_check_revision(void)
 }

 #define OMAP3_SHOW_FEATURE(feat)		\
-	if (omap3_has_ ##feat())		\
+	if (omap_has_ ##feat())		\
 		printk(#feat" ");

 void __init omap3_cpuinfo(void)
@@ -314,20 +314,20 @@ void __init omap3_cpuinfo(void)
 		/*
 		 * AM35xx devices
 		 */
-		if (omap3_has_sgx()) {
+		if (omap_has_sgx()) {
 			omap_revision = OMAP3517_REV(rev);
 			strcpy(cpu_name, "AM3517");
 		} else {
 			/* Already set in omap3_check_revision() */
 			strcpy(cpu_name, "AM3505");
 		}
-	} else if (omap3_has_iva() && omap3_has_sgx()) {
+	} else if (omap_has_iva() && omap_has_sgx()) {
 		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
 		strcpy(cpu_name, "OMAP3430/3530");
-	} else if (omap3_has_iva()) {
+	} else if (omap_has_iva()) {
 		omap_revision = OMAP3525_REV(rev);
 		strcpy(cpu_name, "OMAP3525");
-	} else if (omap3_has_sgx()) {
+	} else if (omap_has_sgx()) {
 		omap_revision = OMAP3515_REV(rev);
 		strcpy(cpu_name, "OMAP3515");
 	} else {
diff --git a/arch/arm/plat-omap/include/plat/cpu.h
b/arch/arm/plat-omap/include/plat/cpu.h
index 7514174..80dc8e0 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -434,28 +434,28 @@ int omap_chip_is(struct omap_chip_id oci);
 void omap2_check_revision(void);

 /*
- * Runtime detection of OMAP3 features
+ * Runtime detection of OMAP features
  */
-extern u32 omap3_features;
+extern u32 omap_features;

-#define OMAP3_HAS_L2CACHE		BIT(0)
-#define OMAP3_HAS_IVA			BIT(1)
-#define OMAP3_HAS_SGX			BIT(2)
-#define OMAP3_HAS_NEON			BIT(3)
-#define OMAP3_HAS_ISP			BIT(4)
-#define OMAP3_HAS_192MHZ_CLK		BIT(5)
+#define OMAP_HAS_L2CACHE		BIT(0)
+#define OMAP_HAS_IVA			BIT(1)
+#define OMAP_HAS_SGX			BIT(2)
+#define OMAP_HAS_NEON			BIT(3)
+#define OMAP_HAS_ISP			BIT(4)
+#define OMAP_HAS_192MHZ_CLK		BIT(5)

-#define OMAP3_HAS_FEATURE(feat,flag)			\
-static inline unsigned int omap3_has_ ##feat(void)	\
+#define OMAP_HAS_FEATURE(feat, flag)			\
+static inline unsigned int omap_has_ ##feat(void)	\
 {							\
-	return (omap3_features & OMAP3_HAS_ ##flag);	\
+	return (omap_features & OMAP_HAS_ ##flag);	\
 }							\

-OMAP3_HAS_FEATURE(l2cache, L2CACHE)
-OMAP3_HAS_FEATURE(sgx, SGX)
-OMAP3_HAS_FEATURE(iva, IVA)
-OMAP3_HAS_FEATURE(neon, NEON)
-OMAP3_HAS_FEATURE(isp, ISP)
-OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
+OMAP_HAS_FEATURE(l2cache, L2CACHE)
+OMAP_HAS_FEATURE(sgx, SGX)
+OMAP_HAS_FEATURE(iva, IVA)
+OMAP_HAS_FEATURE(neon, NEON)
+OMAP_HAS_FEATURE(isp, ISP)
+OMAP_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)

 #endif
-- 
1.6.3.3
