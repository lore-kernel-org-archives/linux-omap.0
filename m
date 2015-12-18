From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 4/9] clk: ti: mux: export mux clock APIs locally
Date: Fri, 18 Dec 2015 15:58:56 +0200
Message-ID: <1450447141-29936-5-git-send-email-t-kristo@ti.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
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
index 69f08a1..d723dad 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -28,7 +28,7 @@
 
 #define to_clk_mux(_hw) container_of(_hw, struct clk_mux, hw)
 
-static u8 ti_clk_mux_get_parent(struct clk_hw *hw)
+u8 ti_clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
 	int num_parents = clk_hw_get_num_parents(hw);
@@ -65,7 +65,7 @@ static u8 ti_clk_mux_get_parent(struct clk_hw *hw)
 	return val;
 }
 
-static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
 	u32 val;
-- 
1.7.9.5

