From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/2] ARM: OMAP: dmtimer: check for pm_runtime_get_sync() failure
Date: Mon, 16 Mar 2015 20:14:02 -0500
Message-ID: <1426554843-42641-2-git-send-email-s-anna@ti.com>
References: <1426554843-42641-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53368 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbbCQBOc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 21:14:32 -0400
In-Reply-To: <1426554843-42641-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

The current OMAP dmtimer probe does not check for the return
status of pm_runtime_get_sync() before initializing the timer
registers. Any timer with missing hwmod data would return a
failure here, and the access of registers without enabling the
clocks for the timer would trigger a l3_noc interrupt and a
kernel boot hang. Add proper checking so that the probe would
return a failure graciously without hanging the kernel boot.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/plat-omap/dmtimer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index db10169a08de..f32c74c0e1de 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -799,6 +799,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
 	const struct dmtimer_platform_data *pdata;
+	int ret;
 
 	match = of_match_device(of_match_ptr(omap_timer_match), dev);
 	pdata = match ? match->data : dev->platform_data;
@@ -860,7 +861,12 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	}
 
 	if (!timer->reserved) {
-		pm_runtime_get_sync(dev);
+		ret = pm_runtime_get_sync(dev);
+		if (ret < 0) {
+			dev_err(dev, "%s: pm_runtime_get_sync failed!\n",
+				__func__);
+			goto err_get_sync;
+		}
 		__omap_dm_timer_init_regs(timer);
 		pm_runtime_put(dev);
 	}
@@ -873,6 +879,11 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	dev_dbg(dev, "Device Probed.\n");
 
 	return 0;
+
+err_get_sync:
+	pm_runtime_put_noidle(dev);
+	pm_runtime_disable(dev);
+	return ret;
 }
 
 /**
-- 
2.3.2

