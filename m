From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/4] CLK: TI: OMAP5: Correct the DT clock aliases for timers
Date: Fri, 13 Mar 2015 17:58:36 -0500
Message-ID: <1426287518-47786-3-git-send-email-s-anna@ti.com>
References: <1426287518-47786-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426287518-47786-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

The DT clock aliases for Timers use the legacy (non-DT) device
names and a source clock named sys_ck. OMAP5 is DT-boot only,
so correct the DT clock aliases to use the DT device names
instead. Also, the source clock name is corrected from 'sys_ck'
to 'timer_sys_ck', the name used by the OMAP dmtimer driver.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/clk/ti/clk-54xx.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
index 14160b223548..96c69a335975 100644
--- a/drivers/clk/ti/clk-54xx.c
+++ b/drivers/clk/ti/clk-54xx.c
@@ -208,17 +208,17 @@ static struct ti_dt_clk omap54xx_clks[] = {
 	DT_CLK("usbhs_omap", "usbtll_fck", "dummy_ck"),
 	DT_CLK("omap_wdt", "ick", "dummy_ck"),
 	DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
-	DT_CLK("omap_timer.1", "sys_ck", "sys_clkin"),
-	DT_CLK("omap_timer.2", "sys_ck", "sys_clkin"),
-	DT_CLK("omap_timer.3", "sys_ck", "sys_clkin"),
-	DT_CLK("omap_timer.4", "sys_ck", "sys_clkin"),
-	DT_CLK("omap_timer.9", "sys_ck", "sys_clkin"),
-	DT_CLK("omap_timer.10", "sys_ck", "sys_clkin"),
-	DT_CLK("omap_timer.11", "sys_ck", "sys_clkin"),
-	DT_CLK("omap_timer.5", "sys_ck", "dss_syc_gfclk_div"),
-	DT_CLK("omap_timer.6", "sys_ck", "dss_syc_gfclk_div"),
-	DT_CLK("omap_timer.7", "sys_ck", "dss_syc_gfclk_div"),
-	DT_CLK("omap_timer.8", "sys_ck", "dss_syc_gfclk_div"),
+	DT_CLK("4ae18000.timer", "timer_sys_ck", "sys_clkin"),
+	DT_CLK("48032000.timer", "timer_sys_ck", "sys_clkin"),
+	DT_CLK("48034000.timer", "timer_sys_ck", "sys_clkin"),
+	DT_CLK("48036000.timer", "timer_sys_ck", "sys_clkin"),
+	DT_CLK("4803e000.timer", "timer_sys_ck", "sys_clkin"),
+	DT_CLK("48086000.timer", "timer_sys_ck", "sys_clkin"),
+	DT_CLK("48088000.timer", "timer_sys_ck", "sys_clkin"),
+	DT_CLK("40138000.timer", "timer_sys_ck", "dss_syc_gfclk_div"),
+	DT_CLK("4013a000.timer", "timer_sys_ck", "dss_syc_gfclk_div"),
+	DT_CLK("4013c000.timer", "timer_sys_ck", "dss_syc_gfclk_div"),
+	DT_CLK("4013e000.timer", "timer_sys_ck", "dss_syc_gfclk_div"),
 	{ .node_name = NULL },
 };
 
-- 
2.3.2
