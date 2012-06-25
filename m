From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv10 3/7] I2C: OMAP: Use SET_RUNTIME_PM_OPS
Date: Mon, 25 Jun 2012 16:41:38 +0530
Message-ID: <1340622702-21622-4-git-send-email-shubhrajyoti@ti.com>
References: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340622702-21622-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Use SET_RUNTIME_PM_OPS macro to set runtime functions.

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d704f64..c771c28 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1130,6 +1130,7 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 #ifdef CONFIG_PM_RUNTIME
 static void omap_i2c_restore(struct omap_i2c_dev *dev)
 {
@@ -1191,15 +1192,16 @@ static int omap_i2c_runtime_resume(struct device *dev)
 
 	return 0;
 }
+#endif /* CONFIG_PM_RUNTIME */
 
 static struct dev_pm_ops omap_i2c_pm_ops = {
-	.runtime_suspend = omap_i2c_runtime_suspend,
-	.runtime_resume = omap_i2c_runtime_resume,
+	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
+			   omap_i2c_runtime_resume, NULL)
 };
 #define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
 #else
 #define OMAP_I2C_PM_OPS NULL
-#endif
+#endif /* CONFIG_PM */
 
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
-- 
1.7.5.4
