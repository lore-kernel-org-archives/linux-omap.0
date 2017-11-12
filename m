From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 5/5] misc: w2sg0004: add debugging code and Kconfig
Date: Sun, 12 Nov 2017 21:59:58 +0100
Message-ID: <6a12650a2f438340ddfaf438d6dbbd43ca684d6b.1510520397.git.hns@goldelico.com>
References: <cover.1510520397.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510520397.git.hns@goldelico.com>
In-Reply-To: <cover.1510520397.git.hns@goldelico.com>
References: <cover.1510520397.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, "H. Nikolaus Schaller" <hns@goldelico.com>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

This allows to set CONFIG_W2SG0004_DEBUG which will
make the driver report more activities and it will turn on the
GPS module during boot while the driver assumes that it
is off. This can be used to debug the correct functioning of
the hardware. Therefore we add it as an option to the driver
because we think it is of general use (and a little tricky to
add by system testers).

Normally it should be off.
---
 drivers/misc/Kconfig    |  8 ++++++++
 drivers/misc/w2sg0004.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 09d171d68408..f15ff5a97e42 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -528,4 +528,12 @@ config W2SG0004
 	  is opened/closed.
 	  It also provides a rfkill gps name to control the LNA power.
 
+config W2SG0004_DEBUG
+	bool "W2SG0004 on/off debugging"
+	depends on W2SG0004
+	help
+	  Enable driver debugging mode of W2SG0004 GPS. If you say y here
+	  this will turn on the module and you can check if it is turned
+	  off by the driver.
+
 endmenu
diff --git a/drivers/misc/w2sg0004.c b/drivers/misc/w2sg0004.c
index 55101aa6beeb..b6e2253a580f 100644
--- a/drivers/misc/w2sg0004.c
+++ b/drivers/misc/w2sg0004.c
@@ -22,6 +22,10 @@
  *
  */
 
+#ifdef CONFIG_W2SG0004_DEBUG
+#define DEBUG 1
+#endif
+
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -251,6 +255,7 @@ static int w2sg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	pr_debug("%s() tty = %p\n", __func__, tty);
 
 	data = w2sg_get_by_minor(tty->index);
+	pr_debug("%s() data = %p\n", __func__, data);
 
 	if (!data)
 		return -ENODEV;
@@ -363,6 +368,8 @@ static int w2sg_probe(struct serdev_device *serdev)
 
 	w2sg_by_minor[minor] = data;
 
+	pr_debug("w2sg serdev_device_set_drvdata\n");
+
 	serdev_device_set_drvdata(serdev, data);
 
 	data->lna_regulator = pdata->lna_regulator;
@@ -381,6 +388,8 @@ static int w2sg_probe(struct serdev_device *serdev)
 
 	INIT_DELAYED_WORK(&data->work, toggle_work);
 
+	pr_debug("w2sg devm_gpio_request\n");
+
 	err = devm_gpio_request(&serdev->dev, data->on_off_gpio,
 				"w2sg0004-on-off");
 	if (err < 0)
@@ -394,6 +403,8 @@ static int w2sg_probe(struct serdev_device *serdev)
 	serdev_device_set_baudrate(data->uart, 9600);
 	serdev_device_set_flow_control(data->uart, false);
 
+	pr_debug("w2sg rfkill_alloc\n");
+
 	rf_kill = rfkill_alloc("GPS", &serdev->dev, RFKILL_TYPE_GPS,
 				&w2sg0004_rfkill_ops, data);
 	if (rf_kill == NULL) {
@@ -401,6 +412,8 @@ static int w2sg_probe(struct serdev_device *serdev)
 		goto err_rfkill;
 	}
 
+	pr_debug("w2sg register rfkill\n");
+
 	err = rfkill_register(rf_kill);
 	if (err) {
 		dev_err(&serdev->dev, "Cannot register rfkill device\n");
@@ -409,6 +422,8 @@ static int w2sg_probe(struct serdev_device *serdev)
 
 	data->rf_kill = rf_kill;
 
+	pr_debug("w2sg alloc_tty_driver\n");
+
 	/* allocate the tty driver */
 	data->tty_drv = alloc_tty_driver(1);
 	if (!data->tty_drv)
@@ -434,6 +449,8 @@ static int w2sg_probe(struct serdev_device *serdev)
 	 */
 	tty_set_operations(data->tty_drv, &w2sg_serial_ops);
 
+	pr_debug("w2sg tty_register_driver\n");
+
 	/* register the tty driver */
 	err = tty_register_driver(data->tty_drv);
 	if (err) {
@@ -443,6 +460,8 @@ static int w2sg_probe(struct serdev_device *serdev)
 		goto err_rfkill;
 	}
 
+	pr_debug("w2sg call tty_port_init\n");
+
 	tty_port_init(&data->port);
 	data->port.ops = &w2sg_port_ops;
 
@@ -451,11 +470,27 @@ static int w2sg_probe(struct serdev_device *serdev)
  * which only fails because the gpio is already assigned
  */
 
+	pr_debug("w2sg call tty_port_register_device\n");
+
 	data->dev = tty_port_register_device(&data->port,
 			data->tty_drv, minor, &serdev->dev);
 
+	pr_debug("w2sg tty_port_register_device -> %p\n", data->dev);
+	pr_debug("w2sg port.tty = %p\n", data->port.tty);
+
 	pr_debug("w2sg probed\n");
 
+#ifdef CONFIG_W2SG0004_DEBUG
+	pr_debug("w2sg DEBUGGING MODE enabled\n");
+	/* turn on for debugging rx notifications */
+	pr_debug("w2sg power gpio ON\n");
+	gpio_set_value_cansleep(data->on_off_gpio, 1);
+	mdelay(100);
+	pr_debug("w2sg power gpio OFF\n");
+	gpio_set_value_cansleep(data->on_off_gpio, 0);
+	mdelay(300);
+#endif
+
 	/* keep off until user space requests the device */
 	w2sg_set_power(data, false);
 
@@ -465,6 +500,8 @@ static int w2sg_probe(struct serdev_device *serdev)
 	rfkill_destroy(rf_kill);
 	serdev_device_close(data->uart);
 out:
+	pr_debug("w2sg error %d\n", err);
+
 	return err;
 }
 
-- 
2.12.2
