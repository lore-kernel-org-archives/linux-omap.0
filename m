From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git+ 4/5] twl4030-gpio supports LED signals
Date: Mon, 13 Oct 2008 13:04:16 -0700
Message-ID: <200810131304.16416.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:36268 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753800AbYJMUSj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Oct 2008 16:18:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Expose the two TWL4030 LED signals as output-only GPIOs.  Boards
need to explicitly ask that this be done, to help avoid conflicts
on boards using these same pins to hook up to a vibrator motor.

Note that these are high drive open drain signals; LEDA is rated
for up to 160 mA (!), LEDB up to 60 mA.  Boards using one of these
signals to drive a bank of LCD backlight LEDs would probably want
to access the dedicated PWMs for brightness control, too; easy to
add such support later.

Example:  Beagle has one real LED here (PWM not necessary), and
one GPIO controlling VBUS output over EHCI (PWM not wanted).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/gpio/twl4030-gpio.c |  129 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/i2c/twl4030.h |    3 
 2 files changed, 126 insertions(+), 6 deletions(-)

--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -85,6 +85,32 @@ static inline int gpio_twl4030_write(u8 
 	return twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, data, address);
 }
 
+/*----------------------------------------------------------------------*/
+
+/*
+ * LED register offsets (use TWL4030_MODULE_{LED,PWMA,PWMB}))
+ * PWMs A and B are dedicated to LEDs A and B, respectively.
+ */
+
+#define TWL4030_LED_LEDEN	0x0
+
+/* LEDEN bits */
+#define LEDEN_LEDAON		BIT(0)
+#define LEDEN_LEDBON		BIT(1)
+#define LEDEN_LEDAEXT		BIT(2)
+#define LEDEN_LEDBEXT		BIT(3)
+#define LEDEN_LEDAPWM		BIT(4)
+#define LEDEN_LEDBPWM		BIT(5)
+#define LEDEN_PWM_LENGTHA	BIT(6)
+#define LEDEN_PWM_LENGTHB	BIT(7)
+
+#define TWL4030_PWMx_PWMxON	0x0
+#define TWL4030_PWMx_PWMxOFF	0x1
+
+#define PWMxON_LENGTH		BIT(7)
+
+/*----------------------------------------------------------------------*/
+
 /*
  * To read a TWL4030 GPIO module register
  */
@@ -97,6 +123,32 @@ static inline int gpio_twl4030_read(u8 a
 	return (ret < 0) ? ret : data;
 }
 
