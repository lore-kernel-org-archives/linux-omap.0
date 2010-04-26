From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/10] OMAP2+ clock: remove DEFAULT_RATE clksel_rate flag
Date: Mon, 26 Apr 2010 01:04:31 -0600
Message-ID: <20100426070427.9743.16547.stgit@localhost.localdomain>
References: <20100426070217.9743.92728.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52244 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab0DZHHf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 03:07:35 -0400
In-Reply-To: <20100426070217.9743.92728.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The DEFAULT_RATE clksel_rate flag is essentially useless.  It was set
on some of the lowest divisors, which, when switching to a much
higher-rate parent, could have potentially resulted in rates that
exceeded the hardware specifications for downstream clocks in the
window between the clk_set_parent(), and a subsequent clk_set_rate().
It seems much safer to just remove the flag and always use the highest
available divisor (resulting in the lowest possible rate) after the
switch, and this patch does so.

Ideally, it would be best to first attempt to switch to a divisor that
matches the clock's rate with the previous parent, if at all possible.
But that is a project for some other day or some other person.  The
parent changing code is rarely used.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clkt_clksel.c       |   57 +++++++++++++++-------
 arch/arm/mach-omap2/clock2420_data.c    |   46 +++++++++---------
 arch/arm/mach-omap2/clock2430_data.c    |   48 +++++++++----------
 arch/arm/mach-omap2/clock3xxx_data.c    |   80 ++++++++++++++++---------------
 arch/arm/mach-omap2/clock_common_data.c |    6 +-
 arch/arm/plat-omap/include/plat/clock.h |   13 ++---
 6 files changed, 135 insertions(+), 115 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index e50812d..9a23aeb 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -67,38 +67,61 @@ static const struct clksel *_omap2_get_clksel_by_parent(struct clk *clk,
 	return clks;
 }
 
-/*
- * Converts encoded control register address into a full address
- * On error, the return value (parent_div) will be 0.
+/**
+ * _omap2_clksel_get_src_field - find the new clksel divisor to use
+ * @src_clk: planned new parent struct clk *
+ * @clk: struct clk * that is being reparented
+ * @field_val: pointer to a u32 to contain the register data for the divisor
+ *
+ * Given an intended new parent struct clk * @src_clk, and the struct
+ * clk * @clk to the clock that is being reparented, find the
+ * appropriate rate divisor for the new clock (returned as the return
+ * value), and the corresponding register bitfield data to program to
+ * reach that divisor (returned in the u32 pointed to by @field_val).
+ * Returns 0 on error, or returns the newly-selected divisor upon
+ * success (in this latter case, the corresponding register bitfield
+ * value is passed back in the variable pointed to by @field_val)
  */
