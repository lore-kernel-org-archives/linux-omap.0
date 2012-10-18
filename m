From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/3] RTC: omap-rtc: enable pm_runtime
Date: Thu, 18 Oct 2012 17:53:50 +0200
Message-ID: <1350575631-15523-2-git-send-email-zonque@gmail.com>
References: <1350575631-15523-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:32983 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756255Ab2JRPyG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 11:54:06 -0400
In-Reply-To: <1350575631-15523-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: a.zummo@towertech.it, david-b@pacbell.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, koen@dominion.thruhere.net, Daniel Mack <zonque@gmail.com>

This is needed as preparation for platforms where using pm runtime usage
is mandatory.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/rtc/rtc-omap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 0b614e3..baa876e 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/platform_device.h>
@@ -322,6 +323,9 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	rtc = rtc_device_register(pdev->name, &pdev->dev,
 			&omap_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc)) {
@@ -420,6 +424,8 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
 		free_irq(omap_rtc_alarm, rtc);
 
 	rtc_device_unregister(rtc);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	iounmap(rtc_base);
 	release_mem_region(mem->start, resource_size(mem));
 	return 0;
@@ -442,11 +448,15 @@ static int omap_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 	else
 		rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
 
+	pm_runtime_put_sync(&pdev->dev);
+
 	return 0;
 }
 
 static int omap_rtc_resume(struct platform_device *pdev)
 {
+	pm_runtime_get_sync(&pdev->dev);
+
 	if (device_may_wakeup(&pdev->dev))
 		disable_irq_wake(omap_rtc_alarm);
 	else
-- 
1.7.11.7

