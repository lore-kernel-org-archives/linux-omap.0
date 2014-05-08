From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/3] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Thu, 8 May 2014 12:06:48 +0300
Message-ID: <1399540009-6953-2-git-send-email-tomi.valkeinen@ti.com>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51785 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397AbaEHJHJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 05:07:09 -0400
In-Reply-To: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omap2_dpll_round_rate() doesn't actually round the given rate, even if
the name and the description so hints. Instead it only tries to find an
exact rate match, or if that fails, return ~0 as an error.

What this basically means is that the user of the clock needs to know
what rates the dpll can support, which obviously isn't right.

This patch adds a simple method of rounding: during the iteration, the
code keeps track of the closest rate match. If no exact match is found,
the closest is returned.

However, as it is unclear whether current drivers rely on the current
behavior, the rounding functionality not enabled by default, but by
setting DPLL_USE_ROUNDED_RATE for the DPLL.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 332af927f4d3..ddbb8d003719 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -298,6 +298,8 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 	struct dpll_data *dd;
 	unsigned long ref_rate;
 	const char *clk_name;
+	unsigned long diff, closest_diff = ~0;
+	bool use_rounding = clk->flags & DPLL_USE_ROUNDED_RATE;
 
 	if (!clk || !clk->dpll_data)
 		return ~0;
@@ -345,20 +347,31 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 		pr_debug("clock: %s: m = %d: n = %d: new_rate = %lu\n",
 			 clk_name, m, n, new_rate);
 
-		if (target_rate == new_rate) {
+		diff = max(target_rate, new_rate) - min(target_rate, new_rate);
+
+		if ((use_rounding && diff < closest_diff) ||
+			(!use_rounding && diff == 0)) {
+			closest_diff = diff;
+
 			dd->last_rounded_m = m;
 			dd->last_rounded_n = n;
-			dd->last_rounded_rate = target_rate;
-			break;
+			dd->last_rounded_rate = new_rate;
+
+			if (diff == 0)
+				break;
 		}
 	}
 
-	if (target_rate != new_rate) {
+	if (closest_diff == ~0) {
 		pr_debug("clock: %s: cannot round to rate %lu\n",
 			 clk_name, target_rate);
 		return ~0;
 	}
 
-	return target_rate;
+	if (closest_diff > 0)
+		pr_debug("clock: %s: rounded rate %lu to %lu\n",
+			 clk_name, target_rate, dd->last_rounded_rate);
+
+	return dd->last_rounded_rate;
 }
 
-- 
1.9.1

