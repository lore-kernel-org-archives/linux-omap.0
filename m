From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv10 04/11] I2C: OMAP: Prevent the register access after pm_runtime_put in probe
Date: Tue, 29 May 2012 16:26:16 +0530
Message-ID: <1338288983-15026-5-git-send-email-shubhrajyoti@ti.com>
References: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338288983-15026-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

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

Reviewed-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
-v9 Changed the $SUBJECT as it was too generic.
-v9 Dropping attempting

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
