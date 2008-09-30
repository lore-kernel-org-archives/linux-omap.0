From: David Brownell <david-b@pacbell.net>
Subject: [PATCH 26/25] twl4030 gpio cleanups
Date: Tue, 30 Sep 2008 12:49:06 -0700
Message-ID: <200809301249.06778.david-b@pacbell.net>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:47930 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753119AbYI3TtJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2008 15:49:09 -0400
In-Reply-To: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Clean up the twl4030-gpio code a bit ... mostly by shrinkage.

Remove a bunch of macros that are just obfuscating what the
TWL4030 GPIO code is doing.  Some duplicated standard macros
like BIT(); others hid trivial math (mask/shift); others were
completely unused.

Use BIT() in several places to highlight the bitmasking and
make the code more compact.

Remove pointless locking calls, sanity checks, and parenthesis.
And needless irq_chip.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
I suggest just merging 'v5' plus this patch instead of issuing
"v6" series.  ;)

 drivers/gpio/twl4030-gpio.c |  189 ++++++++++--------------------------------
 1 file changed, 47 insertions(+), 142 deletions(-)

--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -41,6 +41,20 @@
 #include <linux/i2c/twl4030-gpio.h>
 
 
+/*
+ * The GPIO "subchip" supports 18 GPIOs which can be configured as
+ * inputs or outputs, with pullups or pulldowns on each pin.  Each
+ * GPIO can trigger interrupts on either or both edges.
+ *
+ * GPIO interrupts can be fed to either of two IRQ lines; this is
+ * intended to support multiple hosts.
+ *
+ * There are also two LED pins used sometimes as output-only GPIOs.
+ *
+ * FIXME code currently only handles the first IRQ line.
+ */
+
+
 static inline void activate_irq(int irq)
 {
 #ifdef CONFIG_ARM
@@ -65,83 +79,15 @@ static int twl4030_gpio_irq_end;
 #define is_module()	false
 #endif
 
-/* BitField Definitions */
-
-/* Data banks : 3 banks for 8 gpios each */
-#define DATA_BANK_MAX				8
-#define GET_GPIO_DATA_BANK(x)			((x)/DATA_BANK_MAX)
-#define GET_GPIO_DATA_OFF(x)			((x)%DATA_BANK_MAX)
-
-/* GPIODATADIR Fields each block 0-7 */
-#define BIT_GPIODATADIR_GPIOxDIR(x)		(x)
-#define MASK_GPIODATADIR_GPIOxDIR(x)		(0x01 << (x))
-
-/* GPIODATAIN Fields each block 0-7 */
-#define BIT_GPIODATAIN_GPIOxIN(x)		(x)
-#define MASK_GPIODATAIN_GPIOxIN(x)		(0x01 << (x))
-
-/* GPIODATAOUT Fields each block 0-7 */
-#define BIT_GPIODATAOUT_GPIOxOUT(x)		(x)
-#define MASK_GPIODATAOUT_GPIOxOUT(x)		(0x01 << (x))
-
-/* CLEARGPIODATAOUT Fields */
-#define BIT_CLEARGPIODATAOUT_GPIOxOUT(x)	(x)
-#define MASK_CLEARGPIODATAOUT_GPIOxOUT(x)	(0x01 << (x))
-
-/* SETGPIODATAOUT Fields */
-#define BIT_SETGPIODATAOUT_GPIOxOUT(x)		(x)
-#define MASK_SETGPIODATAOUT_GPIOxOUT(x)		(0x01 << (x))
-
-/* GPIO_DEBEN Fields */
-#define BIT_GPIO_DEBEN_GPIOxDEB(x)		(x)
-#define MASK_GPIO_DEBEN_GPIOxDEB(x)		(0x01 << (x))
-
-/* GPIO_ISR1A Fields */
-#define BIT_GPIO_ISR_GPIOxISR(x)		(x)
-#define MASK_GPIO_ISR_GPIOxISR(x)		(0x01 << (x))
-
-/* GPIO_IMR1A Fields */
-#define BIT_GPIO_IMR1A_GPIOxIMR(x)		(x)
-#define MASK_GPIO_IMR1A_GPIOxIMR(x)		(0x01 << (x))
-
-/* GPIO_SIR1 Fields */
-#define BIT_GPIO_SIR1_GPIOxSIR(x)		(x)
-#define MASK_GPIO_SIR1_GPIO0SIR			(0x01 << (x))
-
-
-/* Control banks : 5 banks for 4 gpios each */
-#define DATA_CTL_MAX			4
-#define GET_GPIO_CTL_BANK(x)		((x)/DATA_CTL_MAX)
-#define GET_GPIO_CTL_OFF(x)		((x)%DATA_CTL_MAX)
-#define GPIO_BANK_MAX			GET_GPIO_CTL_BANK(TWL4030_GPIO_MAX)
-
-/* GPIOPUPDCTRx Fields 5 banks of 4 gpios each */
-#define BIT_GPIOPUPDCTR1_GPIOxPD(x)	(2 * (x))
-#define MASK_GPIOPUPDCTR1_GPIOxPD(x)	(0x01 << (2 * (x)))
-#define BIT_GPIOPUPDCTR1_GPIOxPU(x)	((x) + 1)
-#define MASK_GPIOPUPDCTR1_GPIOxPU(x)	(0x01 << (((2 * (x)) + 1)))
-
-/* GPIO_EDR1 Fields */
-#define BIT_GPIO_EDR1_GPIOxFALLING(x)	(2 * (x))
-#define MASK_GPIO_EDR1_GPIOxFALLING(x)	(0x01 << (2 * (x)))
-#define BIT_GPIO_EDR1_GPIOxRISING(x)	((x) + 1)
-#define MASK_GPIO_EDR1_GPIOxRISING(x)	(0x01 << (((2 * (x)) + 1)))
-
 /* GPIO_SIH_CTRL Fields */
-#define BIT_GPIO_SIH_CTRL_EXCLEN	(0x000)
-#define MASK_GPIO_SIH_CTRL_EXCLEN	(0x00000001)
-#define BIT_GPIO_SIH_CTRL_PENDDIS	(0x001)
-#define MASK_GPIO_SIH_CTRL_PENDDIS	(0x00000002)
-#define BIT_GPIO_SIH_CTRL_COR		(0x002)
-#define MASK_GPIO_SIH_CTRL_COR		(0x00000004)
+#define MASK_GPIO_SIH_CTRL_EXCLEN	BIT(0)
+#define MASK_GPIO_SIH_CTRL_PENDDIS	BIT(1)
+#define MASK_GPIO_SIH_CTRL_COR		BIT(2)
 
 /* GPIO_CTRL Fields */
-#define BIT_GPIO_CTRL_GPIO0CD1		(0x000)
-#define MASK_GPIO_CTRL_GPIO0CD1		(0x00000001)
-#define BIT_GPIO_CTRL_GPIO1CD2		(0x001)
-#define MASK_GPIO_CTRL_GPIO1CD2		(0x00000002)
-#define BIT_GPIO_CTRL_GPIO_ON		(0x002)
-#define MASK_GPIO_CTRL_GPIO_ON		(0x00000004)
+#define MASK_GPIO_CTRL_GPIO0CD1		BIT(0)
+#define MASK_GPIO_CTRL_GPIO1CD2		BIT(1)
+#define MASK_GPIO_CTRL_GPIO_ON		BIT(2)
 
 /* Mask for GPIO registers when aggregated into a 32-bit integer */
 #define GPIO_32_MASK			0x0003ffff
@@ -298,29 +244,13 @@ static struct irq_chip twl4030_gpio_irq_
 	.set_type	= twl4030_gpio_irq_set_type,
 };
 
