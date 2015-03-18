From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 32/35] ARM: OMAP4+: control: remove support for legacy pad read/write
Date: Wed, 18 Mar 2015 16:44:17 +0200
Message-ID: <1426689860-17537-33-git-send-email-t-kristo@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52483 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964823AbbCROpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2015 10:45:38 -0400
In-Reply-To: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

omap4_ctrl_pad_readl/writel are no longer used by anybody, so remove
these. Syscon / pinctrl should be used to access the padconf area
instead.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |   24 +-----------------------
 arch/arm/mach-omap2/control.h |    5 +----
 arch/arm/mach-omap2/io.c      |   11 ++++-------
 3 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index f756f21..9f96e60 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -36,7 +36,6 @@
 
 static void __iomem *omap2_ctrl_base;
 static s16 omap2_ctrl_offset;
-static void __iomem *omap4_ctrl_pad_base;
 static struct regmap *omap2_ctrl_syscon;
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
@@ -139,13 +138,9 @@ struct omap3_control_regs {
 static struct omap3_control_regs control_context;
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
 
-#define OMAP4_CTRL_PAD_REGADDR(reg)	(omap4_ctrl_pad_base + (reg))
-
-void __init omap2_set_globals_control(void __iomem *ctrl,
-				      void __iomem *ctrl_pad)
+void __init omap2_set_globals_control(void __iomem *ctrl)
 {
 	omap2_ctrl_base = ctrl;
-	omap4_ctrl_pad_base = ctrl_pad;
 }
 
 u8 omap_ctrl_readb(u16 offset)
@@ -218,23 +213,6 @@ void omap_ctrl_writel(u32 val, u16 offset)
 			     val);
 }
 
-/*
- * On OMAP4 control pad are not addressable from control
- * core base. So the common omap_ctrl_read/write APIs breaks
- * Hence export separate APIs to manage the omap4 pad control
- * registers. This APIs will work only for OMAP4
- */
-
-u32 omap4_ctrl_pad_readl(u16 offset)
-{
-	return readl_relaxed(OMAP4_CTRL_PAD_REGADDR(offset));
-}
-
-void omap4_ctrl_pad_writel(u32 val, u16 offset)
-{
-	writel_relaxed(val, OMAP4_CTRL_PAD_REGADDR(offset));
-}
-
 #ifdef CONFIG_ARCH_OMAP3
 
 /**
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index 5353ff4..80d2b7d 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -443,11 +443,9 @@
 extern u8 omap_ctrl_readb(u16 offset);
 extern u16 omap_ctrl_readw(u16 offset);
 extern u32 omap_ctrl_readl(u16 offset);
-extern u32 omap4_ctrl_pad_readl(u16 offset);
 extern void omap_ctrl_writeb(u8 val, u16 offset);
 extern void omap_ctrl_writew(u16 val, u16 offset);
 extern void omap_ctrl_writel(u32 val, u16 offset);
-extern void omap4_ctrl_pad_writel(u32 val, u16 offset);
 
 extern void omap3_save_scratchpad_contents(void);
 extern void omap3_clear_scratchpad_contents(void);
@@ -465,8 +463,7 @@ extern int omap3_ctrl_save_padconf(void);
 void omap3_ctrl_init(void);
 int omap2_control_base_init(void);
 int omap_control_init(void);
-extern void omap2_set_globals_control(void __iomem *ctrl,
-				      void __iomem *ctrl_pad);
+void omap2_set_globals_control(void __iomem *ctrl);
 void __init omap3_control_legacy_iomap_init(void);
 #else
 #define omap_ctrl_readb(x)		0
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index c3fa739..6c39cc0 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -443,7 +443,7 @@ void __init omap3_init_early(void)
 	/* XXX: remove these once OMAP3 is DT only */
 	if (!of_have_populated_dt()) {
 		omap2_set_globals_control(
-			OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE), NULL);
+			OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE));
 		omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE));
 		omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
 				     NULL);
@@ -631,8 +631,7 @@ void __init omap4430_init_early(void)
 {
 	omap2_set_globals_tap(OMAP443X_CLASS,
 			      OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
-				  OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
@@ -660,8 +659,7 @@ void __init omap5_init_early(void)
 {
 	omap2_set_globals_tap(OMAP54XX_CLASS,
 			      OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
-				  OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
 	omap2_prcm_base_init();
@@ -686,8 +684,7 @@ void __init omap5_init_late(void)
 void __init dra7xx_init_early(void)
 {
 	omap2_set_globals_tap(-1, OMAP2_L4_IO_ADDRESS(DRA7XX_TAP_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
-				  OMAP2_L4_IO_ADDRESS(DRA7XX_CTRL_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
 	omap2_prcm_base_init();
-- 
1.7.9.5

