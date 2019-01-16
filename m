From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 1/3] clk: ti: add a usecount for autoidle
Date: Wed, 16 Jan 2019 23:04:27 +0100
Message-ID: <20190116220429.9136-2-andreas@kemnade.info>
References: <20190116220429.9136-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116220429.9136-1-andreas@kemnade.info>
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
Change  since v2:
- rebase on top of clk: ti: get rid of CLK_IS_BASIC
Changes since v1:
- use spinlocks instead of mutexes
- invert logic
 drivers/clk/ti/autoidle.c | 32 ++++++++++++++++++++++++++++----
 include/linux/clk/ti.h    |  1 +
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index a129b4b36ea3..964e97b5478a 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -36,17 +36,41 @@ struct clk_ti_autoidle {
 
 static LIST_HEAD(autoidle_clks);
 
+/*
+ * we have some non-atomic read/write
+ * operations behind it, so lets
+ * take one lock for handling autoidle
+ * of all clocks
+ */
+static DEFINE_SPINLOCK(autoidle_spinlock);
+
 static int _omap2_clk_deny_idle(struct clk_hw_omap *clk)
 {
-	if (clk->ops && clk->ops->deny_idle)
-		clk->ops->deny_idle(clk);
+	if (clk->ops && clk->ops->deny_idle) {
+		unsigned long irqflags;
+
+		spin_lock_irqsave(&autoidle_spinlock, irqflags);
+		clk->autoidle_count++;
+		if (clk->autoidle_count == 1)
+			clk->ops->deny_idle(clk);
+
+		spin_unlock_irqrestore(&autoidle_spinlock, irqflags);
+	}
 	return 0;
 }
 
 static int _omap2_clk_allow_idle(struct clk_hw_omap *clk)
 {
-	if (clk->ops && clk->ops->allow_idle)
-		clk->ops->allow_idle(clk);
+	if (clk->ops && clk->ops->allow_idle) {
+		unsigned long irqflags;
+
+		spin_lock_irqsave(&autoidle_spinlock, irqflags);
+		clk->autoidle_count--;
+		if (clk->autoidle_count == 0)
+			clk->ops->allow_idle(clk);
+
+		spin_unlock_irqrestore(&autoidle_spinlock, irqflags);
+	}
 	return 0;
 }
 
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