-/*
- * These are the irqchip methods for the TWL4030 PIH GPIO module interrupt.
- * The PIH module doesn't have interrupt masking capability, so these
- * methods are NULL.
- */
-static void twl4030_gpio_module_ack(unsigned int irq) {}
-static void twl4030_gpio_module_mask(unsigned int irq) {}
-static void twl4030_gpio_module_unmask(unsigned int irq) {}
-static struct irq_chip twl4030_gpio_module_irq_chip = {
-	.ack	= twl4030_gpio_module_ack,
-	.mask	= twl4030_gpio_module_mask,
-	.unmask	= twl4030_gpio_module_unmask,
-};
 
 /*
  * To configure TWL4030 GPIO module registers
  */
 static inline int gpio_twl4030_write(u8 address, u8 data)
 {
-	int ret = 0;
-
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, data, address);
-	return ret;
+	return twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, data, address);
 }
 
 /*
@@ -332,9 +262,7 @@ static inline int gpio_twl4030_read(u8 a
 	int ret = 0;
 
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &data, address);
-	if (ret >= 0)
-		ret = data;
-	return ret;
+	return (ret < 0) ? ret : data;
 }
 
 /*
@@ -352,7 +280,7 @@ int twl4030_request_gpio(int gpio)
 		return ret;
 
 	mutex_lock(&gpio_lock);
-	if (gpio_usage_count & (0x1 << gpio)) {
+	if (gpio_usage_count & BIT(gpio)) {
 		ret = -EBUSY;
 	} else {
 		/* First time usage? - switch on GPIO module */
