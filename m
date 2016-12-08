From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v3] clk: ti: omap36xx: Work around sprz319 advisory 2.1
Date: Thu, 8 Dec 2016 08:11:55 +0100
Message-ID: <20161208071155.GA7530@localhost.localdomain>
References: <1480713278-6884-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <2239782.MNuANFihMe@avalon>
 <20161205093649.GA31898@localhost.localdomain>
 <3176488.xoM6adFiVO@avalon>
 <f020ef5f-0f0b-fd4c-d4da-55daa539c3d0@ti.com>
 <20161208001654.GD5423@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161208001654.GD5423@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Tero Kristo <t-kristo@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Richard Watts <rrw@kynesim.co.uk>, Tony Lindgren <tony@atomide.com>, Alexander Kinzer <a.kinzer@plusoptix.de>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 07, 2016 at 04:16:54PM -0800, Stephen Boyd wrote:
> On 12/05, Tero Kristo wrote:
> > The compiler should ideally generate same size code for these both.
> > Personally, I don't mind which version goes in; I'd say both are as
> > readable.
> > 
> > Stephen, Mike, is one of you going to pick this up? I don't think I
> > have anything else to pull due to the ongoing discussion with the
> > other pending stuff.
> 
> I have no problem picking up either version. Please send it with
> the appropriate tags added and I can merge it.

Here it is for your convenience. Of course I'd like to see smaller code
to go in as exactly those sneaky tiny incremental code size increases
made Linux kernel unusable on most of my hardware over time ;-)
However, if Laurent is unhappy with changes I made, I will not object
merging his version any more.

Best regards,
	ladis

-- >8 --
From: Richard Watts <rrw@kynesim.co.uk>
Subject: [PATCH v4] clk: ti: omap36xx: Work around sprz319 advisory 2.1

The OMAP36xx DPLL5, driving EHCI USB, can be subject to a long-term
frequency drift. The frequency drift magnitude depends on the VCO update
rate, which is inversely proportional to the PLL divider. The kernel
DPLL configuration code results in a high value for the divider, leading
to a long term drift high enough to cause USB transmission errors. In
the worst case the USB PHY's ULPI interface can stop responding,
breaking USB operation completely. This manifests itself on the
Beagleboard xM by the LAN9514 reporting 'Cannot enable port 2. Maybe the
cable is bad?' in the kernel log.

Errata sprz319 advisory 2.1 documents PLL values that minimize the
drift. Use them automatically when DPLL5 is used for USB operation,
which we detect based on the requested clock rate. The clock framework
will still compute the PLL parameters and resulting rate as usual, but
the PLL M and N values will then be overridden. This can result in the
effective clock rate being slightly different than the rate cached by
the clock framework, but won't cause any adverse effect to USB
operation.

Signed-off-by: Richard Watts <rrw@kynesim.co.uk>
[Upported from v3.2 to v4.9]
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
Changes since v2:
 - Added spaces around '+'

Changes since v3:
 - Small omap3_dpll5_apply_errata rewrite to save few bytes (92 with
   gcc-5.4.0).

 drivers/clk/ti/clk-3xxx.c | 20 +++++++-------
 drivers/clk/ti/clock.h    |  9 +++++++
 drivers/clk/ti/dpll.c     | 19 +++++++++++++-
 drivers/clk/ti/dpll3xxx.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 8831e1a..11d8aa3 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -22,13 +22,6 @@
 
 #include "clock.h"
 
-/*
- * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
- * that are sourced by DPLL5, and both of these require this clock
- * to be at 120 MHz for proper operation.
- */
-#define DPLL5_FREQ_FOR_USBHOST		120000000
-
 #define OMAP3430ES2_ST_DSS_IDLE_SHIFT			1
 #define OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT		5
 #define OMAP3430ES2_ST_SSI_IDLE_SHIFT			8
@@ -546,14 +539,21 @@ void __init omap3_clk_lock_dpll5(void)
 	struct clk *dpll5_clk;
 	struct clk *dpll5_m2_clk;
 
+	/*
+	 * Errata sprz319f advisory 2.1 documents a USB host clock drift issue
+	 * that can be worked around using specially crafted dpll5 settings
+	 * with a dpll5_m2 divider set to 8. Set the dpll5 rate to 8x the USB
+	 * host clock rate, its .set_rate handler() will detect that frequency
+	 * and use the errata settings.
+	 */
 	dpll5_clk = clk_get(NULL, "dpll5_ck");
-	clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
+	clk_set_rate(dpll5_clk, OMAP3_DPLL5_FREQ_FOR_USBHOST * 8);
 	clk_prepare_enable(dpll5_clk);
 
