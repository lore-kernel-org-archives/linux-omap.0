From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 2/7] ARM: OMAP2+: Remove hard-coded test on timer ID
Date: Mon, 4 Feb 2013 13:46:31 -0600
Message-ID: <1360007196-21350-3-git-send-email-jon-hunter@ti.com>
References: <1360007196-21350-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54358 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754733Ab3BDTrR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 14:47:17 -0500
In-Reply-To: <1360007196-21350-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Jon Hunter <jon-hunter@ti.com>

Currently, when configuring the clock-events and clock-source timers
for OMAP2+ devices, we check whether the timer ID is 12 before
attempting to set the parent clock for the timer.

This test was added for OMAP3 general purpose devices (no security
features enabled) that a 12th timer available but unlike the other
timers only has a single functional clock source. Calling
clk_set_parent() for this 12th timer would always return an error
because there is only one choice for a parent clock. Therefore,
this hard-coded timer ID test was added.

To avoid this timer ID test, simply check to see if the timer's current
parent clock is the desired parent clock and only call clk_set_parent()
if this is not the case.

Also if clk_get() fails, then use PTR_ERR() to return the error code.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 83118fb..c6b3fdd 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -224,6 +224,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	struct device_node *np;
 	struct omap_hwmod *oh;
 	struct resource irq, mem;
+	struct clk *src;
 	int r = 0;
 
 	if (of_have_populated_dt()) {
@@ -278,24 +279,24 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	/* After the dmtimer is using hwmod these clocks won't be needed */
 	timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
 	if (IS_ERR(timer->fclk))
-		return -ENODEV;
+		return PTR_ERR(timer->fclk);
+
+	src = clk_get(NULL, fck_source);
+	if (IS_ERR(src))
+		return PTR_ERR(src);
 
-	/* FIXME: Need to remove hard-coded test on timer ID */
-	if (gptimer_id != 12) {
-		struct clk *src;
-
-		src = clk_get(NULL, fck_source);
-		if (IS_ERR(src)) {
-			r = -EINVAL;
-		} else {
-			r = clk_set_parent(timer->fclk, src);
-			if (IS_ERR_VALUE(r))
-				pr_warn("%s: %s cannot set source\n",
-					__func__, oh->name);
+	if (clk_get_parent(timer->fclk) != src) {
+		r = clk_set_parent(timer->fclk, src);
+		if (IS_ERR_VALUE(r)) {
+			pr_warn("%s: %s cannot set source\n", __func__,
+				oh->name);
 			clk_put(src);
+			return r;
 		}
 	}
 
+	clk_put(src);
+
 	omap_hwmod_setup_one(oh_name);
 	omap_hwmod_enable(oh);
 	__omap_dm_timer_init_regs(timer);
-- 
1.7.10.4

