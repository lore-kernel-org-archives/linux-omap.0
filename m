From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/5] [RFC] ARM: timer-sp: Use of_clk_get_parent_count() instead of open coding
Date: Fri, 29 May 2015 11:25:49 +0200
Message-ID: <1432891549-23295-6-git-send-email-geert+renesas@glider.be>
References: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:42117 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662AbbE2J0K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2015 05:26:10 -0400
In-Reply-To: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: linux-clk@vger.kernel.org, kernel@stlinux.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is an RFC, as it depends on "[RFC] clk: Provide dummy
of_clk_get_parent_count() for !OF/!CCF".
---
 arch/arm/common/timer-sp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 19211324772f387c..be87a5d480ffb655 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -234,7 +235,7 @@ static void __init sp804_of_init(struct device_node *np)
 		clk1 = NULL;
 
 	/* Get the 2nd clock if the timer has 3 timer clocks */
-	if (of_count_phandle_with_args(np, "clocks", "#clock-cells") == 3) {
+	if (of_clk_get_parent_count(np) == 3) {
 		clk2 = of_clk_get(np, 1);
 		if (IS_ERR(clk2)) {
 			pr_err("sp804: %s clock not found: %d\n", np->name,
-- 
1.9.1

