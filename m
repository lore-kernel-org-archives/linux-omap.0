From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/6] OMAP4: ID: add omap_has_feature for max freq supported
Date: Sat, 2 Jul 2011 08:00:22 +0530
Message-ID: <1309573826-10615-3-git-send-email-rnayak@ti.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com>
 <1309573826-10615-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43120 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967Ab1GBCbk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 22:31:40 -0400
In-Reply-To: <1309573826-10615-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Aneesh V <aneesh@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Aneesh V <aneesh@ti.com>

Macros for identifying the max frequency supported by various
OMAP4 variants - Expanding along the lines of OMAP3's feature
handling.

[nm@ti.com: minor fixes for checks that should only for 443x|446x]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Aneesh V <aneesh@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
V2:
* Replaced 'omap3_features' and 'omap4_features' with a single
  variable 'omap_features'
---
 arch/arm/mach-omap2/id.c              |   40 +++++++++++++++++++++++++++-----
 arch/arm/plat-omap/include/plat/cpu.h |   23 +++++++++++++++++-
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 743889a..37efb86 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -31,7 +31,7 @@
 static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
 
-u32 omap3_features;
+u32 omap_features;
 
 unsigned int omap_rev(void)
 {
@@ -183,14 +183,14 @@ static void __init omap24xx_check_revision(void)
 #define OMAP3_CHECK_FEATURE(status,feat)				\
 	if (((status & OMAP3_ ##feat## _MASK) 				\
 		>> OMAP3_ ##feat## _SHIFT) != FEAT_ ##feat## _NONE) { 	\
-		omap3_features |= OMAP3_HAS_ ##feat;			\
+		omap_features |= OMAP3_HAS_ ##feat;			\
 	}
 
 static void __init omap3_check_features(void)
 {
 	u32 status;
 
-	omap3_features = 0;
+	omap_features = 0;
 
 	status = omap_ctrl_readl(OMAP3_CONTROL_OMAP_STATUS);
 
@@ -200,11 +200,11 @@ static void __init omap3_check_features(void)
 	OMAP3_CHECK_FEATURE(status, NEON);
 	OMAP3_CHECK_FEATURE(status, ISP);
 	if (cpu_is_omap3630())
-		omap3_features |= OMAP3_HAS_192MHZ_CLK;
+		omap_features |= OMAP3_HAS_192MHZ_CLK;
 	if (!cpu_is_omap3505() && !cpu_is_omap3517())
-		omap3_features |= OMAP3_HAS_IO_WAKEUP;
+		omap_features |= OMAP3_HAS_IO_WAKEUP;
 
-	omap3_features |= OMAP3_HAS_SDRC;
+	omap_features |= OMAP3_HAS_SDRC;
 
 	/*
 	 * TODO: Get additional info (where applicable)
@@ -212,9 +212,34 @@ static void __init omap3_check_features(void)
 	 */
 }
 
+static void __init omap4_check_features(void)
+{
+	u32 si_type;
+
+	if (cpu_is_omap443x())
+		omap_features |= OMAP4_HAS_MPU_1GHZ;
+
+
+	if (cpu_is_omap446x()) {
+		si_type =
+			read_tap_reg(OMAP4_CTRL_MODULE_CORE_STD_FUSE_PROD_ID_1);
+		switch ((si_type & (3 << 16)) >> 16) {
+		case 2:
+			/* High performance device */
+			omap_features |= OMAP4_HAS_MPU_1_5GHZ;
+			break;
+		case 1:
+		default:
+			/* Standard device */
+			omap_features |= OMAP4_HAS_MPU_1_2GHZ;
+			break;
+		}
+	}
+}
+
 static void __init ti816x_check_features(void)
 {
-	omap3_features = OMAP3_HAS_NEON;
+	omap_features = OMAP3_HAS_NEON;
 }
 
 static void __init omap3_check_revision(void)
@@ -527,6 +552,7 @@ void __init omap2_check_revision(void)
 		return;
 	} else if (cpu_is_omap44xx()) {
 		omap4_check_revision();
+		omap4_check_features();
 		return;
 	} else {
 		pr_err("OMAP revision unknown, please fix!\n");
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 86b1420..0690f1a 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -481,7 +481,7 @@ void omap2_check_revision(void);
 /*
  * Runtime detection of OMAP3 features
  */
-extern u32 omap3_features;
+extern u32 omap_features;
 
 #define OMAP3_HAS_L2CACHE		BIT(0)
 #define OMAP3_HAS_IVA			BIT(1)
@@ -491,11 +491,15 @@ extern u32 omap3_features;
 #define OMAP3_HAS_192MHZ_CLK		BIT(5)
 #define OMAP3_HAS_IO_WAKEUP		BIT(6)
 #define OMAP3_HAS_SDRC			BIT(7)
+#define OMAP4_HAS_MPU_1GHZ		BIT(8)
+#define OMAP4_HAS_MPU_1_2GHZ		BIT(9)
+#define OMAP4_HAS_MPU_1_5GHZ		BIT(10)
+
 
 #define OMAP3_HAS_FEATURE(feat,flag)			\
 static inline unsigned int omap3_has_ ##feat(void)	\
 {							\
-	return (omap3_features & OMAP3_HAS_ ##flag);	\
+	return omap_features & OMAP3_HAS_ ##flag;	\
 }							\
 
 OMAP3_HAS_FEATURE(l2cache, L2CACHE)
@@ -507,4 +511,19 @@ OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
 OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
 OMAP3_HAS_FEATURE(sdrc, SDRC)
 
+/*
+ * Runtime detection of OMAP4 features
+ */
+extern u32 omap_features;
+
+#define OMAP4_HAS_FEATURE(feat, flag)			\
+static inline unsigned int omap4_has_ ##feat(void)	\
+{							\
+	return omap_features & OMAP4_HAS_ ##flag;	\
+}							\
+
+OMAP4_HAS_FEATURE(mpu_1ghz, MPU_1GHZ)
+OMAP4_HAS_FEATURE(mpu_1_2ghz, MPU_1_2GHZ)
+OMAP4_HAS_FEATURE(mpu_1_5ghz, MPU_1_5GHZ)
+
 #endif
-- 
1.7.4.1