@@ -362,7 +290,7 @@ int twl4030_request_gpio(int gpio)
 			ret = gpio_twl4030_write(REG_GPIO_SIH_CTRL, 0x00);
 		}
 		if (!ret)
-			gpio_usage_count |= (0x1 << gpio);
+			gpio_usage_count |= BIT(gpio);
 		else
 			gpio_free(twl_gpiochip.base + gpio);
 	}
@@ -383,10 +311,10 @@ int twl4030_free_gpio(int gpio)
 
 	mutex_lock(&gpio_lock);
 
-	if ((gpio_usage_count & (0x1 << gpio)) == 0) {
+	if ((gpio_usage_count & BIT(gpio)) == 0) {
 		ret = -EPERM;
 	} else {
-		gpio_usage_count &= ~(0x1 << gpio);
+		gpio_usage_count &= ~BIT(gpio);
 		gpio_free(twl_gpiochip.base + gpio);
 	}
 
@@ -399,27 +327,21 @@ int twl4030_free_gpio(int gpio)
 }
 EXPORT_SYMBOL(twl4030_free_gpio);
 
-/*
- * Set direction for TWL4030 GPIO
- */
 static int twl4030_set_gpio_direction(int gpio, int is_input)
 {
-	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
-	u8 d_msk = MASK_GPIODATADIR_GPIOxDIR(GET_GPIO_DATA_OFF(gpio));
+	u8 d_bnk = gpio >> 3;
+	u8 d_msk = BIT(gpio & 0x7);
 	u8 reg = 0;
 	u8 base = REG_GPIODATADIR1 + d_bnk;
 	int ret = 0;
 
-	if (unlikely(!(gpio_usage_count & (0x1 << gpio))))
-		return -EPERM;
-
 	mutex_lock(&gpio_lock);
 	ret = gpio_twl4030_read(base);
 	if (ret >= 0) {
 		if (is_input)
-			reg = (u8) ((ret) & ~(d_msk));
+			reg = ret & ~d_msk;
 		else
-			reg = (u8) ((ret) | (d_msk));
+			reg = ret | d_msk;
 
 		ret = gpio_twl4030_write(base, reg);
 	}
@@ -427,48 +349,33 @@ static int twl4030_set_gpio_direction(in
 	return ret;
 }
 
-/*
- * To enable/disable GPIO pin on TWL4030
- */
 static int twl4030_set_gpio_dataout(int gpio, int enable)
 {
-	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
-	u8 d_msk = MASK_GPIODATAOUT_GPIOxOUT(GET_GPIO_DATA_OFF(gpio));
+	u8 d_bnk = gpio >> 3;
+	u8 d_msk = BIT(gpio & 0x7);
 	u8 base = 0;
-	int ret = 0;
-
-	if (unlikely(!(gpio_usage_count & (0x1 << gpio))))
-		return -EPERM;
 
 	if (enable)
 		base = REG_SETGPIODATAOUT1 + d_bnk;
 	else
 		base = REG_CLEARGPIODATAOUT1 + d_bnk;
 
-	mutex_lock(&gpio_lock);
-	ret = gpio_twl4030_write(base, d_msk);
-	mutex_unlock(&gpio_lock);
-	return ret;
+	return gpio_twl4030_write(base, d_msk);
 }
 
-/*
- * To get the status of a GPIO pin on TWL4030
- */
 int twl4030_get_gpio_datain(int gpio)
 {
-	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
-	u8 d_off = BIT_GPIODATAIN_GPIOxIN(GET_GPIO_DATA_OFF(gpio));
+	u8 d_bnk = gpio >> 3;
+	u8 d_off = gpio & 0x7;
 	u8 base = 0;
 	int ret = 0;
 
 	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & (0x1 << gpio))))
