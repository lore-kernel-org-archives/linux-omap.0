From: balajitk@ti.com
Subject: [PATCH v4 02/08] ARM: OMAP: Rename all twl4030_i2c*.
Date: Fri, 11 Dec 2009 21:34:46 +0530
Message-ID: <1260547486-23667-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48950 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933388AbZLKQFO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Dec 2009 11:05:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, sameo@linux.intel.com, me@felipebalbi.com, peter.ujfalusi@nokia.com, dtor@mail.ru, p_gortmaker@yahoo.com, a.zummo@towertech.it, tony@atomide.com, wim@iguana.be, timo.t.kokkonen@nokia.com, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Balaji T K <balajitk@ti.com>

 This patch renames function names like twl4030_i2c_write_u8,
 twl4030_i2c_read_u8 to twl_i2c_write_u8, twl_i2c_read_u8
 and also common variable in twl-core.c

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/gpio/twl4030-gpio.c             |   18 ++--
 drivers/input/keyboard/twl4030_keypad.c |    4 +-
 drivers/input/misc/twl4030-pwrbutton.c  |    2 +-
 drivers/mfd/twl-core.c                  |  136 +++++++++++++++++--------------
 drivers/mfd/twl4030-irq.c               |   18 ++--
 drivers/mfd/twl4030-power.c             |   54 ++++++------
 drivers/regulator/twl-regulator.c       |    8 +-
 drivers/rtc/rtc-twl.c                   |   14 ++--
 drivers/usb/otg/twl4030-usb.c           |   36 ++++----
 drivers/video/omap/lcd_2430sdp.c        |    2 +-
 drivers/watchdog/twl4030_wdt.c          |    2 +-
 include/linux/i2c/twl.h                 |   31 ++++++--
 sound/soc/codecs/twl4030.c              |    8 +-
 13 files changed, 180 insertions(+), 153 deletions(-)

diff --git a/drivers/gpio/twl4030-gpio.c b/drivers/gpio/twl4030-gpio.c
index a320d7b..7fe881e 100644
--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -80,7 +80,7 @@ static unsigned int gpio_usage_count;
  */
 static inline int gpio_twl4030_write(u8 address, u8 data)
 {
-	return twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, data, address);
+	return twl_i2c_write_u8(TWL4030_MODULE_GPIO, data, address);
 }
 
 /*----------------------------------------------------------------------*/
@@ -117,7 +117,7 @@ static inline int gpio_twl4030_read(u8 address)
 	u8 data;
 	int ret = 0;
 
-	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &data, address);
+	ret = twl_i2c_read_u8(TWL4030_MODULE_GPIO, &data, address);
 	return (ret < 0) ? ret : data;
 }
 
@@ -142,7 +142,7 @@ static void twl4030_led_set_value(int led, int value)
 		cached_leden &= ~mask;
 	else
 		cached_leden |= mask;
-	status = twl4030_i2c_write_u8(TWL4030_MODULE_LED, cached_leden,
+	status = twl_i2c_write_u8(TWL4030_MODULE_LED, cached_leden,
 			TWL4030_LED_LEDEN);
 	mutex_unlock(&gpio_lock);
 }
@@ -223,23 +223,23 @@ static int twl_request(struct gpio_chip *chip, unsigned offset)
 		}
 
 		/* initialize PWM to always-drive */
