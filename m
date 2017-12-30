From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: [PATCH 27/33] clk: ti: fapll: change round_rate() return logic
Date: Sat, 30 Dec 2017 01:13:06 +0000
Message-ID: <1514596392-22270-28-git-send-email-pure.logic@nexus-software.ie>
References: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: pure.logic@nexus-software.ie, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch updates the round_rate() logic here to return zero instead of a
negative number on error.

In conjunction with higher-level changes associated with acting on the
return value of clk_ops->round_rate() it is then possible to have
clk_ops->round_rate() return values from 1 Hz to ULONG_MAX Hz instead of
the current limitation of 1 Hz to LONG_MAX Hz.

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/clk/ti/fapll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 2e74437..f435a8c 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -227,12 +227,12 @@ static unsigned long ti_fapll_round_rate(struct clk_hw *hw, unsigned long rate,
 	int error;
 
 	if (!rate)
-		return -EINVAL;
+		return 0;
 
 	error = ti_fapll_set_div_mult(rate, *parent_rate,
 				      &pre_div_p, &mult_n);
 	if (error)
-		return error;
+		return 0;
 
 	rate = *parent_rate / pre_div_p;
 	rate *= mult_n;
@@ -414,7 +414,7 @@ static unsigned long ti_fapll_synth_round_rate(struct clk_hw *hw,
 	unsigned long r;
 
 	if (ti_fapll_clock_is_bypass(fd) || !synth->div || !rate)
-		return -EINVAL;
+		return 0;
 
 	/* Only post divider m available with no fractional divider? */
 	if (!synth->freq) {
-- 
2.7.4
