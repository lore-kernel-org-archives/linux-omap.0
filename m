From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 11/27] clk: ti: dm816x: cleanup unnecessary clock aliases
Date: Mon, 30 Oct 2017 15:04:29 +0200
Message-ID: <1509368685-29112-12-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Most of the clock aliases are no longer needed, only leave the ones
required by OMAP timer code in place.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-816x.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
index 2a5d84f..ac9c94a 100644
--- a/drivers/clk/ti/clk-816x.c
+++ b/drivers/clk/ti/clk-816x.c
@@ -19,24 +19,8 @@
 static struct ti_dt_clk dm816x_clks[] = {
 	DT_CLK(NULL, "sys_clkin", "sys_clkin_ck"),
 	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK(NULL, "sys_32k_ck", "sys_32k_ck"),
 	DT_CLK(NULL, "timer_32k_ck", "sysclk18_ck"),
 	DT_CLK(NULL, "timer_ext_ck", "tclkin_ck"),
-	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
-	DT_CLK(NULL, "timer1_fck", "timer1_fck"),
-	DT_CLK(NULL, "timer2_fck", "timer2_fck"),
-	DT_CLK(NULL, "timer3_fck", "timer3_fck"),
-	DT_CLK(NULL, "timer4_fck", "timer4_fck"),
-	DT_CLK(NULL, "timer5_fck", "timer5_fck"),
-	DT_CLK(NULL, "timer6_fck", "timer6_fck"),
-	DT_CLK(NULL, "timer7_fck", "timer7_fck"),
-	DT_CLK(NULL, "sysclk4_ck", "sysclk4_ck"),
-	DT_CLK(NULL, "sysclk5_ck", "sysclk5_ck"),
-	DT_CLK(NULL, "sysclk6_ck", "sysclk6_ck"),
-	DT_CLK(NULL, "sysclk10_ck", "sysclk10_ck"),
-	DT_CLK(NULL, "sysclk18_ck", "sysclk18_ck"),
-	DT_CLK(NULL, "sysclk24_ck", "sysclk24_ck"),
-	DT_CLK("4a100000.ethernet", "sysclk24_ck", "sysclk24_ck"),
 	{ .node_name = NULL },
 };
 
@@ -50,6 +34,7 @@ int __init dm816x_dt_clk_init(void)
 {
 	ti_dt_clocks_register(dm816x_clks);
 	omap2_clk_disable_autoidle_all();
+	ti_clk_add_aliases();
 	omap2_clk_enable_init_clocks(enable_init_clks,
 				     ARRAY_SIZE(enable_init_clks));
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
