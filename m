From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 13/15] clk: ti: gate: export gate_clk_ops locally
Date: Mon, 13 Feb 2017 11:35:09 +0200
Message-ID: <1486978511-29668-14-git-send-email-t-kristo@ti.com>
References: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

These are going to be used by the clkctrl support that will be introduced
later.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clock.h | 1 +
 drivers/clk/ti/gate.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index a85f5c0..2605e2b 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -255,6 +255,7 @@ int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
 
 extern const struct clk_ops ti_clk_divider_ops;
 extern const struct clk_ops ti_clk_mux_ops;
+extern const struct clk_ops omap_gate_clk_ops;
 
 void omap2_init_clk_clkdm(struct clk_hw *hw);
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index a65f082..77f0920 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -35,7 +35,7 @@
 	.disable	= &omap2_clkops_disable_clkdm,
 };
 
-static const struct clk_ops omap_gate_clk_ops = {
+const struct clk_ops omap_gate_clk_ops = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable		= &omap2_dflt_clk_enable,
 	.disable	= &omap2_dflt_clk_disable,
-- 
1.9.1

