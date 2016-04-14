From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 02/28] clk: ti: dpll: use ti_clk_get to fetch ref/bypass clocks
Date: Thu, 14 Apr 2016 14:07:51 +0300
Message-ID: <1460632097-25727-3-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, sboyd@codeaurora.org, mturquette@baylibre.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This allows getting rid of the DT_CLK() aliases under drivers/clk/ti.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/dpll.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 3bc9959..0042fc2 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -220,8 +220,8 @@ struct clk *ti_clk_register_dpll(struct ti_clk *setup)
 	if (dpll->num_parents < 2)
 		return ERR_PTR(-EINVAL);
 
-	clk_ref = clk_get_sys(NULL, dpll->parents[0]);
-	clk_bypass = clk_get_sys(NULL, dpll->parents[1]);
+	clk_ref = ti_clk_get(dpll->parents[0]);
+	clk_bypass = ti_clk_get(dpll->parents[1]);
 
 	if (IS_ERR_OR_NULL(clk_ref) || IS_ERR_OR_NULL(clk_bypass))
 		return ERR_PTR(-EAGAIN);
-- 
1.7.9.5

