From: Tero Kristo <t-kristo@ti.com>
Subject: [RESEND PATCHv2 17/28] clk: ti: dm814x: transition to usage of ti_clk_get
Date: Mon, 13 Jun 2016 22:04:51 +0300
Message-ID: <1465844702-12200-18-git-send-email-t-kristo@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Cleanup any unnecessary DT_CLK() alias entries from the DM814x clock file.
Also, use ti_clk_get where necessary.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-814x.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/clk/ti/clk-814x.c b/drivers/clk/ti/clk-814x.c
index 52c6efc..17dc99b 100644
--- a/drivers/clk/ti/clk-814x.c
+++ b/drivers/clk/ti/clk-814x.c
@@ -13,19 +13,7 @@
 #include "clock.h"
 
 static struct ti_dt_clk dm814_clks[] = {
-	DT_CLK(NULL, "devosc_ck", "devosc_ck"),
-	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
-	DT_CLK(NULL, "sysclk4_ck", "sysclk4_ck"),
-	DT_CLK(NULL, "sysclk5_ck", "sysclk5_ck"),
-	DT_CLK(NULL, "sysclk6_ck", "sysclk6_ck"),
-	DT_CLK(NULL, "sysclk8_ck", "sysclk8_ck"),
-	DT_CLK(NULL, "sysclk10_ck", "sysclk10_ck"),
-	DT_CLK(NULL, "sysclk18_ck", "sysclk18_ck"),
 	DT_CLK(NULL, "timer_sys_ck", "devosc_ck"),
-	DT_CLK(NULL, "timer1_fck", "timer1_fck"),
-	DT_CLK(NULL, "timer2_fck", "timer2_fck"),
-	DT_CLK(NULL, "cpsw_125mhz_gclk", "cpsw_125mhz_gclk"),
-	DT_CLK(NULL, "cpsw_cpts_rft_clk", "cpsw_cpts_rft_clk"),
 	{ .node_name = NULL },
 };
 
@@ -65,7 +53,7 @@ static int __init dm814x_adpll_enable_init_clocks(void)
 	for (i = 0; i < ARRAY_SIZE(init_clocks); i++) {
 		struct clk *clock;
 
-		clock = clk_get(NULL, init_clocks[i]);
+		clock = ti_clk_get(init_clocks[i]);
 		if (WARN(IS_ERR(clock), "could not find init clock %s\n",
 			 init_clocks[i]))
 			continue;
-- 
1.9.1

