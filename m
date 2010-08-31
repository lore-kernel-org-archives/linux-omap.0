From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH] I2C: Fix for suspend/resume issue in i2c-core
Date: Tue, 31 Aug 2010 07:20:14 +0530
Message-ID: <1283219414-8798-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33400 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755311Ab0H3MRl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Aug 2010 08:17:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Vishwanath BS <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@deeprootsystems.com>, Ben Dooks <ben-linux@fluff.org>

In current i2c core driver, pm_runtime_set_active call from i2c_device_pm_resume
is not balanced by pm_runtime_set_suspended call from i2c_device_pm_suspend.
pm_runtime_set_active called from resume path will increase the child_count of
the device's parent. However, matching pm_runtime_set_suspended is not called
in suspend routine because of which child_count of the device's parent
is not balanced, preventing the parent device to idle.
Issue has been fixed by adding pm_runtime_set_suspended call inside suspend
reoutine which will make sure that child_counts are balanced.
This fix has been tested on OMAP4430.

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/i2c/i2c-core.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 6649176..3146bff
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -196,14 +196,22 @@ static int i2c_legacy_resume(struct device *dev)
 static int i2c_device_pm_suspend(struct device *dev)
 {
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	int ret;
 
 	if (pm_runtime_suspended(dev))
 		return 0;
 
 	if (pm)
-		return pm->suspend ? pm->suspend(dev) : 0;
+		ret = pm->suspend ? pm->suspend(dev) : 0;
+	else
+		ret = i2c_legacy_suspend(dev, PMSG_SUSPEND);
 
-	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
+	if (!ret) {
+		pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
+		pm_runtime_enable(dev);
+	}
+	return ret;
 }
 
 static int i2c_device_pm_resume(struct device *dev)
-- 
1.7.0.4

