From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] clk: ti: Fix FAPLL recalc_rate for rounding errors
Date: Sun, 22 Mar 2015 15:35:24 -0700
Message-ID: <1427063726-4248-2-git-send-email-tony@atomide.com>
References: <1427063726-4248-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ftx-008-i768.relay.mailchannels.net ([50.61.143.68]:47708 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751941AbbCVWkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Mar 2015 18:40:16 -0400
In-Reply-To: <1427063726-4248-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Tero Kristo <t-kristo@ti.com>

We need to round the calculated value to have it match the requested rate.

While at it, let's fix a typo and use a define for SYNTH_MAX_DIV_M as we
will need it in later patches for set_rate.

And let's remove two unused includes.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/ti/fapll.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index d216406..3b5e231 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -11,12 +11,10 @@
 
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
-#include <asm/div64.h>
 
 /* FAPLL Control Register PLL_CTRL */
 #define FAPLL_MAIN_LOCK		BIT(7)
@@ -49,6 +47,8 @@
 /* Synthesizer frequency register */
 #define SYNTH_LDFREQ		BIT(31)
 
+#define SYNTH_MAX_DIV_M		0xff
+
 struct fapll_data {
 	struct clk_hw hw;
 	void __iomem *base;
@@ -218,11 +218,10 @@ static unsigned long ti_fapll_synth_recalc_rate(struct clk_hw *hw,
 		rate *= 8;
 	}
 
-	/* Synth ost-divider M */
-	synth_div_m = readl_relaxed(synth->div) & 0xff;
-	do_div(rate, synth_div_m);
+	/* Synth post-divider M */
+	synth_div_m = readl_relaxed(synth->div) & SYNTH_MAX_DIV_M;
 
-	return rate;
+	return DIV_ROUND_UP_ULL(rate, synth_div_m);
 }
 
 static struct clk_ops ti_fapll_synt_ops = {
-- 
2.1.4

