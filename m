From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 1/4] OMAP: PM: omap_device: conditionally use PM domain runtime helpers
Date: Mon, 11 Jul 2011 16:29:26 -0700
Message-ID: <1310426969-30306-2-git-send-email-khilman@ti.com>
References: <1310426969-30306-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:58107 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758502Ab1GKX3g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 19:29:36 -0400
Received: by mail-iw0-f180.google.com with SMTP id 9so7920169iwn.11
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 16:29:35 -0700 (PDT)
In-Reply-To: <1310426969-30306-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@lists.linux-foundation.org

Only build and use the runtime PM helper functions only when runtime
PM is actually enabled.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/omap_device.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d21579b..f7d2ff7 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -537,6 +537,7 @@ int omap_early_device_register(struct omap_device *od)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
 static int _od_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -563,12 +564,12 @@ static int _od_runtime_resume(struct device *dev)
 
 	return pm_generic_runtime_resume(dev);
 }
+#endif
 
 static struct dev_pm_domain omap_device_pm_domain = {
 	.ops = {
-		.runtime_suspend = _od_runtime_suspend,
-		.runtime_idle = _od_runtime_idle,
-		.runtime_resume = _od_runtime_resume,
+		SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
+				   _od_runtime_idle)
 		USE_PLATFORM_PM_SLEEP_OPS
 	}
 };
-- 
1.7.6

