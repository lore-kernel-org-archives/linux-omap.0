From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Subject: [PATCH] omap-i2c: fix incorrect log message when using a device tree
Date: Fri, 31 Aug 2012 13:02:55 +0200
Message-ID: <1346410975-29930-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

When booting using a device tree, the adapter number is dynamically
assigned after the log message is sent.
This patch modifies the log message to get a correct adapter id.

Applies on 3.6-rc3. Tested on OMAP3 (Gumstix Overo).

Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5d19a49..136b4fe 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1064,9 +1064,6 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
-	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", pdev->id,
-		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
-
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
@@ -1084,6 +1081,9 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
+	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", adap->nr,
+		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
+
 	of_i2c_register_devices(adap);
 
 	pm_runtime_put(dev->dev);
-- 
1.7.5.4
