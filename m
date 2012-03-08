From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 07/13] OMAP: I2C: Optimise the remove code
Date: Thu, 8 Mar 2012 18:47:59 +0530
Message-ID: <1331212685-6524-8-git-send-email-shubhrajyoti@ti.com>
References: <1331212685-6524-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331212685-6524-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The omap_i2c_remove function may not be needed after
device exit so the memory could be freed.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 99b14d3..dd4e296 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1134,8 +1134,7 @@ err_release_region:
 	return r;
 }
 
-static int
-omap_i2c_remove(struct platform_device *pdev)
+static int __devexit omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
 	struct resource		*mem;
@@ -1228,7 +1227,7 @@ static struct dev_pm_ops omap_i2c_pm_ops = {
 
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
-	.remove		= omap_i2c_remove,
+	.remove		= __devexit_p(omap_i2c_remove),
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
-- 
1.7.1
