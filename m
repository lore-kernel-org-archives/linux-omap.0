From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC 5/5] drivers: sh: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
Date: Tue, 14 Apr 2015 19:04:33 +0530
Message-ID: <1429018473-21865-6-git-send-email-rnayak@codeaurora.org>
References: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: rjw@rjwysocki.net, ssantosh@kernel.org, tony@atomide.com, khilman@deeprootsystems.com, nsekhar@ti.com, magnus.damm@gmail.com
Cc: linux-arm-msm@vger.kernel.org, inux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

USE_PM_CLK_RUNTIME_OPS is introduced so we don't repeat the same code
to do runtime_suspend and runtime_resume across users of PM clocks.
Use it to remove the boilerplate code.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/sh/pm_runtime.c | 47 ++---------------------------------------------
 1 file changed, 2 insertions(+), 45 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index cd4c293..e0fd1e0 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -20,58 +20,15 @@
 #include <linux/bitmap.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_PM
-static int sh_pm_runtime_suspend(struct device *dev)
-{
-	int ret;
-
-	ret = pm_generic_runtime_suspend(dev);
-	if (ret) {
-		dev_err(dev, "failed to suspend device\n");
-		return ret;
-	}
-
-	ret = pm_clk_suspend(dev);
-	if (ret) {
-		dev_err(dev, "failed to suspend clock\n");
-		pm_generic_runtime_resume(dev);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int sh_pm_runtime_resume(struct device *dev)
-{
-	int ret;
-
-	ret = pm_clk_resume(dev);
-	if (ret) {
-		dev_err(dev, "failed to resume clock\n");
-		return ret;
-	}
-
-	return pm_generic_runtime_resume(dev);
-}
-
 static struct dev_pm_domain default_pm_domain = {
 	.ops = {
-		.runtime_suspend = sh_pm_runtime_suspend,
-		.runtime_resume = sh_pm_runtime_resume,
+		USE_PM_CLK_RUNTIME_OPS
 		USE_PLATFORM_PM_SLEEP_OPS
 	},
 };
 
-#define DEFAULT_PM_DOMAIN_PTR	(&default_pm_domain)
-
-#else
-
-#define DEFAULT_PM_DOMAIN_PTR	NULL
-
-#endif /* CONFIG_PM */
-
 static struct pm_clk_notifier_block platform_bus_notifier = {
-	.pm_domain = DEFAULT_PM_DOMAIN_PTR,
+	.pm_domain = &default_pm_domain,
 	.con_ids = { NULL, },
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
