From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 1/2] CLK: TI: OMAP4: Remove gpmc_fck from dummy clocks
Date: Mon, 17 Feb 2014 12:27:44 +0100
Message-ID: <1392636465-31459-2-git-send-email-florian.vaussard@epfl.ch>
References: <1392636465-31459-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:40519 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416AbaBQL2U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Feb 2014 06:28:20 -0500
In-Reply-To: <1392636465-31459-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

When arch/arm/mach-omap2/gpmc.c calls clk_get(..., "fck"), it will
get a dummy clock and try to use it. As the rate is configured to zero,
this will result in several divisions by zero, and misconfigured
timings, with devices on the bus being lost in the La La Land.

It is better to remove gpmc_fck from the dummy clocks, so that gpmc.c
can fail gracefully.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 drivers/clk/ti/clk-44xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index ae00218..02517a8 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -222,7 +222,6 @@ static struct ti_dt_clk omap44xx_clks[] = {
 	DT_CLK(NULL, "auxclk5_src_ck", "auxclk5_src_ck"),
 	DT_CLK(NULL, "auxclk5_ck", "auxclk5_ck"),
 	DT_CLK(NULL, "auxclkreq5_ck", "auxclkreq5_ck"),
-	DT_CLK("50000000.gpmc", "fck", "dummy_ck"),
 	DT_CLK("omap_i2c.1", "ick", "dummy_ck"),
 	DT_CLK("omap_i2c.2", "ick", "dummy_ck"),
 	DT_CLK("omap_i2c.3", "ick", "dummy_ck"),
-- 
1.8.1.2

