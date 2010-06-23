From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 6/9] omap: move generic omap3 features to generic
Date: Tue, 22 Jun 2010 21:16:12 -0500
Message-ID: <1277259375-18521-7-git-send-email-nm@ti.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35614 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab0FWCQa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 22:16:30 -0400
In-Reply-To: <1277259375-18521-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Vishwanath S <vishwa.s@ti.com>, linux-omap@vger.kernel.org

sgx, iva, l2cache, sgx, neon, isp are generic features, make
them generic features, current OMAP3 detection mechanism
is still retained. 192Mhz is more specific OMAP3 feature
so it is retained as is

Cc: Tony Lindgren <tony@atomide.com>
Cc: Angelo Arrifano <miknix@gmail.com>
Cc: "Zebediah C. McClure" <zmc@lurian.net>
Cc: Alistair Buxton <a.j.buxton@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Senthilvadivu Gurusamy <svadivu@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Cc: Vishwanath S <vishwa.s@ti.com>
Cc: linux-omap@vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/id.c              |   20 ++++++++--------
 arch/arm/plat-omap/common.c           |    4 +++
 arch/arm/plat-omap/include/plat/cpu.h |   39 +++++++++++++++++++-------------
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 809e13a..01555b6 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -161,7 +161,7 @@ static void __init omap24xx_check_revision(void)
 #define OMAP3_CHECK_FEATURE(status,feat)				\
 	if (((status & OMAP3_ ##feat## _MASK) 				\
 		>> OMAP3_ ##feat## _SHIFT) != FEAT_ ##feat## _NONE) { 	\
-		omap3_features |= OMAP3_HAS_ ##feat;			\
+		omap_features |= OMAP_HAS_ ##feat;			\
 	}
 
 static void __init omap3_check_features(void)
@@ -310,20 +310,20 @@ static void __init omap3_cpuinfo(void)
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
@@ -354,11 +354,11 @@ static void __init omap3_cpuinfo(void)
 	/* Print verbose information */
 	pr_info("%s ES%s (", cpu_name, cpu_rev);
 
-	OMAP_SHOW_FEATURE(3, l2cache);
-	OMAP_SHOW_FEATURE(3, iva);
-	OMAP_SHOW_FEATURE(3, sgx);
-	OMAP_SHOW_FEATURE(3, neon);
-	OMAP_SHOW_FEATURE(3, isp);
+	OMAP_SHOW_FEATURE(, l2cache);
+	OMAP_SHOW_FEATURE(, iva);
+	OMAP_SHOW_FEATURE(, sgx);
+	OMAP_SHOW_FEATURE(, neon);
+	OMAP_SHOW_FEATURE(, isp);
 	OMAP_SHOW_FEATURE(3, 192mhz_clk);
 
 	printk(")\n");
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 538e170..6d4d295 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -89,6 +89,10 @@ void __init omap_reserve(void)
 	omap_vram_reserve_sdram_lmb();
 }
 
+/* OMAP Generic features */
+u32 omap_features;
+EXPORT_SYMBOL(omap_features);
+
 void __init omap_check_revision()
 {
 #ifdef CONFIG_ARCH_OMAP1
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index f8ecbc4..3cc4947 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -331,14 +331,14 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_omap3517
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
-						(!omap3_has_iva()) &&	\
-						(!omap3_has_sgx()))
+						(!omap_has_iva()) &&	\
+						(!omap_has_sgx()))
 # define cpu_is_omap3515()		(cpu_is_omap3430() &&		\
-						(!omap3_has_iva()) &&	\
-						(omap3_has_sgx()))
+						(!omap_has_iva()) &&	\
+						(omap_has_sgx()))
 # define cpu_is_omap3525()		(cpu_is_omap3430() &&		\
-						(!omap3_has_sgx()) &&	\
-						(omap3_has_iva()))
+						(!omap_has_sgx()) &&	\
+						(omap_has_iva()))
 # define cpu_is_omap3530()		(cpu_is_omap3430())
 # define cpu_is_omap3505()		is_omap3505()
 # define cpu_is_omap3517()		is_omap3517()
@@ -457,22 +457,29 @@ static inline unsigned int omap##rev##_has_ ##feat(void)		\
 }									\
 
 /*
+ * Runtime detection of Generic OMAP features
+ */
+extern u32 omap_features;
+
+#define OMAP_HAS_L2CACHE		BIT(0)
+#define OMAP_HAS_IVA			BIT(1)
+#define OMAP_HAS_SGX			BIT(2)
+#define OMAP_HAS_NEON			BIT(3)
+#define OMAP_HAS_ISP			BIT(4)
+
+OMAP_HAS_FEATURE(, l2cache, L2CACHE)
+OMAP_HAS_FEATURE(, sgx, SGX)
+OMAP_HAS_FEATURE(, iva, IVA)
+OMAP_HAS_FEATURE(, neon, NEON)
+OMAP_HAS_FEATURE(, isp, ISP)
+
+/*
  * Runtime detection of OMAP3 features
  */
 extern u32 omap3_features;
 
-#define OMAP3_HAS_L2CACHE		BIT(0)
-#define OMAP3_HAS_IVA			BIT(1)
-#define OMAP3_HAS_SGX			BIT(2)
-#define OMAP3_HAS_NEON			BIT(3)
-#define OMAP3_HAS_ISP			BIT(4)
 #define OMAP3_HAS_192MHZ_CLK		BIT(5)
 
-OMAP_HAS_FEATURE(3, l2cache, L2CACHE)
-OMAP_HAS_FEATURE(3, sgx, SGX)
-OMAP_HAS_FEATURE(3, iva, IVA)
-OMAP_HAS_FEATURE(3, neon, NEON)
-OMAP_HAS_FEATURE(3, isp, ISP)
 OMAP_HAS_FEATURE(3, 192mhz_clk, 192MHZ_CLK)
 
 #endif
-- 
1.6.3.3

