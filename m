From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] I2C: OMAP: fix runtime PM get/put balance on error
Date: Fri, 29 Jun 2012 14:37:48 +0530
Message-ID: <1340960868-7371-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41924 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882Ab2F2JIS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 05:08:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>, Kevin Hilman <khilman@ti.com>

    ensure pm_runtime_put() is called, on pm_runtime_get_sync()
    failure.

    Without this, after a failed call, the runtime PM usecount will have
    been incremented, but not decremented causing the usecount to never
    reach zero after a failure. Thanks to Kevin for educating about it. 
    While at it also fix a missing pm_runtime_disable in the probe error
    path.

Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2500f19..c8e5c76 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1113,10 +1113,10 @@ err_free_irq:
 	free_irq(dev->irq, dev);
 err_unuse_clocks:
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+err_free_mem:
 	pm_runtime_put(dev->dev);
 	iounmap(dev->base);
 	pm_runtime_disable(&pdev->dev);
-err_free_mem:
 	platform_set_drvdata(pdev, NULL);
 	kfree(dev);
 err_release_region:
@@ -1136,10 +1136,9 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 	free_irq(dev->irq, dev);
 	i2c_del_adapter(&dev->adapter);
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (IS_ERR_VALUE(ret))
-		return ret;
+	if (!IS_ERR_VALUE(ret))
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 
-	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	iounmap(dev->base);
-- 
1.7.5.4

