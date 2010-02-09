From: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Subject: [PATCHV3] OMAP3630: Clock: Workaround for DPLL HS divider limitation
Date: Tue, 9 Feb 2010 16:28:14 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026B757441@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32885 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062Ab0BIK6r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 05:58:47 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Turquette, Mike" <mturquette@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>

From: Mike Turquette <mturquette@ti.com>
Date: Fri, 5 Feb 2010 19:09:52 +0530
Subject: [PATCH] OMAP3630: Clock: Workaround for DPLL HS divider limitation

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
---
 arch/arm/mach-omap2/clock34xx.c      |   41 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock34xx.h      |    1 +
 arch/arm/mach-omap2/clock34xx_data.c |   20 ++++++++++++++++
 3 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index c1c1b93..1e6297f 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -133,6 +133,47 @@ const struct clkops clkops_omap3430es2_hsotgusb_wait = {
 	.find_companion = omap2_clk_dflt_find_companion,
 };
 
+/**
+ * omap3_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suffering
+ *         from HSDivider PWRDN problem Implements Errata ID: i556.
+ * @clk: DPLL output struct clk
+ *
+ * 3630 only: dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck, dpll4_m5_ck
+ * & dpll4_m6_ck dividers gets loaded with reset valueafter their respective
+ * PWRDN bits are set.
+ * Any dummy write (Any other value different from the Read value) to the
+ * corresponding CM_CLKSEL register will refresh the dividers.
+ */
+int omap3_pwrdn_clk_enable_with_hsdiv_restore(struct clk *clk)
+{
+	u32 dummy_v, orig_v, clksel_shift;
+	int ret;
+
+	/* Enable PWRDN bit of HSDIVIDER */
+	ret = omap2_dflt_clk_enable(clk);
+
+	/* Restore the dividers */
+	if (!ret) {
+		clksel_shift = __ffs(clk->parent->clksel_mask);
+		orig_v = dummy_v = __raw_readl(clk->parent->clksel_reg);
+
+		/* Write any other value different from the Read value */
+		dummy_v ^= (1 << clksel_shift);
+		__raw_writel(dummy_v, clk->parent->clksel_reg);
+
+		/* Write the original divider */
+		__raw_writel(orig_v, clk->parent->clksel_reg);
+	}
+	return ret;
+}
+
+const struct clkops clkops_omap3_pwrdn_with_hsdiv_wait_restore = {
+	.enable		= omap3_pwrdn_clk_enable_with_hsdiv_restore,
+	.disable	= omap2_dflt_clk_disable,
+	.find_companion	= omap2_clk_dflt_find_companion,
+	.find_idlest	= omap2_clk_dflt_find_idlest,
+};
+
 const struct clkops omap3_clkops_noncore_dpll_ops = {
 	.enable		= omap3_noncore_dpll_enable,
 	.disable	= omap3_noncore_dpll_disable,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 313efc0..29ef390 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -21,5 +21,6 @@ extern const struct clkops clkops_omap3430es2_ssi_wait;
 extern const struct clkops clkops_omap3430es2_hsotgusb_wait;
 extern const struct clkops clkops_omap3430es2_dss_usbhost_wait;
 extern const struct clkops omap3_clkops_noncore_dpll_ops;
+extern const struct clkops clkops_omap3_pwrdn_with_hsdiv_wait_restore;
 
 #endif
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 8728f1f..9d11d53 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -3240,6 +3240,26 @@ int __init omap3xxx_clk_init(void)
 		}
 	}
 
+	if (cpu_is_omap3630()) {
+
+		/*
+		 * For 3630: override clkops_omap2_dflt_wait for the
+		 * clocks affected from PWRDN reset Limitation
+		 */
+		dpll3_m3x2_ck.ops =
+				&clkops_omap3_pwrdn_with_hsdiv_wait_restore;
+		dpll4_m2x2_ck.ops =
+				&clkops_omap3_pwrdn_with_hsdiv_wait_restore;
+		dpll4_m3x2_ck.ops =
+				&clkops_omap3_pwrdn_with_hsdiv_wait_restore;
+		dpll4_m4x2_ck.ops =
+				&clkops_omap3_pwrdn_with_hsdiv_wait_restore;
+		dpll4_m5x2_ck.ops =
+				&clkops_omap3_pwrdn_with_hsdiv_wait_restore;
+		dpll4_m6x2_ck.ops =
+				&clkops_omap3_pwrdn_with_hsdiv_wait_restore;
+	}
+
 	clk_init(&omap2_clk_functions);
 
 	for (c = omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks); c++)
-- 
1.5.6.3

