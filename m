From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] clk: ti: dra7: constify clk_hw_omap_ops structure
Date: Sun, 15 Nov 2015 20:48:14 +0100
Message-ID: <1447616894-31717-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: kernel-janitors@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The clk_hw_omap_ops structures are never modified, so declare this one as
const, like the others.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/clk/ti/apll.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index f3eab6e..b336a8c 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -323,7 +323,7 @@ static void omap2_apll_deny_idle(struct clk_hw_omap *clk)
 	omap2_apll_set_autoidle(clk, OMAP2_APLL_AUTOIDLE_DISABLE);
 }
 
-static struct clk_hw_omap_ops omap2_apll_hwops = {
+static const struct clk_hw_omap_ops omap2_apll_hwops = {
 	.allow_idle	= &omap2_apll_allow_idle,
 	.deny_idle	= &omap2_apll_deny_idle,
 };

