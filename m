From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] clk: ti: Implement FAPLL set_rate for the PLL
Date: Sun, 22 Mar 2015 15:35:26 -0700
Message-ID: <1427063726-4248-4-git-send-email-tony@atomide.com>
References: <1427063726-4248-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aso-006-i431.relay.mailchannels.net ([23.91.64.112]:26370 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752135AbbCVWk2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Mar 2015 18:40:28 -0400
In-Reply-To: <1427063726-4248-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Tero Kristo <t-kristo@ti.com>

Since we have a fractional divider for the synthesizer, just implement
a simple multiply logic for the PLL.

It seems the PLL divider needs to have also the multiplier set for the PLL
to lock. At least I have not yet figured out if divided rates are doable.

So let's just ignore the PLL divider for now as the synthesizer has both
integer and fractional dividers so we don't even need to use the PLL
divider for the rates we know work with PLL locking.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/ti/fapll.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 4064f7b..b6f5187 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -18,11 +18,20 @@
 #include <linux/clk/ti.h>
 
 /* FAPLL Control Register PLL_CTRL */
+#define FAPLL_MAIN_MULT_N_SHIFT	16
+#define FAPLL_MAIN_DIV_P_SHIFT	8
 #define FAPLL_MAIN_LOCK		BIT(7)
 #define FAPLL_MAIN_PLLEN	BIT(3)
 #define FAPLL_MAIN_BP		BIT(2)
 #define FAPLL_MAIN_LOC_CTL	BIT(0)
 
+#define FAPLL_MAIN_MAX_MULT_N	0xffff
+#define FAPLL_MAIN_MAX_DIV_P	0xff
+#define FAPLL_MAIN_CLEAR_MASK	\
+	((FAPLL_MAIN_MAX_MULT_N << FAPLL_MAIN_MULT_N_SHIFT) | \
+	 (FAPLL_MAIN_DIV_P_SHIFT << FAPLL_MAIN_DIV_P_SHIFT) | \
+	 FAPLL_MAIN_LOC_CTL)
+
 /* FAPLL powerdown register PWD */
 #define FAPLL_PWD_OFFSET	4
 
@@ -82,6 +91,48 @@ static bool ti_fapll_clock_is_bypass(struct fapll_data *fd)
 		return !!(v & FAPLL_MAIN_BP);
 }
 
+static void ti_fapll_set_bypass(struct fapll_data *fd)
+{
+	u32 v = readl_relaxed(fd->base);
+
+	if (fd->bypass_bit_inverted)
+		v &= ~FAPLL_MAIN_BP;
+	else
+		v |= FAPLL_MAIN_BP;
+	writel_relaxed(v, fd->base);
+}
+
+static void ti_fapll_clear_bypass(struct fapll_data *fd)
+{
+	u32 v = readl_relaxed(fd->base);
+
+	if (fd->bypass_bit_inverted)
+		v |= FAPLL_MAIN_BP;
+	else
+		v &= ~FAPLL_MAIN_BP;
+	writel_relaxed(v, fd->base);
+}
+
+static int ti_fapll_wait_lock(struct fapll_data *fd)
+{
+	int retries = FAPLL_MAX_RETRIES;
+	u32 v;
+
+	while ((v = readl_relaxed(fd->base))) {
+		if (v & FAPLL_MAIN_LOCK)
+			return 0;
+
+		if (retries-- <= 0)
+			break;
+
+		udelay(1);
+	}
+
+	pr_err("%s failed to lock\n", fd->name);
+
+	return -ETIMEDOUT;
+}
+
 static int ti_fapll_enable(struct clk_hw *hw)
 {
 	struct fapll_data *fd = to_fapll(hw);
@@ -89,6 +140,7 @@ static int ti_fapll_enable(struct clk_hw *hw)
 
 	v |= FAPLL_MAIN_PLLEN;
 	writel_relaxed(v, fd->base);
+	ti_fapll_wait_lock(fd);
 
 	return 0;
 }
@@ -144,12 +196,85 @@ static u8 ti_fapll_get_parent(struct clk_hw *hw)
 	return 0;
 }
 
+static int ti_fapll_set_div_mult(unsigned long rate,
+				 unsigned long parent_rate,
+				 u32 *pre_div_p, u32 *mult_n)
+{
+	/*
+	 * So far no luck getting decent clock with PLL divider,
+	 * PLL does not seem to lock and the signal does not look
+	 * right. It seems the divider can only be used together
+	 * with the multiplier?
+	 */
+	if (rate < parent_rate) {
+		pr_warn("FAPLL main divider rates unsupported\n");
+		return -EINVAL;
+	}
+
+	*mult_n = rate / parent_rate;
+	if (*mult_n > FAPLL_MAIN_MAX_MULT_N)
+		return -EINVAL;
+	*pre_div_p = 1;
+
+	return 0;
+}
+
+static long ti_fapll_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	u32 pre_div_p, mult_n;
+	int error;
+
+	if (!rate)
+		return -EINVAL;
+
+	error = ti_fapll_set_div_mult(rate, *parent_rate,
+				      &pre_div_p, &mult_n);
+	if (error)
+		return error;
+
+	rate = *parent_rate / pre_div_p;
+	rate *= mult_n;
+
+	return rate;
+}
+
+static int ti_fapll_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct fapll_data *fd = to_fapll(hw);
+	u32 pre_div_p, mult_n, v;
+	int error;
+
+	if (!rate)
+		return -EINVAL;
+
+	error = ti_fapll_set_div_mult(rate, parent_rate,
+				      &pre_div_p, &mult_n);
+	if (error)
+		return error;
+
+	ti_fapll_set_bypass(fd);
+	v = readl_relaxed(fd->base);
+	v &= ~FAPLL_MAIN_CLEAR_MASK;
+	v |= pre_div_p << FAPLL_MAIN_DIV_P_SHIFT;
+	v |= mult_n << FAPLL_MAIN_MULT_N_SHIFT;
+	writel_relaxed(v, fd->base);
+	if (ti_fapll_is_enabled(hw))
+		ti_fapll_wait_lock(fd);
+	ti_fapll_clear_bypass(fd);
+
+	return 0;
+}
+
 static struct clk_ops ti_fapll_ops = {
 	.enable = ti_fapll_enable,
 	.disable = ti_fapll_disable,
 	.is_enabled = ti_fapll_is_enabled,
 	.recalc_rate = ti_fapll_recalc_rate,
 	.get_parent = ti_fapll_get_parent,
+	.round_rate = ti_fapll_round_rate,
+	.set_rate = ti_fapll_set_rate,
 };
 
 static int ti_fapll_synth_enable(struct clk_hw *hw)
-- 
2.1.4

