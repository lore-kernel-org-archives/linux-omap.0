From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: Fix configuration of J-Type DPLLs to work for
 OMAP3 and OMAP4
Date: Tue, 21 Dec 2010 17:22:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012211719210.1446@utopia.booyaka.com>
References: <1292617875-15662-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1012180304080.16875@utopia.booyaka.com> <4D0F709C.3010904@ti.com> <alpine.DEB.2.00.1012211658270.1446@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45206 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab0LVAW2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 19:22:28 -0500
In-Reply-To: <alpine.DEB.2.00.1012211658270.1446@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>

On Tue, 21 Dec 2010, Paul Walmsley wrote:

> The queued patch -- slightly modified -- is included below.

Well, what got posted was a slightly older version.  Here's the correct 
one.  The integration tag that includes this one is 
'integration-2.6.38-20101221-006'

I've also added linux-arm-kernel@vger.kernel.org to the Cc:.  You might 
want to do that when posting future OMAP patches, that saves a little 
extra work...


- Paul

From: Jon Hunter <jon-hunter@ti.com>
Date: Fri, 17 Dec 2010 14:31:15 -0600
Subject: [PATCH] OMAP: Fix configuration of J-Type DPLLs to work for OMAP3 and OMAP4

J-Type DPLLs have additional configuration parameters that need to
be programmed when setting the multipler and divider for the DPLL.
These parameters being the sigma delta divider (SD_DIV) for the DPLL
and the digital controlled oscillator (DCO) to be used by the DPLL.

The current code is implemented specifically to configure the
OMAP3630 PER J-Type DPLL. The OMAP4430 USB DPLL is also a J-Type DPLL
and so this code needs to be updated to work for both OMAP3 and OMAP4
devices and any other future devices that have J-TYPE DPLLs.

For the OMAP3630 PER DPLL both the SD_DIV and DCO paramenters are
used but for the OMAP4430 USB DPLL only the SD_DIV field is used.
The current implementation will only program the SD_DIV and DCO
fields if the DPLL has both and hence this does not work for
OMAP4430.

In order to make the code more generic add two new fields to the
dpll_data structure for the SD_DIV field and DCO field bit-masks
and only program these fields if the masks are defined for a specific
DPLL. This simplifies the code and allows us to remove the flag
DPLL_NO_DCO_SEL.

Tested on OMAP36xx Zoom3 and OMAP4 Blaze.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
[paul@pwsan.com: removed explicit inlining and added '_' prefix on lookup_*()
 functions; added testing info to commit message; added 35xx comments back in]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.h             |    1 -
 arch/arm/mach-omap2/clock3xxx_data.c    |    2 +
 arch/arm/mach-omap2/clock44xx_data.c    |    3 +-
 arch/arm/mach-omap2/dpll3xxx.c          |   53 ++++++++++++++++++++----------
 arch/arm/plat-omap/include/plat/clock.h |    5 ++-
 5 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index a535c7a..896584e 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -49,7 +49,6 @@
 
 /* DPLL Type and DCO Selection Flags */
 #define DPLL_J_TYPE		0x1
