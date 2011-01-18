From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: Add basic support for 720MHz part
Date: Tue, 18 Jan 2011 13:19:55 +0530
Message-ID: <1295336995-15831-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36952 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab1ARHuE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 02:50:04 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0I7o0gP017146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 18 Jan 2011 01:50:02 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds support for new speed enhanced parts with ARM
and IVA running at 720MHz and 520MHz respectively. These parts
can be probed at run-time by reading PRODID.SKUID[3:0] at
0x4830A20C [1].

This patch specifically does following:
 * Detect devices capable of 720MHz.
 * Add new OPP
 * Ensure that OPP is conditionally enabled.
 * Check for presence of IVA before attempting to enable
   the corresponding OPP.

  [1] http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
Since v2:
1) pr_xxx() -> dev_xxx() functions - suggested by 
   Manjunath (manjugk@ti.com)
2) Add check for presense of IVA - earlier planned to
   be in a separate patch; but we multiple discussions
   on optimizations.
3) Do look-up for hwmod corresponding for iva only if
   iva is present. Should save multiple strcmp()s in
   _lookup().

Since v1:
1) Using opp_enable() to enable the OPP after the OPP
   table has been initialized.
2) Starting at 3 levels of indent, the statements had
   be broken into multiple lines for most of the code.
   So, opted to create a new static that enables the
   OPPs corresponding to 720MHz.
3) I have only build tested this patch - will be able
   to confirm working tomorrow. With any further change,
   if needed. (However, functionally nothing has changed.)


 arch/arm/mach-omap2/control.h         |    7 ++++
 arch/arm/mach-omap2/id.c              |   10 +++++
 arch/arm/mach-omap2/opp3xxx_data.c    |   63 ++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/cpu.h |    2 +
 4 files changed, 81 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index f0629ae..eebc045 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -365,6 +365,13 @@
 #define		FEAT_NEON		0
 #define		FEAT_NEON_NONE		1
 
+/*
+ * Product ID register
+ */
+#define OMAP3_PRODID			0x020C
+
+#define OMAP3_SKUID_MASK		0x0f
+#define		OMAP3_SKUID_720MHZ	0x08
 
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_ARCH_OMAP2PLUS
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 5f9086c..53fbe01 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -195,6 +195,15 @@ static void __init omap3_check_features(void)
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
 
 static void __init omap3_check_revision(void)
@@ -445,6 +454,7 @@ static void __init omap3_cpuinfo(void)
 	OMAP3_SHOW_FEATURE(neon);
 	OMAP3_SHOW_FEATURE(isp);
 	OMAP3_SHOW_FEATURE(192mhz_clk);
+	OMAP3_SHOW_FEATURE(720mhz);
 
 	printk(")\n");
 }
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
index 0486fce..cba17f7 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -17,8 +17,10 @@
  * GNU General Public License for more details.
  */
 #include <linux/module.h>
+#include <linux/opp.h>
 
 #include <plat/cpu.h>
+#include <plat/omap_device.h>
 
 #include "omap_opp_data.h"
 
@@ -33,6 +35,8 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
 	OPP_INITIALIZER("mpu", true, 550000000, 1270000),
 	/* MPU OPP5 */
 	OPP_INITIALIZER("mpu", true, 600000000, 1350000),
+	/* MPU OPP6 */
+	OPP_INITIALIZER("mpu", false, 720000000, 1350000),
 
 	/*
 	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
@@ -58,6 +62,8 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
 	OPP_INITIALIZER("iva", true, 400000000, 1270000),
 	/* DSP OPP5 */
 	OPP_INITIALIZER("iva", true, 430000000, 1350000),
+	/* DSP OPP6 */
+	OPP_INITIALIZER("iva", false, 520000000, 1350000),
 };
 
 static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
@@ -85,6 +91,57 @@ static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
 	OPP_INITIALIZER("iva", false, 800000000, 1375000),
 };
 
+
+/**
+ * omap3_opp_enable_720Mhz() - Enable the OPP corresponding to 720MHz
+ *
+ * This function would be executed only if the silicon is capable of
+ * running at the 720MHz.
+ */
+static int __init omap3_opp_enable_720Mhz(void)
+{
+	int r = -ENODEV;
+	struct omap_hwmod *oh_mpu = omap_hwmod_lookup("mpu");
+	struct omap_hwmod *oh_iva;
+	struct platform_device *pdev;
+
+	if (!oh_mpu || !oh_mpu->od) {
+		goto err;
+	} else {
+		pdev = &oh_mpu->od->pdev;
+
+		r = opp_enable(&pdev->dev, 720000000);
+		if (r < 0) {
+			dev_err(&pdev->dev,
+				"opp_enable() failed for mpu@720MHz");
+			goto err;
+		}
+	}
+
+	if (omap3_has_iva()) {
+		oh_iva = omap_hwmod_lookup("iva");
+
+		if (!oh_iva || !oh_iva->od) {
+			r = -ENODEV;
+			goto err;
+		} else {
+			pdev = &oh_iva->od->pdev;
+
+			r = opp_enable(&pdev->dev, 520000000);
+			if (r < 0) {
+				dev_err(&pdev->dev,
+					"opp_enable() failed for iva@520MHz");
+				goto err;
+			}
+		}
+	}
+
+	dev_info(&pdev->dev, "Enabled OPP corresponding to 720MHz\n");
+
+err:
+	return r;
+}
+
 /**
  * omap3_opp_init() - initialize omap3 opp table
  */
@@ -98,10 +155,14 @@ static int __init omap3_opp_init(void)
 	if (cpu_is_omap3630())
 		r = omap_init_opp_table(omap36xx_opp_def_list,
 			ARRAY_SIZE(omap36xx_opp_def_list));
-	else
+	else {
 		r = omap_init_opp_table(omap34xx_opp_def_list,
 			ARRAY_SIZE(omap34xx_opp_def_list));
 
+		if (omap3_has_720mhz())
+			r = omap3_opp_enable_720Mhz();
+	}
+
 	return r;
 }
 device_initcall(omap3_opp_init);
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 3fd8b40..5c77987 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -455,6 +455,7 @@ extern u32 omap3_features;
 #define OMAP3_HAS_ISP			BIT(4)
 #define OMAP3_HAS_192MHZ_CLK		BIT(5)
 #define OMAP3_HAS_IO_WAKEUP		BIT(6)
+#define OMAP3_HAS_720MHZ		BIT(7)
 
 #define OMAP3_HAS_FEATURE(feat,flag)			\
 static inline unsigned int omap3_has_ ##feat(void)	\
@@ -469,5 +470,6 @@ OMAP3_HAS_FEATURE(neon, NEON)
 OMAP3_HAS_FEATURE(isp, ISP)
 OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
 OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
+OMAP3_HAS_FEATURE(720mhz, 720MHZ)
 
 #endif
-- 
1.7.2.2

