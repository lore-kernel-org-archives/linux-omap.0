From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv2 13/13] OMAP: I2C: Handle error check for pm runtime
Date: Thu, 8 Mar 2012 18:48:05 +0530
Message-ID: <1331212685-6524-14-git-send-email-shubhrajyoti@ti.com>
References: <1331212685-6524-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35574 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754360Ab2CHNTF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 08:19:05 -0500
In-Reply-To: <1331212685-6524-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, rnayak@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

If PM runtime get_sync fails return with the error
so that no further reads/writes goes through the interface.
This will avoid possible abort.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 47a94cf..293e056 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -616,7 +616,9 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	int i;
 	int r;
 
-	pm_runtime_get_sync(dev->dev);
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0)
+		return r;
 
 	r = omap_i2c_wait_for_bb(dev);
 	if (r < 0)
@@ -1044,7 +1046,9 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->regs = (u8 *)reg_map_ip_v1;
 
 	pm_runtime_enable(dev->dev);
-	pm_runtime_get_sync(dev->dev);
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0)
+		return r;
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
@@ -1129,12 +1133,15 @@ err_unuse_clocks:
 static int __devexit omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
+	int ret;
 
 	platform_set_drvdata(pdev, NULL);
 
 	free_irq(dev->irq, dev);
 	i2c_del_adapter(&dev->adapter);
-	pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		return ret;
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.1

