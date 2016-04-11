From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 13/30] clk: ti: dm814x: transition to usage of ti_clk_get
Date: Mon, 11 Apr 2016 11:19:04 +0300
Message-ID: <1460362761-4842-14-git-send-email-t-kristo@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Cleanup any unnecessary DT_CLK() alias entries from the DM814x clock file.
Also, use ti_clk_get where necessary.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 drivers/clk/ti/clk-814x.c |   14 +-------------
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
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
