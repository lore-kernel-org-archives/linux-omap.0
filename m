From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/27] clk: ti: clkctrl: fix flags for mux and divider opt clocks
Date: Mon, 30 Oct 2017 15:04:24 +0200
Message-ID: <1509368685-29112-7-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Flag handling was missing for these two, so add it.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clkctrl.c | 12 ++++++++++--
 drivers/clk/ti/clock.h   |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 0f78219..fe44fbe 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -324,6 +324,9 @@ static struct clk_hw *_ti_omap4_clkctrl_xlate(struct of_phandle_args *clkspec,
 	}
 
 	mux->mask = num_parents;
+	if (!(mux->flags & CLK_MUX_INDEX_ONE))
+		mux->mask--;
+
 	mux->mask = (1 << fls(mux->mask)) - 1;
 
 	mux->shift = data->bit;
@@ -343,6 +346,7 @@ static struct clk_hw *_ti_omap4_clkctrl_xlate(struct of_phandle_args *clkspec,
 {
 	struct clk_omap_divider *div;
 	const struct omap_clkctrl_div_data *div_data = data->data;
+	u8 div_flags = 0;
 
 	div = kzalloc(sizeof(*div), GFP_KERNEL);
 	if (!div)
@@ -350,9 +354,13 @@ static struct clk_hw *_ti_omap4_clkctrl_xlate(struct of_phandle_args *clkspec,
 
 	div->reg.ptr = reg;
 	div->shift = data->bit;
+	div->flags = div_data->flags;
+
+	if (div->flags & CLK_DIVIDER_POWER_OF_TWO)
+		div_flags |= CLKF_INDEX_POWER_OF_TWO;
 
-	if (ti_clk_parse_divider_data((int *)div_data->dividers,
-				      div_data->max_div, 0, 0,
+	if (ti_clk_parse_divider_data((int *)div_data->dividers, 0,
+				      div_data->max_div, div_flags,
 				      &div->width, &div->table)) {
 		pr_err("%s: Data parsing for %pOF:%04x:%d failed\n", __func__,
 		       node, offset, data->bit);
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 169241f..fc754e2 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -207,6 +207,7 @@ struct ti_dt_clk {
 struct omap_clkctrl_div_data {
 	const int *dividers;
 	int max_div;
+	u32 flags;
 };
 
 struct omap_clkctrl_bit_data {
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
