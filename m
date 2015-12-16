From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2] clk: ti: omap5+: dpll: implement errata i810
Date: Wed, 16 Dec 2015 11:02:10 +0200
Message-ID: <1450256530-10251-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Errata i810 states that DPLL controller can get stuck while transitioning
to a power saving state, while its M/N ratio is being re-programmed.

As a workaround, before re-programming the M/N ratio, SW has to ensure
the DPLL cannot start an idle state transition. SW can disable DPLL
idling by setting the DPLL AUTO_DPLL_MODE=0 or keeping a clock request
active by setting a dependent clock domain in SW_WKUP.

This errata is known to impact OMAP5 and DRA7 chips, but lets enable it
unconditionally to avoid any potential problems with earlier generation
SoCs also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
v2: made the fix to be applied unconditionally on all OMAP3+ SoCs

 drivers/clk/ti/dpll3xxx.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index f4dec00..cb26eb8 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -305,7 +305,7 @@ static void _lookup_sddiv(struct clk_hw_omap *clk, u8 *sd_div, u16 m, u8 n)
 static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 {
 	struct dpll_data *dd = clk->dpll_data;
-	u8 dco, sd_div;
+	u8 dco, sd_div, ai = 0;
 	u32 v;
 
 	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
@@ -350,6 +350,21 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 		v |= sd_div << __ffs(dd->sddiv_mask);
 	}
 
+	/*
+	 * Errata i810 - DPLL controller can get stuck while transitioning
+	 * to a power saving state. Software must ensure the DPLL can not
+	 * transition to a low power state while changing M/N values.
+	 * Easiest way to accomplish this is to prevent DPLL autoidle
+	 * before doing the M/N re-program.
+	 */
+	ai = omap3_dpll_autoidle_read(clk);
+	if (ai) {
+		omap3_dpll_deny_idle(clk);
+
+		/* OCP barrier */
+		omap3_dpll_autoidle_read(clk);
+	}
+
 	ti_clk_ll_ops->clk_writel(v, dd->mult_div1_reg);
 
 	/* Set 4X multiplier and low-power mode */
@@ -379,6 +394,9 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 
 	_omap3_noncore_dpll_lock(clk);
 
+	if (ai)
+		omap3_dpll_allow_idle(clk);
+
 	return 0;
 }
 
-- 
1.7.9.5

