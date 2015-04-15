From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 01/35] clk: composite: add support for disable_unused clk operation
Date: Wed, 15 Apr 2015 15:52:48 +0300
Message-ID: <1429102402-5276-2-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35722 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755106AbbDOMwh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:52:37 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Certain gate clocks require this for the init time clk_disable_unused
functionality to work properly, thus add support for it. If the gate
clock does not provide disable_unused ops, just call gate_ops->disable,
just like the core clock code would do.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-composite.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 956b7e5..5cb1496 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -187,6 +187,20 @@ static void clk_composite_disable(struct clk_hw *hw)
 	gate_ops->disable(gate_hw);
 }
 
+static void clk_composite_disable_unused(struct clk_hw *hw)
+{
+	struct clk_composite *composite = to_clk_composite(hw);
+	const struct clk_ops *gate_ops = composite->gate_ops;
+	struct clk_hw *gate_hw = composite->gate_hw;
+
+	__clk_hw_set_clk(gate_hw, hw);
+
+	if (gate_ops->disable_unused)
+		gate_ops->disable_unused(gate_hw);
+	else
+		gate_ops->disable(gate_hw);
+}
+
 struct clk *clk_register_composite(struct device *dev, const char *name,
 			const char **parent_names, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
@@ -267,6 +281,8 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		clk_composite_ops->is_enabled = clk_composite_is_enabled;
 		clk_composite_ops->enable = clk_composite_enable;
 		clk_composite_ops->disable = clk_composite_disable;
+		clk_composite_ops->disable_unused =
+			clk_composite_disable_unused;
 	}
 
 	init.ops = clk_composite_ops;
-- 
1.7.9.5

