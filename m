From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/19] AM35xx: Add clock support for new modules on AM35xx
Date: Mon, 15 Feb 2010 18:24:50 -0700
Message-ID: <20100216012449.1101.58722.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57419 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932493Ab0BPB07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:26:59 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ranjith Lohithakshan <ranjithl@ti.com>

From: Ranjith Lohithakshan <ranjithl@ti.com>

This patch adds clock support for the following AM35xx modules
	- Ethernet MAC
	- CAN Controller (HECC)
	- New MUSB OTG Controller with integrated Phy
	- Video Processing Front End (VPFE)
	- Additional UART (UART4)

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c       |   93 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock34xx.h       |    4 +
 arch/arm/mach-omap2/clock34xx_data.c  |  118 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm-regbits-34xx.h |   10 +++
 4 files changed, 225 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index d339d2b..6180a03 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -39,6 +39,16 @@
  */
 #define DPLL5_FREQ_FOR_USBHOST		120000000
 
+/*
+ * In AM35xx IPSS, the {ICK,FCK} enable bits for modules are exported
+ * in the same register at a bit offset of 0x8. The EN_ACK for ICK is
+ * at an offset of 4 from ICK enable bit.
+ */
+#define AM35XX_IPSS_ICK_MASK			0xF
+#define AM35XX_IPSS_ICK_EN_ACK_OFFSET 	0x4
+#define AM35XX_IPSS_ICK_FCK_OFFSET		0x8
+#define AM35XX_IPSS_CLK_IDLEST_VAL		0
+
 /* needed by omap3_core_dpll_m2_set_rate() */
 struct clk *sdrc_ick_p, *arm_fck_p;
 
@@ -144,6 +154,89 @@ const struct clkops clkops_noncore_dpll_ops = {
 	.disable	= omap3_noncore_dpll_disable,
 };
 
