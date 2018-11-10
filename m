From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 1/3] clk: ti: add a usecount for autoidle
Date: Sat, 10 Nov 2018 21:31:13 +0100
Message-ID: <20181110203115.13335-2-andreas@kemnade.info>
References: <20181110203115.13335-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181110203115.13335-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

Multiple users might deny autoidle on a clock. So we should have some
counting here, also according to the comment in  _setup_iclk_autoidle().
Also setting autoidle regs is not atomic, so there is another reason
for locking.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes since v1:
- use spinlocks instead of mutexes
- invert logic
---
 drivers/clk/ti/autoidle.c | 36 ++++++++++++++++++++++++++++--------
 include/linux/clk/ti.h    |  1 +
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index 7bb9afbe4058..161f67850393 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -37,6 +37,14 @@ struct clk_ti_autoidle {
 static LIST_HEAD(autoidle_clks);
 static LIST_HEAD(clk_hw_omap_clocks);
 
+/*
+ * we have some non-atomic read/write
+ * operations behind it, so lets
+ * take one lock for handling autoidle
+ * of all clocks
+ */
+static DEFINE_SPINLOCK(autoidle_spinlock);
+
 /**
  * omap2_clk_deny_idle - disable autoidle on an OMAP clock
  * @clk: struct clk * to disable autoidle for
@@ -48,8 +56,15 @@ int omap2_clk_deny_idle(struct clk *clk)
 	struct clk_hw_omap *c;
 
 	c = to_clk_hw_omap(__clk_get_hw(clk));
-	if (c->ops && c->ops->deny_idle)
-		c->ops->deny_idle(c);
+	if (c->ops && c->ops->deny_idle) {
+		unsigned long irqflags;
+
+		spin_lock_irqsave(&autoidle_spinlock, irqflags);
+		c->autoidle_count++;
+		if (c->autoidle_count == 1)
+			c->ops->deny_idle(c);
+		spin_unlock_irqrestore(&autoidle_spinlock, irqflags);
+	}
 	return 0;
 }
 
@@ -64,8 +79,15 @@ int omap2_clk_allow_idle(struct clk *clk)
 	struct clk_hw_omap *c;
 
 	c = to_clk_hw_omap(__clk_get_hw(clk));
-	if (c->ops && c->ops->allow_idle)
-		c->ops->allow_idle(c);
+	if (c->ops && c->ops->allow_idle) {
+		unsigned long irqflags;
+
+		spin_lock_irqsave(&autoidle_spinlock, irqflags);
+		c->autoidle_count--;
+		if (c->autoidle_count == 0)
+			c->ops->allow_idle(c);
+		spin_unlock_irqrestore(&autoidle_spinlock, irqflags);
+	}
 	return 0;
 }
 
@@ -201,8 +223,7 @@ int omap2_clk_enable_autoidle_all(void)
 	struct clk_hw_omap *c;
 
 	list_for_each_entry(c, &clk_hw_omap_clocks, node)
-		if (c->ops && c->ops->allow_idle)
-			c->ops->allow_idle(c);
+		omap2_clk_allow_idle(c->hw.clk);
 
 	_clk_generic_allow_autoidle_all();
 
@@ -223,8 +244,7 @@ int omap2_clk_disable_autoidle_all(void)
 	struct clk_hw_omap *c;
 
 	list_for_each_entry(c, &clk_hw_omap_clocks, node)
-		if (c->ops && c->ops->deny_idle)
-			c->ops->deny_idle(c);
+		omap2_clk_deny_idle(c->hw.clk);
 
 	_clk_generic_deny_autoidle_all();
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index eacc5df57b99..78872efc7be0 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -160,6 +160,7 @@ struct clk_hw_omap {
 	struct clockdomain	*clkdm;
 	const struct clk_hw_omap_ops	*ops;
 	u32			context;
+	int			autoidle_count;
 };
 
 /*
-- 
2.11.0
