From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v3 6/6] OMAP4: Smartreflex framework extensions
Date: Wed, 27 Oct 2010 21:46:36 +0530
Message-ID: <1288196196-15469-7-git-send-email-thara@ti.com>
References: <1288196196-15469-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38509 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756380Ab0J0QQq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 12:16:46 -0400
In-Reply-To: <1288196196-15469-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

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
 arch/arm/mach-omap2/sr_device.c   |   12 +++++++++++-
 arch/arm/plat-omap/Kconfig        |    2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 2669584..23e14c0 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -149,7 +149,11 @@ static void sr_set_clk_length(struct omap_sr *sr)
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
@@ -189,7 +193,7 @@ static void sr_set_regfields(struct omap_sr *sr)
 	 * file or pmic specific data structure. In that case these structure
 	 * fields will have to be populated using the pdata or pmic structure.
 	 */
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		sr->err_weight = OMAP3430_SR_ERRWEIGHT;
 		sr->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
 		sr->accum_data = OMAP3430_SR_ACCUMDATA;
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index b7e2d10..c157392 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -20,6 +20,7 @@
 
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 
 #include <plat/omap_device.h>
 #include <plat/smartreflex.h>
@@ -101,7 +102,16 @@ static void __init sr_set_nvalues(struct omap_sr_dev_data *dev_data,
 	}
 
 	for (i = 0; i < dev_data->volts_supported; i++) {
-		u32 v = omap_ctrl_readl(dev_data->efuse_nvalues_offs[i]);
+		u32 v;
+		if (cpu_is_omap44xx()) {
+			u16 offset = dev_data->efuse_nvalues_offs[i];
+
+			v = omap_ctrl_readb(offset) |
+				omap_ctrl_readb(offset + 1) << 8 |
+				omap_ctrl_readb(offset + 2) << 16;
+		} else {
+			v = omap_ctrl_readl(dev_data->efuse_nvalues_offs[i]);
+		}
 
 		dev_data->volt_data[i].sr_nvalue = v;
 	}
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 7ba92c2..afc6fed 100644
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

