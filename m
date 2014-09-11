From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] CLK: TI: consider the fact that of_clk_get() might return an error
Date: Thu, 11 Sep 2014 18:01:12 +0200
Message-ID: <1410451272-31068-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41667 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854AbaIKQBQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 12:01:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I "forgot" to update the dtb and the kernel crashed:
|Unable to handle kernel NULL pointer dereference at virtual address 0000002e
|PC is at __clk_get_flags+0x4/0xc
|LR is at ti_dt_clockdomains_setup+0x70/0xe8

because I did not have the clock nodes. of_clk_get() returns an error
pointer which is not checked here.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/clk/ti/clockdomain.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index f1e0038d76ac..fdd458600c2c 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -36,6 +36,11 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
 
 	for (i = 0; i < num_clks; i++) {
 		clk = of_clk_get(node, i);
+		if (IS_ERR(clk)) {
+			pr_err("Failed get %s' clock nr %d (%ld)\n",
+					node->full_name, i, PTR_ERR(clk));
+			continue;
+		}
 		if (__clk_get_flags(clk) & CLK_IS_BASIC) {
 			pr_warn("can't setup clkdm for basic clk %s\n",
 				__clk_get_name(clk));
-- 
2.1.0