-#define DPLL_NO_DCO_SEL		0x2
 
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index e7a41bc..9ab817e 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -602,6 +602,8 @@ static struct dpll_data dpll4_dd_3630 __initdata = {
 	.autoidle_mask	= OMAP3430_AUTO_PERIPH_DPLL_MASK,
 	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.idlest_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
+	.dco_mask	= OMAP3630_PERIPH_DPLL_DCO_SEL_MASK,
+	.sddiv_mask	= OMAP3630_PERIPH_DPLL_SD_DIV_MASK,
 	.max_multiplier = OMAP3630_MAX_JTYPE_DPLL_MULT,
 	.min_divider	= 1,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 39c0f24..dad0564 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -947,6 +947,7 @@ static struct dpll_data dpll_unipro_dd = {
 	.enable_mask	= OMAP4430_DPLL_EN_MASK,
 	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
 	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
+	.sddiv_mask	= OMAP4430_DPLL_SD_DIV_MASK,
 	.max_multiplier	= OMAP4430_MAX_DPLL_MULT,
 	.max_divider	= OMAP4430_MAX_DPLL_DIV,
 	.min_divider	= 1,
@@ -999,7 +1000,7 @@ static struct clk usb_hs_clk_div_ck = {
 static struct dpll_data dpll_usb_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_USB,
 	.clk_bypass	= &usb_hs_clk_div_ck,
-	.flags		= DPLL_J_TYPE | DPLL_NO_DCO_SEL,
+	.flags		= DPLL_J_TYPE,
 	.clk_ref	= &sys_clkin_ck,
 	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_USB,
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index cb535ee..5df9f53 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -223,10 +223,9 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
 }
 
 /**
- * lookup_dco_sddiv -  Set j-type DPLL4 compensation variables
+ * _lookup_dco - Lookup DCO used by j-type DPLL
  * @clk: pointer to a DPLL struct clk
  * @dco: digital control oscillator selector
- * @sd_div: target sigma-delta divider
  * @m: DPLL multiplier to set
  * @n: DPLL divider to set
  *
@@ -235,11 +234,9 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
  * XXX This code is not needed for 3430/AM35xx; can it be optimized
  * out in non-multi-OMAP builds for those chips?
  */
-static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16 m,
-			     u8 n)
+static void _lookup_dco(struct clk *clk, u8 *dco, u16 m, u8 n)
 {
-	unsigned long fint, clkinp, sd; /* watch out for overflow */
-	int mod1, mod2;
+	unsigned long fint, clkinp; /* watch out for overflow */
 
 	clkinp = clk->parent->rate;
 	fint = (clkinp / n) * m;
@@ -248,6 +245,27 @@ static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16 m,
 		*dco = 2;
 	else
 		*dco = 4;
+}
+
+/**
+ * _lookup_sddiv - Calculate sigma delta divider for j-type DPLL
+ * @clk: pointer to a DPLL struct clk
+ * @sd_div: target sigma-delta divider
+ * @m: DPLL multiplier to set
+ * @n: DPLL divider to set
+ *
+ * See 36xx TRM section 3.5.3.3.3.2 "Type B DPLL (Low-Jitter)"
+ *
+ * XXX This code is not needed for 3430/AM35xx; can it be optimized
+ * out in non-multi-OMAP builds for those chips?
+ */
+static void _lookup_sddiv(struct clk *clk, u8 *sd_div, u16 m, u8 n)
+{
+	unsigned long clkinp, sd; /* watch out for overflow */
+	int mod1, mod2;
+
+	clkinp = clk->parent->rate;
+
 	/*
 	 * target sigma-delta to near 250MHz
 	 * sd = ceil[(m/(n+1)) * (clkinp_MHz / 250)]
@@ -276,6 +294,7 @@ static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16 m,
 static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 {
 	struct dpll_data *dd = clk->dpll_data;
+	u8 dco, sd_div;
 	u32 v;
 
 	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
@@ -298,18 +317,16 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 	v |= m << __ffs(dd->mult_mask);
 	v |= (n - 1) << __ffs(dd->div1_mask);
 
-	/*
-	 * XXX This code is not needed for 3430/AM35XX; can it be optimized
-	 * out in non-multi-OMAP builds for those chips?
-	 */
-	if ((dd->flags & DPLL_J_TYPE) && !(dd->flags & DPLL_NO_DCO_SEL)) {
-		u8 dco, sd_div;
-		lookup_dco_sddiv(clk, &dco, &sd_div, m, n);
-		/* XXX This probably will need revision for OMAP4 */
-		v &= ~(OMAP3630_PERIPH_DPLL_DCO_SEL_MASK
-			| OMAP3630_PERIPH_DPLL_SD_DIV_MASK);
-		v |= dco << __ffs(OMAP3630_PERIPH_DPLL_DCO_SEL_MASK);
-		v |= sd_div << __ffs(OMAP3630_PERIPH_DPLL_SD_DIV_MASK);
+	/* Configure dco and sd_div for dplls that have these fields */
+	if (dd->dco_mask) {
+		_lookup_dco(clk, &dco, m, n);
+		v &= ~(dd->dco_mask);
+		v |= dco << __ffs(dd->dco_mask);
+	}
+	if (dd->sddiv_mask) {
+		_lookup_sddiv(clk, &sd_div, m, n);
+		v &= ~(dd->sddiv_mask);
+		v |= sd_div << __ffs(dd->sddiv_mask);
 	}
 
 	__raw_writel(v, dd->mult_div1_reg);
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 6e22315..8eb0ada 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -124,8 +124,7 @@ struct clksel {
  *
  * Possible values for @flags:
  * DPLL_J_TYPE: "J-type DPLL" (only some 36xx, 4xxx DPLLs)
- * NO_DCO_SEL: don't program DCO (only for some J-type DPLLs)
-
+ *
  * @freqsel_mask is only used on the OMAP34xx family and AM35xx.
  *
  * XXX Some DPLLs have multiple bypass inputs, so it's not technically
@@ -161,6 +160,8 @@ struct dpll_data {
 	u32			autoidle_mask;
 	u32			freqsel_mask;
 	u32			idlest_mask;
+	u32			dco_mask;
+	u32			sddiv_mask;
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
-- 
1.7.2.3

