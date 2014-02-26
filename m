From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v3 1/2] CLK: TI: OMAP4/5/DRA7: Remove gpmc_fck from dummy clocks
Date: Wed, 26 Feb 2014 11:38:08 +0100
Message-ID: <1393411089-9550-2-git-send-email-florian.vaussard@epfl.ch>
References: <1393411089-9550-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:57661 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbaBZKiY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Feb 2014 05:38:24 -0500
In-Reply-To: <1393411089-9550-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

When arch/arm/mach-omap2/gpmc.c calls clk_get(..., "fck"), it will
get a dummy clock and try to use it. As the rate is configured to zero,
this will result in several divisions by zero, and misconfigured
timings, with devices on the bus being lost in the La La Land.

It is better to remove gpmc_fck from the dummy clocks, so that gpmc.c
can fail gracefully.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 drivers/clk/ti/clk-44xx.c | 1 -
 drivers/clk/ti/clk-54xx.c | 1 -
 drivers/clk/ti/clk-7xx.c  | 1 -
 3 files changed, 3 deletions(-)

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
diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
index 0ef9f58..08f3d1b 100644
--- a/drivers/clk/ti/clk-54xx.c
+++ b/drivers/clk/ti/clk-54xx.c
@@ -182,7 +182,6 @@ static struct ti_dt_clk omap54xx_clks[] = {
 	DT_CLK(NULL, "auxclk3_src_ck", "auxclk3_src_ck"),
 	DT_CLK(NULL, "auxclk3_ck", "auxclk3_ck"),
 	DT_CLK(NULL, "auxclkreq3_ck", "auxclkreq3_ck"),
-	DT_CLK(NULL, "gpmc_ck", "dummy_ck"),
 	DT_CLK("omap_i2c.1", "ick", "dummy_ck"),
 	DT_CLK("omap_i2c.2", "ick", "dummy_ck"),
 	DT_CLK("omap_i2c.3", "ick", "dummy_ck"),
diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index 9977653..f7e4073 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -262,7 +262,6 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK(NULL, "vip1_gclk_mux", "vip1_gclk_mux"),
 	DT_CLK(NULL, "vip2_gclk_mux", "vip2_gclk_mux"),
 	DT_CLK(NULL, "vip3_gclk_mux", "vip3_gclk_mux"),
-	DT_CLK(NULL, "gpmc_ck", "dummy_ck"),
 	DT_CLK("omap_i2c.1", "ick", "dummy_ck"),
 	DT_CLK("omap_i2c.2", "ick", "dummy_ck"),
 	DT_CLK("omap_i2c.3", "ick", "dummy_ck"),
-- 
1.8.1.2

