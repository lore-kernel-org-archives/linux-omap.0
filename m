From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v5 5/5] OMAP4: Smartreflex framework extensions
Date: Mon, 20 Dec 2010 22:30:37 +0530
Message-ID: <1292864437-15353-6-git-send-email-thara@ti.com>
References: <1292864437-15353-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52233 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874Ab0LTRAx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 12:00:53 -0500
In-Reply-To: <1292864437-15353-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com, Thara Gopinath <thara@ti.com>

This patch extends the smartreflex framework to support
OMAP4. The changes are minor like compiling smartreflex Kconfig
option for OMAP4 also, and a couple of OMAP4 checks in
the smartreflex framework.

The change in sr_device.c where new logic has to be introduced
for reading the efuse registers is due to the fact that in OMAP4
the efuse registers are 24 bit aligned. A __raw_readl will
fail for non-32 bit aligned address and hence the 8-bit read
and shift.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    8 ++++++--
 arch/arm/mach-omap2/sr_device.c   |   17 ++++++++++++++++-
 arch/arm/plat-omap/Kconfig        |    2 +-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 52a05b3..77ecebf 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -153,7 +153,11 @@ static void sr_set_clk_length(struct omap_sr *sr)
 	struct clk *sys_ck;
 	u32 sys_clk_speed;
 
-	sys_ck = clk_get(NULL, "sys_ck");
+	if (cpu_is_omap34xx())
+		sys_ck = clk_get(NULL, "sys_ck");
+	else
+		sys_ck = clk_get(NULL, "sys_clkin_ck");
+
 	if (IS_ERR(sys_ck)) {
 		dev_err(&sr->pdev->dev, "%s: unable to get sys clk\n",
 			__func__);
@@ -193,7 +197,7 @@ static void sr_set_regfields(struct omap_sr *sr)
 	 * file or pmic specific data structure. In that case these structure
 	 * fields will have to be populated using the pdata or pmic structure.
 	 */
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		sr->err_weight = OMAP3430_SR_ERRWEIGHT;
 		sr->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
 		sr->accum_data = OMAP3430_SR_ACCUMDATA;
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 9a3538f..786d685 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -20,6 +20,7 @@
 
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 
 #include <plat/omap_device.h>
 #include <plat/smartreflex.h>
@@ -51,7 +52,21 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 			GFP_KERNEL);
 
 	for (i = 0; i < count; i++) {
-		u32 v = omap_ctrl_readl(volt_data[i].sr_efuse_offs);
+		u32 v;
+		/*
+		 * In OMAP4 the efuse registers are 24 bit aligned.
+		 * A __raw_readl will fail for non-32 bit aligned address
+		 * and hence the 8-bit read and shift.
+		 */
+		if (cpu_is_omap44xx()) {
+			u16 offset = volt_data[i].sr_efuse_offs;
+
+			v = omap_ctrl_readb(offset) |
+				omap_ctrl_readb(offset + 1) << 8 |
+				omap_ctrl_readb(offset + 2) << 16;
+		} else {
+			 v = omap_ctrl_readl(volt_data[i].sr_efuse_offs);
+		}
 
 		nvalue_table[i].efuse_offs = volt_data[i].sr_efuse_offs;
 		nvalue_table[i].nvalue = v;
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 4029e6a..88ff484 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -37,7 +37,7 @@ config OMAP_DEBUG_LEDS
 
 config OMAP_SMARTREFLEX
 	bool "SmartReflex support"
-	depends on ARCH_OMAP3 && PM
+	depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM
 	help
 	  Say Y if you want to enable SmartReflex.
 
-- 
1.7.0.4

