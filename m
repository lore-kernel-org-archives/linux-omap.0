From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv7 13/18] I2C: OMAP: Handle error check for pm runtime
Date: Wed, 11 Apr 2012 16:22:24 +0530
Message-ID: <1334141549-8288-14-git-send-email-shubhrajyoti@ti.com>
References: <1334141549-8288-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59492 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757380Ab2DKKxW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 06:53:22 -0400
In-Reply-To: <1334141549-8288-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

If PM runtime get_sync fails return with the error
so that no further reads/writes goes through the interface.
This will avoid possible abort. Add a error message in case
of failure with the cause of the failure.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 8258597..f371d4f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -616,7 +616,11 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	int i;
 	int r;
 
-	pm_runtime_get_sync(dev->dev);
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0) {
+		dev_err(dev->dev, "pm_runtime_get_sync failed %d\n", r);
+		return r;
+	}
 
 	r = omap_i2c_wait_for_bb(dev);
 	if (r < 0)
@@ -1044,7 +1048,11 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->regs = (u8 *)reg_map_ip_v1;
 
 	pm_runtime_enable(dev->dev);
-	pm_runtime_get_sync(dev->dev);
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0) {
+		dev_err(dev->dev, "pm_runtime_get_sync failed:%d\n", r);
+		return r;
+	}
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
@@ -1129,12 +1137,17 @@ err_unuse_clocks:
 static int __devexit omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
+	int ret;
 
 	platform_set_drvdata(pdev, NULL);
 
 	free_irq(dev->irq, dev);
 	i2c_del_adapter(&dev->adapter);
-	pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		dev_err(dev->dev, "pm_runtime_get_sync failed %d\n", r);
+		return ret;
+	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.4.1

