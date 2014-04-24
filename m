From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/6] PM / clock_ops: Add helpers combining generic runtime and generic clock PM
Date: Thu, 24 Apr 2014 12:26:33 +0200
Message-ID: <1398335198-26555-2-git-send-email-geert+renesas@glider.be>
References: <1398335198-26555-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398335198-26555-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-omap@vger.kernel.org

Add helpers pm_generic_runtime_clk_suspend() and
pm_generic_clk_runtime_resume(), combining generic runtime PM and generic
clock PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/power/clock_ops.c |   40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_clock.h       |    6 ++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 2d5c9c1eceb1..3cdb9fa2920d 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/pm.h>
 #include <linux/pm_clock.h>
+#include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -523,3 +524,42 @@ void pm_clk_add_notifier(struct bus_type *bus,
 	clknb->nb.notifier_call = pm_clk_notify;
 	bus_register_notifier(bus, &clknb->nb);
 }
+
+/**
+ * pm_generic_runtime_clk_suspend - Generic runtime suspend and clock disable
+ *				    callback for subsystems.
+ * @dev: Device to resume.
+ */
+int pm_generic_runtime_clk_suspend(struct device *dev)
+{
+	int ret;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	ret = pm_generic_runtime_suspend(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_clk_suspend(dev);
+	if (ret) {
+		pm_generic_runtime_resume(dev);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm_generic_runtime_clk_suspend);
+
+/**
+ * pm_generic_clk_runtime_resume - Generic clock enable and runtime resume
+ *				   callback for subsystems.
+ * @dev: Device to resume.
+ */
+int pm_generic_clk_runtime_resume(struct device *dev)
+{
+	dev_dbg(dev, "%s\n", __func__);
+
+	pm_clk_resume(dev);
+	return pm_generic_runtime_resume(dev);
+}
+EXPORT_SYMBOL_GPL(pm_generic_clk_runtime_resume);
diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index 6981aa288c45..bf1e4d09a0ca 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -35,6 +35,8 @@ extern int pm_clk_add_clk(struct device *dev, struct clk *clk);
 extern void pm_clk_remove(struct device *dev, const char *con_id);
 extern int pm_clk_suspend(struct device *dev);
 extern int pm_clk_resume(struct device *dev);
+extern int pm_generic_runtime_clk_suspend(struct device *dev);
+extern int pm_generic_clk_runtime_resume(struct device *dev);
 #else
 static inline bool pm_clk_no_clocks(struct device *dev)
 {
@@ -59,6 +61,10 @@ static inline void pm_clk_remove(struct device *dev, const char *con_id)
 }
 #define pm_clk_suspend	NULL
 #define pm_clk_resume	NULL
+static inline int pm_generic_runtime_clk_suspend(struct device *dev)
+	{ return 0; }
+static inline int pm_generic_clk_runtime_resume(struct device *dev)
+	{ return 0; }
 #endif
 
 #ifdef CONFIG_HAVE_CLK
-- 
1.7.9.5
