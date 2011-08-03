From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] Revert "i2c-omap: fix static suspend vs. runtime suspend"
Date: Wed,  3 Aug 2011 10:59:39 -0700
Message-ID: <1312394379-21516-1-git-send-email-khilman@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This reverts commit adf6e07922255937c8bfeea777d19502b4c9a2be.

Remove system PM methods which can race with runtime PM methods.

Also, as of v3.1, the PM domain level code for OMAP handles device
power state transistions automatically for devices, so calling them
from

Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
Ben, with your ack, I'll queue this up with a couple other fixes to
this driver for v3.1-rc.  Thanks.

 drivers/i2c/busses/i2c-omap.c |   29 -----------------------------
 1 files changed, 0 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 84df53f..e854be0 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1148,41 +1148,12 @@ omap_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
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
-static struct dev_pm_ops omap_i2c_pm_ops = {
-	.suspend = omap_i2c_suspend,
-	.resume = omap_i2c_resume,
-};
-#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
-#else
-#define OMAP_I2C_PM_OPS NULL
-#endif
-
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
 	.remove		= omap_i2c_remove,
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
-		.pm	= OMAP_I2C_PM_OPS,
 	},
 };
 
-- 
1.7.6
