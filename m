From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] clk: qcom: common: fix legacy board-clock registration
Date: Sat, 11 Nov 2017 17:29:28 +0100
Message-ID: <20171111162929.11722-1-johan@kernel.org>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

Make sure to search only the child nodes of "/clocks", rather than the
whole device-tree depth-first starting at "/clocks" when determining
whether to register a fixed clock in the legacy board-clock registration
helper.

Fixes: ee15faffef11 ("clk: qcom: common: Add API to register board clocks backwards compatibly")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clk/qcom/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index b35564c0493f..b8064a336d46 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -133,8 +133,10 @@ static int _qcom_cc_register_board_clk(struct device *dev, const char *path,
 	int ret;
 
 	clocks_node = of_find_node_by_path("/clocks");
-	if (clocks_node)
-		node = of_find_node_by_name(clocks_node, path);
+	if (clocks_node) {
+		node = of_get_child_by_name(clocks_node, path);
+		of_node_put(clocks_node);
+	}
 
 	if (!node) {
 		fixed = devm_kzalloc(dev, sizeof(*fixed), GFP_KERNEL);
-- 
2.15.0

