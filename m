From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 03/18] OMAP: GPIO: Move gpio_get_index() to mach-omap
Date: Fri, 22 Apr 2011 16:38:17 +0530
Message-ID: <1303470512-19671-4-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38686 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab1DVLEv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 07:04:51 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

gpio_get_index() uses cpu_is* checks. Move this function from
plat-omap/gpio.c to SoC specific GPIO files in mach-omap*/ and
use pdata to pass the function pointer.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |   14 ++++++++++
 arch/arm/mach-omap1/gpio16xx.c         |   18 +++++++++++++-
 arch/arm/mach-omap1/gpio7xx.c          |   18 +++++++++++++-
 arch/arm/mach-omap2/gpio.c             |   12 +++++++++
 arch/arm/plat-omap/gpio.c              |   42 +++++++++++++-------------------
 arch/arm/plat-omap/include/plat/gpio.h |    5 ++++
 6 files changed, 82 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 04c4b04..eb2727a 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -21,6 +21,8 @@
 #define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
 #define OMAP1510_GPIO_BASE		0xFFFCE000
 
+#define OMAP1510_GPIO_INDEX_MASK	0x0f
+
 /* gpio1 */
 static struct __initdata resource omap15xx_mpu_gpio_resources[] = {
 	{
@@ -80,6 +82,15 @@ static struct __initdata platform_device omap15xx_gpio = {
 	.resource = omap15xx_gpio_resources,
 };
 
+static int get_gpio_index(int gpio)
+{
+	return gpio & OMAP1510_GPIO_INDEX_MASK;
+}
+
+static struct omap_gpio_func gpio_fn = {
+	.get_index = get_gpio_index,
+};
+
 /*
  * omap15xx_gpio_init needs to be done before
  * machine_init functions access gpio APIs.
@@ -90,7 +101,10 @@ static int __init omap15xx_gpio_init(void)
 	if (!cpu_is_omap15xx())
 		return -EINVAL;
 
+	omap15xx_gpio_config.gpio_fn = &gpio_fn;
 	platform_device_register(&omap15xx_mpu_gpio);
+
+	omap15xx_mpu_gpio_config.gpio_fn = &gpio_fn;
 	platform_device_register(&omap15xx_gpio);
 
 	gpio_bank_count = 2;
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 5dd0d4c..9d8aabc 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -24,6 +24,8 @@
 #define OMAP1610_GPIO4_BASE		0xfffbbc00
 #define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
 
+#define OMAP1610_GPIO_INDEX_MASK	0x0f
+
 /* mpu gpio */
 static struct __initdata resource omap16xx_mpu_gpio_resources[] = {
 	{
@@ -178,6 +180,15 @@ static struct __initdata platform_device * omap16xx_gpio_dev[] = {
 	&omap16xx_gpio4,
 };
 
+static int get_gpio_index(int gpio)
+{
+	return gpio & OMAP1610_GPIO_INDEX_MASK;
+}
+
+static struct omap_gpio_func gpio_fn = {
+	.get_index = get_gpio_index,
+};
+
 /*
  * omap16xx_gpio_init needs to be done before
  * machine_init functions access gpio APIs.
@@ -190,8 +201,13 @@ static int __init omap16xx_gpio_init(void)
 	if (!cpu_is_omap16xx())
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
+	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
+		struct omap_gpio_platform_data *pdata;
+
+		pdata = omap16xx_gpio_dev[i]->dev.platform_data;
+		pdata->gpio_fn = &gpio_fn;
 		platform_device_register(omap16xx_gpio_dev[i]);
+	}
 
 	gpio_bank_count = ARRAY_SIZE(omap16xx_gpio_dev);
 
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 1204c8b..74456a9 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -26,6 +26,8 @@
 #define OMAP7XX_GPIO6_BASE		0xfffbe800
 #define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
 
+#define OMAP7XX_GPIO_INDEX_MASK		0x1f
+
 /* mpu gpio */
 static struct __initdata resource omap7xx_mpu_gpio_resources[] = {
 	{
@@ -240,6 +242,15 @@ static struct __initdata platform_device * omap7xx_gpio_dev[] = {
 	&omap7xx_gpio6,
 };
 
+static int get_gpio_index(int gpio)
+{
+	return gpio & OMAP7XX_GPIO_INDEX_MASK;
+}
+
+static struct omap_gpio_func gpio_fn = {
+	.get_index = get_gpio_index,
+};
+
 /*
  * omap7xx_gpio_init needs to be done before
  * machine_init functions access gpio APIs.
@@ -252,8 +263,13 @@ static int __init omap7xx_gpio_init(void)
 	if (!cpu_is_omap7xx())
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(omap7xx_gpio_dev); i++)
+	for (i = 0; i < ARRAY_SIZE(omap7xx_gpio_dev); i++) {
+		struct omap_gpio_platform_data *pdata;
+
+		pdata = omap7xx_gpio_dev[i]->dev.platform_data;
+		pdata->gpio_fn = &gpio_fn;
 		platform_device_register(omap7xx_gpio_dev[i]);
+	}
 
 	gpio_bank_count = ARRAY_SIZE(omap7xx_gpio_dev);
 
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 9529842..498ab92 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -24,6 +24,8 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
+#define OMAP2_GPIO_INDEX_MASK		0x1f
+
 static struct omap_device_pm_latency omap_gpio_latency[] = {
 	[0] = {
 		.deactivate_func = omap_device_idle_hwmods,
@@ -32,6 +34,15 @@ static struct omap_device_pm_latency omap_gpio_latency[] = {
 	},
 };
 
+static int get_gpio_index(int gpio)
+{
+	return gpio & OMAP2_GPIO_INDEX_MASK;
+}
+
+static struct omap_gpio_func gpio_fn = {
+	.get_index = get_gpio_index,
+};
+
 static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 {
 	struct omap_device *od;
@@ -60,6 +71,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	pdata->bank_width = dev_attr->bank_width;
 	pdata->dbck_flag = dev_attr->dbck_flag;
 	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
+	pdata->gpio_fn = &gpio_fn;
 
 	switch (oh->class->rev) {
 	case 0:
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 498e1df..e70bb6e 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -183,23 +183,13 @@ static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
  * related to all instances of the device
  */
 static struct gpio_bank *gpio_bank;
+static struct omap_gpio_func gpio_fn;
 
 static int bank_width;
 
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
 int gpio_bank_count;
 
-static inline int get_gpio_index(int gpio)
-{
-	if (cpu_is_omap7xx())
-		return gpio & 0x1f;
-	if (cpu_is_omap24xx())
-		return gpio & 0x1f;
-	if (cpu_is_omap34xx() || cpu_is_omap44xx())
-		return gpio & 0x1f;
-	return gpio & 0x0f;
-}
-
 static inline int gpio_valid(int gpio)
 {
 	if (gpio < 0)
@@ -394,7 +384,7 @@ static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 		return -EINVAL;
 	}
 	return (__raw_readl(reg)
-			& (1 << get_gpio_index(gpio))) != 0;
+			& (1 << gpio_fn.get_index(gpio))) != 0;
 }
 
 static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
@@ -440,7 +430,7 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 		return -EINVAL;
 	}
 
-	return (__raw_readl(reg) & (1 << get_gpio_index(gpio))) != 0;
+	return (__raw_readl(reg) & (1 << gpio_fn.get_index(gpio))) != 0;
 }
 
 #define MOD_REG_BIT(reg, bit_mask, set)	\
@@ -477,7 +467,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	else
 		debounce = (debounce / 0x1f) - 1;
 
-	l = 1 << get_gpio_index(gpio);
+	l = 1 << gpio_fn.get_index(gpio);
 
 	if (bank->method == METHOD_GPIO_44XX)
 		reg += OMAP4_GPIO_DEBOUNCINGTIME;
@@ -729,7 +719,7 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 
 	bank = irq_data_get_irq_chip_data(d);
 	spin_lock_irqsave(&bank->lock, flags);
-	retval = _set_gpio_triggering(bank, get_gpio_index(gpio), type);
+	retval = _set_gpio_triggering(bank, gpio_fn.get_index(gpio), type);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
@@ -798,7 +788,7 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
 {
-	_clear_gpio_irqbank(bank, 1 << get_gpio_index(gpio));
+	_clear_gpio_irqbank(bank, 1 << gpio_fn.get_index(gpio));
 }
 
 static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
@@ -932,7 +922,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
 {
-	_enable_gpio_irqbank(bank, 1 << get_gpio_index(gpio), enable);
+	_enable_gpio_irqbank(bank, 1 << gpio_fn.get_index(gpio), enable);
 }
 
 /*
@@ -985,10 +975,10 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 
 static void _reset_gpio(struct gpio_bank *bank, int gpio)
 {
-	_set_gpio_direction(bank, get_gpio_index(gpio), 1);
+	_set_gpio_direction(bank, gpio_fn.get_index(gpio), 1);
 	_set_gpio_irqenable(bank, gpio, 0);
 	_clear_gpio_irqstatus(bank, gpio);
-	_set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
+	_set_gpio_triggering(bank, gpio_fn.get_index(gpio), IRQ_TYPE_NONE);
 }
 
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
@@ -1001,7 +991,7 @@ static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
 	if (check_gpio(gpio) < 0)
 		return -ENODEV;
 	bank = irq_data_get_irq_chip_data(d);
-	retval = _set_gpio_wakeup(bank, get_gpio_index(gpio), enable);
+	retval = _set_gpio_wakeup(bank, gpio_fn.get_index(gpio), enable);
 
 	return retval;
 }
@@ -1180,7 +1170,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 		gpio_irq = bank->virtual_irq_start;
 		for (; isr != 0; isr >>= 1, gpio_irq++) {
-			gpio_index = get_gpio_index(irq_to_gpio(gpio_irq));
+			gpio_index = gpio_fn.get_index(irq_to_gpio(gpio_irq));
 
 			if (!(isr & 1))
 				continue;
@@ -1231,18 +1221,18 @@ static void gpio_mask_irq(struct irq_data *d)
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 
 	_set_gpio_irqenable(bank, gpio, 0);
-	_set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
+	_set_gpio_triggering(bank, gpio_fn.get_index(gpio), IRQ_TYPE_NONE);
 }
 
 static void gpio_unmask_irq(struct irq_data *d)
 {
 	unsigned int gpio = d->irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned int irq_mask = 1 << get_gpio_index(gpio);
+	unsigned int irq_mask = 1 << gpio_fn.get_index(gpio);
 	u32 trigger = irqd_get_trigger_type(d);
 
 	if (trigger)
-		_set_gpio_triggering(bank, get_gpio_index(gpio), trigger);
+		_set_gpio_triggering(bank, gpio_fn.get_index(gpio), trigger);
 
 	/* For level-triggered GPIOs, the clearing must be done after
 	 * the HW source is cleared, thus after the handler has run */
@@ -1446,7 +1436,7 @@ static int gpio_get(struct gpio_chip *chip, unsigned offset)
 	gpio = chip->base + offset;
 	bank = container_of(chip, struct gpio_bank, chip);
 	reg = bank->base;
-	mask = 1 << get_gpio_index(gpio);
+	mask = 1 << gpio_fn.get_index(gpio);
 
 	if (gpio_is_input(bank, mask))
 		return _get_gpio_datain(bank, gpio);
@@ -1674,6 +1664,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 			return ret;
 		if (cpu_class_is_omap1())
 			mpuio_init();
+
+		gpio_fn.get_index = pdata->gpio_fn->get_index;
 	}
 
 	id = pdev->id;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index cac2e8a..1cfb01b 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -71,8 +71,13 @@ struct omap_gpio_dev_attr {
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
 };
 
+struct omap_gpio_func {
+	int (*get_index)(int gpio);
+};
+
 struct omap_gpio_platform_data {
 	u16 virtual_irq_start;
+	struct omap_gpio_func *gpio_fn;
 	int bank_type;
 	int bank_width;		/* GPIO bank width */
 	int bank_stride;	/* Only needed for omap1 MPUIO */
-- 
1.7.1

