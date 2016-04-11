From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 16/30] clk: ti: mux: export mux clock APIs locally
Date: Mon, 11 Apr 2016 11:19:07 +0300
Message-ID: <1460362761-4842-17-git-send-email-t-kristo@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

get_parent and set_parent are going to be required by the support of
module clocks, so export these locally.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clock.h |    3 +++
 drivers/clk/ti/mux.c   |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 90f3f47..7eca8a1 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -224,6 +224,9 @@ extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
 extern const struct clk_ops ti_clk_divider_ops;
 extern const struct clk_ops ti_clk_mux_ops;
 
+u8 ti_clk_mux_get_parent(struct clk_hw *hw);
+int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index);
+
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 44777ab..57ff471 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -26,7 +26,7 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
-static u8 ti_clk_mux_get_parent(struct clk_hw *hw)
+u8 ti_clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
 	int num_parents = clk_hw_get_num_parents(hw);
@@ -63,7 +63,7 @@ static u8 ti_clk_mux_get_parent(struct clk_hw *hw)
 	return val;
 }
 
-static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
 	u32 val;
-- 
1.7.9.5

