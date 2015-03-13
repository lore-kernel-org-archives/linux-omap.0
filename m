From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/4] CLK: TI: OMAP4: Remove the legacy timer DT clock aliases
Date: Fri, 13 Mar 2015 17:58:35 -0500
Message-ID: <1426287518-47786-2-git-send-email-s-anna@ti.com>
References: <1426287518-47786-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426287518-47786-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

The DT clock aliases for timers using the legacy OMAP timer
device names have been cleaned up. These device names reflect
the names used in legacy boot, and are no longer applicable
as OMAP4 is DT boot only now.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/clk/ti/clk-44xx.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 4f4c87751db5..581db7711f51 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -249,17 +249,6 @@ static struct ti_dt_clk omap44xx_clks[] = {
 	DT_CLK("usbhs_tll", "usbtll_fck", "dummy_ck"),
 	DT_CLK("omap_wdt", "ick", "dummy_ck"),
 	DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
-	DT_CLK("omap_timer.1", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("omap_timer.2", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("omap_timer.3", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("omap_timer.4", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("omap_timer.9", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("omap_timer.10", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("omap_timer.11", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("omap_timer.5", "timer_sys_ck", "syc_clk_div_ck"),
-	DT_CLK("omap_timer.6", "timer_sys_ck", "syc_clk_div_ck"),
-	DT_CLK("omap_timer.7", "timer_sys_ck", "syc_clk_div_ck"),
-	DT_CLK("omap_timer.8", "timer_sys_ck", "syc_clk_div_ck"),
 	DT_CLK("4a318000.timer", "timer_sys_ck", "sys_clkin_ck"),
 	DT_CLK("48032000.timer", "timer_sys_ck", "sys_clkin_ck"),
 	DT_CLK("48034000.timer", "timer_sys_ck", "sys_clkin_ck"),
-- 
2.3.2
