From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv8 08/18] I2C: OMAP: Fix the error handling
Date: Thu, 12 Apr 2012 18:36:25 +0530
Message-ID: <1334235995-6727-9-git-send-email-shubhrajyoti@ti.com>
References: <1334235995-6727-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334235995-6727-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
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

This may access the i2c registers without the clocks.
Attempting to fix the same by moving the pm_rintime_put after the error check.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2096726..a461097 100644
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
1.7.4.1
