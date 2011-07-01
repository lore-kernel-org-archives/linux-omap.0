From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/7] OMAP4: ID: add omap_has_feature for max freq supported
Date: Fri, 1 Jul 2011 07:37:56 +0530
Message-ID: <1309486081-8257-3-git-send-email-rnayak@ti.com>
References: <1309486081-8257-1-git-send-email-rnayak@ti.com>
 <1309486081-8257-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55689 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149Ab1GACIR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 22:08:17 -0400
In-Reply-To: <1309486081-8257-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, Aneesh V <aneesh@ti.com>, Nishanth Menon <nm@ti.com>

From: Aneesh V <aneesh@ti.com>

Macros for identifying the max frequency supported by various
OMAP4 variants - Expanding along the lines of OMAP3's feature
handling.

[nm@ti.com: minor fixes for checks that should only for 443x|446x]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Aneesh V <aneesh@ti.com>
---
 arch/arm/mach-omap2/id.c              |   29 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/cpu.h |   19 +++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 3d43d64..a86d0f9 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -32,6 +32,7 @@ static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
 
 u32 omap3_features;
+u32 omap4_features;
 
 unsigned int omap_rev(void)
 {
@@ -212,6 +213,33 @@ static void __init omap3_check_features(void)
 	 */
 }
 
+static void __init omap4_check_features(void)
+{
+	u32 si_type;
+
+	omap4_features = 0;
+
+	if (cpu_is_omap443x())
+		omap4_features |= OMAP4_HAS_MPU_1GHZ;
+
+
+	if (cpu_is_omap446x()) {
+		si_type =
+			read_tap_reg(OMAP4_CTRL_MODULE_CORE_STD_FUSE_PROD_ID_1);
+		switch ((si_type & (3 << 16)) >> 16) {
+		case 2:
+			/* High performance device */
+			omap4_features |= OMAP4_HAS_MPU_1_5GHZ;
+			break;
+		case 1:
+		default:
+			/* Standard device */
+			omap4_features |= OMAP4_HAS_MPU_1_2GHZ;
+			break;
+		}
+	}
+}
+
 static void __init ti816x_check_features(void)
 {
 	omap3_features = OMAP3_HAS_NEON;
@@ -527,6 +555,7 @@ void __init omap2_check_revision(void)
 		return;
 	} else if (cpu_is_omap44xx()) {
 		omap4_check_revision();
+		omap4_check_features();
 		return;
 	} else {
 		pr_err("OMAP revision unknown, please fix!\n");
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 86b1420..7e1ba5c 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -507,4 +507,23 @@ OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
 OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
 OMAP3_HAS_FEATURE(sdrc, SDRC)
 
+/*
+ * Runtime detection of OMAP4 features
+ */
+extern u32 omap4_features;
+
+#define OMAP4_HAS_MPU_1GHZ		BIT(0)
+#define OMAP4_HAS_MPU_1_2GHZ		BIT(1)
+#define OMAP4_HAS_MPU_1_5GHZ		BIT(2)
+
+#define OMAP4_HAS_FEATURE(feat, flag)			\
+static inline unsigned int omap4_has_ ##feat(void)	\
+{							\
+	return omap4_features & OMAP4_HAS_ ##flag;	\
+}							\
+
+OMAP4_HAS_FEATURE(mpu_1ghz, MPU_1GHZ)
+OMAP4_HAS_FEATURE(mpu_1_2ghz, MPU_1_2GHZ)
+OMAP4_HAS_FEATURE(mpu_1_5ghz, MPU_1_5GHZ)
+
 #endif
-- 
1.7.4.1

