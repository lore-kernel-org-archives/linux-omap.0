From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 19/28] clk: ti: remove un-used definitions from public clk_hw_omap struct
Date: Thu, 14 Apr 2016 14:08:08 +0300
Message-ID: <1460632097-25727-20-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, sboyd@codeaurora.org, mturquette@baylibre.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Clksel support has been deprecated a while back, so remove these from
the struct also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 include/linux/clk/ti.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 210e946..1451291 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -127,8 +127,6 @@ struct clk_hw_omap_ops {
  * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
  * @flags: see "struct clk.flags possibilities" above
  * @clksel_reg: for clksel clks, register va containing src/divisor select
- * @clksel_mask: bitmask in @clksel_reg for the src/divisor selector
- * @clksel: for clksel clks, pointer to struct clksel for this clock
  * @dpll_data: for DPLLs, pointer to struct dpll_data for this clock
  * @clkdm_name: clockdomain name that this clock is contained in
  * @clkdm: pointer to struct clockdomain, resolved from @clkdm_name at runtime
@@ -143,8 +141,6 @@ struct clk_hw_omap {
 	u8			enable_bit;
 	u8			flags;
 	void __iomem		*clksel_reg;
-	u32			clksel_mask;
-	const struct clksel	*clksel;
 	struct dpll_data	*dpll_data;
 	const char		*clkdm_name;
 	struct clockdomain	*clkdm;
-- 
1.7.9.5

