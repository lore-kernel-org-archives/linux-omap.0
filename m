From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 3/4] CLK: TI: DRA7: Correct timer_sys_ck clock aliases for Timers
Date: Fri, 13 Mar 2015 17:58:37 -0500
Message-ID: <1426287518-47786-4-git-send-email-s-anna@ti.com>
References: <1426287518-47786-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426287518-47786-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

The OMAP DMTimer API, omap_dm_timer_set_source(), can set the parent
of a timer node using 3 different values that use fixed parent names
for the clocks. The parent name, timer_sys_ck, is used for setting the
parent when used with the source index OMAP_TIMER_SRC_SYS_CLK. This
should point to the TIMER_SYS_CLK and not the SYSCLKIN2, so correct
the clock aliases appropriately. SYSCLKIN2 is not a mandatory clock
input.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/clk/ti/clk-7xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index ee32f4deebf4..256295eb5157 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -289,13 +289,13 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK("usbhs_omap", "usbtll_fck", "dummy_ck"),
 	DT_CLK("omap_wdt", "ick", "dummy_ck"),
 	DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
-	DT_CLK("4ae18000.timer", "timer_sys_ck", "sys_clkin2"),
-	DT_CLK("48032000.timer", "timer_sys_ck", "sys_clkin2"),
-	DT_CLK("48034000.timer", "timer_sys_ck", "sys_clkin2"),
-	DT_CLK("48036000.timer", "timer_sys_ck", "sys_clkin2"),
-	DT_CLK("4803e000.timer", "timer_sys_ck", "sys_clkin2"),
-	DT_CLK("48086000.timer", "timer_sys_ck", "sys_clkin2"),
-	DT_CLK("48088000.timer", "timer_sys_ck", "sys_clkin2"),
+	DT_CLK("4ae18000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("48032000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("48034000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("48036000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("4803e000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("48086000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("48088000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK("48820000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK("48822000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK("48824000.timer", "timer_sys_ck", "timer_sys_clk_div"),
-- 
2.3.2
