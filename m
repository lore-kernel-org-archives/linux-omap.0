From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/2] clk: ti: add a usecount for autoidle
Date: Thu,  4 Oct 2018 22:38:16 +0200
Message-ID: <20181004203817.22101-2-andreas@kemnade.info>
References: <20181004203817.22101-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004203817.22101-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

We have the scenario that first autoidle is disabled for all clocks,
then it is disabled for selected ones and then enabled for all. So
we should have some counting here, also according to the
comment in  _setup_iclk_autoidle()

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/clk/ti/autoidle.c | 32 ++++++++++++++++++++++++--------
 include/linux/clk/ti.h    |  1 +
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index 7bb9afbe4058..bb6cff168e73 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -37,6 +37,14 @@ struct clk_ti_autoidle {
 static LIST_HEAD(autoidle_clks);
 static LIST_HEAD(clk_hw_omap_clocks);
 
+/*
+ * we have some non-atomic read/write
+ * operations behind it, so lets
+ * take one mutex for handling autoidle
+ * of all clocks
+ */
+static DEFINE_MUTEX(autoidle_mutex);
+
 /**
  * omap2_clk_deny_idle - disable autoidle on an OMAP clock
  * @clk: struct clk * to disable autoidle for
@@ -48,8 +56,13 @@ int omap2_clk_deny_idle(struct clk *clk)
 	struct clk_hw_omap *c;
 
 	c = to_clk_hw_omap(__clk_get_hw(clk));
-	if (c->ops && c->ops->deny_idle)
-		c->ops->deny_idle(c);
+	if (c->ops && c->ops->deny_idle) {
+		mutex_lock(&autoidle_mutex);
+		c->autoidle_count--;
+		if (c->autoidle_count == -1)
+			c->ops->deny_idle(c);
+		mutex_unlock(&autoidle_mutex);
+	}
 	return 0;
 }
 
@@ -64,8 +77,13 @@ int omap2_clk_allow_idle(struct clk *clk)
 	struct clk_hw_omap *c;
 
 	c = to_clk_hw_omap(__clk_get_hw(clk));
-	if (c->ops && c->ops->allow_idle)
-		c->ops->allow_idle(c);
+	if (c->ops && c->ops->allow_idle) {
+		mutex_lock(&autoidle_mutex);
+		c->autoidle_count++;
+		if (c->autoidle_count == 0)
+			c->ops->allow_idle(c);
+		mutex_unlock(&autoidle_mutex);
+	}
 	return 0;
 }
 
@@ -201,8 +219,7 @@ int omap2_clk_enable_autoidle_all(void)
 	struct clk_hw_omap *c;
 
 	list_for_each_entry(c, &clk_hw_omap_clocks, node)
-		if (c->ops && c->ops->allow_idle)
-			c->ops->allow_idle(c);
+		omap2_clk_allow_idle(c->hw.clk);
 
 	_clk_generic_allow_autoidle_all();
 
@@ -223,8 +240,7 @@ int omap2_clk_disable_autoidle_all(void)
 	struct clk_hw_omap *c;
 
 	list_for_each_entry(c, &clk_hw_omap_clocks, node)
-		if (c->ops && c->ops->deny_idle)
-			c->ops->deny_idle(c);
+		omap2_clk_deny_idle(c->hw.clk);
 
 	_clk_generic_deny_autoidle_all();
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index a8faa38b1ed6..c460355419c0 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -159,6 +159,7 @@ struct clk_hw_omap {
 	const char		*clkdm_name;
 	struct clockdomain	*clkdm;
 	const struct clk_hw_omap_ops	*ops;
+	int autoidle_count;
 };
 
 /*
-- 
2.11.0
