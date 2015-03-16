From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] clk: ti: clk-3xxx: Correct McBSP related DT clock definitions
Date: Mon, 16 Mar 2015 12:40:57 +0200
Message-ID: <1426502458-6124-2-git-send-email-peter.ujfalusi@ti.com>
References: <1426502458-6124-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426502458-6124-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@linaro.org, sboyd@codeaurora.org
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In DT boot we do not have devices named as omap-mcbsp.X.
Correct the McBSP2/4 ick mapping (they were 2->4 and 4->2).
Collect the McBSP clock definition in one location at the same time.

Fixes the following warning on boot:
[    0.307739] omap_hwmod: mcbsp2: _wait_target_ready failed: -16
[    0.307769] omap_hwmod: mcbsp2: cannot be enabled for reset (3)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/clk/ti/clk-3xxx.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 383a06e49b09..757636d166cf 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -34,7 +34,6 @@ static struct ti_dt_clk omap3xxx_clks[] = {
 	DT_CLK(NULL, "omap_96m_alwon_fck", "omap_96m_alwon_fck"),
 	DT_CLK("etb", "emu_core_alwon_ck", "emu_core_alwon_ck"),
 	DT_CLK(NULL, "sys_altclk", "sys_altclk"),
-	DT_CLK(NULL, "mcbsp_clks", "mcbsp_clks"),
 	DT_CLK(NULL, "sys_clkout1", "sys_clkout1"),
 	DT_CLK(NULL, "dpll1_ck", "dpll1_ck"),
 	DT_CLK(NULL, "dpll1_x2_ck", "dpll1_x2_ck"),
@@ -82,8 +81,6 @@ static struct ti_dt_clk omap3xxx_clks[] = {
 	DT_CLK(NULL, "i2c3_fck", "i2c3_fck"),
 	DT_CLK(NULL, "i2c2_fck", "i2c2_fck"),
 	DT_CLK(NULL, "i2c1_fck", "i2c1_fck"),
-	DT_CLK(NULL, "mcbsp5_fck", "mcbsp5_fck"),
-	DT_CLK(NULL, "mcbsp1_fck", "mcbsp1_fck"),
 	DT_CLK(NULL, "core_48m_fck", "core_48m_fck"),
 	DT_CLK(NULL, "mcspi4_fck", "mcspi4_fck"),
 	DT_CLK(NULL, "mcspi3_fck", "mcspi3_fck"),
@@ -122,10 +119,6 @@ static struct ti_dt_clk omap3xxx_clks[] = {
 	DT_CLK(NULL, "uart1_ick", "uart1_ick"),
 	DT_CLK(NULL, "gpt11_ick", "gpt11_ick"),
 	DT_CLK(NULL, "gpt10_ick", "gpt10_ick"),
-	DT_CLK("omap-mcbsp.5", "ick", "mcbsp5_ick"),
-	DT_CLK("omap-mcbsp.1", "ick", "mcbsp1_ick"),
-	DT_CLK(NULL, "mcbsp5_ick", "mcbsp5_ick"),
-	DT_CLK(NULL, "mcbsp1_ick", "mcbsp1_ick"),
 	DT_CLK(NULL, "omapctrl_ick", "omapctrl_ick"),
 	DT_CLK(NULL, "dss_tv_fck", "dss_tv_fck"),
 	DT_CLK(NULL, "dss_96m_fck", "dss_96m_fck"),
@@ -179,15 +172,17 @@ static struct ti_dt_clk omap3xxx_clks[] = {
 	DT_CLK(NULL, "gpt4_ick", "gpt4_ick"),
 	DT_CLK(NULL, "gpt3_ick", "gpt3_ick"),
 	DT_CLK(NULL, "gpt2_ick", "gpt2_ick"),
-	DT_CLK("omap-mcbsp.2", "ick", "mcbsp2_ick"),
-	DT_CLK("omap-mcbsp.3", "ick", "mcbsp3_ick"),
-	DT_CLK("omap-mcbsp.4", "ick", "mcbsp4_ick"),
-	DT_CLK(NULL, "mcbsp4_ick", "mcbsp2_ick"),
+	DT_CLK(NULL, "mcbsp_clks", "mcbsp_clks"),
+	DT_CLK(NULL, "mcbsp1_ick", "mcbsp1_ick"),
+	DT_CLK(NULL, "mcbsp2_ick", "mcbsp2_ick"),
 	DT_CLK(NULL, "mcbsp3_ick", "mcbsp3_ick"),
-	DT_CLK(NULL, "mcbsp2_ick", "mcbsp4_ick"),
+	DT_CLK(NULL, "mcbsp4_ick", "mcbsp4_ick"),
+	DT_CLK(NULL, "mcbsp5_ick", "mcbsp5_ick"),
+	DT_CLK(NULL, "mcbsp1_fck", "mcbsp1_fck"),
 	DT_CLK(NULL, "mcbsp2_fck", "mcbsp2_fck"),
 	DT_CLK(NULL, "mcbsp3_fck", "mcbsp3_fck"),
 	DT_CLK(NULL, "mcbsp4_fck", "mcbsp4_fck"),
+	DT_CLK(NULL, "mcbsp5_fck", "mcbsp5_fck"),
 	DT_CLK("etb", "emu_src_ck", "emu_src_ck"),
 	DT_CLK(NULL, "emu_src_ck", "emu_src_ck"),
 	DT_CLK(NULL, "pclk_fck", "pclk_fck"),
-- 
2.3.0