+/*----------------------------------------------------------------------*/
+
+static u8 cached_leden;		/* protected by gpio_lock */
+
+/* The LED lines are open drain outputs ... a FET pulls to GND, so an
+ * external pullup is needed.  We could also expose the integrated PWM
+ * as a LED brightness control; we initialize it as "always on".
+ */
+static void twl4030_led_set_value(int led, int value)
+{
+	u8 mask = LEDEN_LEDAON | LEDEN_LEDAPWM;
+	int status;
+
+	if (led)
+		mask <<= 1;
+
+	mutex_lock(&gpio_lock);
+	if (value)
+		cached_leden &= ~mask;
+	else
+		cached_leden |= mask;
+	status = twl4030_i2c_write_u8(TWL4030_MODULE_LED, cached_leden,
+			TWL4030_LED_LEDEN);
+	mutex_unlock(&gpio_lock);
+}
+
 static int twl4030_set_gpio_direction(int gpio, int is_input)
 {
 	u8 d_bnk = gpio >> 3;
@@ -226,6 +278,44 @@ static int twl_request(struct gpio_chip 
 
 	mutex_lock(&gpio_lock);
 
+	/* Support the two LED outputs as output-only GPIOs. */
+	if (offset >= TWL4030_GPIO_MAX) {
+		u8	ledclr_mask = LEDEN_LEDAON | LEDEN_LEDAEXT
+				| LEDEN_LEDAPWM | LEDEN_PWM_LENGTHA;
+		u8	module = TWL4030_MODULE_PWMA;
+
+		offset -= TWL4030_GPIO_MAX;
+		if (offset) {
+			ledclr_mask <<= 1;
+			module = TWL4030_MODULE_PWMB;
+		}
+
+		/* initialize PWM to always-drive */
+		status = twl4030_i2c_write_u8(module, 0x7f,
+				TWL4030_PWMx_PWMxOFF);
+		if (status < 0)
+			goto done;
+		status = twl4030_i2c_write_u8(module, 0x7f,
+				TWL4030_PWMx_PWMxON);
+		if (status < 0)
+			goto done;
+
+		/* init LED to not-driven (high) */
+		module = TWL4030_MODULE_LED;
+		status = twl4030_i2c_read_u8(module, &cached_leden,
+				TWL4030_LED_LEDEN);
+		if (status < 0)
+			goto done;
+		cached_leden &= ~ledclr_mask;
+		status = twl4030_i2c_write_u8(module, cached_leden,
+				TWL4030_LED_LEDEN);
+		if (status < 0)
+			goto done;
+
+		status = 0;
+		goto done;
+	}
+
 	/* on first use, turn GPIO module "on" */
 	if (!gpio_usage_count)
 		status = gpio_twl4030_write(REG_GPIO_CTRL,
@@ -241,6 +331,11 @@ done:
 
 static void twl_free(struct gpio_chip *chip, unsigned offset)
 {
+	if (offset >= TWL4030_GPIO_MAX) {
+		twl4030_led_set_value(offset - TWL4030_GPIO_MAX, 1);
+		return;
+	}
+
 	mutex_lock(&gpio_lock);
 
 	gpio_usage_count &= ~BIT(offset);
@@ -254,30 +349,46 @@ static void twl_free(struct gpio_chip *c
 
 static int twl_direction_in(struct gpio_chip *chip, unsigned offset)
 {
-	return twl4030_set_gpio_direction(offset, 1);
+	return (offset < TWL4030_GPIO_MAX)
+		? twl4030_set_gpio_direction(offset, 1)
+		: -EINVAL;
 }
 
 static int twl_get(struct gpio_chip *chip, unsigned offset)
 {
-	int status = twl4030_get_gpio_datain(offset);
+	int status = 0;
 
+	if (offset < TWL4030_GPIO_MAX)
+		status = twl4030_get_gpio_datain(offset);
+	else if (offset == TWL4030_GPIO_MAX)
+		status = cached_leden & LEDEN_LEDAON;
+	else
+		status = cached_leden & LEDEN_LEDBON;
 	return (status < 0) ? 0 : status;
 }
 
 static int twl_direction_out(struct gpio_chip *chip, unsigned offset, int value)
 {
-	twl4030_set_gpio_dataout(offset, value);
-	return twl4030_set_gpio_direction(offset, 0);
+	if (offset < TWL4030_GPIO_MAX) {
+		twl4030_set_gpio_dataout(offset, value);
+		return twl4030_set_gpio_direction(offset, 0);
+	} else {
+		twl4030_led_set_value(offset - TWL4030_GPIO_MAX, value);
+		return 0;
+	}
 }
 
 static void twl_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	twl4030_set_gpio_dataout(offset, value);
+	if (offset < TWL4030_GPIO_MAX)
+		twl4030_set_gpio_dataout(offset, value);
+	else
+		twl4030_led_set_value(offset - TWL4030_GPIO_MAX, value);
 }
 
 static int twl_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	return twl4030_gpio_irq_base
+	return (twl4030_gpio_irq_base && (offset < TWL4030_GPIO_MAX))
 		? (twl4030_gpio_irq_base + offset)
 		: -EINVAL;
 }
@@ -360,6 +471,12 @@ no_irqs:
 	twl_gpiochip.ngpio = TWL4030_GPIO_MAX;
 	twl_gpiochip.dev = &pdev->dev;
 
+	/* NOTE: we assume VIBRA_CTL.VIBRA_EN, in MODULE_AUDIO_VOICE,
+	 * is (still) clear if use_leds is set.
+	 */
+	if (pdata->use_leds)
+		twl_gpiochip.ngpio += 2;
+
 	ret = gpiochip_add(&twl_gpiochip);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -228,6 +228,9 @@ struct twl4030_gpio_platform_data {
 	int		gpio_base;
 	unsigned	irq_base, irq_end;
 
+	/* package the two LED signals as output-only GPIOs? */
+	bool		use_leds;
+
 	/* For gpio-N, bit (1 << N) in "pullups" is set if that pullup
 	 * should be enabled.  Else, if that bit is set in "pulldowns",
 	 * that pulldown is enabled.  Don't waste power by letting any