+/**
+ * am35xx_clk_find_idlest - return clock ACK info for AM35XX IPSS
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
+ *
+ * The interface clocks on AM35xx IPSS reflects the clock idle status
+ * in the enable register itsel at a bit offset of 4 from the enable
+ * bit. A value of 1 indicates that clock is enabled.
+ */
+static void am35xx_clk_find_idlest(struct clk *clk,
+					    void __iomem **idlest_reg,
+					    u8 *idlest_bit,
+					    u8 *idlest_val)
+{
+	*idlest_reg = (__force void __iomem *)(clk->enable_reg);
+	*idlest_bit = clk->enable_bit + AM35XX_IPSS_ICK_EN_ACK_OFFSET;
+	*idlest_val = AM35XX_IPSS_CLK_IDLEST_VAL;
+}
+
+/**
+ * am35xx_clk_find_companion - find companion clock to @clk
+ * @clk: struct clk * to find the companion clock of
+ * @other_reg: void __iomem ** to return the companion clock CM_*CLKEN va in
+ * @other_bit: u8 ** to return the companion clock bit shift in
+ *
+ * Some clocks don't have companion clocks.  For example, modules with
+ * only an interface clock (such as HECC) don't have a companion
+ * clock.  Right now, this code relies on the hardware exporting a bit
+ * in the correct companion register that indicates that the
+ * nonexistent 'companion clock' is active.  Future patches will
+ * associate this type of code with per-module data structures to
+ * avoid this issue, and remove the casts.  No return value.
+ */
+static void am35xx_clk_find_companion(struct clk *clk, void __iomem **other_reg,
+					    u8 *other_bit)
+{
+	*other_reg = (__force void __iomem *)(clk->enable_reg);
+	if (clk->enable_bit & AM35XX_IPSS_ICK_MASK)
+		*other_bit = clk->enable_bit + AM35XX_IPSS_ICK_FCK_OFFSET;
+	else
+		*other_bit = clk->enable_bit - AM35XX_IPSS_ICK_FCK_OFFSET;
+}
+
+const struct clkops clkops_am35xx_ipss_module_wait = {
+	.enable		= omap2_dflt_clk_enable,
+	.disable	= omap2_dflt_clk_disable,
+	.find_idlest	= am35xx_clk_find_idlest,
+	.find_companion	= am35xx_clk_find_companion,
+};
+
+/**
+ * am35xx_clk_ipss_find_idlest - return CM_IDLEST info for IPSS
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
+ *
+ * The IPSS target CM_IDLEST bit is at a different shift from the
+ * CM_{I,F}CLKEN bit.  Pass back the correct info via @idlest_reg
+ * and @idlest_bit.  No return value.
+ */
+static void am35xx_clk_ipss_find_idlest(struct clk *clk,
+					    void __iomem **idlest_reg,
+					    u8 *idlest_bit,
+					    u8 *idlest_val)
+{
+	u32 r;
+
+	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
+	*idlest_reg = (__force void __iomem *)r;
+	*idlest_bit = AM35XX_ST_IPSS_SHIFT;
+	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
+}
+
+const struct clkops clkops_am35xx_ipss_wait = {
+	.enable		= omap2_dflt_clk_enable,
+	.disable	= omap2_dflt_clk_disable,
+	.find_idlest	= am35xx_clk_ipss_find_idlest,
+	.find_companion	= omap2_clk_dflt_find_companion,
+};
+
 int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 {
 	/*
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 73f2109..e61e653 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -22,4 +22,8 @@ extern const struct clkops clkops_omap3430es2_hsotgusb_wait;
 extern const struct clkops clkops_omap3430es2_dss_usbhost_wait;
 extern const struct clkops clkops_noncore_dpll_ops;
 
+/* AM35xx-specific clkops */
+extern const struct clkops clkops_am35xx_ipss_module_wait;
+extern const struct clkops clkops_am35xx_ipss_wait;
+
 #endif
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 0d04f92..d9d5b2e 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -2983,6 +2983,113 @@ static struct clk wdt1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+/* Clocks for AM35XX */
+static struct clk ipss_ick = {
+	.name		= "ipss_ick",
+	.ops		= &clkops_am35xx_ipss_wait,
+	.parent		= &core_l3_ick,
+	.clkdm_name	= "core_l3_clkdm",
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= AM35XX_EN_IPSS_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk emac_ick = {
+	.name		= "emac_ick",
+	.ops		= &clkops_am35xx_ipss_module_wait,
+	.parent		= &ipss_ick,
+	.clkdm_name	= "core_l3_clkdm",
+	.enable_reg	= OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit	= AM35XX_CPGMAC_VBUSP_CLK_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk rmii_ck = {
+	.name		= "rmii_ck",
+	.ops		= &clkops_null,
+	.flags		= RATE_FIXED,
+	.rate		= 50000000,
+};
+
+static struct clk emac_fck = {
+	.name		= "emac_fck",
+	.ops		= &clkops_omap2_dflt,
+	.parent		= &rmii_ck,
+	.enable_reg	= OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit	= AM35XX_CPGMAC_FCLK_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk hsotgusb_ick_am35xx = {
+	.name		= "hsotgusb_ick",
+	.ops		= &clkops_am35xx_ipss_module_wait,
+	.parent		= &ipss_ick,
+	.clkdm_name	= "core_l3_clkdm",
+	.enable_reg	= OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit	= AM35XX_USBOTG_VBUSP_CLK_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk hsotgusb_fck_am35xx = {
+	.name		= "hsotgusb_fck",
+	.ops		= &clkops_omap2_dflt,
+	.parent		= &sys_ck,
+	.clkdm_name	= "core_l3_clkdm",
+	.enable_reg	= OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit	= AM35XX_USBOTG_FCLK_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk hecc_ck = {
+	.name		= "hecc_ck",
+	.ops		= &clkops_am35xx_ipss_module_wait,
+	.parent		= &sys_ck,
+	.clkdm_name	= "core_l3_clkdm",
+	.enable_reg	= OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit	= AM35XX_HECC_VBUSP_CLK_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk vpfe_ick = {
+	.name		= "vpfe_ick",
+	.ops		= &clkops_am35xx_ipss_module_wait,
+	.parent		= &ipss_ick,
+	.clkdm_name	= "core_l3_clkdm",
+	.enable_reg	= OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit	= AM35XX_VPFE_VBUSP_CLK_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk pclk_ck = {
+	.name		= "pclk_ck",
+	.ops		= &clkops_null,
+	.flags		= RATE_FIXED,
+	.rate		= 27000000,
+};
+
+static struct clk vpfe_fck = {
+	.name		= "vpfe_fck",
+	.ops		= &clkops_omap2_dflt,
+	.parent		= &pclk_ck,
+	.enable_reg	= OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
+	.enable_bit	= AM35XX_VPFE_FCLK_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
+/*
+ * The UART1/2 functional clock acts as the functional
+ * clock for UART4. No separate fclk control available.
+ */
+static struct clk uart4_ick_am35xx = {
+	.name		= "uart4_ick",
+	.ops		= &clkops_omap2_dflt_wait,
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= AM35XX_EN_UART4_SHIFT,
+	.clkdm_name	= "core_l4_clkdm",
+	.recalc		= &followparent_recalc,
+};
+
 
 /*
  * clkdev
@@ -3209,6 +3316,17 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_3XXX),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
 	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_3XXX),
+	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
+	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
+	CLK(NULL,	"pclk_ck",	&pclk_ck,	CK_AM35XX),
+	CLK("davinci_emac",	"ick",		&emac_ick,	CK_AM35XX),
+	CLK("davinci_emac",	"fck",		&emac_fck,	CK_AM35XX),
+	CLK("vpfe-capture",	"master",	&vpfe_ick,	CK_AM35XX),
+	CLK("vpfe-capture",	"slave",	&vpfe_fck,	CK_AM35XX),
+	CLK("musb_hdrc",	"ick",		&hsotgusb_ick_am35xx,	CK_AM35XX),
+	CLK("musb_hdrc",	"fck",		&hsotgusb_fck_am35xx,	CK_AM35XX),
+	CLK(NULL,	"hecc_ck",	&hecc_ck,	CK_AM35XX),
+	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
 };
 
 
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index d18da47..c04c7c6 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -168,6 +168,12 @@
 #define OMAP3430_EN_SDRC				(1 << 1)
 #define OMAP3430_EN_SDRC_SHIFT				1
 
+/* AM35XX specific CM_ICLKEN1_CORE bits */
+#define AM35XX_EN_IPSS_MASK				(1 << 4)
+#define AM35XX_EN_IPSS_SHIFT				4
+#define AM35XX_EN_UART4_MASK			(1 << 23)
+#define AM35XX_EN_UART4_SHIFT				23
+
 /* CM_ICLKEN2_CORE */
 #define OMAP3430_EN_PKA					(1 << 4)
 #define OMAP3430_EN_PKA_SHIFT				4
@@ -220,6 +226,10 @@
 #define OMAP3430_ST_SSI_STDBY_SHIFT			0
 #define OMAP3430_ST_SSI_STDBY_MASK			(1 << 0)
 
+/* AM35xx specific CM_IDLEST1_CORE bits */
+#define AM35XX_ST_IPSS_SHIFT				5
+#define AM35XX_ST_IPSS_MASK 				(1 << 5)
+
 /* CM_IDLEST2_CORE */
 #define OMAP3430_ST_PKA_SHIFT				4
 #define OMAP3430_ST_PKA_MASK				(1 << 4)


