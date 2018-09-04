From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 RESEND 1/4] clk: clk: Add functions to save/restore clock
 context en-masse
Date: Tue, 4 Sep 2018 12:19:35 +0530
Message-ID: <1536043778-2232-2-git-send-email-j-keerthy@ti.com>
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
Cc: d-gerlach@ti.com, j-keerthy@ti.com, Russ Dill <Russ.Dill@ti.com>, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Russ Dill <Russ.Dill@ti.com>

Deep enough power saving mode can result into losing context of the clock
registers also, and they need to be restored once coming back from the power
saving mode. Hence add functions to save/restore clock context.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/clk.c            | 74 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  7 +++++
 include/linux/clk.h          | 25 +++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d31055a..8a0254a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -923,6 +923,80 @@ static int clk_core_enable_lock(struct clk_core *core)
 	return ret;
 }
 
+static int _clk_save_context(struct clk_core *clk)
+{
+	struct clk_core *child;
+	int ret = 0;
+
+	hlist_for_each_entry(child, &clk->children, child_node) {
+		ret = _clk_save_context(child);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (clk->ops && clk->ops->save_context)
+		ret = clk->ops->save_context(clk->hw);
+
+	return ret;
+}
+
+static void _clk_restore_context(struct clk_core *clk)
+{
+	struct clk_core *child;
+
+	if (clk->ops && clk->ops->restore_context)
+		clk->ops->restore_context(clk->hw);
+
+	hlist_for_each_entry(child, &clk->children, child_node)
+		_clk_restore_context(child);
+}
+
+/**
+ * clk_save_context - save clock context for poweroff
+ *
+ * Saves the context of the clock register for powerstates in which the
+ * contents of the registers will be lost. Occurs deep within the suspend
+ * code.  Returns 0 on success.
+ */
+int clk_save_context(void)
+{
+	struct clk_core *clk;
+	int ret;
+
+	hlist_for_each_entry(clk, &clk_root_list, child_node) {
+		ret = _clk_save_context(clk);
+		if (ret < 0)
+			return ret;
+	}
+
+	hlist_for_each_entry(clk, &clk_orphan_list, child_node) {
+		ret = _clk_save_context(clk);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(clk_save_context);
+
+/**
+ * clk_restore_context - restore clock context after poweroff
+ *
+ * Restore the saved clock context upon resume.
+ *
+ */
+void clk_restore_context(void)
+{
+	struct clk_core *clk;
+
+	hlist_for_each_entry(clk, &clk_root_list, child_node)
+		_clk_restore_context(clk);
+
+	hlist_for_each_entry(clk, &clk_orphan_list, child_node)
+		_clk_restore_context(clk);
+}
+EXPORT_SYMBOL_GPL(clk_restore_context);
+
 /**
  * clk_enable - ungate a clock
  * @clk: the clk being ungated
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08b1aa7..df7379d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -119,6 +119,11 @@ struct clk_duty {
  *		Called with enable_lock held.  This function must not
  *		sleep.
  *
+ * @save_context: Save the context of the clock in prepration for poweroff.
+ *
+ * @restore_context: Restore the context of the clock after a restoration
+ *		of power.
+ *
  * @recalc_rate	Recalculate the rate of this clock, by querying hardware. The
  *		parent rate is an input parameter.  It is up to the caller to
  *		ensure that the prepare_mutex is held across this call.
@@ -223,6 +228,8 @@ struct clk_ops {
 	void		(*disable)(struct clk_hw *hw);
 	int		(*is_enabled)(struct clk_hw *hw);
 	void		(*disable_unused)(struct clk_hw *hw);
+	int		(*save_context)(struct clk_hw *hw);
+	void		(*restore_context)(struct clk_hw *hw);
 	unsigned long	(*recalc_rate)(struct clk_hw *hw,
 					unsigned long parent_rate);
 	long		(*round_rate)(struct clk_hw *hw, unsigned long rate,
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 4f750c4..7da754d 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -629,6 +629,23 @@ int __must_check clk_bulk_enable(int num_clks,
  */
 struct clk *clk_get_sys(const char *dev_id, const char *con_id);
 
+/**
+ * clk_save_context - save clock context for poweroff
+ *
+ * Saves the context of the clock register for powerstates in which the
+ * contents of the registers will be lost. Occurs deep within the suspend
+ * code so locking is not necessary.
+ */
+int clk_save_context(void);
+
+/**
+ * clk_restore_context - restore clock context after poweroff
+ *
+ * This occurs with all clocks enabled. Occurs deep within the resume code
+ * so locking is not necessary.
+ */
+void clk_restore_context(void);
+
 #else /* !CONFIG_HAVE_CLK */
 
 static inline struct clk *clk_get(struct device *dev, const char *id)
@@ -728,6 +745,14 @@ static inline struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 {
 	return NULL;
 }
+
+static inline int clk_save_context(void)
+{
+	return 0;
+}
+
+static inline void clk_restore_context(void) {}
+
 #endif
 
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
-- 
1.9.1
