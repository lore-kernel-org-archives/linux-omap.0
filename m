From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v3] i2c: omap: switch over to autosuspend API
Date: Tue,  7 Aug 2012 15:37:16 +0300
Message-ID: <1344343036-8832-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51736 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753849Ab2HGMlW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 08:41:22 -0400
Received: by lbok6 with SMTP id k6so701057lbo.9
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 05:40:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, vaibhav.bedia@ti.com, Felipe Balbi <balbi@ti.com>

this helps us reduce unnecessary pm transitions
in case we have another i2c message starting soon.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 60928f2..35e8207 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -55,6 +55,9 @@
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
 
+/* timeout for pm runtime autosuspend */
+#define OMAP_I2C_PM_TIMEOUT		1000	/* ms */
+
 /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
 enum {
 	OMAP_I2C_REV_REG = 0,
@@ -645,7 +648,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	omap_i2c_wait_for_bb(dev);
 out:
-	pm_runtime_put(dev->dev);
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
 	return r;
 }
 
@@ -1113,6 +1117,9 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->regs = (u8 *)reg_map_ip_v1;
 
 	pm_runtime_enable(dev->dev);
+	pm_runtime_set_autosuspend_delay(dev->dev, OMAP_I2C_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev->dev);
+
 	r = pm_runtime_get_sync(dev->dev);
 	if (IS_ERR_VALUE(r))
 		goto err_free_mem;
@@ -1189,7 +1196,8 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	of_i2c_register_devices(adap);
 
-	pm_runtime_put(dev->dev);
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
 
 	return 0;
 
-- 
1.7.12.rc0

