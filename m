From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC 2/5] arm: keystone: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
Date: Tue, 14 Apr 2015 19:04:30 +0530
Message-ID: <1429018473-21865-3-git-send-email-rnayak@codeaurora.org>
References: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39908 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439AbbDNNez (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2015 09:34:55 -0400
In-Reply-To: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rjw@rjwysocki.net, ssantosh@kernel.org, tony@atomide.com, khilman@deeprootsystems.com, nsekhar@ti.com, magnus.damm@gmail.com
Cc: linux-arm-msm@vger.kernel.org, inux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>

USE_PM_CLK_RUNTIME_OPS is introduced so we don't repeat the same code
to do runtime_suspend and runtime_resume across users of PM clocks.
Use it to remove the boilerplate code.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm/mach-keystone/pm_domain.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index 41bebfd..edea697 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -19,40 +19,9 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 
-#ifdef CONFIG_PM
-static int keystone_pm_runtime_suspend(struct device *dev)
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
-static int keystone_pm_runtime_resume(struct device *dev)
-{
-	dev_dbg(dev, "%s\n", __func__);
-
-	pm_clk_resume(dev);
-
-	return pm_generic_runtime_resume(dev);
-}
-#endif
-
 static struct dev_pm_domain keystone_pm_domain = {
 	.ops = {
-		SET_RUNTIME_PM_OPS(keystone_pm_runtime_suspend,
-				   keystone_pm_runtime_resume, NULL)
+		USE_PM_CLK_RUNTIME_OPS
 		USE_PLATFORM_PM_SLEEP_OPS
 	},
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

