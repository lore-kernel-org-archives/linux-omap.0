From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 04/68] clk: ti: dra7: Fix mcasp8 clock bits
Date: Wed,  9 Oct 2019 13:04:43 -0400
Message-ID: <20191009170547.32204-4-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit dd8882a255388ba66175098b1560d4f81c100d30 ]

There's a typo for dra7 mcasp clkctrl bit, it should be 22 like the other
macasp instances, and not 24. And in dra7xx_clks[] we have the bits wrong
way around.

Fixes: dffa9051d546 ("clk: ti: dra7: add new clkctrl data")
Cc: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/clk-7xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index b57fe09b428be..9dd6185a4b4e2 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -683,7 +683,7 @@ static const struct omap_clkctrl_reg_data dra7_l4per2_clkctrl_regs[] __initconst
 	{ DRA7_L4PER2_MCASP2_CLKCTRL, dra7_mcasp2_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:0154:22" },
 	{ DRA7_L4PER2_MCASP3_CLKCTRL, dra7_mcasp3_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:015c:22" },
 	{ DRA7_L4PER2_MCASP5_CLKCTRL, dra7_mcasp5_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:016c:22" },
-	{ DRA7_L4PER2_MCASP8_CLKCTRL, dra7_mcasp8_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:0184:24" },
+	{ DRA7_L4PER2_MCASP8_CLKCTRL, dra7_mcasp8_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:0184:22" },
 	{ DRA7_L4PER2_MCASP4_CLKCTRL, dra7_mcasp4_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:018c:22" },
 	{ DRA7_L4PER2_UART7_CLKCTRL, dra7_uart7_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:01c4:24" },
 	{ DRA7_L4PER2_UART8_CLKCTRL, dra7_uart8_bit_data, CLKF_SW_SUP, "l4per2-clkctrl:01d4:24" },
@@ -828,8 +828,8 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK(NULL, "mcasp6_aux_gfclk_mux", "l4per2-clkctrl:01f8:22"),
 	DT_CLK(NULL, "mcasp7_ahclkx_mux", "l4per2-clkctrl:01fc:24"),
 	DT_CLK(NULL, "mcasp7_aux_gfclk_mux", "l4per2-clkctrl:01fc:22"),
-	DT_CLK(NULL, "mcasp8_ahclkx_mux", "l4per2-clkctrl:0184:22"),
-	DT_CLK(NULL, "mcasp8_aux_gfclk_mux", "l4per2-clkctrl:0184:24"),
+	DT_CLK(NULL, "mcasp8_ahclkx_mux", "l4per2-clkctrl:0184:24"),
+	DT_CLK(NULL, "mcasp8_aux_gfclk_mux", "l4per2-clkctrl:0184:22"),
 	DT_CLK(NULL, "mmc1_clk32k", "l3init-clkctrl:0008:8"),
 	DT_CLK(NULL, "mmc1_fclk_div", "l3init-clkctrl:0008:25"),
 	DT_CLK(NULL, "mmc1_fclk_mux", "l3init-clkctrl:0008:24"),
-- 
2.20.1
