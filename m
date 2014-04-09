From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] i2c: omap: Disable default probing of i2c devices for omap i2c.
Date: Wed, 9 Apr 2014 15:52:24 +0530
Message-ID: <1397038944-28409-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

I2c core supports defualt probing functionality for devices not registered through
dt/board files. If there are any client driver registered, i2c core will try to
check if there is any device present corresponding to the address supplied by
the client driver. If the device is actually present and not registered, core
will register it, else the device default probe will fail and we get a omap i2c controller
specific timeout messages.
For example, Using multi_v7_config on omap5-uevm, CONFIG_SENSORS_LM90 and CONFIG_ICS932S401
is the driver which is enabled and gets registered. I2c core tries to find a valid
corresponding device on each of the address supplied by registered driver,
but could not find anyone. Hence, keep dumping the controller timeout speciic message.

The patch tends to disable class based instantiation, default probing will not be attempted
by the i2c-core for omap i2c. Device will always get registered through device tree(dt case)
and board files(for non dt cases).

Tested i2c enumeration and data transfer(using i2c utilities) with linux-next master
on the following boards using omap2plus_defconfig:
* Omap3 beagle-Xm (for dt and non dt case)
* omap4 panda
* omap5-uevm
* Dra7xx
* Beaglebone white
* Beaglebone black
* am335x-evm
* AM43xx epos evm

Tested i2c enumeration with linux-next master(except omap5)
on the following boards using multi_v7_defconfig:
* Omap3 beagle-Xm (for dt and non dt case)
* omap4 panda
* omap5-uevm (tested on next-20140131 tag, where i2c problem can be seen) 
* Dra7xx
* Beaglebone white
* Beaglebone black
* am335x-evm
* AM43xx epos evm

Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 85f8eac..4ec29a0 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1238,7 +1238,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
-	adap->class = I2C_CLASS_HWMON | I2C_CLASS_DEPRECATED;
+	adap->class = 0;
 	strlcpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
 	adap->algo = &omap_i2c_algo;
 	adap->dev.parent = &pdev->dev;
-- 
1.7.9.5
