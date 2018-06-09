From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 06/10] ARM: OMAP1: ams-delta FIQ: don't use static GPIO numbers
Date: Sat,  9 Jun 2018 16:02:20 +0200
Message-ID: <20180609140224.32606-6-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "David S . Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

With introduction of GPIO lookup tables to Amstrad Delta board init
file, semantics of symbols representing OMAP GPIO pins defined in
<mach/board-ams-delta.h> changed from statically assigned global GPIO
numbers to hardware pin numbers local to OMAP "gpio-0-15" chip.

This patch modifies deferred FIQ interrupt handler so it no longer uses
static GPIO numbers in favour of IRQ data descriptors obtained at FIQ
initialization time from descriptor of the GPIO chip with use of its
hardware pin numbers.  The chip descriptor is passed from the board
init file.

As a benefit, the deferred FIQ handler should work faster.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/ams-delta-fiq.c              | 48 +++++++++++++++++-------
 arch/arm/mach-omap1/board-ams-delta.c            | 41 +++++++++++++++++++-
 arch/arm/mach-omap1/include/mach/ams-delta-fiq.h |  2 +-
 3 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index d7ca9e2b40d2..1d54a6177f14 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -13,7 +13,8 @@
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
  */
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -40,14 +41,14 @@ static struct fiq_handler fh = {
 unsigned int fiq_buffer[1024];
 EXPORT_SYMBOL(fiq_buffer);
 
+static struct irq_chip *irq_chip;
+static struct irq_data *irq_data[16];
 static unsigned int irq_counter[16];
 
 static irqreturn_t deferred_fiq(int irq, void *dev_id)
 {
+	struct irq_data *d;
 	int gpio, irq_num, fiq_count;
-	struct irq_chip *irq_chip;
-
-	irq_chip = irq_get_chip(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK));
 
 	/*
 	 * For each handled GPIO interrupt, keep calling its interrupt handler
@@ -55,24 +56,21 @@ static irqreturn_t deferred_fiq(int irq, void *dev_id)
 	 */
 	for (gpio = AMS_DELTA_GPIO_PIN_KEYBRD_CLK;
 			gpio <= AMS_DELTA_GPIO_PIN_HOOK_SWITCH; gpio++) {
-		irq_num = gpio_to_irq(gpio);
+		d = irq_data[gpio];
+		irq_num = d->irq;
 		fiq_count = fiq_buffer[FIQ_CNT_INT_00 + gpio];
 
 		if (irq_counter[gpio] < fiq_count &&
 				gpio != AMS_DELTA_GPIO_PIN_KEYBRD_CLK) {
-			struct irq_data *d = irq_get_irq_data(irq_num);
-
 			/*
 			 * handle_simple_irq() that OMAP GPIO edge
 			 * interrupts default to since commit 80ac93c27441
 			 * requires interrupt already acked and unmasked.
 			 */
-			if (irq_chip) {
-				if (irq_chip->irq_ack)
-					irq_chip->irq_ack(d);
-				if (irq_chip->irq_unmask)
-					irq_chip->irq_unmask(d);
-			}
+			if (irq_chip->irq_ack)
+				irq_chip->irq_ack(d);
+			if (irq_chip->irq_unmask)
+				irq_chip->irq_unmask(d);
 		}
 		for (; irq_counter[gpio] < fiq_count; irq_counter[gpio]++)
 			generic_handle_irq(irq_num);
@@ -80,14 +78,36 @@ static irqreturn_t deferred_fiq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-void __init ams_delta_init_fiq(void)
+void __init ams_delta_init_fiq(struct gpio_chip *chip)
 {
+	struct gpio_desc *gpiod;
 	void *fiqhandler_start;
 	unsigned int fiqhandler_length;
 	struct pt_regs FIQ_regs;
 	unsigned long val, offset;
 	int i, retval;
 
+	/* Store irq_chip location for IRQ handler use */
+	irq_chip = chip->irq.chip;
+	if (!irq_chip) {
+		pr_err("%s: GPIO chip %s is missing IRQ function\n", __func__,
+		       chip->label);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(irq_data); i++) {
+		gpiod = gpiochip_request_own_desc(chip, i, NULL);
+		if (IS_ERR(gpiod)) {
+			pr_err("%s: failed to get GPIO pin %d (%ld)\n",
+			       __func__, i, PTR_ERR(gpiod));
+			return;
+		}
+		/* Store irq_data location for IRQ handler use */
+		irq_data[i] = irq_get_irq_data(gpiod_to_irq(gpiod));
+
+		gpiochip_free_own_desc(gpiod);
+	}
+
 	fiqhandler_start = &qwerty_fiqin_start;
 	fiqhandler_length = &qwerty_fiqin_end - &qwerty_fiqin_start;
 	pr_info("Installing fiq handler from %p, length 0x%x\n",
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 2821284aa0c9..f15c0793c34b 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -580,6 +580,44 @@ static struct gpiod_hog ams_delta_gpio_hogs[] = {
 	{},
 };
 
+/*
+ * Some drivers may not use GPIO lookup tables but need to be provided
+ * with GPIO numbers.  The same applies to GPIO based IRQ lines - some
+ * drivers may even not use GPIO layer but expect just IRQ numbers.
+ * We could either define GPIO lookup tables then use them on behalf
+ * of those devices, or we can use GPIO driver level methods for
+ * identification of GPIO and IRQ numbers. For the purpose of the latter,
+ * defina a helper function which identifies GPIO chips by their labels.
+ */
+static int gpiochip_match_by_label(struct gpio_chip *chip, void *data)
+{
+	char *label = data;
+
+	return !strcmp(label, chip->label);
+}
+
+/*
+ * The purpose of this function is to take care of proper initialization of
+ * devices and data structures which depend on GPIO lines provided by OMAP GPIO
+ * banks but their drivers don't use GPIO lookup tables or GPIO layer at all.
+ * The function may be called as soon as OMAP GPIO devices are probed.
+ * Since that happens at postcore_initcall, it can be called successfully
+ * from init_machine or later.
+ * Dependent devices may be registered from within this function or later.
+ */
+static void __init omap_gpio_deps_init(void)
+{
+	struct gpio_chip *chip;
+
+	chip = gpiochip_find(OMAP_GPIO_LABEL, gpiochip_match_by_label);
+	if (!chip) {
+		pr_err("%s: OMAP GPIO chip not found\n", __func__);
+		return;
+	}
+
+	ams_delta_init_fiq(chip);
+}
+
 static void __init ams_delta_init(void)
 {
 	/* mux pins for uarts */
@@ -600,6 +638,7 @@ static void __init ams_delta_init(void)
 	omap_cfg_reg(J19_1610_CAM_D6);
 	omap_cfg_reg(J18_1610_CAM_D7);
 
+	omap_gpio_deps_init();
 	gpiod_add_hogs(ams_delta_gpio_hogs);
 
 	omap_serial_init();
@@ -642,8 +681,6 @@ static void __init ams_delta_init(void)
 	gpiod_add_lookup_tables(ams_delta_gpio_tables,
 				ARRAY_SIZE(ams_delta_gpio_tables));
 
-	ams_delta_init_fiq();
-
 	omap_writew(omap_readw(ARM_RSTCT1) | 0x0004, ARM_RSTCT1);
 
 	omapfb_set_lcd_config(&ams_delta_lcd_config);
diff --git a/arch/arm/mach-omap1/include/mach/ams-delta-fiq.h b/arch/arm/mach-omap1/include/mach/ams-delta-fiq.h
index 6dfc3e1210a3..a9769ff396bc 100644
--- a/arch/arm/mach-omap1/include/mach/ams-delta-fiq.h
+++ b/arch/arm/mach-omap1/include/mach/ams-delta-fiq.h
@@ -73,7 +73,7 @@
 extern unsigned int fiq_buffer[];
 extern unsigned char qwerty_fiqin_start, qwerty_fiqin_end;
 
-extern void __init ams_delta_init_fiq(void);
+extern void __init ams_delta_init_fiq(struct gpio_chip *chip);
 #endif
 
 #endif
-- 
2.16.1
