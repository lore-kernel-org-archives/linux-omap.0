From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 17/23] ARM: OMAP4: control: remove support for legacy padconf APIs
Date: Thu, 27 Nov 2014 17:51:48 +0200
Message-ID: <1417103514-17027-18-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38514 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbaK0PwJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2014 10:52:09 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

These are no longer needed for anything with the introduction of
pinctrl DT support, thus removed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |   23 +----------------------
 arch/arm/mach-omap2/control.h |    5 +----
 arch/arm/mach-omap2/io.c      |   27 +++++++++------------------
 3 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index f9519f1..e664dba 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -33,7 +33,6 @@
 #define PADCONF_SAVE_DONE		0x1
 
 static void __iomem *omap2_ctrl_base;
-static void __iomem *omap4_ctrl_pad_base;
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 struct omap3_scratchpad {
@@ -136,13 +135,10 @@ static struct omap3_control_regs control_context;
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
 
 #define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
-#define OMAP4_CTRL_PAD_REGADDR(reg)	(omap4_ctrl_pad_base + (reg))
 
-void __init omap2_set_globals_control(void __iomem *ctrl,
-				      void __iomem *ctrl_pad)
+void __init omap2_set_globals_control(void __iomem *ctrl)
 {
 	omap2_ctrl_base = ctrl;
-	omap4_ctrl_pad_base = ctrl_pad;
 }
 
 void __iomem *omap_ctrl_base_get(void)
@@ -180,23 +176,6 @@ void omap_ctrl_writel(u32 val, u16 offset)
 	writel_relaxed(val, OMAP_CTRL_REGADDR(offset));
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
index 8a9d97d7..c08c00f 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -436,11 +436,9 @@ extern void __iomem *omap_ctrl_base_get(void);
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
@@ -457,8 +455,7 @@ extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
 void omap3_ctrl_init(void);
 int omap_control_init(void);
-extern void omap2_set_globals_control(void __iomem *ctrl,
-				      void __iomem *ctrl_pad);
+void omap2_set_globals_control(void __iomem *ctrl);
 #else
 #define omap_ctrl_base_get()		0
 #define omap_ctrl_readb(x)		0
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 6a94345..3a61b31 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -384,8 +384,7 @@ void __init omap2420_init_early(void)
 	omap2_set_globals_tap(OMAP242X_CLASS, OMAP2_L4_IO_ADDRESS(0x48014000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE),
-				  NULL);
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE));
 	omap2xxx_check_revision();
 	omap2xxx_prm_init();
 	omap2xxx_cm_init();
@@ -412,8 +411,7 @@ void __init omap2430_init_early(void)
 	omap2_set_globals_tap(OMAP243X_CLASS, OMAP2_L4_IO_ADDRESS(0x4900a000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
-				  NULL);
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE));
 	omap2xxx_check_revision();
 	omap2xxx_prm_init();
 	omap2xxx_cm_init();
@@ -444,8 +442,7 @@ void __init omap3_init_early(void)
 	omap2_set_globals_tap(OMAP343X_CLASS, OMAP2_L4_IO_ADDRESS(0x4830A000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
-				  NULL);
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE));
 	/* XXX: remove these two once OMAP3 is DT only */
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE));
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE), NULL);
@@ -493,8 +490,7 @@ void __init ti81xx_init_early(void)
 {
 	omap2_set_globals_tap(OMAP343X_CLASS,
 			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
-				  NULL);
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE));
 	/* XXX: remove these two once TI81xx is DT only */
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE));
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
@@ -559,8 +555,7 @@ void __init am33xx_init_early(void)
 {
 	omap2_set_globals_tap(AM335X_CLASS,
 			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
-	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
-				  NULL);
+	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE));
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	am33xx_prm_init();
@@ -583,8 +578,7 @@ void __init am43xx_init_early(void)
 {
 	omap2_set_globals_tap(AM335X_CLASS,
 			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
-	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
-				  NULL);
+	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE));
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	omap44xx_prm_init();
@@ -608,8 +602,7 @@ void __init omap4430_init_early(void)
 {
 	omap2_set_globals_tap(OMAP443X_CLASS,
 			      OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
-				  OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
@@ -638,8 +631,7 @@ void __init omap5_init_early(void)
 {
 	omap2_set_globals_tap(OMAP54XX_CLASS,
 			      OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
-				  OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
 	omap44xx_prm_init();
@@ -665,8 +657,7 @@ void __init omap5_init_late(void)
 void __init dra7xx_init_early(void)
 {
 	omap2_set_globals_tap(-1, OMAP2_L4_IO_ADDRESS(DRA7XX_TAP_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
-				  OMAP2_L4_IO_ADDRESS(DRA7XX_CTRL_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
 	omap44xx_prm_init();
-- 
1.7.9.5