-		status = twl4030_i2c_write_u8(module, 0x7f,
+		status = twl_i2c_write_u8(module, 0x7f,
 				TWL4030_PWMx_PWMxOFF);
 		if (status < 0)
 			goto done;
-		status = twl4030_i2c_write_u8(module, 0x7f,
+		status = twl_i2c_write_u8(module, 0x7f,
 				TWL4030_PWMx_PWMxON);
 		if (status < 0)
 			goto done;
 
 		/* init LED to not-driven (high) */
 		module = TWL4030_MODULE_LED;
-		status = twl4030_i2c_read_u8(module, &cached_leden,
+		status = twl_i2c_read_u8(module, &cached_leden,
 				TWL4030_LED_LEDEN);
 		if (status < 0)
 			goto done;
 		cached_leden &= ~ledclr_mask;
-		status = twl4030_i2c_write_u8(module, cached_leden,
+		status = twl_i2c_write_u8(module, cached_leden,
 				TWL4030_LED_LEDEN);
 		if (status < 0)
 			goto done;
@@ -370,7 +370,7 @@ static int __devinit gpio_twl4030_pulls(u32 ups, u32 downs)
 		message[i] = bit_mask;
 	}
 
-	return twl4030_i2c_write(TWL4030_MODULE_GPIO, message,
+	return twl_i2c_write(TWL4030_MODULE_GPIO, message,
 				REG_GPIOPUPDCTR1, 5);
 }
 
@@ -387,7 +387,7 @@ static int __devinit gpio_twl4030_debounce(u32 debounce, u8 mmc_cd)
 	debounce >>= 8;
 	message[3] = (debounce & 0x03);
 
-	return twl4030_i2c_write(TWL4030_MODULE_GPIO, message,
+	return twl_i2c_write(TWL4030_MODULE_GPIO, message,
 				REG_GPIO_DEBEN1, 3);
 }
 
diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 1d1536a..eeaa7ac 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -133,7 +133,7 @@ struct twl4030_keypad {
 static int twl4030_kpread(struct twl4030_keypad *kp,
 		u8 *data, u32 reg, u8 num_bytes)
 {
-	int ret = twl4030_i2c_read(TWL4030_MODULE_KEYPAD, data, reg, num_bytes);
+	int ret = twl_i2c_read(TWL4030_MODULE_KEYPAD, data, reg, num_bytes);
 
 	if (ret < 0)
 		dev_warn(kp->dbg_dev,
@@ -145,7 +145,7 @@ static int twl4030_kpread(struct twl4030_keypad *kp,
 
 static int twl4030_kpwrite_u8(struct twl4030_keypad *kp, u8 data, u32 reg)
 {
-	int ret = twl4030_i2c_write_u8(TWL4030_MODULE_KEYPAD, data, reg);
+	int ret = twl_i2c_write_u8(TWL4030_MODULE_KEYPAD, data, reg);
 
 	if (ret < 0)
 		dev_warn(kp->dbg_dev,
diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index a73b889..bdde5c8 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -49,7 +49,7 @@ static irqreturn_t powerbutton_irq(int irq, void *_pwr)
 	local_irq_enable();
 #endif
 
-	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &value,
+	err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &value,
 				  STS_HW_CONDITIONS);
 	if (!err)  {
 		input_report_key(pwr, KEY_POWER, value & PWR_PWRON_IRQ);
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index b6e8202..36fca95 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1,5 +1,6 @@
 /*
- * twl4030_core.c - driver for TWL4030/TPS659x0 PM and audio CODEC devices
+ * twl_core.c - driver for TWL4030/TWL5030/TWL60X0/TPS659x0 PM
+ * and audio CODEC devices
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
@@ -55,7 +56,7 @@
  * (and associated registers).
  */
 
-#define DRIVER_NAME			"twl4030"
+#define DRIVER_NAME			"twl"
 
 #if defined(CONFIG_TWL4030_BCI_BATTERY) || \
 	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)
@@ -125,7 +126,7 @@
 /* Last - for index max*/
 #define TWL4030_MODULE_LAST		TWL4030_MODULE_SECURED_REG
 
-#define TWL4030_NUM_SLAVES		4
+#define TWL_NUM_SLAVES		4
 
 #if defined(CONFIG_INPUT_TWL4030_PWRBUTTON) \
 	|| defined(CONFIG_INPUT_TWL4030_PWBUTTON_MODULE)
@@ -134,6 +135,13 @@
 #define twl_has_pwrbutton()	false
 #endif
 
+#define SUB_CHIP_ID0 0
+#define SUB_CHIP_ID1 1
+#define SUB_CHIP_ID2 2
+#define SUB_CHIP_ID3 3
+
+#define TWL_MODULE_LAST TWL4030_MODULE_LAST
+
 /* Base Address defns for twl4030_map[] */
 
 /* subchip/slave 0 - USB ID */
@@ -195,7 +203,7 @@
 static bool inuse;
 
 /* Structure for each TWL4030 Slave */
-struct twl4030_client {
+struct twl_client {
 	struct i2c_client *client;
 	u8 address;
 
@@ -206,16 +214,16 @@ struct twl4030_client {
 	struct mutex xfer_lock;
 };
 
-static struct twl4030_client twl4030_modules[TWL4030_NUM_SLAVES];
+static struct twl_client twl_modules[TWL_NUM_SLAVES];
 
 
 /* mapping the module id to slave id and base address */
-struct twl4030mapping {
+struct twl_mapping {
 	unsigned char sid;	/* Slave ID */
 	unsigned char base;	/* base address */
 };
 
-static struct twl4030mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
+static struct twl_mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
 	/*
 	 * NOTE:  don't change this table without updating the
 	 * <linux/i2c/twl4030.h> defines for TWL4030_MODULE_*
@@ -254,7 +262,7 @@ static struct twl4030mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
 /* Exported Functions */
 
 /**
- * twl4030_i2c_write - Writes a n bit register in TWL4030
+ * twl_i2c_write - Writes a n bit register in TWL4030/TWL5030/TWL60X0
  * @mod_no: module number
  * @value: an array of num_bytes+1 containing data to write
  * @reg: register address (just offset will do)
@@ -265,19 +273,19 @@ static struct twl4030mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
  *
  * Returns the result of operation - 0 is success
  */
-int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
+int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 {
 	int ret;
 	int sid;
-	struct twl4030_client *twl;
+	struct twl_client *twl;
 	struct i2c_msg *msg;
 
-	if (unlikely(mod_no > TWL4030_MODULE_LAST)) {
+	if (unlikely(mod_no > TWL_MODULE_LAST)) {
 		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
 		return -EPERM;
 	}
 	sid = twl4030_map[mod_no].sid;
-	twl = &twl4030_modules[sid];
+	twl = &twl_modules[sid];
 
 	if (unlikely(!inuse)) {
 		pr_err("%s: client %d is not initialized\n", DRIVER_NAME, sid);
@@ -303,10 +311,10 @@ int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 		ret = 0;
 	return ret;
 }
-EXPORT_SYMBOL(twl4030_i2c_write);
+EXPORT_SYMBOL(twl_i2c_write);
 
 /**
- * twl4030_i2c_read - Reads a n bit register in TWL4030
+ * twl_i2c_read - Reads a n bit register in TWL4030/TWL5030/TWL60X0
  * @mod_no: module number
  * @value: an array of num_bytes containing data to be read
  * @reg: register address (just offset will do)
@@ -314,20 +322,20 @@ EXPORT_SYMBOL(twl4030_i2c_write);
  *
  * Returns result of operation - num_bytes is success else failure.
  */
-int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
+int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 {
 	int ret;
 	u8 val;
 	int sid;
-	struct twl4030_client *twl;
+	struct twl_client *twl;
 	struct i2c_msg *msg;
 
-	if (unlikely(mod_no > TWL4030_MODULE_LAST)) {
+	if (unlikely(mod_no > TWL_MODULE_LAST)) {
 		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
 		return -EPERM;
 	}
 	sid = twl4030_map[mod_no].sid;
-	twl = &twl4030_modules[sid];
+	twl = &twl_modules[sid];
 
 	if (unlikely(!inuse)) {
 		pr_err("%s: client %d is not initialized\n", DRIVER_NAME, sid);
@@ -355,40 +363,40 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 		ret = 0;
 	return ret;
 }
-EXPORT_SYMBOL(twl4030_i2c_read);
+EXPORT_SYMBOL(twl_i2c_read);
 
 /**
- * twl4030_i2c_write_u8 - Writes a 8 bit register in TWL4030
+ * twl_i2c_write_u8 - Writes a 8 bit register in TWL4030/TWL5030/TWL60X0
  * @mod_no: module number
  * @value: the value to be written 8 bit
  * @reg: register address (just offset will do)
  *
  * Returns result of operation - 0 is success
  */
-int twl4030_i2c_write_u8(u8 mod_no, u8 value, u8 reg)
+int twl_i2c_write_u8(u8 mod_no, u8 value, u8 reg)
 {
 
 	/* 2 bytes offset 1 contains the data offset 0 is used by i2c_write */
 	u8 temp_buffer[2] = { 0 };
 	/* offset 1 contains the data */
 	temp_buffer[1] = value;
-	return twl4030_i2c_write(mod_no, temp_buffer, reg, 1);
+	return twl_i2c_write(mod_no, temp_buffer, reg, 1);
 }
-EXPORT_SYMBOL(twl4030_i2c_write_u8);
+EXPORT_SYMBOL(twl_i2c_write_u8);
 
 /**
- * twl4030_i2c_read_u8 - Reads a 8 bit register from TWL4030
+ * twl_i2c_read_u8 - Reads a 8 bit register from TWL4030/TWL5030/TWL60X0
  * @mod_no: module number
  * @value: the value read 8 bit
  * @reg: register address (just offset will do)
  *
  * Returns result of operation - 0 is success
  */
-int twl4030_i2c_read_u8(u8 mod_no, u8 *value, u8 reg)
+int twl_i2c_read_u8(u8 mod_no, u8 *value, u8 reg)
 {
-	return twl4030_i2c_read(mod_no, value, reg, 1);
+	return twl_i2c_read(mod_no, value, reg, 1);
 }
-EXPORT_SYMBOL(twl4030_i2c_read_u8);
+EXPORT_SYMBOL(twl_i2c_read_u8);
 
 /*----------------------------------------------------------------------*/
 
@@ -398,7 +406,7 @@ add_numbered_child(unsigned chip, const char *name, int num,
 		bool can_wakeup, int irq0, int irq1)
 {
 	struct platform_device	*pdev;
-	struct twl4030_client	*twl = &twl4030_modules[chip];
+	struct twl_client	*twl = &twl_modules[chip];
 	int			status;
 
 	pdev = platform_device_alloc(name, num);
@@ -492,23 +500,24 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 				pdata->bci, sizeof(*pdata->bci),
 				false,
 				/* irq0 = CHG_PRES, irq1 = BCI */
-				pdata->irq_base + 8 + 1, pdata->irq_base + 2);
+				pdata->irq_base + BCI_PRES_INTR_OFFSET,
+				pdata->irq_base + BCI_INTR_OFFSET);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
 
 	if (twl_has_gpio() && pdata->gpio) {
-		child = add_child(1, "twl4030_gpio",
+		child = add_child(SUB_CHIP_ID1, "twl4030_gpio",
 				pdata->gpio, sizeof(*pdata->gpio),
-				false, pdata->irq_base + 0, 0);
+				false, pdata->irq_base + GPIO_INTR_OFFSET, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
 
 	if (twl_has_keypad() && pdata->keypad) {
-		child = add_child(2, "twl4030_keypad",
+		child = add_child(SUB_CHIP_ID2, "twl4030_keypad",
 				pdata->keypad, sizeof(*pdata->keypad),
-				true, pdata->irq_base + 1, 0);
+				true, pdata->irq_base + KEYPAD_INTR_OFFSET, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
@@ -516,7 +525,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 	if (twl_has_madc() && pdata->madc) {
 		child = add_child(2, "twl4030_madc",
 				pdata->madc, sizeof(*pdata->madc),
-				true, pdata->irq_base + 3, 0);
+				true, pdata->irq_base + MADC_INTR_OFFSET, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
@@ -531,7 +540,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 		 */
 		child = add_child(3, "twl4030_rtc",
 				NULL, 0,
-				true, pdata->irq_base + 8 + 3, 0);
+				true, pdata->irq_base + RTC_INTR_OFFSET, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
@@ -581,7 +590,8 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 				pdata->usb, sizeof(*pdata->usb),
 				true,
 				/* irq0 = USB_PRES, irq1 = USB */
-				pdata->irq_base + 8 + 2, pdata->irq_base + 4);
+				pdata->irq_base + USB_PRES_INTR_OFFSET,
+				pdata->irq_base + USB_INTR_OFFSET);
 
 		if (IS_ERR(child))
 			return PTR_ERR(child);
@@ -679,7 +689,7 @@ static inline int __init protect_pm_master(void)
 {
 	int e = 0;
 
-	e = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, KEY_LOCK,
+	e = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_LOCK,
 			R_PROTECT_KEY);
 	return e;
 }
@@ -688,9 +698,9 @@ static inline int __init unprotect_pm_master(void)
 {
 	int e = 0;
 
-	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, KEY_UNLOCK1,
+	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_UNLOCK1,
 			R_PROTECT_KEY);
-	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, KEY_UNLOCK2,
+	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_UNLOCK2,
 			R_PROTECT_KEY);
 	return e;
 }
@@ -709,7 +719,7 @@ static void clocks_init(struct device *dev)
 		osc = clk_get(dev, "osc_sys_ck");
 
 	if (IS_ERR(osc)) {
-		printk(KERN_WARNING "Skipping twl4030 internal clock init and "
+		printk(KERN_WARNING "Skipping twl internal clock init and "
 				"using bootloader value (unknown osc rate)\n");
 		return;
 	}
@@ -723,7 +733,7 @@ static void clocks_init(struct device *dev)
 	 */
 	osc = ERR_PTR(-EIO);
 
-	printk(KERN_WARNING "Skipping twl4030 internal clock init and "
+	printk(KERN_WARNING "Skipping twl internal clock init and "
 	       "using bootloader value (unknown osc rate)\n");
 
 	return;
@@ -744,7 +754,7 @@ static void clocks_init(struct device *dev)
 	ctrl |= HIGH_PERF_SQ;
 	e |= unprotect_pm_master();
 	/* effect->MADC+USB ck en */
-	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
+	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
 	e |= protect_pm_master();
 
 	if (e < 0)
@@ -756,7 +766,7 @@ static void clocks_init(struct device *dev)
 int twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
 int twl_exit_irq(void);
 
-static int twl4030_remove(struct i2c_client *client)
+static int twl_remove(struct i2c_client *client)
 {
 	unsigned i;
 	int status;
@@ -765,12 +775,12 @@ static int twl4030_remove(struct i2c_client *client)
 	if (status < 0)
 		return status;
 
-	for (i = 0; i < TWL4030_NUM_SLAVES; i++) {
-		struct twl4030_client	*twl = &twl4030_modules[i];
+	for (i = 0; i < TWL_NUM_SLAVES; i++) {
+		struct twl_client	*twl = &twl_modules[i];
 
 		if (twl->client && twl->client != client)
 			i2c_unregister_device(twl->client);
-		twl4030_modules[i].client = NULL;
+		twl_modules[i].client = NULL;
 	}
 	inuse = false;
 	return 0;
@@ -778,7 +788,7 @@ static int twl4030_remove(struct i2c_client *client)
 
 /* NOTE:  this driver only handles a single twl4030/tps659x0 chip */
 static int __init
-twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id)
+twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	int				status;
 	unsigned			i;
@@ -799,8 +809,8 @@ twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -EBUSY;
 	}
 
-	for (i = 0; i < TWL4030_NUM_SLAVES; i++) {
-		struct twl4030_client	*twl = &twl4030_modules[i];
+	for (i = 0; i < TWL_NUM_SLAVES; i++) {
+		struct twl_client	*twl = &twl_modules[i];
 
 		twl->address = client->addr + i;
 		if (i == 0)
@@ -840,11 +850,11 @@ twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	status = add_children(pdata, id->driver_data);
 fail:
 	if (status < 0)
-		twl4030_remove(client);
+		twl_remove(client);
 	return status;
 }
 
-static const struct i2c_device_id twl4030_ids[] = {
+static const struct i2c_device_id twl_ids[] = {
 	{ "twl4030", TWL4030_VAUX2 },	/* "Triton 2" */
 	{ "twl5030", 0 },		/* T2 updated */
 	{ "tps65950", 0 },		/* catalog version of twl5030 */
@@ -852,28 +862,28 @@ static const struct i2c_device_id twl4030_ids[] = {
 	{ "tps65920", TPS_SUBSET },	/* fewer LDOs; no codec or charger */
 	{ /* end of list */ },
 };
-MODULE_DEVICE_TABLE(i2c, twl4030_ids);
+MODULE_DEVICE_TABLE(i2c, twl_ids);
 
 /* One Client Driver , 4 Clients */
-static struct i2c_driver twl4030_driver = {
+static struct i2c_driver twl_driver = {
 	.driver.name	= DRIVER_NAME,
-	.id_table	= twl4030_ids,
-	.probe		= twl4030_probe,
-	.remove		= twl4030_remove,
+	.id_table	= twl_ids,
+	.probe		= twl_probe,
+	.remove		= twl_remove,
 };
 
-static int __init twl4030_init(void)
+static int __init twl_init(void)
 {
-	return i2c_add_driver(&twl4030_driver);
+	return i2c_add_driver(&twl_driver);
 }
-subsys_initcall(twl4030_init);
+subsys_initcall(twl_init);
 
-static void __exit twl4030_exit(void)
+static void __exit twl_exit(void)
 {
-	i2c_del_driver(&twl4030_driver);
+	i2c_del_driver(&twl_driver);
 }
-module_exit(twl4030_exit);
+module_exit(twl_exit);
 
 MODULE_AUTHOR("Texas Instruments, Inc.");
-MODULE_DESCRIPTION("I2C Core interface for TWL4030");
+MODULE_DESCRIPTION("I2C Core interface for TWL");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 72e05c3..ef04922 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -194,7 +194,7 @@ static int twl4030_irq_thread(void *data)
 		/* Wait for IRQ, then read PIH irq status (also blocking) */
 		wait_for_completion_interruptible(&irq_event);
 
-		ret = twl4030_i2c_read_u8(TWL4030_MODULE_PIH, &pih_isr,
+		ret = twl_i2c_read_u8(TWL4030_MODULE_PIH, &pih_isr,
 					  REG_PIH_ISR_P1);
 		if (ret) {
 			pr_warning("twl4030: I2C error %d reading PIH ISR\n",
@@ -290,7 +290,7 @@ static int twl4030_init_sih_modules(unsigned line)
 		if (!sih->bytes_ixr)
 			continue;
 
-		status = twl4030_i2c_write(sih->module, buf,
+		status = twl_i2c_write(sih->module, buf,
 				sih->mask[line].imr_offset, sih->bytes_ixr);
 		if (status < 0)
 			pr_err("twl4030: err %d initializing %s %s\n",
@@ -304,7 +304,7 @@ static int twl4030_init_sih_modules(unsigned line)
 		 * And for PWR_INT it's not documented...
 		 */
 		if (sih->set_cor) {
-			status = twl4030_i2c_write_u8(sih->module,
+			status = twl_i2c_write_u8(sih->module,
 					TWL4030_SIH_CTRL_COR_MASK,
 					sih->control_offset);
 			if (status < 0)
@@ -328,14 +328,14 @@ static int twl4030_init_sih_modules(unsigned line)
 		 * uncommon with PWR_INT.PWRON.
 		 */
 		for (j = 0; j < 2; j++) {
-			status = twl4030_i2c_read(sih->module, rxbuf,
+			status = twl_i2c_read(sih->module, rxbuf,
 				sih->mask[line].isr_offset, sih->bytes_ixr);
 			if (status < 0)
 				pr_err("twl4030: err %d initializing %s %s\n",
 					status, sih->name, "ISR");
 
 			if (!sih->set_cor)
-				status = twl4030_i2c_write(sih->module, buf,
+				status = twl_i2c_write(sih->module, buf,
 					sih->mask[line].isr_offset,
 					sih->bytes_ixr);
 			/* else COR=1 means read sufficed.
@@ -404,7 +404,7 @@ static void twl4030_sih_do_mask(struct work_struct *work)
 		return;
 
 	/* write the whole mask ... simpler than subsetting it */
-	status = twl4030_i2c_write(sih->module, imr.bytes,
+	status = twl_i2c_write(sih->module, imr.bytes,
 			sih->mask[irq_line].imr_offset, sih->bytes_ixr);
 	if (status)
 		pr_err("twl4030: %s, %s --> %d\n", __func__,
@@ -435,7 +435,7 @@ static void twl4030_sih_do_edge(struct work_struct *work)
 	 * any processor on the other IRQ line, EDR registers are
 	 * shared.
 	 */
-	status = twl4030_i2c_read(sih->module, bytes + 1,
+	status = twl_i2c_read(sih->module, bytes + 1,
 			sih->edr_offset, sih->bytes_edr);
 	if (status) {
 		pr_err("twl4030: %s, %s --> %d\n", __func__,
@@ -469,7 +469,7 @@ static void twl4030_sih_do_edge(struct work_struct *work)
 	}
 
 	/* Write */
-	status = twl4030_i2c_write(sih->module, bytes,
+	status = twl_i2c_write(sih->module, bytes,
 			sih->edr_offset, sih->bytes_edr);
 	if (status)
 		pr_err("twl4030: %s, %s --> %d\n", __func__,
@@ -554,7 +554,7 @@ static inline int sih_read_isr(const struct sih *sih)
 	/* FIXME need retry-on-error ... */
 
 	isr.word = 0;
-	status = twl4030_i2c_read(sih->module, isr.bytes,
+	status = twl_i2c_read(sih->module, isr.bytes,
 			sih->mask[irq_line].isr_offset, sih->bytes_ixr);
 
 	return (status < 0) ? status : le32_to_cpu(isr.word);
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index e7878b9..95a67d7 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -115,11 +115,11 @@ static int __init twl4030_write_script_byte(u8 address, u8 byte)
 {
 	int err;
 
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
 				R_MEMORY_ADDRESS);
 	if (err)
 		goto out;
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, byte,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, byte,
 				R_MEMORY_DATA);
 out:
 	return err;
@@ -176,18 +176,18 @@ static int __init twl4030_config_wakeup3_sequence(u8 address)
 	u8 data;
 
 	/* Set SLEEP to ACTIVE SEQ address for P3 */
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
 				R_SEQ_ADD_S2A3);
 	if (err)
 		goto out;
 
 	/* P3 LVL_WAKEUP should be on LEVEL */
-	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
+	err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
 				R_P3_SW_EVENTS);
 	if (err)
 		goto out;
 	data |= LVL_WAKEUP;
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data,
 				R_P3_SW_EVENTS);
 out:
 	if (err)
@@ -201,42 +201,42 @@ static int __init twl4030_config_wakeup12_sequence(u8 address)
 	u8 data;
 
 	/* Set SLEEP to ACTIVE SEQ address for P1 and P2 */
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
 				R_SEQ_ADD_S2A12);
 	if (err)
 		goto out;
 
 	/* P1/P2 LVL_WAKEUP should be on LEVEL */
-	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
+	err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
 				R_P1_SW_EVENTS);
 	if (err)
 		goto out;
 
 	data |= LVL_WAKEUP;
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data,
 				R_P1_SW_EVENTS);
 	if (err)
 		goto out;
 
-	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
+	err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
 				R_P2_SW_EVENTS);
 	if (err)
 		goto out;
 
 	data |= LVL_WAKEUP;
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data,
 				R_P2_SW_EVENTS);
 	if (err)
 		goto out;
 
 	if (machine_is_omap_3430sdp() || machine_is_omap_ldp()) {
 		/* Disabling AC charger effect on sleep-active transitions */
-		err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
+		err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
 					R_CFG_P1_TRANSITION);
 		if (err)
 			goto out;
 		data &= ~(1<<1);
-		err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data ,
+		err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data ,
 					R_CFG_P1_TRANSITION);
 		if (err)
 			goto out;
@@ -254,7 +254,7 @@ static int __init twl4030_config_sleep_sequence(u8 address)
 	int err;
 
 	/* Set ACTIVE to SLEEP SEQ address in T2 memory*/
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
 				R_SEQ_ADD_A2S);
 
 	if (err)
@@ -269,41 +269,41 @@ static int __init twl4030_config_warmreset_sequence(u8 address)
 	u8 rd_data;
 
 	/* Set WARM RESET SEQ address for P1 */
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
 				R_SEQ_ADD_WARM);
 	if (err)
 		goto out;
 
 	/* P1/P2/P3 enable WARMRESET */
-	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
+	err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
 				R_P1_SW_EVENTS);
 	if (err)
 		goto out;
 
 	rd_data |= ENABLE_WARMRESET;
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
 				R_P1_SW_EVENTS);
 	if (err)
 		goto out;
 
-	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
+	err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
 				R_P2_SW_EVENTS);
 	if (err)
 		goto out;
 
 	rd_data |= ENABLE_WARMRESET;
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
 				R_P2_SW_EVENTS);
 	if (err)
 		goto out;
 
-	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
+	err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
 				R_P3_SW_EVENTS);
 	if (err)
 		goto out;
 
 	rd_data |= ENABLE_WARMRESET;
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
 				R_P3_SW_EVENTS);
 out:
 	if (err)
@@ -327,7 +327,7 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 	rconfig_addr = res_config_addrs[rconfig->resource];
 
 	/* Set resource group */
-	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &grp,
+	err = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &grp,
 				rconfig_addr + DEVGROUP_OFFSET);
 	if (err) {
 		pr_err("TWL4030 Resource %d group could not be read\n",
@@ -338,7 +338,7 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 	if (rconfig->devgroup >= 0) {
 		grp &= ~DEVGROUP_MASK;
 		grp |= rconfig->devgroup << DEVGROUP_SHIFT;
-		err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+		err = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					grp, rconfig_addr + DEVGROUP_OFFSET);
 		if (err < 0) {
 			pr_err("TWL4030 failed to program devgroup\n");
@@ -347,7 +347,7 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 	}
 
 	/* Set resource types */
-	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &type,
+	err = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &type,
 				rconfig_addr + TYPE_OFFSET);
 	if (err < 0) {
 		pr_err("TWL4030 Resource %d type could not be read\n",
@@ -365,7 +365,7 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 		type |= rconfig->type2 << TYPE2_SHIFT;
 	}
 
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 				type, rconfig_addr + TYPE_OFFSET);
 	if (err < 0) {
 		pr_err("TWL4030 failed to program resource type\n");
@@ -424,12 +424,12 @@ void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 	struct twl4030_resconfig *resconfig;
 	u8 address = twl4030_start_script_address;
 
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, R_KEY_1,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, R_KEY_1,
 				R_PROTECT_KEY);
 	if (err)
 		goto unlock;
 
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, R_KEY_2,
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, R_KEY_2,
 				R_PROTECT_KEY);
 	if (err)
 		goto unlock;
@@ -452,7 +452,7 @@ void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 		}
 	}
 
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, R_PROTECT_KEY);
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, R_PROTECT_KEY);
 	if (err)
 		pr_err("TWL4030 Unable to relock registers\n");
 	return;
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index c8a6e58..8cc46e9 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -64,7 +64,7 @@ twl4030reg_read(struct twlreg_info *info, unsigned offset)
 	u8 value;
 	int status;
 
-	status = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER,
+	status = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER,
 			&value, info->base + offset);
 	return (status < 0) ? status : value;
 }
@@ -72,7 +72,7 @@ twl4030reg_read(struct twlreg_info *info, unsigned offset)
 static inline int
 twl4030reg_write(struct twlreg_info *info, unsigned offset, u8 value)
 {
-	return twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+	return twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 			value, info->base + offset);
 }
 
@@ -171,12 +171,12 @@ static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
 	if (!(status & (P3_GRP | P2_GRP | P1_GRP)))
 		return -EACCES;
 
-	status = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER,
+	status = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER,
 			message >> 8, 0x15 /* PB_WORD_MSB */ );
 	if (status >= 0)
 		return status;
 
-	return twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER,
+	return twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER,
 			message, 0x16 /* PB_WORD_LSB */ );
 }
 
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 93565be..6119712 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -92,7 +92,7 @@ static int twl4030_rtc_read_u8(u8 *data, u8 reg)
 {
 	int ret;
 
-	ret = twl4030_i2c_read_u8(TWL4030_MODULE_RTC, data, reg);
+	ret = twl_i2c_read_u8(TWL4030_MODULE_RTC, data, reg);
 	if (ret < 0)
 		pr_err("twl4030_rtc: Could not read TWL4030"
 		       "register %X - error %d\n", reg, ret);
@@ -106,7 +106,7 @@ static int twl4030_rtc_write_u8(u8 data, u8 reg)
 {
 	int ret;
 
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_RTC, data, reg);
+	ret = twl_i2c_write_u8(TWL4030_MODULE_RTC, data, reg);
 	if (ret < 0)
 		pr_err("twl4030_rtc: Could not write TWL4030"
 		       "register %X - error %d\n", reg, ret);
@@ -201,7 +201,7 @@ static int twl4030_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	if (ret < 0)
 		return ret;
 
-	ret = twl4030_i2c_read(TWL4030_MODULE_RTC, rtc_data,
+	ret = twl_i2c_read(TWL4030_MODULE_RTC, rtc_data,
 			       REG_SECONDS_REG, ALL_TIME_REGS);
 
 	if (ret < 0) {
@@ -243,7 +243,7 @@ static int twl4030_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		goto out;
 
 	/* update all the time registers in one shot */
-	ret = twl4030_i2c_write(TWL4030_MODULE_RTC, rtc_data,
+	ret = twl_i2c_write(TWL4030_MODULE_RTC, rtc_data,
 			REG_SECONDS_REG, ALL_TIME_REGS);
 	if (ret < 0) {
 		dev_err(dev, "rtc_set_time error %d\n", ret);
@@ -266,7 +266,7 @@ static int twl4030_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	unsigned char rtc_data[ALL_TIME_REGS + 1];
 	int ret;
 
-	ret = twl4030_i2c_read(TWL4030_MODULE_RTC, rtc_data,
+	ret = twl_i2c_read(TWL4030_MODULE_RTC, rtc_data,
 			       REG_ALARM_SECONDS_REG, ALL_TIME_REGS);
 	if (ret < 0) {
 		dev_err(dev, "rtc_read_alarm error %d\n", ret);
@@ -305,7 +305,7 @@ static int twl4030_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	alarm_data[6] = bin2bcd(alm->time.tm_year - 100);
 
 	/* update all the alarm registers in one shot */
-	ret = twl4030_i2c_write(TWL4030_MODULE_RTC, alarm_data,
+	ret = twl_i2c_write(TWL4030_MODULE_RTC, alarm_data,
 			REG_ALARM_SECONDS_REG, ALL_TIME_REGS);
 	if (ret) {
 		dev_err(dev, "rtc_set_alarm error %d\n", ret);
@@ -363,7 +363,7 @@ static irqreturn_t twl4030_rtc_interrupt(int irq, void *rtc)
 	 * risk wrongly clearing status for some other IRQ (losing
 	 * the interrupt).  Be smarter about handling RTC_UF ...
 	 */
-	res = twl4030_i2c_read_u8(TWL4030_MODULE_INT,
+	res = twl_i2c_read_u8(TWL4030_MODULE_INT,
 			&rd_reg, TWL4030_INT_PWR_ISR1);
 	if (res)
 		goto out;
diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 591334d..2a315a7 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -276,16 +276,16 @@ static int twl4030_i2c_write_u8_verify(struct twl4030_usb *twl,
 {
 	u8 check;
 
-	if ((twl4030_i2c_write_u8(module, data, address) >= 0) &&
-	    (twl4030_i2c_read_u8(module, &check, address) >= 0) &&
+	if ((twl_i2c_write_u8(module, data, address) >= 0) &&
+	    (twl_i2c_read_u8(module, &check, address) >= 0) &&
 						(check == data))
 		return 0;
 	dev_dbg(twl->dev, "Write%d[%d,0x%x] wrote %02x but read %02x\n",
 			1, module, address, check, data);
 
 	/* Failed once: Try again */
-	if ((twl4030_i2c_write_u8(module, data, address) >= 0) &&
-	    (twl4030_i2c_read_u8(module, &check, address) >= 0) &&
+	if ((twl_i2c_write_u8(module, data, address) >= 0) &&
+	    (twl_i2c_read_u8(module, &check, address) >= 0) &&
 						(check == data))
 		return 0;
 	dev_dbg(twl->dev, "Write%d[%d,0x%x] wrote %02x but read %02x\n",
@@ -303,7 +303,7 @@ static inline int twl4030_usb_write(struct twl4030_usb *twl,
 {
 	int ret = 0;
 
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_USB, data, address);
+	ret = twl_i2c_write_u8(TWL4030_MODULE_USB, data, address);
 	if (ret < 0)
 		dev_dbg(twl->dev,
 			"TWL4030:USB:Write[0x%x] Error %d\n", address, ret);
@@ -315,7 +315,7 @@ static inline int twl4030_readb(struct twl4030_usb *twl, u8 module, u8 address)
 	u8 data;
 	int ret = 0;
 
-	ret = twl4030_i2c_read_u8(module, &data, address);
+	ret = twl_i2c_read_u8(module, &data, address);
 	if (ret >= 0)
 		ret = data;
 	else
@@ -462,7 +462,7 @@ static void twl4030_phy_power(struct twl4030_usb *twl, int on)
 		 * SLEEP. We work around this by clearing the bit after usv3v1
 		 * is re-activated. This ensures that VUSB3V1 is really active.
 		 */
-		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0,
+		twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0,
 							VUSB_DEDICATED2);
 		regulator_enable(twl->usb1v5);
 		pwr &= ~PHY_PWR_PHYPWD;
@@ -505,44 +505,44 @@ static void twl4030_phy_resume(struct twl4030_usb *twl)
 static int twl4030_usb_ldo_init(struct twl4030_usb *twl)
 {
 	/* Enable writing to power configuration registers */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0xC0, PROTECT_KEY);
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0x0C, PROTECT_KEY);
+	twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0xC0, PROTECT_KEY);
+	twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0x0C, PROTECT_KEY);
 
 	/* put VUSB3V1 LDO in active state */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB_DEDICATED2);
+	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB_DEDICATED2);
 
 	/* input to VUSB3V1 LDO is from VBAT, not VBUS */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x14, VUSB_DEDICATED1);
+	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x14, VUSB_DEDICATED1);
 
 	/* Initialize 3.1V regulator */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_DEV_GRP);
+	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_DEV_GRP);
 
 	twl->usb3v1 = regulator_get(twl->dev, "usb3v1");
 	if (IS_ERR(twl->usb3v1))
 		return -ENODEV;
 
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_TYPE);
+	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_TYPE);
 
 	/* Initialize 1.5V regulator */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_DEV_GRP);
+	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_DEV_GRP);
 
 	twl->usb1v5 = regulator_get(twl->dev, "usb1v5");
 	if (IS_ERR(twl->usb1v5))
 		goto fail1;
 
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_TYPE);
+	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_TYPE);
 
 	/* Initialize 1.8V regulator */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_DEV_GRP);
+	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_DEV_GRP);
 
 	twl->usb1v8 = regulator_get(twl->dev, "usb1v8");
 	if (IS_ERR(twl->usb1v8))
 		goto fail2;
 
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_TYPE);
+	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_TYPE);
 
 	/* disable access to power configuration registers */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, PROTECT_KEY);
+	twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, PROTECT_KEY);
 
 	return 0;
 
diff --git a/drivers/video/omap/lcd_2430sdp.c b/drivers/video/omap/lcd_2430sdp.c
index c5dc86d..f01f7d8 100644
--- a/drivers/video/omap/lcd_2430sdp.c
+++ b/drivers/video/omap/lcd_2430sdp.c
@@ -51,7 +51,7 @@ static unsigned enable_gpio;
 #define TWL4030_VPLL2_DEV_GRP           0x33
 #define TWL4030_VPLL2_DEDICATED         0x36
 
-#define t2_out(c, r, v) twl4030_i2c_write_u8(c, r, v)
+#define t2_out(c, r, v) twl_i2c_write_u8(c, r, v)
 
 
 static int sdp2430_panel_init(struct lcd_panel *panel,
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 20968b2..8162a40 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -48,7 +48,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 
 static int twl4030_wdt_write(unsigned char val)
 {
-	return twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, val,
+	return twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, val,
 					TWL4030_WATCHDOG_CFG_REG_OFFS);
 }
 
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 5306a75..27a6094 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -22,8 +22,8 @@
  *
  */
 
-#ifndef __TWL4030_H_
-#define __TWL4030_H_
+#ifndef __TWL_H_
+#define __TWL_H_
 
 #include <linux/types.h>
 #include <linux/input/matrix_keypad.h>
@@ -69,20 +69,37 @@
 #define TWL4030_MODULE_RTC		0x14
 #define TWL4030_MODULE_SECURED_REG	0x15
 
+#define TWL_MODULE_USB		TWL4030_MODULE_USB
+#define TWL_MODULE_AUDIO_VOICE	TWL4030_MODULE_AUDIO_VOICE
+#define TWL_MODULE_PIH		TWL4030_MODULE_PIH
+#define TWL_MODULE_MADC		TWL4030_MODULE_MADC
+#define TWL_MODULE_MAIN_CHARGE	TWL4030_MODULE_MAIN_CHARGE
+#define TWL_MODULE_PM_MASTER	TWL4030_MODULE_PM_MASTER
+#define TWL_MODULE_PM_RECEIVER	TWL4030_MODULE_PM_RECEIVER
+#define TWL_MODULE_RTC		TWL4030_MODULE_RTC
+
+#define GPIO_INTR_OFFSET	0
+#define KEYPAD_INTR_OFFSET	1
+#define BCI_INTR_OFFSET		2
+#define MADC_INTR_OFFSET	3
+#define USB_INTR_OFFSET		4
+#define BCI_PRES_INTR_OFFSET	9
+#define USB_PRES_INTR_OFFSET	10
+#define RTC_INTR_OFFSET		11
 /*
  * Read and write single 8-bit registers
  */
-int twl4030_i2c_write_u8(u8 mod_no, u8 val, u8 reg);
-int twl4030_i2c_read_u8(u8 mod_no, u8 *val, u8 reg);
+int twl_i2c_write_u8(u8 mod_no, u8 val, u8 reg);
+int twl_i2c_read_u8(u8 mod_no, u8 *val, u8 reg);
 
 /*
  * Read and write several 8-bit registers at once.
  *
- * IMPORTANT:  For twl4030_i2c_write(), allocate num_bytes + 1
+ * IMPORTANT:  For twl_i2c_write(), allocate num_bytes + 1
  * for the value, and populate your data starting at offset 1.
  */
-int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
-int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
+int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
+int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 
 /*----------------------------------------------------------------------*/
 
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index c3a6ceb..2a27f7b 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -175,7 +175,7 @@ static int twl4030_write(struct snd_soc_codec *codec,
 {
 	twl4030_write_reg_cache(codec, reg, value);
 	if (likely(reg < TWL4030_REG_SW_SHADOW))
-		return twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE, value,
+		return twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE, value,
 					    reg);
 	else
 		return 0;
@@ -261,7 +261,7 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 	do {
 		/* this takes a little while, so don't slam i2c */
 		udelay(2000);
-		twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte,
+		twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte,
 				    TWL4030_REG_ANAMICL);
 	} while ((i++ < 100) &&
 		 ((byte & TWL4030_CNCL_OFFSET_START) ==
@@ -542,7 +542,7 @@ static int pin_name##pga_event(struct snd_soc_dapm_widget *w,		\
 		break;							\
 	case SND_SOC_DAPM_POST_PMD:					\
 		reg_val = twl4030_read_reg_cache(w->codec, reg);	\
-		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,	\
+		twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,	\
 					reg_val & (~mask),		\
 					reg);				\
 		break;							\
@@ -679,7 +679,7 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 		mdelay((ramp_base[(hs_pop & TWL4030_RAMP_DELAY) >> 2] /
 			twl4030->sysclk) + 1);
 		/* Bypass the reg_cache to mute the headset */
-		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+		twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
 					hs_gain & (~0x0f),
 					TWL4030_REG_HS_GAIN_SET);
 
-- 
1.5.4.7

