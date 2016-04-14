From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 18/28] clk: ti: dm816x: cleanup any unnecessary clock aliases
Date: Thu, 14 Apr 2016 14:08:07 +0300
Message-ID: <1460632097-25727-19-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, sboyd@codeaurora.org, mturquette@baylibre.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Cleanup any unnecessary DT_CLK() alias entries from the DM816x clock file.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-816x.c |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
index 2a5d84f..e0a984e 100644
--- a/drivers/clk/ti/clk-816x.c
+++ b/drivers/clk/ti/clk-816x.c
@@ -17,25 +17,9 @@
 #include "clock.h"
 
 static struct ti_dt_clk dm816x_clks[] = {
-	DT_CLK(NULL, "sys_clkin", "sys_clkin_ck"),
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
 	DT_CLK("4a100000.ethernet", "sysclk24_ck", "sysclk24_ck"),
 	{ .node_name = NULL },
 };
-- 
1.7.9.5

