From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 3/5] arm: omap1: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
Date: Thu, 23 Apr 2015 14:03:11 +0530
Message-ID: <1429777993-11702-4-git-send-email-rnayak@codeaurora.org>
References: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44635 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757084AbbDWIdl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2015 04:33:41 -0400
In-Reply-To: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rjw@rjwysocki.net, ssantosh@kernel.org, tony@atomide.com, khilman@kernel.org, nsekhar@ti.com, magnus.damm@gmail.com, geert@linux-m68k.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>

USE_PM_CLK_RUNTIME_OPS is introduced so we don't repeat the same code
to do runtime_suspend and runtime_resume across users of PM clocks.
Use it to remove the boilerplate code.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
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

