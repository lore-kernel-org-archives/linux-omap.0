From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 18/33] ARM: OMAP4+: PRM: determine prm_device_inst based on DT compatibility
Date: Fri, 13 Feb 2015 18:12:37 +0200
Message-ID: <1423843973-6050-16-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54288 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692AbbBMQOK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:14:10 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

PRM device instance offset is now provided through the prm_init_data.
This gets rid of some cpu_is_X / soc_is_X calls from PRM core code,
preparing for PRM to be its own separate driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h |    2 ++
 arch/arm/mach-omap2/prm44xx.c     |    2 ++
 arch/arm/mach-omap2/prm_common.c  |   28 +++++++++++++++++++++++++---
 arch/arm/mach-omap2/prminst44xx.c |   18 +++++-------------
 arch/arm/mach-omap2/prminst44xx.h |    1 +
 5 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 78b511a..3757be2 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -525,6 +525,7 @@ struct of_device_id;
  * @mem: IO mem pointer for this module
  * @offset: module base address offset from the IO base
  * @flags: PRCM module init flags
+ * @device_inst_offset: device instance offset within the module address space
  * @init: low level PRCM init function for this module
  * @np: device node for this PRCM module
  */
@@ -533,6 +534,7 @@ struct omap_prcm_init_data {
 	void __iomem *mem;
 	s16 offset;
 	u16 flags;
+	s32 device_inst_offset;
 	int (*init)(const struct omap_prcm_init_data *data);
 	struct device_node *np;
 };
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index e179dbe..1994dcc 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -712,6 +712,8 @@ int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
 	if (!soc_is_dra7xx())
 		prm_features |= PRM_HAS_VOLTAGE;
 
+	omap4_prminst_set_prm_dev_inst(data->device_inst_offset);
+
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index b2e1eee..0fc2da9 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -34,6 +34,9 @@
 #include "prm3xxx.h"
 #include "prm33xx.h"
 #include "prm44xx.h"
+#include "prm54xx.h"
+#include "prm7xx.h"
+#include "prcm43xx.h"
 #include "common.h"
 #include "clock.h"
 #include "cm.h"
@@ -647,6 +650,25 @@ static struct omap_prcm_init_data am3_prm_data __initdata = {
 static struct omap_prcm_init_data omap4_prm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_PRM,
 	.init = omap44xx_prm_init,
+	.device_inst_offset = OMAP4430_PRM_DEVICE_INST,
+};
+
+static struct omap_prcm_init_data omap5_prm_data __initdata = {
+	.index = CLK_MEMMAP_INDEX_PRM,
+	.init = omap44xx_prm_init,
+	.device_inst_offset = OMAP54XX_PRM_DEVICE_INST,
+};
+
+static struct omap_prcm_init_data dra7_prm_data __initdata = {
+	.index = CLK_MEMMAP_INDEX_PRM,
+	.init = omap44xx_prm_init,
+	.device_inst_offset = DRA7XX_PRM_DEVICE_INST,
+};
+
+static struct omap_prcm_init_data am4_prm_data __initdata = {
+	.index = CLK_MEMMAP_INDEX_PRM,
+	.init = omap44xx_prm_init,
+	.device_inst_offset = AM43XX_PRM_DEVICE_INST,
 };
 
 static struct omap_prcm_init_data scrm_data __initdata = {
@@ -655,14 +677,14 @@ static struct omap_prcm_init_data scrm_data __initdata = {
 
 static struct of_device_id omap_prcm_dt_match_table[] __initdata = {
 	{ .compatible = "ti,am3-prcm", .data = &am3_prm_data },
-	{ .compatible = "ti,am4-prcm", .data = &omap4_prm_data },
+	{ .compatible = "ti,am4-prcm", .data = &am4_prm_data },
 	{ .compatible = "ti,omap2-prcm", .data = &omap2_prm_data },
 	{ .compatible = "ti,omap3-prm", .data = &omap3_prm_data },
 	{ .compatible = "ti,omap4-prm", .data = &omap4_prm_data },
 	{ .compatible = "ti,omap4-scrm", .data = &scrm_data },
-	{ .compatible = "ti,omap5-prm", .data = &omap4_prm_data },
+	{ .compatible = "ti,omap5-prm", .data = &omap5_prm_data },
 	{ .compatible = "ti,omap5-scrm", .data = &scrm_data },
-	{ .compatible = "ti,dra7-prm", .data = &omap4_prm_data },
+	{ .compatible = "ti,dra7-prm", .data = &dra7_prm_data },
 	{ }
 };
 
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 8adf7b1..c4859c4 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -47,22 +47,14 @@ void omap_prm_base_init(void)
 
 s32 omap4_prmst_get_prm_dev_inst(void)
 {
-	if (prm_dev_inst != PRM_INSTANCE_UNKNOWN)
-		return prm_dev_inst;
-
-	/* This cannot be done way early at boot.. as things are not setup */
-	if (cpu_is_omap44xx())
-		prm_dev_inst = OMAP4430_PRM_DEVICE_INST;
-	else if (soc_is_omap54xx())
-		prm_dev_inst = OMAP54XX_PRM_DEVICE_INST;
-	else if (soc_is_dra7xx())
-		prm_dev_inst = DRA7XX_PRM_DEVICE_INST;
-	else if (soc_is_am43xx())
-		prm_dev_inst = AM43XX_PRM_DEVICE_INST;
-
 	return prm_dev_inst;
 }
 
+void omap4_prminst_set_prm_dev_inst(s32 dev_inst)
+{
+	prm_dev_inst = dev_inst;
+}
+
 /* Read a register in a PRM instance */
 u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 {
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prminst44xx.h
index fb1c9d7..0c03d07 100644
--- a/arch/arm/mach-omap2/prminst44xx.h
+++ b/arch/arm/mach-omap2/prminst44xx.h
@@ -14,6 +14,7 @@
 
 #define PRM_INSTANCE_UNKNOWN	-1
 extern s32 omap4_prmst_get_prm_dev_inst(void);
+void omap4_prminst_set_prm_dev_inst(s32 dev_inst);
 
 /*
  * In an ideal world, we would not export these low-level functions,
-- 
1.7.9.5

