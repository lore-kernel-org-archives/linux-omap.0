From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] clk: ti: omap5: Add missing AESS clock
Date: Tue, 14 Jan 2020 07:06:07 -0800
Message-ID: <20200114150607.18092-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, "H . Nikolaus Schaller" <hns@goldelico.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

Looks like we're missing AESS clock for omap5. This is similar to what
omap4 has.

Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/ti/clk-54xx.c         | 15 +++++++++++++++
 include/dt-bindings/clock/omap5.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
--- a/drivers/clk/ti/clk-54xx.c
+++ b/drivers/clk/ti/clk-54xx.c
@@ -35,6 +35,20 @@ static const struct omap_clkctrl_reg_data omap5_dsp_clkctrl_regs[] __initconst =
 	{ 0 },
 };
 
+static const char * const omap5_aess_fclk_parents[] __initconst = {
+	"abe_clk",
+	NULL,
+};
+
+static const struct omap_clkctrl_div_data omap5_aess_fclk_data __initconst = {
+	.max_div = 2,
+};
+
+static const struct omap_clkctrl_bit_data omap5_aess_bit_data[] __initconst = {
+	{ 24, TI_CLK_DIVIDER, omap5_aess_fclk_parents, &omap5_aess_fclk_data },
+	{ 0 },
+};
+
 static const char * const omap5_dmic_gfclk_parents[] __initconst = {
 	"abe_cm:clk:0018:26",
 	"pad_clks_ck",
@@ -122,6 +136,7 @@ static const struct omap_clkctrl_bit_data omap5_timer8_bit_data[] __initconst =
 
 static const struct omap_clkctrl_reg_data omap5_abe_clkctrl_regs[] __initconst = {
 	{ OMAP5_L4_ABE_CLKCTRL, NULL, 0, "abe_iclk" },
+	{ OMAP5_AESS_CLKCTRL, omap5_aess_bit_data, CLKF_SW_SUP, "abe_cm:clk:0008:24" },
 	{ OMAP5_MCPDM_CLKCTRL, NULL, CLKF_SW_SUP, "pad_clks_ck" },
 	{ OMAP5_DMIC_CLKCTRL, omap5_dmic_bit_data, CLKF_SW_SUP, "abe_cm:clk:0018:24" },
 	{ OMAP5_MCBSP1_CLKCTRL, omap5_mcbsp1_bit_data, CLKF_SW_SUP, "abe_cm:clk:0028:24" },
diff --git a/include/dt-bindings/clock/omap5.h b/include/dt-bindings/clock/omap5.h
--- a/include/dt-bindings/clock/omap5.h
+++ b/include/dt-bindings/clock/omap5.h
@@ -16,6 +16,7 @@
 
 /* abe clocks */
 #define OMAP5_L4_ABE_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
+#define OMAP5_AESS_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x28)
 #define OMAP5_MCPDM_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x30)
 #define OMAP5_DMIC_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x38)
 #define OMAP5_MCBSP1_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x48)
-- 
2.24.1
