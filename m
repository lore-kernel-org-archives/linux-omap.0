From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv10 04/10] I2C: OMAP: Prevent the register access after pm_runtime_put in probe
Date: Mon, 14 May 2012 14:19:52 +0530
Message-ID: <1336985398-3291-5-git-send-email-shubhrajyoti@ti.com>
References: <1336985398-3291-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39470 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755212Ab2ENIu6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 04:50:58 -0400
In-Reply-To: <1336985398-3291-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

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

This may access the i2c registers without the clocks in the error cases.
Fix the same by moving the pm_runtime_put after the error check.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
- Changed the $SUBJECT as it was too generic.
- Dropping attempting

 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index bf07ffd..1777d79 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1061,8 +1061,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", pdev->id,
 		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
 
-	pm_runtime_put(dev->dev);
-
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
@@ -1082,6 +1080,8 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	of_i2c_register_devices(adap);
 
+	pm_runtime_put(dev->dev);
+
 	return 0;
 
 err_free_irq:
-- 
1.7.5.4

