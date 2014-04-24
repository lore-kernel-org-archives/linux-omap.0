From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC 1/4] clk: Add CLK_RUNTIME_PM and clk_may_runtime_pm()
Date: Thu, 24 Apr 2014 12:13:20 +0200
Message-ID: <1398334403-26181-2-git-send-email-geert+renesas@glider.be>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398334403-26181-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add a flag CLK_RUNTIME_PM, to let low-level clock drivers indicate that
a clock is suitable for Runtime PM.
Add clk_may_runtime_pm(), to get the status of the flag.

This will allow the device core to enable automatic Runtime PM management
for devices tied to clocks that are suitable for Runtime PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/clk/clk.c            |   12 ++++++++++++
 include/linux/clk-provider.h |    1 +
 include/linux/clk.h          |    1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0b2819551756..a83a2cc0af67 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1115,6 +1115,18 @@ long clk_get_accuracy(struct clk *clk)
 EXPORT_SYMBOL_GPL(clk_get_accuracy);
 
 /**
+ * clk_may_runtime_pm - check if the clock is suitable for Runtime PM
+ * @clk: the clock to check
+ *
+ * Return true if the clock is suitable for Runtime PM
+ * Return false if clk is NULL, or if the clock is not suitable for Runtime PM.
+ */
+bool clk_may_runtime_pm(const struct clk *clk)
+{
+	return clk && clk->flags & CLK_RUNTIME_PM;
+}
+
+/**
  * __clk_recalc_rates
  * @clk: first clk in the subtree
  * @msg: notification type (see include/linux/clk.h)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 24c8ba4fa6ae..3ca9a7c1f02d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -30,6 +30,7 @@
 #define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
 #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
+#define CLK_RUNTIME_PM		BIT(9) /* clock is suitable for Runtime PM */
 
 struct clk_hw;
 struct dentry;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index d030fce1d77e..07f156580064 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -106,6 +106,7 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb);
  */
 long clk_get_accuracy(struct clk *clk);
 
+bool clk_may_runtime_pm(const struct clk *clk);
 #else /* !CONFIG_COMMON_CLK */
 
 static inline long clk_get_accuracy(struct clk *clk)
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
