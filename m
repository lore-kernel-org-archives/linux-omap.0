From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 1/7] clkdev: add helper registration API
Date: Thu, 30 Jun 2016 17:13:32 +0300
Message-ID: <1467296018-25086-2-git-send-email-t-kristo@ti.com>
References: <1467296018-25086-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1467296018-25086-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

In certain cases, it is desirable to extend the implementation of the
clkdev lookup, to avoid registering massive amounts of clkdev aliases.
A simple helper implementation can instead be used to search and
automatically create the clkdev entries. A sample of this is the TI
clock implementation, which currently registers a large number of
clkdev entries with a very simple mapping strategy.

This patch adds an API to register a helper function that gets called
during clk_get(), in case everything else fails to look up the clock.
Individual clock drivers are then free to register the helper and
implement it the way they want.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 drivers/clk/clkdev.c   | 22 +++++++++++++++++++++-
 include/linux/clkdev.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 89cc700..788c0b2 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -26,6 +26,8 @@
 
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
+static struct clk * (*clkdev_get_helper)(const char *dev_id,
+					 const char *con_id);
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 static struct clk *__of_clk_get(struct device_node *np, int index,
@@ -190,7 +192,13 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 out:
 	mutex_unlock(&clocks_mutex);
 
-	return cl ? clk : ERR_PTR(-ENOENT);
+	if (cl)
+		return clk;
+
+	if (clkdev_get_helper)
+		return clkdev_get_helper(dev_id, con_id);
+
+	return ERR_PTR(-ENOENT);
 }
 EXPORT_SYMBOL(clk_get_sys);
 
@@ -209,6 +217,18 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 }
 EXPORT_SYMBOL(clk_get);
 
+int clkdev_helper_register(struct clk * (*helper)(const char *,
+						  const char *))
+{
+	if (clkdev_get_helper)
+		return -EBUSY;
+
+	clkdev_get_helper = helper;
+
+	return 0;
+}
+EXPORT_SYMBOL(clkdev_helper_register);
+
 void clk_put(struct clk *clk)
 {
 	__clk_put(clk);
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index 2eabc86..173e2fa 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -51,6 +51,7 @@ int clk_add_alias(const char *, const char *, const char *, struct device *);
 
 int clk_register_clkdev(struct clk *, const char *, const char *);
 int clk_hw_register_clkdev(struct clk_hw *, const char *, const char *);
+int clkdev_helper_register(struct clk * (*)(const char *, const char *));
 
 #ifdef CONFIG_COMMON_CLK
 int __clk_get(struct clk *clk);
-- 
1.9.1

