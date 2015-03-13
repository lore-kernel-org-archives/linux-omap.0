From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 4/4] CLK: TI: DRA7: Add timer_sys_ck aliases for Timers 13 through 16
Date: Fri, 13 Mar 2015 17:58:38 -0500
Message-ID: <1426287518-47786-5-git-send-email-s-anna@ti.com>
References: <1426287518-47786-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426287518-47786-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

The OMAP DMTimer API, omap_dm_timer_set_source(), uses the clock name
timer_sys_ck for setting a timer's clock source for the source index
OMAP_TIMER_SRC_SYS_CLK. There is currently no clock alias data for
the Timers 13 through 16 for this clock name, so add the same.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/clk/ti/clk-7xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index 256295eb5157..5d2217ae4478 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -300,6 +300,10 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK("48822000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK("48824000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK("48826000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("48828000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("4882a000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("4882c000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("4882e000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK(NULL, "sys_clkin", "sys_clkin1"),
 	{ .node_name = NULL },
 };
-- 
2.3.2
