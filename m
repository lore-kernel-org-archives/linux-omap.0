From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git+ 3/5] hsmmc.c glue uses standard GPIO calls
Date: Mon, 13 Oct 2008 13:03:07 -0700
Message-ID: <200810131303.08075.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:36242 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753560AbYJMUSi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Oct 2008 16:18:38 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Convert the hsmmc init code over to standard GPIO calls:
gpio_request(), gpio_free(), gpio_get_value_cansleep().

NOTE that this doesn't pass GPIO numbers in to hsmmc_init();
those values are still hard-wired.  (For the write protect
signal, the LACK of value is hard-wired...)  So the hsmmc
glue is still kind of problematic.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/hsmmc.c |   25 ++++++++++++-------------
 drivers/gpio/twl4030-gpio.c |   28 +---------------------------
 include/linux/i2c/twl4030.h |    4 ----
 3 files changed, 13 insertions(+), 44 deletions(-)

--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -15,7 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
+
 #include <mach/hardware.h>
 #include <mach/mmc.h>
 #include <mach/board.h>
@@ -32,8 +34,6 @@
 #define LDO_CLR			0x00
 #define VSEL_S2_CLR		0x40
 #define GPIO_0_BIT_POS		(1 << 0)
-#define MMC1_CD_IRQ		0
-#define MMC2_CD_IRQ		1
 
 #define OMAP2_CONTROL_DEVCONF0	0x48002274
 #define OMAP2_CONTROL_DEVCONF1	0x490022E8
@@ -45,9 +45,12 @@
 #define OMAP2_CONTROL_PBIAS_PWRDNZ	(1 << 1)
 #define OMAP2_CONTROL_PBIAS_SCTRL	(1 << 2)
 
+
+static const int mmc1_cd_gpio = OMAP_MAX_GPIO_LINES;		/* HACK!! */
+
 static int hsmmc_card_detect(int irq)
 {
-	return twl4030_get_gpio_datain(irq - TWL4030_GPIO_IRQ_BASE);
+	return gpio_get_value_cansleep(mmc1_cd_gpio);
 }
 
 /*
@@ -60,11 +63,11 @@ static int hsmmc_late_init(struct device
 	/*
 	 * Configure TWL4030 GPIO parameters for MMC hotplug irq
 	 */
-	ret = twl4030_request_gpio(MMC1_CD_IRQ);
+	ret = gpio_request(mmc1_cd_gpio, "mmc0_cd");
 	if (ret)
 		goto err;
 
-	ret = twl4030_set_gpio_debounce(MMC1_CD_IRQ, TWL4030_GPIO_IS_ENABLE);
+	ret = twl4030_set_gpio_debounce(0, true);
 	if (ret)
 		goto err;
 
@@ -77,11 +80,7 @@ err:
 
 static void hsmmc_cleanup(struct device *dev)
 {
-	int ret = 0;
-
-	ret = twl4030_free_gpio(MMC1_CD_IRQ);
-	if (ret)
-		dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
+	gpio_free(mmc1_cd_gpio);
 }
 
 #ifdef CONFIG_PM
@@ -123,7 +122,7 @@ static int hsmmc_suspend(struct device *
 {
 	int ret = 0;
 
-	disable_irq(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ));
+	disable_irq(TWL4030_GPIO_IRQ_NO(0));
 	ret = mask_cd_interrupt(1);
 
 	return ret;
@@ -133,7 +132,7 @@ static int hsmmc_resume(struct device *d
 {
 	int ret = 0;
 
-	enable_irq(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ));
+	enable_irq(TWL4030_GPIO_IRQ_NO(0));
 	ret = mask_cd_interrupt(0);
 
 	return ret;
@@ -260,7 +259,7 @@ static struct omap_mmc_platform_data mmc
 						MMC_VDD_165_195,
 		.name			= "first slot",
 
-		.card_detect_irq        = TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ),
+		.card_detect_irq        = TWL4030_GPIO_IRQ_NO(0),
 		.card_detect            = hsmmc_card_detect,
 	},
 };
--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -97,31 +97,6 @@ static inline int gpio_twl4030_read(u8 a
 	return (ret < 0) ? ret : data;
 }
 
-/*
- * twl4030 GPIO request function
- */
-int twl4030_request_gpio(int gpio)
-{
-	if (unlikely(gpio >= TWL4030_GPIO_MAX))
-		return -EPERM;
-
-	return gpio_request(twl_gpiochip.base + gpio, NULL);
-}
-EXPORT_SYMBOL(twl4030_request_gpio);
-
-/*
- * TWL4030 GPIO free module
- */
-int twl4030_free_gpio(int gpio)
-{
-	if (unlikely(gpio >= TWL4030_GPIO_MAX))
-		return -EPERM;
-
-	gpio_free(twl_gpiochip.base + gpio);
-	return 0;
-}
-EXPORT_SYMBOL(twl4030_free_gpio);
-
 static int twl4030_set_gpio_direction(int gpio, int is_input)
 {
 	u8 d_bnk = gpio >> 3;
@@ -158,7 +133,7 @@ static int twl4030_set_gpio_dataout(int 
 	return gpio_twl4030_write(base, d_msk);
 }
 
-int twl4030_get_gpio_datain(int gpio)
+static int twl4030_get_gpio_datain(int gpio)
 {
 	u8 d_bnk = gpio >> 3;
 	u8 d_off = gpio & 0x7;
@@ -176,7 +151,6 @@ int twl4030_get_gpio_datain(int gpio)
 
 	return ret;
 }
-EXPORT_SYMBOL(twl4030_get_gpio_datain);
 
 /*
  * Configure debounce timing value for a GPIO pin on TWL4030
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -319,17 +319,13 @@ int twl4030_sih_setup(int module);
 /* TWL4030 GPIO interrupt definitions */
 
 #define TWL4030_GPIO_IRQ_NO(n)		(TWL4030_GPIO_IRQ_BASE + (n))
-#define TWL4030_GPIO_IS_ENABLE		1
 
 /*
  * Exported TWL4030 GPIO APIs
  *
  * WARNING -- use standard GPIO and IRQ calls instead; these will vanish.
  */
-int twl4030_get_gpio_datain(int gpio);
-int twl4030_request_gpio(int gpio);
 int twl4030_set_gpio_debounce(int gpio, int enable);
-int twl4030_free_gpio(int gpio);
 
 #if defined(CONFIG_TWL4030_BCI_BATTERY) || \
 	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)
