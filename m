From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] ARM: AM43xx: clk: Change the wdt1 func clk src to per_32k clk
Date: Wed, 16 Apr 2014 09:44:08 +0530
Message-ID: <1397621648-15691-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46252 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaDPEOm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2014 00:14:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, t-kristo@ti.com, rnayak@ti.com, nsekhar@ti.com, lokeshvutla@ti.com

WDT1 module can take one of the below clocks as input functional
clock -
	- On-Chip 32K RC Osc [default/reset]
	- 32K from PRCM

The On-Chip 32K RC Osc clock is not an accurate clock-source as per
the design/spec, so as a result, for example, timer which supposed
to get expired @60Sec, but will expire somewhere ~@40Sec, which is
not expected by any use-case.

The solution here is to switch the input clock-source to PRCM
generated 32K clock-source during boot-time itself.
This is derived from AM33xx clock file.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/clk/ti/clk-43xx.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index 67c8de5..ae2524e 100644
--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -110,9 +110,22 @@ static struct ti_dt_clk am43xx_clks[] = {
 
 int __init am43xx_dt_clk_init(void)
 {
+	struct clk *clk1, *clk2;
+
 	ti_dt_clocks_register(am43xx_clks);
 
 	omap2_clk_disable_autoidle_all();
 
+	/*
+	 * The On-Chip 32K RC Osc clock is not an accurate clock-source as per
+	 * the design/spec, so as a result, for example, timer which supposed
+	 * to get expired @60Sec, but will expire somewhere ~@40Sec, which is
+	 * not expected by any use-case, so change WDT1 clock source to PRCM
+	 * 32KHz clock.
+	 */
+	clk1 = clk_get_sys(NULL, "wdt1_fck");
+	clk2 = clk_get_sys(NULL, "clkdiv32k_ick");
+	clk_set_parent(clk1, clk2);
+
 	return 0;
 }
-- 
1.7.9.5

