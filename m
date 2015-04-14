From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC 1/5] PM / clock_ops: Provide default runtime ops to users
Date: Tue, 14 Apr 2015 19:04:29 +0530
Message-ID: <1429018473-21865-2-git-send-email-rnayak@codeaurora.org>
References: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-sh-owner@vger.kernel.org
To: rjw@rjwysocki.net, ssantosh@kernel.org, tony@atomide.com, khilman@deeprootsystems.com, nsekhar@ti.com, magnus.damm@gmail.com
Cc: linux-arm-msm@vger.kernel.org, inux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Most users of PM clocks do the extact same things in the runtime
suspend/resume callbacks. Provide them USE_PM_CLK_RUNTIME_OPS so
as to avoid/remove boilerplate code.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/base/power/clock_ops.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/pm_clock.h       | 10 ++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 7fdd017..8abea66 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -15,6 +15,7 @@
 #include <linux/clkdev.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/pm_runtime.h>
 
 #ifdef CONFIG_PM
 
@@ -367,6 +368,43 @@ static int pm_clk_notify(struct notifier_block *nb,
 	return 0;
 }
 
+int pm_clk_runtime_suspend(struct device *dev)
+{
+	int ret;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	ret = pm_generic_runtime_suspend(dev);
+	if (ret) {
+		dev_err(dev, "failed to suspend device\n");
+		return ret;
+	}
+
+	ret = pm_clk_suspend(dev);
+	if (ret) {
+		dev_err(dev, "failed to suspend clock\n");
+		pm_generic_runtime_resume(dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+int pm_clk_runtime_resume(struct device *dev)
+{
+	int ret;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	ret = pm_clk_resume(dev);
+	if (ret) {
+		dev_err(dev, "failed to resume clock\n");
+		return ret;
+	}
+
+	return pm_generic_runtime_resume(dev);
+}
+
 #else /* !CONFIG_PM */
 
 /**
diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index 0b00396..25266c6 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -20,6 +20,16 @@ struct pm_clk_notifier_block {
 
 struct clk;
 
+#ifdef CONFIG_PM
+extern int pm_clk_runtime_suspend(struct device *dev);
+extern int pm_clk_runtime_resume(struct device *dev);
+#define USE_PM_CLK_RUNTIME_OPS \
+	.runtime_suspend = pm_clk_runtime_suspend, \
+	.runtime_resume = pm_clk_runtime_resume,
+#else
+#define USE_PM_CLK_RUNTIME_OPS
+#endif
+
 #ifdef CONFIG_PM_CLK
 static inline bool pm_clk_no_clocks(struct device *dev)
 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