-static u32 _omap2_clksel_get_src_field(struct clk *src_clk, struct clk *clk,
-				       u32 *field_val)
+static u8 _omap2_clksel_get_src_field(struct clk *src_clk, struct clk *clk,
+				      u32 *field_val)
 {
 	const struct clksel *clks;
-	const struct clksel_rate *clkr;
+	const struct clksel_rate *clkr, *max_clkr;
+	u8 max_div = 0;
 
 	clks = _omap2_get_clksel_by_parent(clk, src_clk);
 	if (!clks)
 		return 0;
 
+	/*
+	 * Find the highest divisor (e.g., the one resulting in the
+	 * lowest rate) to use as the default.  This should avoid
+	 * clock rates that are too high for the device.  XXX A better
+	 * solution here would be to try to determine if there is a
+	 * divisor matching the original clock rate before the parent
+	 * switch, and if it cannot be found, to fall back to the
+	 * highest divisor.
+	 */
 	for (clkr = clks->rates; clkr->div; clkr++) {
-		if (clkr->flags & cpu_mask && clkr->flags & DEFAULT_RATE)
-			break; /* Found the default rate for this platform */
+		if (!(clkr->flags & cpu_mask))
+			continue;
+
+		if (clkr->div > max_div) {
+			max_div = clkr->div;
+			max_clkr = clkr;
+		}
 	}
 
-	if (!clkr->div) {
-		printk(KERN_ERR "clock: Could not find default rate for "
+	if (max_div == 0) {
+		WARN(1, "clock: Could not find divisor for "
 		       "clock %s parent %s\n", clk->name,
 		       src_clk->parent->name);
 		return 0;
 	}
 
-	/* Should never happen.  Add a clksel mask to the struct clk. */
-	WARN_ON(clk->clksel_mask == 0);
+	*field_val = max_clkr->val;
 
-	*field_val = clkr->val;
-
-	return clkr->div;
+	return max_div;
 }
 
 
@@ -177,8 +200,6 @@ unsigned long omap2_clksel_recalc(struct clk *clk)
  *
  * Finds 'best' divider value in an array based on the source and target
  * rates.  The divider array must be sorted with smallest divider first.
- * Note that this will not work for clocks which are part of CONFIG_PARTICIPANT,
- * they are only settable as part of virtual_prcm set.
  *
  * Returns the rounded clock rate or returns 0xffffffff on error.
  */
@@ -380,7 +401,7 @@ int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent)
 {
 	u32 field_val, v, parent_div;
 
-	if (!clk->clksel)
+	if (!clk->clksel || !clk->clksel_mask)
 		return -EINVAL;
 
 	parent_div = _omap2_clksel_get_src_field(new_parent, clk, &field_val);
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 1381e76..23bc981 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -155,12 +155,12 @@ static struct clk apll54_ck = {
 /* func_54m_ck */
 
 static const struct clksel_rate func_54m_apll54_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate func_54m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 0 },
 };
 
@@ -201,12 +201,12 @@ static struct clk func_96m_ck = {
 /* func_48m_ck */
 
 static const struct clksel_rate func_48m_apll96_rates[] = {
-	{ .div = 2, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate func_48m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 0 },
 };
 
@@ -256,22 +256,22 @@ static struct clk wdt1_osc_ck = {
  * flags fields, which mark them as 2420-only.
  */
 static const struct clksel_rate common_clkout_src_core_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate common_clkout_src_sys_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate common_clkout_src_96m_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate common_clkout_src_54m_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 3, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
@@ -300,7 +300,7 @@ static struct clk sys_clkout_src = {
 };
 
 static const struct clksel_rate common_clkout_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 2, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 4, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 8, .val = 3, .flags = RATE_IN_24XX },
@@ -384,7 +384,7 @@ static struct clk emul_ck = {
  *
  */
 static const struct clksel_rate mpu_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 4, .val = 4, .flags = RATE_IN_242X },
 	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
@@ -420,7 +420,7 @@ static struct clk mpu_ck = {	/* Control cpu */
  * routed into a synchronizer and out of clocks abc.
  */
 static const struct clksel_rate dsp_fck_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
 	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
@@ -450,7 +450,7 @@ static struct clk dsp_fck = {
 
 /* DSP interface clock */
 static const struct clksel_rate dsp_irate_ick_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 0 },
 };
@@ -532,7 +532,7 @@ static struct clk iva1_mpu_int_ifck = {
 static const struct clksel_rate core_l3_core_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 2, .val = 2, .flags = RATE_IN_242X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
 	{ .div = 6, .val = 6, .flags = RATE_IN_24XX },
 	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
 	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
@@ -559,7 +559,7 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 /* usb_l4_ick */
 static const struct clksel_rate usb_l4_ick_core_l3_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
@@ -591,7 +591,7 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
  * this domain.
  */
 static const struct clksel_rate l4_core_l3_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
@@ -622,7 +622,7 @@ static struct clk l4_ck = {		/* used both as an ick and fck */
  */
 static const struct clksel_rate ssi_ssr_sst_fck_core_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
 	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
 	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
@@ -730,7 +730,7 @@ static struct clk gfx_ick = {
 /* XXX Add RATE_NOT_VALIDATED */
 
 static const struct clksel_rate dss1_fck_sys_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
@@ -744,7 +744,7 @@ static const struct clksel_rate dss1_fck_core_rates[] = {
 	{ .div = 8, .val = 8, .flags = RATE_IN_24XX },
 	{ .div = 9, .val = 9, .flags = RATE_IN_24XX },
 	{ .div = 12, .val = 12, .flags = RATE_IN_24XX },
-	{ .div = 16, .val = 16, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 16, .val = 16, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
@@ -779,12 +779,12 @@ static struct clk dss1_fck = {
 };
 
 static const struct clksel_rate dss2_fck_sys_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate dss2_fck_48m_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
@@ -825,7 +825,7 @@ static struct clk dss_54m_fck = {	/* Alt clk used in power management */
  * functional clock parents.
  */
 static const struct clksel_rate gpt_alt_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
@@ -1588,7 +1588,7 @@ static struct clk vlynq_ick = {
 };
 
 static const struct clksel_rate vlynq_fck_96m_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_242X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_242X },
 	{ .div = 0 }
 };
 
@@ -1601,7 +1601,7 @@ static const struct clksel_rate vlynq_fck_core_rates[] = {
 	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
 	{ .div = 9, .val = 9, .flags = RATE_IN_242X },
 	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
-	{ .div = 16, .val = 16, .flags = RATE_IN_242X | DEFAULT_RATE },
+	{ .div = 16, .val = 16, .flags = RATE_IN_242X },
 	{ .div = 18, .val = 18, .flags = RATE_IN_242X },
 	{ .div = 0 }
 };
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 1aac227..2df50d9 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -155,12 +155,12 @@ static struct clk apll54_ck = {
 /* func_54m_ck */
 
 static const struct clksel_rate func_54m_apll54_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate func_54m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 0 },
 };
 
@@ -192,12 +192,12 @@ static struct clk core_ck = {
 
 /* func_96m_ck */
 static const struct clksel_rate func_96m_apll96_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate func_96m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_243X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_243X },
 	{ .div = 0 },
 };
 
@@ -222,12 +222,12 @@ static struct clk func_96m_ck = {
 /* func_48m_ck */
 
 static const struct clksel_rate func_48m_apll96_rates[] = {
-	{ .div = 2, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate func_48m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 0 },
 };
 
@@ -277,22 +277,22 @@ static struct clk wdt1_osc_ck = {
  * flags fields, which mark them as 2420-only.
  */
 static const struct clksel_rate common_clkout_src_core_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate common_clkout_src_sys_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate common_clkout_src_96m_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate common_clkout_src_54m_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 3, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
@@ -321,7 +321,7 @@ static struct clk sys_clkout_src = {
 };
 
 static const struct clksel_rate common_clkout_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 2, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 4, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 8, .val = 3, .flags = RATE_IN_24XX },
@@ -369,7 +369,7 @@ static struct clk emul_ck = {
  *
  */
 static const struct clksel_rate mpu_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 0 },
 };
@@ -402,7 +402,7 @@ static struct clk mpu_ck = {	/* Control cpu */
  * routed into a synchronizer and out of clocks abc.
  */
 static const struct clksel_rate dsp_fck_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
 	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
@@ -429,7 +429,7 @@ static struct clk dsp_fck = {
 
 /* DSP interface clock */
 static const struct clksel_rate dsp_irate_ick_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
 	{ .div = 0 },
@@ -481,7 +481,7 @@ static struct clk iva2_1_ick = {
  */
 static const struct clksel_rate core_l3_core_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
-	{ .div = 4, .val = 4, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
 	{ .div = 6, .val = 6, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
@@ -505,7 +505,7 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 /* usb_l4_ick */
 static const struct clksel_rate usb_l4_ick_core_l3_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
@@ -537,7 +537,7 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
  * this domain.
  */
 static const struct clksel_rate l4_core_l3_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
@@ -568,7 +568,7 @@ static struct clk l4_ck = {		/* used both as an ick and fck */
  */
 static const struct clksel_rate ssi_ssr_sst_fck_core_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
 	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
 	{ .div = 5, .val = 5, .flags = RATE_IN_243X },
@@ -673,7 +673,7 @@ static struct clk gfx_ick = {
  */
 static const struct clksel_rate mdm_ick_core_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_243X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_243X | DEFAULT_RATE },
+	{ .div = 4, .val = 4, .flags = RATE_IN_243X },
 	{ .div = 6, .val = 6, .flags = RATE_IN_243X },
 	{ .div = 9, .val = 9, .flags = RATE_IN_243X },
 	{ .div = 0 }
@@ -718,7 +718,7 @@ static struct clk mdm_osc_ck = {
 /* XXX Add RATE_NOT_VALIDATED */
 
 static const struct clksel_rate dss1_fck_sys_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
@@ -732,7 +732,7 @@ static const struct clksel_rate dss1_fck_core_rates[] = {
 	{ .div = 8, .val = 8, .flags = RATE_IN_24XX },
 	{ .div = 9, .val = 9, .flags = RATE_IN_24XX },
 	{ .div = 12, .val = 12, .flags = RATE_IN_24XX },
-	{ .div = 16, .val = 16, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 16, .val = 16, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
@@ -767,12 +767,12 @@ static struct clk dss1_fck = {
 };
 
 static const struct clksel_rate dss2_fck_sys_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate dss2_fck_48m_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
@@ -813,7 +813,7 @@ static struct clk dss_54m_fck = {	/* Alt clk used in power management */
  * functional clock parents.
  */
 static const struct clksel_rate gpt_alt_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 1, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 0 }
 };
 
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 9cba556..56bd0d8 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -110,32 +110,32 @@ static struct clk virt_38_4m_ck = {
 };
 
 static const struct clksel_rate osc_sys_12m_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_13m_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_16_8m_rates[] = {
-	{ .div = 1, .val = 5, .flags = RATE_IN_3430ES2 | DEFAULT_RATE },
+	{ .div = 1, .val = 5, .flags = RATE_IN_3430ES2 },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_19_2m_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_26m_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 3, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_38_4m_rates[] = {
-	{ .div = 1, .val = 4, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 4, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
@@ -163,7 +163,7 @@ static struct clk osc_sys_ck = {
 };
 
 static const struct clksel_rate div2_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
@@ -213,7 +213,7 @@ static struct clk sys_clkout1 = {
 /* CM CLOCKS */
 
 static const struct clksel_rate div16_dpll_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
 	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
@@ -233,7 +233,7 @@ static const struct clksel_rate div16_dpll_rates[] = {
 };
 
 static const struct clksel_rate div32_dpll4_rates_3630[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_36XX | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_36XX },
 	{ .div = 2, .val = 2, .flags = RATE_IN_36XX },
 	{ .div = 3, .val = 3, .flags = RATE_IN_36XX },
 	{ .div = 4, .val = 4, .flags = RATE_IN_36XX },
@@ -450,7 +450,7 @@ static struct clk dpll3_x2_ck = {
 };
 
 static const struct clksel_rate div31_dpll3_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 3, .val = 3, .flags = RATE_IN_3430ES2 },
 	{ .div = 4, .val = 4, .flags = RATE_IN_3430ES2 },
@@ -698,7 +698,7 @@ static struct clk omap_192m_alwon_fck = {
 
 static const struct clksel_rate omap_96m_alwon_fck_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_36XX },
-	{ .div = 2, .val = 2, .flags = RATE_IN_36XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_36XX },
 	{ .div = 0 }
 };
 
@@ -708,12 +708,12 @@ static const struct clksel omap_96m_alwon_fck_clksel[] = {
 };
 
 static const struct clksel_rate omap_96m_dpll_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate omap_96m_sys_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
@@ -799,12 +799,12 @@ static struct clk dpll4_m3x2_ck = {
 };
 
 static const struct clksel_rate omap_54m_d4m3x2_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate omap_54m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
@@ -825,12 +825,12 @@ static struct clk omap_54m_fck = {
 };
 
 static const struct clksel_rate omap_48m_cm96m_rates[] = {
-	{ .div = 2, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 0, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate omap_48m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
@@ -1049,22 +1049,22 @@ static struct clk dpll5_m2_ck = {
 /* CM EXTERNAL CLOCK OUTPUTS */
 
 static const struct clksel_rate clkout2_src_core_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate clkout2_src_sys_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate clkout2_src_96m_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate clkout2_src_54m_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 3, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
@@ -1090,7 +1090,7 @@ static struct clk clkout2_src_ck = {
 };
 
 static const struct clksel_rate sys_clkout2_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
 	{ .div = 2, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 4, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 8, .val = 3, .flags = RATE_IN_343X },
@@ -1125,7 +1125,7 @@ static struct clk corex2_fck = {
 /* DPLL power domain clock controls */
 
 static const struct clksel_rate div4_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
 	{ .div = 0 }
@@ -1161,7 +1161,7 @@ static struct clk mpu_ck = {
 
 /* arm_fck is divided by two when DPLL1 locked; otherwise, passthrough mpu_ck */
 static const struct clksel_rate arm_fck_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
 	{ .div = 2, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 0 },
 };
@@ -1333,25 +1333,25 @@ static struct clk gfx_cg2_ck = {
 
 static const struct clksel_rate sgx_core_rates[] = {
 	{ .div = 2, .val = 5, .flags = RATE_IN_36XX },
-	{ .div = 3, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 3, .val = 0, .flags = RATE_IN_343X },
 	{ .div = 4, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 6, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate sgx_192m_rates[] = {
-	{ .div = 1,  .val = 4, .flags = RATE_IN_36XX | DEFAULT_RATE },
+	{ .div = 1,  .val = 4, .flags = RATE_IN_36XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate sgx_corex2_rates[] = {
-	{ .div = 3, .val = 6, .flags = RATE_IN_36XX | DEFAULT_RATE },
+	{ .div = 3, .val = 6, .flags = RATE_IN_36XX },
 	{ .div = 5, .val = 7, .flags = RATE_IN_36XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate sgx_96m_rates[] = {
-	{ .div = 1,  .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1,  .val = 3, .flags = RATE_IN_343X },
 	{ .div = 0 },
 };
 
@@ -1576,12 +1576,12 @@ static struct clk i2c1_fck = {
  * MCBSP 2, 3, 4 get their 96MHz clock from per_96m_fck.
  */
 static const struct clksel_rate common_mcbsp_96m_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate common_mcbsp_mcbsp_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
@@ -1714,7 +1714,7 @@ static struct clk hdq_fck = {
 /* DPLL3-derived clock */
 
 static const struct clksel_rate ssi_ssr_corex2_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
 	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
@@ -2353,7 +2353,7 @@ static struct clk usbhost_ick = {
 /* WKUP */
 
 static const struct clksel_rate usim_96m_rates[] = {
-	{ .div = 2,  .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2,  .val = 3, .flags = RATE_IN_343X },
 	{ .div = 4,  .val = 4, .flags = RATE_IN_343X },
 	{ .div = 8,  .val = 5, .flags = RATE_IN_343X },
 	{ .div = 10, .val = 6, .flags = RATE_IN_343X },
@@ -2361,7 +2361,7 @@ static const struct clksel_rate usim_96m_rates[] = {
 };
 
 static const struct clksel_rate usim_120m_rates[] = {
-	{ .div = 4,  .val = 7,	.flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 4,  .val = 7,	.flags = RATE_IN_343X },
 	{ .div = 8,  .val = 8,	.flags = RATE_IN_343X },
 	{ .div = 16, .val = 9,	.flags = RATE_IN_343X },
 	{ .div = 20, .val = 10, .flags = RATE_IN_343X },
@@ -2951,22 +2951,22 @@ static struct clk mcbsp4_fck = {
 /* More information: ARM Cortex-A8 Technical Reference Manual, sect 10.1 */
 
 static const struct clksel_rate emu_src_sys_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate emu_src_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate emu_src_per_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate emu_src_mpu_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 3, .flags = RATE_IN_343X },
 	{ .div = 0 },
 };
 
@@ -2995,7 +2995,7 @@ static struct clk emu_src_ck = {
 };
 
 static const struct clksel_rate pclk_emu_rates[] = {
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
 	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
 	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
@@ -3019,7 +3019,7 @@ static struct clk pclk_fck = {
 };
 
 static const struct clksel_rate pclkx2_emu_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
 	{ .div = 0 },
@@ -3069,7 +3069,7 @@ static struct clk traceclk_src_fck = {
 };
 
 static const struct clksel_rate traceclk_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
 	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
 	{ .div = 0 },
diff --git a/arch/arm/mach-omap2/clock_common_data.c b/arch/arm/mach-omap2/clock_common_data.c
index f69096b..6f96dc4 100644
--- a/arch/arm/mach-omap2/clock_common_data.c
+++ b/arch/arm/mach-omap2/clock_common_data.c
@@ -20,18 +20,18 @@
 
 /* clksel_rate data common to 24xx/343x */
 const struct clksel_rate gpt_32k_rates[] = {
-	 { .div = 1, .val = 0, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
+	 { .div = 1, .val = 0, .flags = RATE_IN_24XX | RATE_IN_343X },
 	 { .div = 0 }
 };
 
 const struct clksel_rate gpt_sys_rates[] = {
-	 { .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
+	 { .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X },
 	 { .div = 0 }
 };
 
 const struct clksel_rate gfx_l3_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | RATE_IN_343X },
 	{ .div = 3, .val = 3, .flags = RATE_IN_243X | RATE_IN_343X },
 	{ .div = 4, .val = 4, .flags = RATE_IN_243X | RATE_IN_343X },
 	{ .div = 0 }
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 34f7fa9..9c551d6 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -196,13 +196,12 @@ extern struct clk dummy_ck;
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
 
 /* Clksel_rate flags */
-#define DEFAULT_RATE		(1 << 0)
-#define RATE_IN_242X		(1 << 1)
-#define RATE_IN_243X		(1 << 2)
-#define RATE_IN_343X		(1 << 3)	/* rates common to all 343X */
-#define RATE_IN_3430ES2		(1 << 4)	/* 3430ES2 rates only */
-#define RATE_IN_36XX		(1 << 5)
-#define RATE_IN_4430		(1 << 6)
+#define RATE_IN_242X		(1 << 0)
+#define RATE_IN_243X		(1 << 1)
+#define RATE_IN_343X		(1 << 2)	/* rates common to all 343X */
+#define RATE_IN_3430ES2		(1 << 3)	/* 3430ES2 rates only */
+#define RATE_IN_36XX		(1 << 4)
+#define RATE_IN_4430		(1 << 5)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 


