From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] twl4030-usb patches
Date: Tue, 2 Sep 2008 08:43:56 -0700
Message-ID: <200809020843.56874.david-b@pacbell.net>
References: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com> <20080902123446.GC7089@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:27230 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751364AbYIBPn7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 11:43:59 -0400
In-Reply-To: <20080902123446.GC7089@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

On Tuesday 02 September 2008, Felipe Balbi wrote:
> twl4030_gpio should be
> moved to gpiolib also before sending to mainline.

Snapshot of what's in my tree ... 


=========== CUT HERE
From: David Brownell <dbrownell@users.sourceforge.net>

Make the TWL4030 GPIOs hook up to gpiolib.

Start to phase out the older TWL-specific calls, starting with
not exporting them (except for the few declared in the public
header, and accessed from arch/arm/mach-omap2/hsmmc.c).

# the Kconfig dependency changes in 2.6.27-rc ...

# should have the base GPIO set up better; minimally
# in a system header, ideally platform data ...

# the whole twl driver should be "new style".

NYET-Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/i2c/chips/Kconfig        |    2 
 drivers/i2c/chips/twl4030-gpio.c |   81 +++++++++++++++++++++++++++++++--------
 2 files changed, 66 insertions(+), 17 deletions(-)

--- beagle.orig/drivers/i2c/chips/Kconfig	2008-08-21 16:11:04.000000000 -0700
+++ beagle/drivers/i2c/chips/Kconfig	2008-08-21 19:58:02.000000000 -0700
@@ -159,7 +159,7 @@ config TWL4030_CORE
 
 config TWL4030_GPIO
 	bool "TWL4030 GPIO Driver"
-	depends on TWL4030_CORE
+	depends on TWL4030_CORE && GPIOLIB
 
 config TWL4030_MADC
 	tristate "TWL4030 MADC Driver"
--- beagle.orig/drivers/i2c/chips/twl4030-gpio.c	2008-08-21 16:11:04.000000000 -0700
+++ beagle/drivers/i2c/chips/twl4030-gpio.c	2008-08-21 16:15:51.000000000 -0700
@@ -31,10 +31,10 @@
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
-#include <linux/random.h>
-#include <linux/syscalls.h>
+#include <linux/device.h>
 #include <linux/kthread.h>
 #include <linux/irq.h>
+#include <linux/gpio.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
@@ -46,7 +46,9 @@
 #include <mach/gpio.h>
 #include <mach/mux.h>
 
-#include <linux/device.h>
+/* TEMPORARY HACK */
+#define	TWL4030_GPIO_BASE	OMAP_MAX_GPIO_LINES
+
 
 /* BitField Definitions */
 
