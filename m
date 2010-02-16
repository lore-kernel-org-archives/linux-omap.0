From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 15/19] OMAP3630: Clock: Workaround for DPLL HS divider
	limitation
Date: Mon, 15 Feb 2010 18:24:59 -0700
Message-ID: <20100216012458.1101.14226.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57438 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499Ab0BPB1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:27:00 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Vijaykumar GN <vijaykumar.gn@ti.com>, Mike Turquette <mturquette@ti.com>

From: Mike Turquette <mturquette@ti.com>

This patch implements a workaround for the DPLL HS divider limitation
in OMAP3630 as given by Errata ID: i556.

Errata:
When PWRDN bit is set, it resets the internal HSDIVIDER divide-by value (Mx).
The reset value gets loaded instead of the previous value.
The following HSDIVIDERs exhibit above behavior:
. DPLL4 : M6 / M5 / M4 / M3 / M2 (CM_CLKEN_PLL[31:26] register bits)
. DPLL3 : M3 (CM_CLKEN_PLL[12] register bit).

Work Around:
It is mandatory to apply the following sequence to ensure the write
value will
be loaded in DPLL HSDIVIDER FSM:
The global sequence when using PWRDN bit is the following:
. Disable Mx HSDIVIDER clock output related functional clock enable bits
        (in CM_FCLKEN_xxx / CM_ICLKEN_xxx)
. Enable PWRDN bit of HSDIVIDER
. Disable PWRDN bit of HSDIVIDER
. Read current HSDIVIDER register value
. Write different value in HSDIVIDER register
. Write expected value in HSDIVIDER register
. Enable Mx HSDIVIDER clock output related functional clocks
        (CM_FCLKEN_xxx / CM_ICLKEN_xxx)

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Vijaykumar GN <vijaykumar.gn@ti.com>
[paul@pwsan.com: updated patch to apply; made workaround function static;
 marked as being 36xx-specific]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c      |   43 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock34xx.h      |    3 ++
 arch/arm/mach-omap2/clock34xx_data.c |   19 +++++++++++++++
 3 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 37da629..c8b4e56 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -150,6 +150,49 @@ const struct clkops clkops_omap3430es2_hsotgusb_wait = {
 	.find_companion = omap2_clk_dflt_find_companion,
 };
 
+/**
+ * omap36xx_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suffering
+ *         from HSDivider PWRDN problem Implements Errata ID: i556.
+ * @clk: DPLL output struct clk
+ *
+ * 3630 only: dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck,
+ * dpll4_m5_ck & dpll4_m6_ck dividers gets loaded with reset
+ * valueafter their respective PWRDN bits are set.  Any dummy write
+ * (Any other value different from the Read value) to the
+ * corresponding CM_CLKSEL register will refresh the dividers.
+ */
+static int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk *clk)
+{
+	u32 dummy_v, orig_v, clksel_shift;
+	int ret;
+
+	/* Clear PWRDN bit of HSDIVIDER */
+	ret = omap2_dflt_clk_enable(clk);
+
+	/* Restore the dividers */
+	if (!ret) {
+		clksel_shift = __ffs(clk->parent->clksel_mask);
+		orig_v = __raw_readl(clk->parent->clksel_reg);
+		dummy_v = orig_v;
+
+		/* Write any other value different from the Read value */
+		dummy_v ^= (1 << clksel_shift);
+		__raw_writel(dummy_v, clk->parent->clksel_reg);
+
+		/* Write the original divider */
+		__raw_writel(orig_v, clk->parent->clksel_reg);
+	}
+
+	return ret;
+}
+
+const struct clkops clkops_omap36xx_pwrdn_with_hsdiv_wait_restore = {
+	.enable		= omap36xx_pwrdn_clk_enable_with_hsdiv_restore,
+	.disable	= omap2_dflt_clk_disable,
+	.find_companion	= omap2_clk_dflt_find_companion,
+	.find_idlest	= omap2_clk_dflt_find_idlest,
+};
+
 const struct clkops clkops_noncore_dpll_ops = {
 	.enable		= omap3_noncore_dpll_enable,
 	.disable	= omap3_noncore_dpll_disable,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index e61e653..b9c65f5 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -26,4 +26,7 @@ extern const struct clkops clkops_noncore_dpll_ops;
 extern const struct clkops clkops_am35xx_ipss_module_wait;
 extern const struct clkops clkops_am35xx_ipss_wait;
 
+/* OMAP36xx-specific clkops */
+extern const struct clkops clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
+
 #endif
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index d9d5b2e..caa6a41 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -3358,6 +3358,25 @@ int __init omap3xxx_clk_init(void)
 		}
 	}
 
+	if (cpu_is_omap3630()) {
+		/*
+		 * For 3630: override clkops_omap2_dflt_wait for the
+		 * clocks affected from PWRDN reset Limitation
+		 */
+		dpll3_m3x2_ck.ops =
+				&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
+		dpll4_m2x2_ck.ops =
+				&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
+		dpll4_m3x2_ck.ops =
+				&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
+		dpll4_m4x2_ck.ops =
+				&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
+		dpll4_m5x2_ck.ops =
+				&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
+		dpll4_m6x2_ck.ops =
+				&clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
+	}
+
 	clk_init(&omap2_clk_functions);
 
 	for (c = omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks); c++)


