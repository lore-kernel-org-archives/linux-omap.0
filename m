From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 08/10] OMAP4: Smartreflex framework extensions
Date: Wed, 18 Aug 2010 16:46:29 +0530
Message-ID: <1282130191-9062-9-git-send-email-thara@ti.com>
References: <1282130191-9062-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41073 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769Ab0HRLQp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:16:45 -0400
In-Reply-To: <1282130191-9062-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

This patch extends the smartreflex framework to support
OMAP4. The changes are minor like compiling smartreflex Kconfig
option for OMAP4 also, and a couple of OMAP4 checks in
the smartreflex framework.

The change in sr_device.c where new logic has to be introduced
for reading the efuse registers are due to two reasons.
	a. Currently in mainline OMAP4 control base offset is actually
	from the mux/padconf module start. Hence a omap_ctrl_read will
	not read from the correct offset for the efuse registers.
	This is currently being fixed through modfications in the
	control layer but till that is finalised, we will have to do
	a ioremap of the general control module  base and do a
	__raw_read to retrieve the efuse values.

	b. In OMAP4 the efuse registers are 24 bit aligned. Hence
	   a __raw_readl will fail for non-32 bit aligned address.
	   Hence the 8-bit read and shift.

Signed-off-by: Thara Gopinath <thara@ti.com>
---

This patch has a checkpatch warning which has been already
acknowledged as a false positive by the checkpatch.pl
maintainer Andy Whitcroft
	http://lkml.org/lkml/2010/8/18/123	

 arch/arm/mach-omap2/smartreflex.c |    7 +++++--
 arch/arm/mach-omap2/sr_device.c   |   21 +++++++++++++++++++--
 arch/arm/plat-omap/Kconfig        |    2 +-
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index bc611d1..2e13c96 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -154,7 +154,10 @@ static void sr_set_clk_length(struct omap_sr *sr)
 	struct clk *sys_ck;
 	u32 sys_clk_speed;
 
-	sys_ck = clk_get(NULL, "sys_ck");
+	if (cpu_is_omap34xx())
+		sys_ck = clk_get(NULL, "sys_ck");
+	else
+		sys_ck = clk_get(NULL, "sys_clkin_ck");
 	sys_clk_speed = clk_get_rate(sys_ck);
 	clk_put(sys_ck);
 
@@ -189,7 +192,7 @@ static void sr_set_regfields(struct omap_sr *sr)
 	 * file or pmic specific data structure. In that case these structure
 	 * fields will have to be populated using the pdata or pmic structure.
 	 */
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		sr->err_weight = OMAP3430_SR_ERRWEIGHT;
 		sr->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
 		sr->accum_data = OMAP3430_SR_ACCUMDATA;
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 3bd0170..f0181d1 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -20,6 +20,7 @@
 
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 
 #include <plat/control.h>
 #include <plat/omap_hwmod.h>
@@ -41,6 +42,7 @@ static void __init sr_read_efuse(struct omap_sr_dev_data *dev_data,
 				struct omap_sr_data *sr_data)
 {
 	int i;
+	void __iomem *ctrl_base;
 
 	if (!dev_data || !dev_data->volts_supported || !dev_data->volt_data ||
 			!dev_data->efuse_nvalues_offs) {
@@ -72,9 +74,24 @@ static void __init sr_read_efuse(struct omap_sr_dev_data *dev_data,
 				dev_data->senpenable_shift);
 	}
 
-	for (i = 0; i < dev_data->volts_supported; i++)
-		dev_data->volt_data[i].sr_nvalue = omap_ctrl_readl(
+	if (cpu_is_omap44xx())
+		ctrl_base =  ioremap(0x4A002000, SZ_1K);
+
+	for (i = 0; i < dev_data->volts_supported; i++) {
+		if (cpu_is_omap44xx()) {
+			u16 offset = dev_data->efuse_nvalues_offs[i];
+
+			dev_data->volt_data[i].sr_nvalue =
+				__raw_readb(ctrl_base + offset) |
+				__raw_readb(ctrl_base + offset + 1) << 8 |
+				__raw_readb(ctrl_base + offset + 2) << 16;
+		} else {
+			dev_data->volt_data[i].sr_nvalue = omap_ctrl_readl(
 				dev_data->efuse_nvalues_offs[i]);
+		}
+	}
+	if (cpu_is_omap44xx())
+		iounmap(ctrl_base);
 }
 
 /*
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index af7acc9..b4e9ac2 100644
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
1.7.1.GIT