@@ -242,7 +244,7 @@ static void twl4030_gpio_unmask_irqchip(
 }
 
 static struct irq_chip twl4030_gpio_irq_chip = {
-	.name	= "twl4030-gpio",
+	.name	= "twl4030",
 	.ack	= twl4030_gpio_mask_and_ack_irqchip,
 	.mask	= twl4030_gpio_mask_irqchip,
 	.unmask	= twl4030_gpio_unmask_irqchip,
@@ -297,23 +299,28 @@ int twl4030_request_gpio(int gpio)
 	if (unlikely(gpio >= TWL4030_GPIO_MAX))
 		return -EPERM;
 
+	ret = gpio_request(TWL4030_GPIO_BASE + gpio, NULL);
+	if (ret < 0)
+		return ret;
+
 	down(&gpio_sem);
 	if (gpio_usage_count & (0x1 << gpio))
 		ret = -EBUSY;
 	else {
 		u8 clear_pull[6] = { 0, 0, 0, 0, 0, 0 };
+
 		/* First time usage? - switch on GPIO module */
 		if (!gpio_usage_count) {
-			ret =
-			gpio_twl4030_write(REG_GPIO_CTRL,
+			ret = gpio_twl4030_write(REG_GPIO_CTRL,
 					MASK_GPIO_CTRL_GPIO_ON);
 			ret = gpio_twl4030_write(REG_GPIO_SIH_CTRL, 0x00);
 		}
 		if (!ret)
 			gpio_usage_count |= (0x1 << gpio);
+		else
+			gpio_free(TWL4030_GPIO_BASE + gpio);
 
-		ret =
-		twl4030_i2c_write(TWL4030_MODULE_GPIO, clear_pull,
+		ret = twl4030_i2c_write(TWL4030_MODULE_GPIO, clear_pull,
 				REG_GPIOPUPDCTR1, 5);
 	}
 	up(&gpio_sem);
@@ -335,8 +342,10 @@ int twl4030_free_gpio(int gpio)
 
 	if ((gpio_usage_count & (0x1 << gpio)) == 0)
 		ret = -EPERM;
-	else
+	else {
 		gpio_usage_count &= ~(0x1 << gpio);
+		gpio_free(TWL4030_GPIO_BASE + gpio);
+	}
 
 	/* Last time usage? - switch off GPIO module */
 	if (!gpio_usage_count)
@@ -350,7 +359,7 @@ EXPORT_SYMBOL(twl4030_free_gpio);
 /*
  * Set direction for TWL4030 GPIO
  */
-int twl4030_set_gpio_direction(int gpio, int is_input)
+static int twl4030_set_gpio_direction(int gpio, int is_input)
 {
 	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
 	u8 d_msk = MASK_GPIODATADIR_GPIOxDIR(GET_GPIO_DATA_OFF(gpio));
@@ -377,12 +386,11 @@ int twl4030_set_gpio_direction(int gpio,
 	up(&gpio_sem);
 	return ret;
 }
-EXPORT_SYMBOL(twl4030_set_gpio_direction);
 
 /*
  * To enable/disable GPIO pin on TWL4030
  */
-int twl4030_set_gpio_dataout(int gpio, int enable)
+static int twl4030_set_gpio_dataout(int gpio, int enable)
 {
 	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
 	u8 d_msk = MASK_GPIODATAOUT_GPIOxOUT(GET_GPIO_DATA_OFF(gpio));
@@ -403,7 +411,6 @@ int twl4030_set_gpio_dataout(int gpio, i
 	up(&gpio_sem);
 	return ret;
 }
-EXPORT_SYMBOL(twl4030_set_gpio_dataout);
 
 /*
  * To get the status of a GPIO pin on TWL4030
@@ -430,6 +437,7 @@ int twl4030_get_gpio_datain(int gpio)
 }
 EXPORT_SYMBOL(twl4030_get_gpio_datain);
 
+#if 0
 /*
  * Configure PULL type for a GPIO pin on TWL4030
  */
@@ -465,7 +473,7 @@ int twl4030_set_gpio_pull(int gpio, int 
 	up(&gpio_sem);
 	return ret;
 }
-EXPORT_SYMBOL(twl4030_set_gpio_pull);
+#endif
 
 /*
  * Configure Edge control for a GPIO pin on TWL4030
@@ -538,6 +546,7 @@ int twl4030_set_gpio_debounce(int gpio, 
 }
 EXPORT_SYMBOL(twl4030_set_gpio_debounce);
 
+#if 0
 /*
  * Configure Card detect for GPIO pin on TWL4030
  */
@@ -567,7 +576,7 @@ int twl4030_set_gpio_card_detect(int gpi
 	up(&gpio_sem);
 	return (ret);
 }
-EXPORT_SYMBOL(twl4030_set_gpio_card_detect);
+#endif
 
 /* MODULE FUNCTIONS */
 
@@ -703,12 +712,52 @@ static void do_twl4030_gpio_module_irq(u
 	}
 }
 
-/* TWL4030 Initialization module */
+static int twl_direction_in(struct gpio_chip *chip, unsigned offset)
+{
+	return twl4030_set_gpio_direction(offset, 1);
+}
+
+static int twl_get(struct gpio_chip *chip, unsigned offset)
+{
+	int status = twl4030_get_gpio_datain(offset);
+
+	return (status < 0) ? 0 : status;
+}
+
+static int twl_direction_out(struct gpio_chip *chip, unsigned offset, int value)
+{
+	twl4030_set_gpio_dataout(offset, value);
+	return twl4030_set_gpio_direction(offset, 0);
+}
+
+static void twl_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	twl4030_set_gpio_dataout(offset, value);
+}
+
+static struct gpio_chip twl_gpiochip = {
+	.label			= "twl4030",
+	.owner			= THIS_MODULE,
+	.direction_input	= twl_direction_in,
+	.get			= twl_get,
+	.direction_output	= twl_direction_out,
+	.set			= twl_set,
+	.base			= TWL4030_GPIO_BASE,
+	.ngpio			= TWL4030_GPIO_MAX,
+	.can_sleep		= 1,
+};
+
+/* TWL4030 GPIO Initialization module */
 static int __init gpio_twl4030_init(void)
 {
 	int ret;
 	int irq = 0;
 
+	ret = gpiochip_add(&twl_gpiochip);
+	if (ret < 0)
+		pr_err("%s: could not register gpiochip, %d\n",
+				__func__, ret);
+
 	/* init the global locking sem */
 	sema_init(&gpio_sem, 1);
 

