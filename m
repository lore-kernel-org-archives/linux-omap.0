From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 07/11] I2C: OMAP: Handle error check for pm runtime
Date: Tue, 29 May 2012 16:26:19 +0530
Message-ID: <1338288983-15026-8-git-send-email-shubhrajyoti@ti.com>
References: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338288983-15026-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

If PM runtime get_sync fails return with the error
so that no further reads/writes goes through the interface.
This will avoid possible abort. Add a error message in case
of failure with the cause of the failure.

Reviewed-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
-v10 Use IS_ERR_VALUE
-v9 Fix the error handling

 drivers/i2c/busses/i2c-omap.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 44e8cfa..c39b72f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -585,7 +585,9 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	int i;
 	int r;
 
-	pm_runtime_get_sync(dev->dev);
+	r = pm_runtime_get_sync(dev->dev);
+	if (IS_ERR_VALUE(r))
+		return r;
 
 	r = omap_i2c_wait_for_bb(dev);
 	if (r < 0)
@@ -1011,7 +1013,9 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->regs = (u8 *)reg_map_ip_v1;
 
 	pm_runtime_enable(dev->dev);
-	pm_runtime_get_sync(dev->dev);
+	r = pm_runtime_get_sync(dev->dev);
+	if (IS_ERR_VALUE(r))
+		goto err_free_mem;
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
@@ -1103,12 +1107,16 @@ omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
 	struct resource		*mem;
+	int ret;
 
 	platform_set_drvdata(pdev, NULL);
 
 	free_irq(dev->irq, dev);
 	i2c_del_adapter(&dev->adapter);
-	pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.5.4
