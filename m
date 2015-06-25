From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] i2c: omap: switch to dev_get_drvdata()
Date: Thu, 25 Jun 2015 14:34:48 -0500
Message-ID: <1435260890-32335-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

there's no need to fetch the platform_device
in order to dereference it back to the dev
pointer to access drvdata, we can use
dev_get_drvdata() instead.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0e894193accf..00712c1cf3c0 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1403,8 +1403,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int omap_i2c_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
 
 	_dev->iestate = omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
 
@@ -1428,8 +1427,7 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 
 static int omap_i2c_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
 
 	if (!_dev->regs)
 		return 0;
-- 
2.4.4
