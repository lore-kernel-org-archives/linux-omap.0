From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] clk: ti: clk-3xxx-legacy: Correct McBSP related clock aliases
Date: Mon, 16 Mar 2015 12:40:58 +0200
Message-ID: <1426502458-6124-3-git-send-email-peter.ujfalusi@ti.com>
References: <1426502458-6124-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426502458-6124-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@linaro.org, sboyd@codeaurora.org
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Correct the McBSP2/4 ick mapping (they were 2->4 and 4->2).
Add missing mcbsp clock aliases.
Collect the McBSP clock definition in one location at the same time.

Fixes the following warning on boot:
[    0.307739] omap_hwmod: mcbsp2: _wait_target_ready failed: -16
[    0.307769] omap_hwmod: mcbsp2: cannot be enabled for reset (3)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/clk/ti/clk-3xxx-legacy.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/ti/clk-3xxx-legacy.c b/drivers/clk/ti/clk-3xxx-legacy.c
index e0732a4c8f26..0b61548d569b 100644
--- a/drivers/clk/ti/clk-3xxx-legacy.c
+++ b/drivers/clk/ti/clk-3xxx-legacy.c
@@ -4320,7 +4320,6 @@ static struct ti_clk_alias omap3xxx_clks[] = {
 	CLK(NULL, "dpll3_m3x2_ck", &dpll3_m3x2_ck),
 	CLK("etb", "emu_core_alwon_ck", &emu_core_alwon_ck),
 	CLK(NULL, "sys_altclk", &sys_altclk),
-	CLK(NULL, "mcbsp_clks", &mcbsp_clks),
 	CLK(NULL, "sys_clkout1", &sys_clkout1),
 	CLK(NULL, "dpll3_m2_ck", &dpll3_m2_ck),
 	CLK(NULL, "core_ck", &core_ck),
@@ -4369,8 +4368,6 @@ static struct ti_clk_alias omap3xxx_clks[] = {
 	CLK(NULL, "i2c3_fck", &i2c3_fck),
 	CLK(NULL, "i2c2_fck", &i2c2_fck),
 	CLK(NULL, "i2c1_fck", &i2c1_fck),
-	CLK(NULL, "mcbsp5_fck", &mcbsp5_fck),
-	CLK(NULL, "mcbsp1_fck", &mcbsp1_fck),
 	CLK(NULL, "core_48m_fck", &core_48m_fck),
 	CLK(NULL, "mcspi4_fck", &mcspi4_fck),
 	CLK(NULL, "mcspi3_fck", &mcspi3_fck),
@@ -4409,8 +4406,6 @@ static struct ti_clk_alias omap3xxx_clks[] = {
 	CLK(NULL, "uart1_ick", &uart1_ick),
 	CLK(NULL, "gpt11_ick", &gpt11_ick),
 	CLK(NULL, "gpt10_ick", &gpt10_ick),
-	CLK("omap-mcbsp.5", "ick", &mcbsp5_ick),
-	CLK("omap-mcbsp.1", "ick", &mcbsp1_ick),
 	CLK(NULL, "mcbsp5_ick", &mcbsp5_ick),
 	CLK(NULL, "mcbsp1_ick", &mcbsp1_ick),
 	CLK(NULL, "omapctrl_ick", &omapctrl_ick),
@@ -4467,15 +4462,22 @@ static struct ti_clk_alias omap3xxx_clks[] = {
 	CLK(NULL, "gpt4_ick", &gpt4_ick),
 	CLK(NULL, "gpt3_ick", &gpt3_ick),
 	CLK(NULL, "gpt2_ick", &gpt2_ick),
+	CLK(NULL, "mcbsp_clks", &mcbsp_clks),
+	CLK("omap-mcbsp.1", "ick", &mcbsp1_ick),
 	CLK("omap-mcbsp.2", "ick", &mcbsp2_ick),
 	CLK("omap-mcbsp.3", "ick", &mcbsp3_ick),
 	CLK("omap-mcbsp.4", "ick", &mcbsp4_ick),
-	CLK(NULL, "mcbsp4_ick", &mcbsp2_ick),
+	CLK("omap-mcbsp.5", "ick", &mcbsp5_ick),
+	CLK(NULL, "mcbsp1_ick", &mcbsp1_ick),
+	CLK(NULL, "mcbsp2_ick", &mcbsp2_ick),
 	CLK(NULL, "mcbsp3_ick", &mcbsp3_ick),
-	CLK(NULL, "mcbsp2_ick", &mcbsp4_ick),
+	CLK(NULL, "mcbsp4_ick", &mcbsp4_ick),
+	CLK(NULL, "mcbsp5_ick", &mcbsp5_ick),
+	CLK(NULL, "mcbsp1_fck", &mcbsp1_fck),
 	CLK(NULL, "mcbsp2_fck", &mcbsp2_fck),
 	CLK(NULL, "mcbsp3_fck", &mcbsp3_fck),
 	CLK(NULL, "mcbsp4_fck", &mcbsp4_fck),
+	CLK(NULL, "mcbsp5_fck", &mcbsp5_fck),
 	CLK(NULL, "emu_src_mux_ck", &emu_src_mux_ck),
 	CLK("etb", "emu_src_ck", &emu_src_ck),
 	CLK(NULL, "emu_src_mux_ck", &emu_src_mux_ck),
-- 
2.3.0
