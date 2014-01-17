From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Fri, 17 Jan 2014 09:44:59 +0200
Message-ID: <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46873 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbaAQHph (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jan 2014 02:45:37 -0500
In-Reply-To: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omap2_dpll_round_rate() doesn't actually round the given rate, even if
the name and the description so hints. Instead it only tries to find an
exact rate match, or if that fails, return ~0 as an error.

What this basically means is that the user of the clock needs to know
what rates the dpll can support, which obviously isn't right.

This patch adds a simple method of rounding: during the iteration, the
code keeps track of the closest rate match. If no exact match is found,
the closest is returned.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 1f1708ef77bb..1b4e68dfb713 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -298,6 +298,7 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 	struct dpll_data *dd;
 	unsigned long ref_rate;
 	const char *clk_name;
+	unsigned long diff, closest_diff = ~0;
 
 	if (!clk || !clk->dpll_data)
 		return ~0;
@@ -345,20 +346,26 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 		pr_debug("clock: %s: m = %d: n = %d: new_rate = %lu\n",
 			 clk_name, m, n, new_rate);
 
-		if (target_rate == new_rate) {
+		diff = max(target_rate, new_rate) - min(target_rate, new_rate);
+
+		if (diff < closest_diff) {
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
+	return dd->last_rounded_rate;
 }
 
-- 
1.8.3.2

