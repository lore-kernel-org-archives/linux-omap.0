From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC 3/5] arm: omap1: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
Date: Tue, 14 Apr 2015 19:04:31 +0530
Message-ID: <1429018473-21865-4-git-send-email-rnayak@codeaurora.org>
References: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
To: rjw@rjwysocki.net, ssantosh@kernel.org, tony@atomide.com, khilman@deeprootsystems.com, nsekhar@ti.com, magnus.damm@gmail.com
Cc: linux-arm-msm@vger.kernel.org, inux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

USE_PM_CLK_RUNTIME_OPS is introduced so we don't repeat the same code
to do runtime_suspend and runtime_resume across users of PM clocks.
Use it to remove the boilerplate code.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm/mach-omap1/pm_bus.c | 37 ++-----------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index c40e209..667c163 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -21,48 +21,15 @@
 
 #include "soc.h"
 
-#ifdef CONFIG_PM
-static int omap1_pm_runtime_suspend(struct device *dev)
-{
-	int ret;
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	ret = pm_generic_runtime_suspend(dev);
-	if (ret)
-		return ret;
-
-	ret = pm_clk_suspend(dev);
-	if (ret) {
-		pm_generic_runtime_resume(dev);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int omap1_pm_runtime_resume(struct device *dev)
-{
-	dev_dbg(dev, "%s\n", __func__);
-
-	pm_clk_resume(dev);
-	return pm_generic_runtime_resume(dev);
-}
-
 static struct dev_pm_domain default_pm_domain = {
 	.ops = {
-		.runtime_suspend = omap1_pm_runtime_suspend,
-		.runtime_resume = omap1_pm_runtime_resume,
+		USE_PM_CLK_RUNTIME_OPS
 		USE_PLATFORM_PM_SLEEP_OPS
 	},
 };
-#define OMAP1_PM_DOMAIN (&default_pm_domain)
-#else
-#define OMAP1_PM_DOMAIN NULL
-#endif /* CONFIG_PM */
 
 static struct pm_clk_notifier_block platform_bus_notifier = {
-	.pm_domain = OMAP1_PM_DOMAIN,
+	.pm_domain = &default_pm_domain,
 	.con_ids = { "ick", "fck", NULL, },
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

