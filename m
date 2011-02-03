From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 1/2] ads7846: OMAP3: Removal of warnings backtrace in bootup
Date: Thu,  3 Feb 2011 15:18:34 +0530
Message-ID: <1296726514-32146-1-git-send-email-sourav.poddar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45802 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755881Ab1BCJsp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 04:48:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, charu@ti.com, gadiyar@ti.com, linux-input@vger.kernel.org, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>

gpio_pendown in ads7846_probe is not getting initalized (defaulted to 0)
resulting in gpio_free to be called without a gpio_request. This
results in the following backtrace in bootup.

------------[ cut here ]------------
WARNING: at drivers/gpio/gpiolib.c:1258 gpio_free+0x100/0x12c()
Modules linked in:
[<c0061208>] (unwind_backtrace+0x0/0xe4) from [<c0091f58>]
	(warn_slowpath_common+0x4c/0x64)
[<c0091f58>] (warn_slowpath_common+0x4c/0x64) from [<c0091f88>]
	(warn_slowpath_null+0x18/0x1c)
[<c0091f88>] (warn_slowpath_null+0x18/0x1c) from [<c024e610>]
	(gpio_free+0x100/0x12c)
[<c024e610>] (gpio_free+0x100/0x12c) from [<c03e9fbc>]
	(ads7846_probe+0xa38/0xc5c)
[<c03e9fbc>] (ads7846_probe+0xa38/0xc5c) from [<c02cff14>]
	(spi_drv_probe+0x18/0x1c)
[<c02cff14>] (spi_drv_probe+0x18/0x1c) from [<c028bca4>]
	(driver_probe_device+0xc8/0x184)
[<c028bca4>] (driver_probe_device+0xc8/0x184) from [<c028bdc8>]
	(__driver_attach+0x68/0x8c)
[<c028bdc8>] (__driver_attach+0x68/0x8c) from [<c028b4c8>]
	(bus_for_each_dev+0x48/0x74)
[<c028b4c8>] (bus_for_each_dev+0x48/0x74) from [<c028ae08>]
	(bus_add_driver+0xa0/0x220)
[<c028ae08>] (bus_add_driver+0xa0/0x220) from [<c028c0c0>]
	(driver_register+0xa8/0x134)
[<c028c0c0>] (driver_register+0xa8/0x134) from [<c0050550>]
	(do_one_initcall+0xcc/0x1a4)
[<c0050550>] (do_one_initcall+0xcc/0x1a4) from [<c00084e4>]
	(kernel_init+0x14c/0x214)
[<c00084e4>] (kernel_init+0x14c/0x214) from [<c005b494>]
	(kernel_thread_exit+0x0/0x8)
---[ end trace 4053287f8a5ec18f ]---

Initializing gpio_pendown in ads7846_probe to -1 before
ads7846_setup_pendown function removes the above backtrace
warning.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/input/touchscreen/ads7846.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 14ea54b..036f245 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1221,6 +1221,7 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	ts->input = input_dev;
 	ts->vref_mv = pdata->vref_mv;
 	ts->swap_xy = pdata->swap_xy;
+	ts->gpio_pendown = -1;
 
 	mutex_init(&ts->lock);
 	init_waitqueue_head(&ts->wait);
-- 
1.7.0.4

