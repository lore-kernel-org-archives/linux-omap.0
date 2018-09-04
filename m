From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 RESEND 2/4] clk: clk: Add clk_gate_restore_context function
Date: Tue, 4 Sep 2018 12:19:36 +0530
Message-ID: <1536043778-2232-3-git-send-email-j-keerthy@ti.com>
References: <1536043778-2232-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1536043778-2232-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, mturquette@baylibre.com, sboyd@kernel.org, t-kristo@ti.com
Cc: d-gerlach@ti.com, j-keerthy@ti.com, russ.dill@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The clock gate restore context function enables or disables
the gate clocks based on the enable_count. This is done in cases
where the clock context is lost and based on the enable_count
the clock either needs to be enabled/disabled.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/clk.c            | 19 +++++++++++++++++++
 include/linux/clk-provider.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8a0254a..dd77577 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -923,6 +923,25 @@ static int clk_core_enable_lock(struct clk_core *core)
 	return ret;
 }
 
+/**
+ * clk_gate_restore_context - restore context for poweroff
+ * @hw: the clk_hw pointer of clock whose state is to be restored
+ *
+ * The clock gate restore context function enables or disables
+ * the gate clocks based on the enable_count. This is done in cases
+ * where the clock context is lost and based on the enable_count
+ * the clock either needs to be enabled/disabled. This
+ * helps restore the state of gate clocks.
+ */
+void clk_gate_restore_context(struct clk_hw *hw)
+{
+	if (hw->clk->core->enable_count)
+		hw->clk->core->ops->enable(hw);
+	else
+		hw->clk->core->ops->disable(hw);
+}
+EXPORT_SYMBOL_GPL(clk_gate_restore_context);
+
 static int _clk_save_context(struct clk_core *clk)
 {
 	struct clk_core *child;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index df7379d..60c5187 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1018,5 +1018,7 @@ static inline void clk_writel(u32 val, u32 __iomem *reg)
 
 #endif	/* platform dependent I/O accessors */
 
+void clk_gate_restore_context(struct clk_hw *hw);
+
 #endif /* CONFIG_COMMON_CLK */
 #endif /* CLK_PROVIDER_H */
-- 
1.9.1