+		|| !(gpio_usage_count & BIT(gpio))))
 		return -EPERM;
 
 	base = REG_GPIODATAIN1 + d_bnk;
-	mutex_lock(&gpio_lock);
 	ret = gpio_twl4030_read(base);
-	mutex_unlock(&gpio_lock);
 	if (ret > 0)
 		ret = (ret >> d_off) & 0x1;
 
@@ -478,8 +385,8 @@ EXPORT_SYMBOL(twl4030_get_gpio_datain);
 
 static int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
 {
-	u8 c_bnk = GET_GPIO_CTL_BANK(gpio);
-	u8 c_off = GET_GPIO_CTL_OFF(gpio);
+	u8 c_bnk = gpio >> 2;
+	u8 c_off = (gpio & 0x3) * 2;
 	u8 c_msk = 0;
 	u8 reg = 0;
 	u8 base = 0;
@@ -488,17 +395,16 @@ static int twl4030_set_gpio_edge_ctrl(in
 	base = REG_GPIO_EDR1 + c_bnk;
 
 	if (edge & IRQ_TYPE_EDGE_RISING)
-		c_msk |= MASK_GPIO_EDR1_GPIOxRISING(c_off);
+		c_msk |= BIT(c_off + 1);
 	if (edge & IRQ_TYPE_EDGE_FALLING)
-		c_msk |= MASK_GPIO_EDR1_GPIOxFALLING(c_off);
+		c_msk |= BIT(c_off);
 
 	mutex_lock(&gpio_lock);
 	ret = gpio_twl4030_read(base);
 	if (ret >= 0) {
 		/* clear the previous rising/falling values */
 		reg = (u8) ret;
-		reg &= ~(MASK_GPIO_EDR1_GPIOxFALLING(c_off)
-			| MASK_GPIO_EDR1_GPIOxRISING(c_off));
+		reg &= ~(0x3 << c_off);
 		reg |= c_msk;
 		ret = gpio_twl4030_write(base, reg);
 	}
@@ -511,14 +417,14 @@ static int twl4030_set_gpio_edge_ctrl(in
  */
 int twl4030_set_gpio_debounce(int gpio, int enable)
 {
-	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
-	u8 d_msk = MASK_GPIO_DEBEN_GPIOxDEB(GET_GPIO_DATA_OFF(gpio));
+	u8 d_bnk = gpio >> 3;
+	u8 d_msk = BIT(gpio & 0x7);
 	u8 reg = 0;
 	u8 base = 0;
 	int ret = 0;
 
 	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & (0x1 << gpio))))
+		|| !(gpio_usage_count & BIT(gpio))))
 		return -EPERM;
 
 	base = REG_GPIO_DEBEN1 + d_bnk;
@@ -526,9 +432,9 @@ int twl4030_set_gpio_debounce(int gpio, 
 	ret = gpio_twl4030_read(base);
 	if (ret >= 0) {
 		if (enable)
-			reg = (u8) ((ret) | (d_msk));
+			reg = ret | d_msk;
 		else
-			reg = (u8) ((ret) & ~(d_msk));
+			reg = ret & ~d_msk;
 
 		ret = gpio_twl4030_write(base, reg);
 	}
@@ -552,7 +458,7 @@ int twl4030_set_gpio_card_detect(int gpi
 
 	/* Only GPIO 0 or 1 can be used for CD feature.. */
 	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & (0x1 << gpio))
+		|| !(gpio_usage_count & BIT(gpio))
 		|| (gpio >= TWL4030_GPIO_MAX_CD))) {
 		return -EPERM;
 	}
@@ -855,7 +761,6 @@ static int __devinit gpio_twl4030_probe(
 		 * Install an irq handler to demultiplex the gpio module
 		 * interrupt.
 		 */
-		set_irq_chip(irq, &twl4030_gpio_module_irq_chip);
 		set_irq_chained_handler(irq, do_twl4030_gpio_module_irq);
 		wake_up_process(gpio_unmask_thread);
 


