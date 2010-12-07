From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/14] OMAP3: control/PRCM: move CONTROL_PADCONF_SYS_NIRQ
	save/restore to SCM code
Date: Mon, 06 Dec 2010 18:25:14 -0700
Message-ID: <20101207012512.3708.64651.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41237 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab0LGBnz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 20:43:55 -0500
In-Reply-To: <20101207012242.3708.45451.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

For some reason, the PRCM context save/restore code also saves and
restores a single System Control Module register,
CONTROL_PADCONF_SYS_NIRQ.  This is probably just an error -- the
register should be handled by SCM code -- so this patch moves it
there.

If this register really does need to be saved and restored before the
rest of the PRCM registers, the code to do so should live in the SCM
code, and the PM code should call this separate function.  This
register pertains to devices with a stacked modem, so this patch is
unlikely to affect most OMAP devices out there.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/control.c |    5 +++++
 arch/arm/mach-omap2/prcm.c    |    5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 9fda3d7..b260e1b 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -134,6 +134,7 @@ struct omap3_control_regs {
 	u32 sramldo4;
 	u32 sramldo5;
 	u32 csi;
+	u32 padconf_sys_nirq;
 };
 
 static struct omap3_control_regs control_context;
@@ -447,6 +448,8 @@ void omap3_control_save_context(void)
 	control_context.sramldo4 = omap_ctrl_readl(OMAP343X_CONTROL_SRAMLDO4);
 	control_context.sramldo5 = omap_ctrl_readl(OMAP343X_CONTROL_SRAMLDO5);
 	control_context.csi = omap_ctrl_readl(OMAP343X_CONTROL_CSI);
+	control_context.padconf_sys_nirq =
+		omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_SYSNIRQ);
 	return;
 }
 
@@ -503,6 +506,8 @@ void omap3_control_restore_context(void)
 	omap_ctrl_writel(control_context.sramldo4, OMAP343X_CONTROL_SRAMLDO4);
 	omap_ctrl_writel(control_context.sramldo5, OMAP343X_CONTROL_SRAMLDO5);
 	omap_ctrl_writel(control_context.csi, OMAP343X_CONTROL_CSI);
+	omap_ctrl_writel(control_context.padconf_sys_nirq,
+			 OMAP343X_CONTROL_PADCONF_SYSNIRQ);
 	return;
 }
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 2eca847..d27cdba 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -42,7 +42,6 @@ static void __iomem *cm2_base;
 #define MAX_MODULE_ENABLE_WAIT		100000
 
 struct omap3_prcm_regs {
-	u32 control_padconf_sys_nirq;
 	u32 iva2_cm_clksel1;
 	u32 iva2_cm_clksel2;
 	u32 cm_sysconfig;
@@ -312,8 +311,6 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 #ifdef CONFIG_ARCH_OMAP3
 void omap3_prcm_save_context(void)
 {
-	prcm_context.control_padconf_sys_nirq =
-			 omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_SYSNIRQ);
 	prcm_context.iva2_cm_clksel1 =
 			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
 	prcm_context.iva2_cm_clksel2 =
@@ -466,8 +463,6 @@ void omap3_prcm_save_context(void)
 
 void omap3_prcm_restore_context(void)
 {
-	omap_ctrl_writel(prcm_context.control_padconf_sys_nirq,
-					 OMAP343X_CONTROL_PADCONF_SYSNIRQ);
 	cm_write_mod_reg(prcm_context.iva2_cm_clksel1, OMAP3430_IVA2_MOD,
 					 CM_CLKSEL1);
 	cm_write_mod_reg(prcm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,


