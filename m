From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 33/33] ARM: OMAP4+: control: add support for initializing control module via DT
Date: Fri, 13 Feb 2015 18:12:52 +0200
Message-ID: <1423843973-6050-31-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54322 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838AbbBMQOo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:14:44 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

OMAP4, OMAP5 and DRA7 now parse DT entries for control module address spaces,
and set up syscon mappings appropriately. Low level IO init is updated to
remove the legacy control module mappings for these devices also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |   44 +++++++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/io.c      |    9 +++------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index a6d987b..d223aa45 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -35,8 +35,8 @@
 #define PADCONF_SAVE_DONE		0x1
 
 static void __iomem *omap2_ctrl_base;
-static void __iomem *omap4_ctrl_pad_base;
 static struct regmap *omap2_ctrl_syscon;
+static struct regmap *omap4_ctrl_pad_syscon;
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 struct omap3_scratchpad {
@@ -138,13 +138,10 @@ struct omap3_control_regs {
 static struct omap3_control_regs control_context;
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
 
-#define OMAP4_CTRL_PAD_REGADDR(reg)	(omap4_ctrl_pad_base + (reg))
-
 void __init omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad)
 {
 	omap2_ctrl_base = ctrl;
-	omap4_ctrl_pad_base = ctrl_pad;
 }
 
 u8 omap_ctrl_readb(u16 offset)
@@ -225,12 +222,15 @@ void omap_ctrl_writel(u32 val, u16 offset)
 
 u32 omap4_ctrl_pad_readl(u16 offset)
 {
-	return readl_relaxed(OMAP4_CTRL_PAD_REGADDR(offset));
+	u32 val;
+
+	regmap_read(omap4_ctrl_pad_syscon, offset, &val);
+	return val;
 }
 
 void omap4_ctrl_pad_writel(u32 val, u16 offset)
 {
-	writel_relaxed(val, OMAP4_CTRL_PAD_REGADDR(offset));
+	regmap_write(omap4_ctrl_pad_syscon, offset, val);
 }
 
 #ifdef CONFIG_ARCH_OMAP3
@@ -658,11 +658,30 @@ static const struct control_init_data ctrl_data = {
 	.index = CLK_MEMMAP_INDEX_CTRL,
 };
 
+static const struct control_init_data omap4_ctrl_gen_core_data = {
+	.index = CLK_MEMMAP_INDEX_CTRL,
+};
+
+static const struct control_init_data omap4_ctrl_pad_core_data = {
+};
+
 static struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,am3-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,am4-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,omap2-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,omap3-scrm", .data = &ctrl_data },
+	{ .compatible = "ti,omap4-ctrl-gen-core",
+	  .data = &omap4_ctrl_gen_core_data },
+	{ .compatible = "ti,omap4-ctrl-pad-core",
+	  .data = &omap4_ctrl_pad_core_data },
+	{ .compatible = "ti,omap5-ctrl-gen-core",
+	  .data = &omap4_ctrl_gen_core_data },
+	{ .compatible = "ti,omap5-ctrl-pad-core",
+	  .data = &omap4_ctrl_pad_core_data },
+	{ .compatible = "ti,dra7-ctrl-gen-core",
+	  .data = &omap4_ctrl_gen_core_data },
+	{ .compatible = "ti,dra7-ctrl-pad-core",
+	  .data = &omap4_ctrl_pad_core_data },
 	{ }
 };
 
@@ -682,6 +701,13 @@ int __init omap2_control_base_init(void)
 	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
 		data = match->data;
 
+		/*
+		 * Only setup omap2_ctrl_base for base index, omap4+ has
+		 * padconf mapping also
+		 */
+		if (data->index != CLK_MEMMAP_INDEX_CTRL)
+			continue;
+
 		omap2_ctrl_base = of_iomap(np, 0);
 		if (!omap2_ctrl_base)
 			return -ENOMEM;
@@ -711,6 +737,10 @@ int __init omap_control_init(void)
 		if (IS_ERR(syscon))
 			return PTR_ERR(syscon);
 
+		/*
+		 * Setup appropriate syscon mapping; omap4+ is currently
+		 * using two of these, separate ones for generic + padconf
+		 */
 		if (data->index == CLK_MEMMAP_INDEX_CTRL) {
 			omap2_ctrl_syscon = syscon;
 
@@ -721,6 +751,8 @@ int __init omap_control_init(void)
 
 			iounmap(omap2_ctrl_base);
 			omap2_ctrl_base = NULL;
+		} else {
+			omap4_ctrl_pad_syscon = syscon;
 		}
 	}
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5e100ed..0b6b20c 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -611,9 +611,8 @@ void __init omap4430_init_early(void)
 {
 	omap2_set_globals_tap(OMAP443X_CLASS,
 			      OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
-				  OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
+	omap2_control_base_init();
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
 	omap2_prcm_base_init();
@@ -640,9 +639,8 @@ void __init omap5_init_early(void)
 {
 	omap2_set_globals_tap(OMAP54XX_CLASS,
 			      OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
-				  OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
+	omap2_control_base_init();
 	omap4_pm_init_early();
 	omap2_prcm_base_init();
 	omap5xxx_check_revision();
@@ -666,9 +664,8 @@ void __init omap5_init_late(void)
 void __init dra7xx_init_early(void)
 {
 	omap2_set_globals_tap(-1, OMAP2_L4_IO_ADDRESS(DRA7XX_TAP_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
-				  OMAP2_L4_IO_ADDRESS(DRA7XX_CTRL_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
+	omap2_control_base_init();
 	omap4_pm_init_early();
 	omap2_prcm_base_init();
 	dra7xxx_check_revision();
-- 
1.7.9.5

