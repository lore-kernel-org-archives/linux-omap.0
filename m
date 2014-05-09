From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 1/3] rtc: omap: remove multiple device id checks
Date: Fri, 9 May 2014 17:39:01 +0530
Message-ID: <753d23945b1de5c2c3403969d712b3b237041f83.1399635871.git.nsekhar@ti.com>
References: <cover.1399635871.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49537 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbaEIMKW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 08:10:22 -0400
In-Reply-To: <cover.1399635871.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux RTC Mailing List <rtc-linux@googlegroups.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>

Remove multiple superfluous device id checks. Since
an id_table is present in the driver probe() should
never encounter an empty device id entry. In case of
OF style match, of_match_device() returns an matching
entry.

For paranoia sake, check for device id entry once and
fail probe() if none is found. This is much better than
checking for it multiple times.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/rtc/rtc-omap.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 26de5f8..70f5149 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -352,6 +352,12 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	if (of_id)
 		pdev->id_entry = of_id->data;
 
+	id_entry = platform_get_device_id(pdev);
+	if (!id_entry) {
+		dev_err(&pdev->dev, "no matching device entry\n");
+		return -ENODEV;
+	}
+
 	omap_rtc_timer = platform_get_irq(pdev, 0);
 	if (omap_rtc_timer <= 0) {
 		pr_debug("%s: no update irq?\n", pdev->name);
@@ -373,8 +379,7 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	id_entry = platform_get_device_id(pdev);
-	if (id_entry && (id_entry->driver_data & OMAP_RTC_HAS_KICKER)) {
+	if (id_entry->driver_data & OMAP_RTC_HAS_KICKER) {
 		rtc_writel(KICK0_VALUE, OMAP_RTC_KICK0_REG);
 		rtc_writel(KICK1_VALUE, OMAP_RTC_KICK1_REG);
 	}
@@ -452,7 +457,7 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	return 0;
 
 fail0:
-	if (id_entry && (id_entry->driver_data & OMAP_RTC_HAS_KICKER))
+	if (id_entry->driver_data & OMAP_RTC_HAS_KICKER)
 		rtc_writel(0, OMAP_RTC_KICK0_REG);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -469,7 +474,7 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
 	/* leave rtc running, but disable irqs */
 	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
 
-	if (id_entry && (id_entry->driver_data & OMAP_RTC_HAS_KICKER))
+	if (id_entry->driver_data & OMAP_RTC_HAS_KICKER)
 		rtc_writel(0, OMAP_RTC_KICK0_REG);
 
 	/* Disable the clock/module */
-- 
1.7.10.1

