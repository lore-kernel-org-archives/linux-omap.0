From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 2/3] clk: ti: check clock type before doing autoidle ops
Date: Wed, 16 Jan 2019 23:04:28 +0100
Message-ID: <20190116220429.9136-3-andreas@kemnade.info>
References: <20190116220429.9136-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116220429.9136-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

Code might use autoidle api with clocks not being omap2 clocks,
so check if clock type is really omap2.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
v3: replace CLK_IS_BASIC check
New in v2
 drivers/clk/ti/autoidle.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index 964e97b5478a..1cae226759dd 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -82,9 +82,15 @@ static int _omap2_clk_allow_idle(struct clk_hw_omap *clk)
  */
 int omap2_clk_deny_idle(struct clk *clk)
 {
-	struct clk_hw_omap *c = to_clk_hw_omap(__clk_get_hw(clk));
+	struct clk_hw *hw = __clk_get_hw(clk);
 
-	return _omap2_clk_deny_idle(c);
+	if (omap2_clk_is_hw_omap(hw)) {
+		struct clk_hw_omap *c = to_clk_hw_omap(hw);
+
+		return _omap2_clk_deny_idle(c);
+	}
+
+	return -EINVAL;
 }
 
 /**
@@ -95,9 +101,15 @@ int omap2_clk_deny_idle(struct clk *clk)
  */
 int omap2_clk_allow_idle(struct clk *clk)
 {
-	struct clk_hw_omap *c = to_clk_hw_omap(__clk_get_hw(clk));
+	struct clk_hw *hw = __clk_get_hw(clk);
+
+	if (omap2_clk_is_hw_omap(hw)) {
+		struct clk_hw_omap *c = to_clk_hw_omap(hw);
+
+		return _omap2_clk_allow_idle(c);
+	}
 
-	return _omap2_clk_allow_idle(c);
+	return -EINVAL;
 }
 
 static void _allow_autoidle(struct clk_ti_autoidle *clk)
-- 
2.11.0
