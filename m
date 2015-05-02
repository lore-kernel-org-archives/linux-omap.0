From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: OMAP3: Add support for configuring MMC pins as GPIO pins
Date: Fri,  1 May 2015 18:05:51 -0700
Message-ID: <1430528752-316-2-git-send-email-tony@atomide.com>
References: <1430528752-316-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ftx-008-i767.relay.mailchannels.net ([50.61.143.67]:3055 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751375AbbEBBGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2015 21:06:08 -0400
In-Reply-To: <1430528752-316-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tim Nordell <tim.nordell@logicpd.com>

Some devices are using the MMC1 pins 4..8 as GPIO pins, and in
this case they need to be configured for 1.8V IO voltage if not
done by the bootloader as otherwise some devices like smsc911x
won't work properly.

Let's also make sure this register is saved and restored for
idle.

Cc: Tim Nordell <tim.nordell@logicpd.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/control.c      |  3 +++
 arch/arm/mach-omap2/control.h      |  3 +++
 arch/arm/mach-omap2/pdata-quirks.c | 22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index af95a62..f008930 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -112,6 +112,7 @@ struct omap3_control_regs {
 	u32 csirxfe;
 	u32 iva2_bootaddr;
 	u32 iva2_bootmod;
+	u32 wkup_ctrl;
 	u32 debobs_0;
 	u32 debobs_1;
 	u32 debobs_2;
@@ -455,6 +456,7 @@ void omap3_control_save_context(void)
 			omap_ctrl_readl(OMAP343X_CONTROL_IVA2_BOOTADDR);
 	control_context.iva2_bootmod =
 			omap_ctrl_readl(OMAP343X_CONTROL_IVA2_BOOTMOD);
+	control_context.wkup_ctrl = omap_ctrl_readl(OMAP34XX_CONTROL_WKUP_CTRL);
 	control_context.debobs_0 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS(0));
 	control_context.debobs_1 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS(1));
 	control_context.debobs_2 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS(2));
@@ -512,6 +514,7 @@ void omap3_control_restore_context(void)
 					OMAP343X_CONTROL_IVA2_BOOTADDR);
 	omap_ctrl_writel(control_context.iva2_bootmod,
 					OMAP343X_CONTROL_IVA2_BOOTMOD);
+	omap_ctrl_writel(control_context.wkup_ctrl, OMAP34XX_CONTROL_WKUP_CTRL);
 	omap_ctrl_writel(control_context.debobs_0, OMAP343X_CONTROL_DEBOBS(0));
 	omap_ctrl_writel(control_context.debobs_1, OMAP343X_CONTROL_DEBOBS(1));
 	omap_ctrl_writel(control_context.debobs_2, OMAP343X_CONTROL_DEBOBS(2));
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index 80d2b7d..ec406bc 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -231,6 +231,9 @@
 #define OMAP343X_PADCONF_ETK_D15	OMAP343X_PADCONF_ETK(17)
 
 /* 34xx GENERAL_WKUP register offsets */
+#define OMAP34XX_CONTROL_WKUP_CTRL	(OMAP343X_CONTROL_GENERAL_WKUP - 0x4)
+#define OMAP36XX_GPIO_IO_PWRDNZ		BIT(6)
+
 #define OMAP343X_CONTROL_WKUP_DEBOBSMUX(i) (OMAP343X_CONTROL_GENERAL_WKUP + \
 						0x008 + (i))
 #define OMAP343X_CONTROL_WKUP_DEBOBS0 (OMAP343X_CONTROL_GENERAL_WKUP + 0x008)
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index af11511..a74612b 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -44,6 +44,27 @@ static void __init omap2420_n8x0_legacy_init(void)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
+/*
+ * Configures GPIOs 126 to 129 to 1.8V mode instead of 3.0V
+ * mode for MMC1 in case bootloader did not configure things.
+ * Note that if the pins are used for MMC1, pbias-regulator
+ * manages the IO voltage.
+ */
+static void __init omap3_gpio126_129(void)
+{
+	u32 reg;
+
+	reg = omap_ctrl_readl(OMAP343X_CONTROL_PBIAS_LITE);
+	reg &= ~OMAP343X_PBIASLITEVMODE1;
+	reg |= OMAP343X_PBIASLITEPWRDNZ1;
+	omap_ctrl_writel(reg, OMAP343X_CONTROL_PBIAS_LITE);
+	if (cpu_is_omap3630()) {
+		reg = omap_ctrl_readl(OMAP34XX_CONTROL_WKUP_CTRL);
+		reg |= OMAP36XX_GPIO_IO_PWRDNZ;
+		omap_ctrl_writel(reg, OMAP34XX_CONTROL_WKUP_CTRL);
+	}
+}
+
 static void __init hsmmc2_internal_input_clk(void)
 {
 	u32 reg;
@@ -356,6 +377,7 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
 	{ "isee,omap3-igep0020-rev-f", omap3_igep0020_rev_f_legacy_init, },
 	{ "isee,omap3-igep0030-rev-g", omap3_igep0030_rev_g_legacy_init, },
+	{ "logicpd,dm3730-torpedo-devkit", omap3_gpio126_129, },
 	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
 	{ "ti,am3517-evm", am3517_evm_legacy_init, },
 	{ "technexion,omap3-tao3530", omap3_tao3530_legacy_init, },
-- 
2.1.4

