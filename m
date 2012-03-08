From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv2 08/13] OMAP: I2C: Fix the error handling
Date: Thu, 8 Mar 2012 18:48:00 +0530
Message-ID: <1331212685-6524-9-git-send-email-shubhrajyoti@ti.com>
References: <1331212685-6524-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35566 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753946Ab2CHNS6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 08:18:58 -0500
In-Reply-To: <1331212685-6524-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, rnayak@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

Currently in probe
      pm_runtime_put(dev->dev);

...
        /* i2c device drivers may be active on return from add_adapter() */
        adap->nr = pdev->id;
        r = i2c_add_numbered_adapter(adap);
        if (r) {
                dev_err(dev->dev, "failure adding adapter\n");
                goto err_free_irq;
        }
...

        return 0;

err_free_irq:
        free_irq(dev->irq, dev);
err_unuse_clocks:
        omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
        pm_runtime_put(dev->dev);

This may access the i2c registers without the clocks.
Attempting to fix the same by moving the pm_rintime_put after the error check.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index dd4e296..e12144e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1095,8 +1095,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", pdev->id,
 		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
 
-	pm_runtime_put(dev->dev);
-
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
@@ -1116,6 +1114,8 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	of_i2c_register_devices(adap);
 
+	pm_runtime_put(dev->dev);
+
 	return 0;
 
 err_free_irq:
-- 
1.7.1

