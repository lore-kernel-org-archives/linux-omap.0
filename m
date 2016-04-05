From: Suman Anna <s-anna@ti.com>
Subject: [PATCH] clk: ti: dflt: remove redundant unlikely
Date: Tue, 5 Apr 2016 13:28:57 -0500
Message-ID: <1459880937-22349-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Commit 7aba4f5201d1 ("clk: ti: dflt: fix enable_reg validity check")
fixed a validation check by using an IS_ERR() macro within the
existing unlikely expression, but IS_ERR() macro already has an
unlikely inside it, so get rid of the redundant unlikely macro
from the validation check.

Reported-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/clk/ti/clkt_dflt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clkt_dflt.c b/drivers/clk/ti/clkt_dflt.c
index 1ddc288fce4e..c6ae563801d7 100644
--- a/drivers/clk/ti/clkt_dflt.c
+++ b/drivers/clk/ti/clkt_dflt.c
@@ -222,7 +222,7 @@ int omap2_dflt_clk_enable(struct clk_hw *hw)
 		}
 	}
 
-	if (unlikely(IS_ERR(clk->enable_reg))) {
+	if (IS_ERR(clk->enable_reg)) {
 		pr_err("%s: %s missing enable_reg\n", __func__,
 		       clk_hw_get_name(hw));
 		ret = -EINVAL;
-- 
2.7.4

