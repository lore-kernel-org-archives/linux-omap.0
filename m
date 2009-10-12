From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] OMAP35x: Add support for 720MHz part
Date: Mon, 12 Oct 2009 18:14:09 +0530
Message-ID: <1255351453-9023-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47429 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754983AbZJLMoy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Oct 2009 08:44:54 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9CCiFaK030232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 07:44:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds support for ARM running at 720MHz part.

The 720MHz capability can be probed run-time by reading the
PRODID.SKUID[3:0] at 0x4830A20C.

  [1] http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c           |    6 ++++++
 arch/arm/mach-omap2/id.c                  |   11 +++++++++++
 arch/arm/plat-omap/include/mach/control.h |    7 +++++++
 arch/arm/plat-omap/include/mach/cpu.h     |    2 ++
 4 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 489556e..9b56af3 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -1096,6 +1096,12 @@ static int __init omap2_clk_arch_init(void)
 	if (!mpurate)
 		return -EINVAL;
 
+	if ((mpurate == 720000000) && !omap3_has_720mhz()) {
+		printk(KERN_ERR "*** Silicon doesn't support 720MHz\n");
+
+		mpurate = 600000000;  /* Set to highest supported */
+	}
+
 	/* REVISIT: not yet ready for 343x */
 	if (clk_set_rate(&dpll1_ck, mpurate))
 		printk(KERN_ERR "*** Unable to set MPU rate\n");
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index d4d563b..e0b427a 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -79,6 +79,7 @@ EXPORT_SYMBOL(omap_type);
 #define OMAP_TAP_DIE_ID_2	0x0220
 #define OMAP_TAP_DIE_ID_3	0x0224
 
+
 #define read_tap_reg(reg)	__raw_readl(tap_base  + (reg))
 
 struct omap_id {
@@ -180,6 +181,15 @@ void __init omap3_check_features(void)
 	 * TODO: Get additional info (where applicable)
 	 *       e.g. Size of L2 cache.
 	 */
+
+	/*
+	 * Does it support 720MHz?
+	 */
+	status = (OMAP3_SKUID_MASK & read_tap_reg(OMAP3_PRODID));
+
+	if (status & OMAP3_SKUID_720MHZ) {
+		omap3_features |= OMAP3_HAS_720MHZ;
+	}
 }
 
 void __init omap3_check_revision(void)
@@ -296,6 +306,7 @@ void __init omap3_cpuinfo(void)
 	OMAP3_SHOW_FEATURE(sgx);
 	OMAP3_SHOW_FEATURE(neon);
 	OMAP3_SHOW_FEATURE(isp);
+	OMAP3_SHOW_FEATURE(720mhz);
 }
 
 /*
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index fdb6300..e886bb6 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -238,6 +238,13 @@
 #define		FEAT_NEON		0
 #define		FEAT_NEON_NONE		1
 
+/*
+ * Product ID register
+ */
+#define OMAP3_PRODID			0x020C
+
+#define OMAP3_SKUID_MASK		0x0f
+#define 	OMAP3_SKUID_720MHZ	0x08
 
 #ifndef __ASSEMBLY__
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 8d0841b..12b91f7 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -472,6 +472,7 @@ extern u32 omap3_features;
 #define OMAP3_HAS_SGX			BIT(2)
 #define OMAP3_HAS_NEON			BIT(3)
 #define OMAP3_HAS_ISP			BIT(4)
+#define OMAP3_HAS_720MHZ		BIT(5)
 
 #define OMAP3_HAS_FEATURE(feat,flag)			\
 static inline unsigned int omap3_has_ ##feat(void)	\
@@ -484,5 +485,6 @@ OMAP3_HAS_FEATURE(sgx, SGX)
 OMAP3_HAS_FEATURE(iva, IVA)
 OMAP3_HAS_FEATURE(neon, NEON)
 OMAP3_HAS_FEATURE(isp, ISP)
+OMAP3_HAS_FEATURE(720mhz, 720MHZ)
 
 #endif
-- 
1.6.2.2

