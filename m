From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 3/3] I2C: OMAP: remove racy suspend/resume callbacks
Date: Tue,  7 Jun 2011 11:22:31 -0700
Message-ID: <1307470951-22801-4-git-send-email-khilman@ti.com>
References: <1307470951-22801-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:47647 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757821Ab1FGSWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 14:22:23 -0400
In-Reply-To: <1307470951-22801-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

Current system PM methods for this driver race with the runtime PM
methods when an i2c xfer is in progress when the system suspend path
is excuted.

These callbacks are only needed when runtime PM is disabled from
userspace, so for now we accept that this device will not hit
retention, even in suspend, if runtime PM disabled.

The correct fix (forthcoming) for v3.0+ is to use device power domain
callbacks at the system PM level to handle this, but for now, this
avoids the race.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4e3256f..77ed95f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1150,27 +1150,7 @@ static int omap_i2c_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int omap_i2c_suspend(struct device *dev)
-{
-	if (!pm_runtime_suspended(dev))
-		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
-			dev->bus->pm->runtime_suspend(dev);
-
-	return 0;
-}
-
-static int omap_i2c_resume(struct device *dev)
-{
-	if (!pm_runtime_suspended(dev))
-		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)
-			dev->bus->pm->runtime_resume(dev);
-
-	return 0;
-}
-
 static struct dev_pm_ops omap_i2c_pm_ops = {
-	.suspend = omap_i2c_suspend,
-	.resume = omap_i2c_resume,
 	.runtime_suspend = omap_i2c_runtime_suspend,
 	.runtime_resume = omap_i2c_runtime_resume,
 };
-- 
1.7.4

