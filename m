From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix bogus struct clk comparison for timer clock
Date: Tue,  5 May 2015 11:02:21 -0700
Message-ID: <1430848941-27106-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nov-007-i575.relay.mailchannels.net ([46.232.183.129]:8704 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756066AbbEESCu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2015 14:02:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Michael Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

With recent changes to use determine_rate, the comparison of two
clocks won't work without doing __clk_get_hw on the clocks
first.

Cc: Michael Turquette <mturquette@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Found one more of these, the coccinelle scripts do not seem
to match this?

---
 arch/arm/mach-omap2/timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index cef67af..22c7a8e 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -35,6 +35,7 @@
 #include <linux/irq.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
+#include <linux/clk-provider.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -298,7 +299,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
-	if (clk_get_parent(timer->fclk) != src) {
+	if (__clk_get_hw(clk_get_parent(timer->fclk)) != __clk_get_hw(src)) {
 		r = clk_set_parent(timer->fclk, src);
 		if (r < 0) {
 			pr_warn("%s: %s cannot set source\n", __func__,
-- 
2.1.4

