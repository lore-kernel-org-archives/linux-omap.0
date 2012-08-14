From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv6 24/24] i2c: omap: Prevent NULL pointer dereference in remove
Date: Tue, 14 Aug 2012 19:49:06 +0530
Message-ID: <1344953946-13005-25-git-send-email-shubhrajyoti@ti.com>
References: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59006 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755750Ab2HNOUX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 10:20:23 -0400
In-Reply-To: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

Prevent the NULL pointer access by moving the platform_set_drvdata function
after the access of the pdev.

[  654.961761] Unable to handle kernel NULL pointer dereference at virtual address 00000070
[  654.970611] pgd = df254000
[  654.973480] [00000070] *pgd=9f1da831, *pte=00000000, *ppte=00000000
[  654.980163] Internal error: Oops: 17 [#1] SMP ARM
[  654.985076] Modules linked in:
[  654.988281] CPU: 1    Not tainted  (3.6.0-rc1-00031-ge547de1-dirty #339)
[  654.995330] PC is at omap_i2c_runtime_resume+0x8/0x148
[  655.000732] LR is at omap_i2c_runtime_resume+0x8/0x148

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 3df6f92..49dbff1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1217,8 +1217,6 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
 	int ret;
 
-	platform_set_drvdata(pdev, NULL);
-
 	i2c_del_adapter(&dev->adapter);
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (IS_ERR_VALUE(ret))
@@ -1227,6 +1225,8 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	platform_set_drvdata(pdev, NULL);
+
 	return 0;
 }
 
-- 
1.7.5.4

