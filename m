From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/14] ARM: OMAP: I2C: tps65010 driver converts to gpiolib
Date: Mon, 17 Mar 2008 11:42:27 +0200
Message-ID: <1205746958-11242-4-git-send-email-tony@atomide.com>
References: omap-upstream-2008-03-17-114234
 <1205746958-11242-1-git-send-email-tony@atomide.com>
 <1205746958-11242-2-git-send-email-tony@atomide.com>
 <1205746958-11242-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62236 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbYCQJnY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:24 -0400
In-Reply-To: <1205746958-11242-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>, David Brownell <dbrownell@users.sourceforge.net>, i2c@lm-sensors.org, Tony Lindgren <tony@atomide.com>

From: David Brownell <david-b@pacbell.net>

Make the tps65010 driver use gpiolib to expose its GPIOs.

Note: This patch will get merged via omap tree instead of I2C
as it will cause some board updates. This has been discussed
at on the I2C list:

http://lists.lm-sensors.org/pipermail/i2c/2008-March/003031.html

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: i2c@lm-sensors.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/chips/Kconfig    |    1 +
 drivers/i2c/chips/tps65010.c |  101 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/i2c/tps65010.h |   30 ++++++++++++
 3 files changed, 131 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index b21593f..2da2edf 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -93,6 +93,7 @@ config ISP1301_OMAP
 
 config TPS65010
 	tristate "TPS6501x Power Management chips"
+	depends on HAVE_GPIO_LIB
 	default y if MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_OSK
 	help
 	  If you say yes here you get support for the TPS6501x series of
diff --git a/drivers/i2c/chips/tps65010.c b/drivers/i2c/chips/tps65010.c
index 4154a91..b67f69c 100644
--- a/drivers/i2c/chips/tps65010.c
+++ b/drivers/i2c/chips/tps65010.c
@@ -30,9 +30,13 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 
 #include <linux/i2c/tps65010.h>
 
+#include <asm/gpio.h>
+
+
 /*-------------------------------------------------------------------------*/
 
 #define	DRIVER_VERSION	"2 May 2005"
@@ -84,7 +88,9 @@ struct tps65010 {
 	u8			chgstatus, regstatus, chgconf;
 	u8			nmask1, nmask2;
 
-	/* not currently tracking GPIO state */
+	u8			outmask;
+	struct gpio_chip	chip;
+	struct platform_device	*leds;
 };
 
 #define	POWER_POLL_DELAY	msecs_to_jiffies(5000)
@@ -449,12 +455,72 @@ static irqreturn_t tps65010_irq(int irq, void *_tps)
 
 /*-------------------------------------------------------------------------*/
 