-	/* Program dpll5_m2_clk divider for no division */
+	/* Program dpll5_m2_clk divider */
 	dpll5_m2_clk = clk_get(NULL, "dpll5_m2_ck");
 	clk_prepare_enable(dpll5_m2_clk);
-	clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
+	clk_set_rate(dpll5_m2_clk, OMAP3_DPLL5_FREQ_FOR_USBHOST);
 
 	clk_disable_unprepare(dpll5_m2_clk);
 	clk_disable_unprepare(dpll5_clk);
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 90f3f47..13c37f4 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -257,11 +257,20 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 				    unsigned long parent_rate);
 
+/*
+ * OMAP3_DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
+ * that are sourced by DPLL5, and both of these require this clock
+ * to be at 120 MHz for proper operation.
+ */
+#define OMAP3_DPLL5_FREQ_FOR_USBHOST	120000000
+
 unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
 int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
 				    unsigned long parent_rate, u8 index);
+int omap3_dpll5_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate);
 void omap3_clk_lock_dpll5(void);
 
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 9fc8754..4b9a419 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -114,6 +114,18 @@ static const struct clk_ops omap3_dpll_ck_ops = {
 	.round_rate	= &omap2_dpll_round_rate,
 };
 
+static const struct clk_ops omap3_dpll5_ck_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+	.get_parent	= &omap2_init_dpll_parent,
+	.recalc_rate	= &omap3_dpll_recalc,
+	.set_rate	= &omap3_dpll5_set_rate,
+	.set_parent	= &omap3_noncore_dpll_set_parent,
+	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
+	.determine_rate	= &omap3_noncore_dpll_determine_rate,
+	.round_rate	= &omap2_dpll_round_rate,
+};
+
 static const struct clk_ops omap3_dpll_per_ck_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
@@ -474,7 +486,12 @@ static void __init of_ti_omap3_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &omap3_dpll_ck_ops, &dd);
+	if ((of_machine_is_compatible("ti,omap3630") ||
+	     of_machine_is_compatible("ti,omap36xx")) &&
+	    !strcmp(node->name, "dpll5_ck"))
+		of_ti_dpll_setup(node, &omap3_dpll5_ck_ops, &dd);
+	else
+		of_ti_dpll_setup(node, &omap3_dpll_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_omap3_dpll_clock, "ti,omap3-dpll-clock",
 	       of_ti_omap3_dpll_setup);
diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 88f2ce8..f7772fc 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -838,3 +838,69 @@ int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
 	return omap3_noncore_dpll_set_rate_and_parent(hw, rate, parent_rate,
 						      index);
 }
+
+/* Apply DM3730 errata sprz319 advisory 2.1. */
+static bool omap3_dpll5_apply_errata(struct clk_hw *hw,
+				     unsigned long parent_rate)
+{
+	struct omap3_dpll5_settings {
+		unsigned int rate;
+		unsigned short m, n;
+	};
+
+	int i;
+	struct dpll_data *dd;
+	struct clk_hw_omap *clk;
+	const struct omap3_dpll5_settings *p;
+	static const struct omap3_dpll5_settings precomputed[] = {
+		/*
+		 * From DM3730 errata advisory 2.1, table 35 and 36.
+		 * The N value is increased by 1 compared to the tables as the
+		 * errata lists register values while last_rounded_field is the
+		 * real divider value.
+		 */
+		{ 12000000,  80,  0 + 1 },
+		{ 13000000, 443,  5 + 1 },
+		{ 19200000,  50,  0 + 1 },
+		{ 26000000, 443, 11 + 1 },
+		{ 38400000,  25,  0 + 1 }
+	};
+
+	for (i = 0; i< ARRAY_SIZE(precomputed); i++) {
+		p = precomputed + i;
+		if (parent_rate == p->rate) {
+			clk = to_clk_hw_omap(hw);
+			dd = clk->dpll_data;
+			/* Update the M, N and rounded rate values */
+			dd->last_rounded_m = p->m;
+			dd->last_rounded_n = p->n;
+			dd->last_rounded_rate =
+				div_u64((u64)parent_rate * p->m, p->n);
+			omap3_noncore_dpll_program(clk, 0);
+
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/**
+ * omap3_dpll5_set_rate - set rate for omap3 dpll5
+ * @hw: clock to change
+ * @rate: target rate for clock
+ * @parent_rate: rate of the parent clock
+ *
+ * Set rate for the DPLL5 clock. Apply the sprz319 advisory 2.1 on OMAP36xx if
+ * the DPLL is used for USB host (detected through the requested rate).
+ */
+int omap3_dpll5_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
+{
+	if (rate == OMAP3_DPLL5_FREQ_FOR_USBHOST * 8) {
+		if (omap3_dpll5_apply_errata(hw, parent_rate))
+			return 0;
+	}
+
+	return omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
+}
-- 
2.1.4

