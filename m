From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v3 4/5] clk: ti: DRA7: Add tbclk data for ehrpwm
Date: Thu, 25 Feb 2016 16:36:35 -0600
Message-ID: <1456439796-28546-5-git-send-email-fcooper@ti.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456439796-28546-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paul@pwsan.com, t-kristo@ti.com, tony@atomide.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

tbclk is needed by ehrpwm to generate pwm waveforms. Hence, register
the required clock information.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Acked-by: Michael Turquette <mturquette@baylibre.com>
---
Version 3 changes:
None

 drivers/clk/ti/clk-7xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index a911d7d..7fcf818 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -304,6 +304,9 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK("4882a000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK("4882c000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK("4882e000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("4843e200.ehrpwm", "tbclk", "ehrpwm0_tbclk"),
+	DT_CLK("48440200.ehrpwm", "tbclk", "ehrpwm1_tbclk"),
+	DT_CLK("48442200.ehrpwm", "tbclk", "ehrpwm2_tbclk"),
 	DT_CLK(NULL, "sys_clkin", "sys_clkin1"),
 	DT_CLK(NULL, "dss_deshdcp_clk", "dss_deshdcp_clk"),
 	{ .node_name = NULL },
-- 
2.7.0
