From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 10/27] clk: ti: dm814x: cleanup unnecessary clock aliases
Date: Mon, 30 Oct 2017 15:04:28 +0200
Message-ID: <1509368685-29112-11-git-send-email-t-kristo@ti.com>
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
 drivers/clk/ti/clk-814x.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/clk/ti/clk-814x.c b/drivers/clk/ti/clk-814x.c
index 52c6efc..7dab941 100644
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
 
@@ -83,6 +71,7 @@ int __init dm814x_dt_clk_init(void)
 {
 	ti_dt_clocks_register(dm814_clks);
 	omap2_clk_disable_autoidle_all();
+	ti_clk_add_aliases();
 	omap2_clk_enable_init_clocks(NULL, 0);
 	timer_clocks_initialized = true;
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
