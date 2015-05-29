From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/5] clk: ti: Use of_clk_get_parent_count() instead of open coding
Date: Fri, 29 May 2015 11:25:47 +0200
Message-ID: <1432891549-23295-4-git-send-email-geert+renesas@glider.be>
References: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:36859 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573AbbE2J0I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2015 05:26:08 -0400
In-Reply-To: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: linux-clk@vger.kernel.org, kernel@stlinux.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/ti/clockdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index 35fe1085480cf33d..b82ef07f34034105 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -32,7 +32,7 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
 	int i;
 	int num_clks;
 
-	num_clks = of_count_phandle_with_args(node, "clocks", "#clock-cells");
+	num_clks = of_clk_get_parent_count(node);
 
 	for (i = 0; i < num_clks; i++) {
 		clk = of_clk_get(node, i);
-- 
1.9.1

