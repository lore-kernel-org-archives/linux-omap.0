From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH] AM35xx: Add clock support for new modules on AM35xx
Date: Wed, 16 Dec 2009 19:27:03 +0530
Message-ID: <1260971823-8532-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40151 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932972AbZLPN5K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 08:57:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, ranjithl@ti.com

This patch adds clock support for the following AM35xx modules
	- Ethernet MAC
	- CAN Controller (HECC)
	- New MUSB OTG Controller with integrated Phy
	- Video Processing Front End (VPFE)
	- Additional UART (UART4)

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
 arch/arm/mach-omap2/clock34xx_data.c  |   93 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm-regbits-34xx.h |    6 ++
 2 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 043caed..d7942b3 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -2983,6 +2983,91 @@ static struct clk wdt1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+/* Clocks for AM35XX */
+static struct clk emac_ick = {
+	.name       = "emac_ick",
+	.ops        = &clkops_omap2_dflt,
+	.parent     = &core_l3_ick,
+	.clkdm_name = "core_l3_clkdm",
+	.enable_reg = OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit = AM35XX_CPGMAC_VBUSP_CLK_SHIFT,
+	.recalc     = &followparent_recalc,
+};
+
+static struct clk emac_fck = {
+	.name       = "emac_fck",
+	.ops        = &clkops_omap2_dflt,
+	.clkdm_name = "core_l3_clkdm",
+	.rate       = 50000000,
+	.enable_reg = OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit = AM35XX_CPGMAC_FCLK_SHIFT,
+	.recalc     = &omap2_clksel_recalc,
+};
+
+static struct clk hsotgusb_ick_am35xx = {
+	.name       = "hsotgusb_ick",
+	.ops        = &clkops_omap2_dflt,
+	.parent     = &core_l3_ick,
+	.clkdm_name = "core_l3_clkdm",
+	.enable_reg = OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit = AM35XX_USBOTG_VBUSP_CLK_SHIFT,
+	.recalc     = &followparent_recalc,
+};
+
+static struct clk hsotgusb_fck_am35xx = {
+	.name       = "hsotgusb_fck",
+	.ops        = &clkops_omap2_dflt,
+	.parent     = &sys_ck,
+	.clkdm_name = "core_l3_clkdm",
+	.enable_reg = OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit = AM35XX_USBOTG_FCLK_SHIFT,
+	.recalc     = &followparent_recalc,
+};
+
+static struct clk hecc_ck = {
+	.name       = "hecc_ck",
+	.ops        = &clkops_omap2_dflt,
+	.parent     = &sys_ck,
+	.clkdm_name = "core_l3_clkdm",
+	.enable_reg = OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit = AM35XX_HECC_VBUSP_CLK_SHIFT,
+	.recalc     = &followparent_recalc,
+};
+
+static struct clk vpfe_ick = {
+	.name       = "vpfe_ick",
+	.ops        = &clkops_omap2_dflt,
+	.parent     = &core_l3_ick,
+	.clkdm_name = "core_l3_clkdm",
+	.enable_reg = OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit = AM35XX_VPFE_VBUSP_CLK_SHIFT,
+	.recalc     = &followparent_recalc,
+};
+
+static struct clk vpfe_fck = {
+	.name       = "vpfe_fck",
+	.ops        = &clkops_omap2_dflt,
+	.clkdm_name = "core_l3_clkdm",
+	.rate       = 27000000,
+	.enable_reg = OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit = AM35XX_VPFE_FCLK_SHIFT,
+	.recalc     = &omap2_clksel_recalc,
+};
+
+/*
+ * The UART1/2 functional clock acts as the functional
+ * clock for UART4. No separate fclk control available.
+ */
+static struct clk uart4_ick = {
+	.name       = "uart4_ick",
+	.ops        = &clkops_omap2_dflt_wait,
+	.parent     = &core_l4_ick,
+	.enable_reg = OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit = AM35XX_EN_UART4_SHIFT,
+	.clkdm_name = "core_l4_clkdm",
+	.recalc     = &followparent_recalc,
+};
+
 
 /*
  * clkdev
@@ -3209,6 +3294,14 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_3XXX),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
 	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_3XXX),
+	CLK("davinci_emac", "ick", &emac_ick, CK_AM35XX),
+	CLK("davinci_emac", "fck", &emac_fck, CK_AM35XX),
+	CLK("musb_hdrc", "ick", &hsotgusb_ick_am35xx, CK_AM35XX),
+	CLK("musb_hdrc", "fck", &hsotgusb_fck_am35xx, CK_AM35XX),
+	CLK(NULL, "hecc_ck", &hecc_ck, CK_AM35XX),
+	CLK("vpfe-capture", "master", &vpfe_ick, CK_AM35XX),
+	CLK("vpfe-capture", "slave", &vpfe_fck, CK_AM35XX),
+	CLK(NULL, "uart4_ick", &uart4_ick, CK_AM35XX),
 };
 
 
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 6923deb..39caf48 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -168,6 +168,12 @@
 #define OMAP3430_EN_SDRC				(1 << 1)
 #define OMAP3430_EN_SDRC_SHIFT				1
 
+/*
+ * On AM35XX MSPro is replaced by another UART (UART4)
+ */
+#define AM35XX_EN_UART4					(1 << 23)
+#define AM35XX_EN_UART4_SHIFT				23
+
 /* CM_ICLKEN2_CORE */
 #define OMAP3430_EN_PKA					(1 << 4)
 #define OMAP3430_EN_PKA_SHIFT				4
-- 
1.6.2.4

