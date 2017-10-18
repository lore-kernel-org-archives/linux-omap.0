From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] clk: ti: omap36xx: optimize sprz319 advisory 2.1
Date: Wed, 18 Oct 2017 12:17:21 +0200
Message-ID: <20171018101721.vqmokklnu76awr53@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Shrink code size of omap36xx specific quirk by almost 100 bytes.

gcc-5.4.0
   text	   data	    bss	    dec	    hex	filename
   4326     168       0    4494    118e dpll3xxx.o-orig
   4234	    168	      0	   4402	   1132	dpll3xxx.o

gcc-6.3.0
   text	   data	    bss	    dec	    hex	filename
   4286	    168	      0	   4454	   1166	dpll3xxx.o-orig
   4190	    168	      0	   4358	   1106	dpll3xxx.o

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/clk/ti/dpll3xxx.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 4534de2ef455..63f70e829f2b 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -844,9 +844,14 @@ static bool omap3_dpll5_apply_errata(struct clk_hw *hw,
 				     unsigned long parent_rate)
 {
 	struct omap3_dpll5_settings {
-		unsigned int rate, m, n;
+		unsigned int rate;
+		unsigned short m, n;
 	};
 
+	int i;
+	struct dpll_data *dd;
+	struct clk_hw_omap *clk;
+	const struct omap3_dpll5_settings *p;
 	static const struct omap3_dpll5_settings precomputed[] = {
 		/*
 		 * From DM3730 errata advisory 2.1, table 35 and 36.
@@ -861,29 +866,23 @@ static bool omap3_dpll5_apply_errata(struct clk_hw *hw,
 		{ 38400000,  25,  0 + 1 }
 	};
 
-	const struct omap3_dpll5_settings *d;
-	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-	struct dpll_data *dd;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(precomputed); ++i) {
-		if (parent_rate == precomputed[i].rate)
-			break;
+	for (i = 0; i < ARRAY_SIZE(precomputed); i++) {
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
 	}
 
-	if (i == ARRAY_SIZE(precomputed))
-		return false;
-
-	d = &precomputed[i];
-
-	/* Update the M, N and rounded rate values and program the DPLL. */
-	dd = clk->dpll_data;
-	dd->last_rounded_m = d->m;
-	dd->last_rounded_n = d->n;
-	dd->last_rounded_rate = div_u64((u64)parent_rate * d->m, d->n);
-	omap3_noncore_dpll_program(clk, 0);
-
-	return true;
+	return false;
 }
 
 /**
-- 
2.11.0

