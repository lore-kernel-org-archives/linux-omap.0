From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/4] clk: clk: Add clk_dflt_restore
Date: Tue, 19 Jun 2018 09:58:23 +0530
Message-ID: <1529382505-3069-3-git-send-email-j-keerthy@ti.com>
References: <1529382505-3069-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529382505-3069-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, sboyd@kernel.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, d-gerlach@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The default restore context function enables or disables
the clock based on the enable_count. This is done in cases
where the clock context is lost and based on the enable_count
the clock either needs to be enabled/disabled. This particularly
helps restore the state of gate clocks.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/clk/clk.c            | 19 +++++++++++++++++++
 include/linux/clk-provider.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7347e06..c201b8b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -910,6 +910,25 @@ static int clk_core_enable_lock(struct clk_core *core)
 	return ret;
 }
 
+/**
+ * clk_dflt_restore_context - restore context for poweroff
+ * @hw: the clk_hw pointer of clock whose state is to be restored
+ *
+ * The default restore context function enables or disables
+ * the clock based on the enable_count. This is done in cases
+ * where the clock context is lost and based on the enable_count
+ * the clock either needs to be enabled/disabled. This particularly
+ * helps restore the state of gate clocks.
+ */
+void clk_dflt_restore_context(struct clk_hw *hw)
+{
+	if (hw->clk->core->enable_count)
+		hw->clk->core->ops->enable(hw);
+	else
+		hw->clk->core->ops->disable(hw);
+}
+EXPORT_SYMBOL_GPL(clk_dflt_restore_context);
+
 static int _clk_save_context(struct clk_core *clk)
 {
 	struct clk_core *child;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7f30d62..3e0c61a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -992,5 +992,7 @@ static inline void clk_writel(u32 val, u32 __iomem *reg)
 
 #endif	/* platform dependent I/O accessors */
 
+void clk_dflt_restore_context(struct clk_hw *hw);
+
 #endif /* CONFIG_COMMON_CLK */
 #endif /* CLK_PROVIDER_H */
-- 
1.9.1
