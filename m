From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/5] ARM: OMAP2+: Remove hard-coded test on timer ID
Date: Wed, 30 Jan 2013 11:04:28 -0600
Message-ID: <1359565471-30721-3-git-send-email-jon-hunter@ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48859 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756005Ab3A3REl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jan 2013 12:04:41 -0500
In-Reply-To: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

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

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 18cb856..69fe623b 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -225,6 +225,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	struct device_node *np;
 	struct omap_hwmod *oh;
 	struct resource irq, mem;
+	struct clk *src;
 	int r = 0;
 
 	if (of_have_populated_dt()) {
@@ -279,22 +280,19 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (IS_ERR(timer->fclk))
 		return -ENODEV;
 
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
-			clk_put(src);
-		}
+	src = clk_get(NULL, fck_source);
+	if (IS_ERR(src))
+		return -EINVAL;
+
+	if (clk_get_parent(timer->fclk) != src) {
+		r = clk_set_parent(timer->fclk, src);
+		if (IS_ERR_VALUE(r))
+			pr_warn("%s: %s cannot set source\n",
+				__func__, oh->name);
 	}
 
+	clk_put(src);
+
 	omap_hwmod_setup_one(*name);
 	omap_hwmod_enable(oh);
 	__omap_dm_timer_init_regs(timer);
-- 
1.7.10.4