+/* offsets 0..3 == GPIO1..GPIO4
+ * offsets 4..5 == LED1/nPG, LED2 (we set one of the non-BLINK modes)
+ */
+static void
+tps65010_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	if (offset < 4)
+		tps65010_set_gpio_out_value(offset + 1, value);
+	else
+		tps65010_set_led(offset - 3, value ? ON : OFF);
+}
+
+static int
+tps65010_output(struct gpio_chip *chip, unsigned offset, int value)
+{
+	/* GPIOs may be input-only */
+	if (offset < 4) {
+		struct tps65010		*tps;
+
+		tps = container_of(chip, struct tps65010, chip);
+		if (!(tps->outmask & (1 << offset)))
+			return -EINVAL;
+		tps65010_set_gpio_out_value(offset + 1, value);
+	} else
+		tps65010_set_led(offset - 3, value ? ON : OFF);
+
+	return 0;
+}
+
+static int tps65010_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	int			value;
+	struct tps65010		*tps;
+
+	tps = container_of(chip, struct tps65010, chip);
+
+	if (offset < 4) {
+		value = i2c_smbus_read_byte_data(tps->client, TPS_DEFGPIO);
+		if (value < 0)
+			return 0;
+		if (value & (1 << (offset + 4)))	/* output */
+			return !(value & (1 << offset));
+		else					/* input */
+			return (value & (1 << offset));
+	}
+
+	/* REVISIT we *could* report LED1/nPG and LED2 state ... */
+	return 0;
+}
+
+
+/*-------------------------------------------------------------------------*/
+
 static struct tps65010 *the_tps;
 
 static int __exit tps65010_remove(struct i2c_client *client)
 {
 	struct tps65010		*tps = i2c_get_clientdata(client);
+	struct tps65010_board	*board = client->dev.platform_data;
 
+	if (board && board->teardown) {
+		int status = board->teardown(client, board->context);
+		if (status < 0)
+			dev_dbg(&client->dev, "board %s %s err %d\n",
+				"teardown", client->name, status);
+	}
 	if (client->irq > 0)
 		free_irq(client->irq, tps);
 	cancel_delayed_work(&tps->work);
@@ -469,6 +535,7 @@ static int tps65010_probe(struct i2c_client *client)
 {
 	struct tps65010		*tps;
 	int			status;
+	struct tps65010_board	*board = client->dev.platform_data;
 
 	if (the_tps) {
 		dev_dbg(&client->dev, "only one tps6501x chip allowed\n");
@@ -577,6 +644,38 @@ static int tps65010_probe(struct i2c_client *client)
 
 	tps->file = debugfs_create_file(DRIVER_NAME, S_IRUGO, NULL,
 				tps, DEBUG_FOPS);
+
+	/* optionally register GPIOs */
+	if (board && board->base > 0) {
+		tps->outmask = board->outmask;
+
+		tps->chip.label = client->name;
+
+		tps->chip.set = tps65010_gpio_set;
+		tps->chip.direction_output = tps65010_output;
+
+		/* NOTE:  only partial support for inputs; nyet IRQs */
+		tps->chip.get = tps65010_gpio_get;
+
+		tps->chip.base = board->base;
+		tps->chip.ngpio = 6;
+		tps->chip.can_sleep = 1;
+
+		status = gpiochip_add(&tps->chip);
+		if (status < 0)
+			dev_err(&client->dev, "can't add gpiochip, err %d\n",
+					status);
+		else if (board->setup) {
+			status = board->setup(client, board->context);
+			if (status < 0) {
+				dev_dbg(&client->dev,
+					"board %s %s err %d\n",
+					"setup", client->name, status);
+				status = 0;
+			}
+		}
+	}
+
 	return 0;
 fail1:
 	kfree(tps);
diff --git a/include/linux/i2c/tps65010.h b/include/linux/i2c/tps65010.h
index 7021635..918c535 100644
--- a/include/linux/i2c/tps65010.h
+++ b/include/linux/i2c/tps65010.h
@@ -152,5 +152,35 @@ extern int tps65010_config_vregs1(unsigned value);
  */
 extern int tps65013_set_low_pwr(unsigned mode);
 
+
+struct i2c_client;
+
+/**
+ * struct tps65010_board - packages GPIO and LED lines
+ * @base: the GPIO number to assign to GPIO-1
+ * @outmask: bit (N-1) is set to allow GPIO-N to be used as an
+ *	(open drain) output
+ * @setup: optional callback issued once the GPIOs are valid
+ * @teardown: optional callback issued before the GPIOs are invalidated
+ * @context: optional parameter passed to setup() and teardown()
+ *
+ * Board data may be used to package the GPIO (and LED) lines for use
+ * in by the generic GPIO and LED frameworks.  The first four GPIOs
+ * starting at gpio_base are GPIO1..GPIO4.  The next two are LED1/nPG
+ * and LED2 (with hardware blinking capability, not currently exposed).
+ *
+ * The @setup callback may be used with the kind of board-specific glue
+ * which hands the (now-valid) GPIOs to other drivers, or which puts
+ * devices in their initial states using these GPIOs.
+ */
+struct tps65010_board {
+	int				base;
+	unsigned			outmask;
+
+	int		(*setup)(struct i2c_client *client, void *context);
+	int		(*teardown)(struct i2c_client *client, void *context);
+	void		*context;
+};
+
 #endif /*  __LINUX_I2C_TPS65010_H */
 
-- 
1.5.3.6

