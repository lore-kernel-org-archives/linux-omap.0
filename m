From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH v3 1/2] ads7846: fix gpio free without requesting
Date: Thu,  3 Feb 2011 20:51:26 +0530
Message-ID: <1296746486-12168-1-git-send-email-sourav.poddar@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: LW@karo-electronics.de
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, gadiyar@ti.com, charu@ti.com, grinberg@compulab.co.il, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Dmitry Torokhov <dtor@mail.ru>
List-Id: linux-omap@vger.kernel.org

gpio_pendown in ads7846_probe is not getting initalized (defaulted to 0)
resulting in gpio_free being called without a gpio_request. This
results in the following backtrace in bootup (at least on an OMAP3430 SDP).

------------[ cut here ]------------
WARNING: at drivers/gpio/gpiolib.c:1258 gpio_free+0x100/0x12c()
Modules linked in:
[<c0061208>] (unwind_backtrace+0x0/0xe4) from [<c0091f58>](warn_slowpath_common+0x4c/0x64)
[<c0091f58>] (warn_slowpath_common+0x4c/0x64) from [<c0091f88>](warn_slowpath_null+0x18/0x1c)
[<c0091f88>] (warn_slowpath_null+0x18/0x1c) from [<c024e610>](gpio_free+0x100/0x12c)
[<c024e610>] (gpio_free+0x100/0x12c) from [<c03e9fbc>](ads7846_probe+0xa38/0xc5c)
[<c03e9fbc>] (ads7846_probe+0xa38/0xc5c) from [<c02cff14>](spi_drv_probe+0x18/0x1c)
[<c02cff14>] (spi_drv_probe+0x18/0x1c) from [<c028bca4>](driver_probe_device+0xc8/0x184)
[<c028bca4>] (driver_probe_device+0xc8/0x184) from [<c028bdc8>](__driver_attach+0x68/0x8c)
[<c028bdc8>] (__driver_attach+0x68/0x8c) from [<c028b4c8>](bus_for_each_dev+0x48/0x74)
[<c028b4c8>] (bus_for_each_dev+0x48/0x74) from [<c028ae08>](bus_add_driver+0xa0/0x220)
[<c028ae08>] (bus_add_driver+0xa0/0x220) from [<c028c0c0>](driver_register+0xa8/0x134)
[<c028c0c0>] (driver_register+0xa8/0x134) from [<c0050550>](do_one_initcall+0xcc/0x1a4)
[<c0050550>] (do_one_initcall+0xcc/0x1a4) from [<c00084e4>](kernel_init+0x14c/0x214)
[<c00084e4>] (kernel_init+0x14c/0x214) from [<c005b494>](kernel_thread_exit+0x0/0x8)
---[ end trace 4053287f8a5ec18f ]---

Initialize gpio_pendown in ads7846_probe to -EINVAL before
ads7846_setup_pendown function and using gpio_is_valid function
in conditional check removes the above backtrace
warning.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Dmitry Torokhov <dtor@mail.ru>

---
 Links related to the previous discussions:
 http://www.spinics.net/lists/linux-omap/msg45093.html
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43506.html

 drivers/input/touchscreen/ads7846.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 14ea54b..ce5baee 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -952,6 +952,7 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
 
 	if (pdata->get_pendown_state) {
 		ts->get_pendown_state = pdata->get_pendown_state;
+		ts->gpio_pendown = -EINVAL;
 		return 0;
 	}
 
@@ -1353,7 +1354,7 @@ static int __devinit ads7846_probe(struct spi_device *spi)
  err_put_regulator:
 	regulator_put(ts->reg);
  err_free_gpio:
-	if (ts->gpio_pendown != -1)
+	if (gpio_is_valid(ts->gpio_pendown))
 		gpio_free(ts->gpio_pendown);
  err_cleanup_filter:
 	if (ts->filter_cleanup)
-- 
1.7.0.4

