From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 01/13] OMAP: GPIO: Modify init() in preparation for platform device implementation
Date: Sat, 18 Sep 2010 19:45:41 +0530
Message-ID: <1284819353-8512-2-git-send-email-charu@ti.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48462 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab0IROQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Sep 2010 10:16:16 -0400
In-Reply-To: <1284819353-8512-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

This is in prepartion for implementing GPIO as a platform device.
gpio bank's base addresses are moved from gpio.c to plat/gpio.h.

This patch also modifies omap_gpio_init() to make use of
omap_gpio_chip_init() and omap_gpio_mod_init(). omap_gpio_mod_init() does
the module init by clearing the status register and initializing the
GPIO control register. omap_gpio_chip_init() initializes the chip request,
free, get, set and other function pointers and sets the gpio irq handler.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |  231 ++++++++++++++++++++++-----------------------
 1 files changed, 115 insertions(+), 116 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index b0467c1..dc8c0dc 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -192,14 +192,12 @@ struct gpio_bank {
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
 #endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 
 	u32 saved_datain;
 	u32 saved_fallingdetect;
 	u32 saved_risingdetect;
-#endif
 	u32 level_mask;
 	u32 toggle_mask;
 	spinlock_t lock;
@@ -1718,10 +1716,122 @@ static void __init omap_gpio_show_rev(void)
  */
 static struct lock_class_key gpio_lock_class;
 
+static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
+{
+	if (cpu_class_is_omap2()) {
+		if (cpu_is_omap44xx()) {
+			__raw_writel(0xffffffff, bank->base +
+					OMAP4_GPIO_IRQSTATUSCLR0);
+			__raw_writel(0x00000000, bank->base +
+					 OMAP4_GPIO_DEBOUNCENABLE);
+			/* Initialize interface clk ungated, module enabled */
+			__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
+		} else if (cpu_is_omap34xx()) {
+			__raw_writel(0x00000000, bank->base +
+					OMAP24XX_GPIO_IRQENABLE1);
+			__raw_writel(0xffffffff, bank->base +
+					OMAP24XX_GPIO_IRQSTATUS1);
+			__raw_writel(0x00000000, bank->base +
+					OMAP24XX_GPIO_DEBOUNCE_EN);
+
+			/* Initialize interface clk ungated, module enabled */
+			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
+		} else if (cpu_is_omap24xx()) {
+			static const u32 non_wakeup_gpios[] = {
+				0xe203ffc0, 0x08700040
+			};
+			if (id < ARRAY_SIZE(non_wakeup_gpios))
+				bank->non_wakeup_gpios = non_wakeup_gpios[id];
+		}
+	} else if (cpu_class_is_omap1()) {
+		if (bank_is_mpuio(bank))
+			__raw_writew(0xffff, bank->base
+						+ OMAP_MPUIO_GPIO_MASKIT);
+		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
+			__raw_writew(0xffff, bank->base
+						+ OMAP1510_GPIO_INT_MASK);
+			__raw_writew(0x0000, bank->base
+						+ OMAP1510_GPIO_INT_STATUS);
+		}
+		if (cpu_is_omap16xx() && bank->method == METHOD_GPIO_1610) {
+			__raw_writew(0x0000, bank->base
+						+ OMAP1610_GPIO_IRQENABLE1);
+			__raw_writew(0xffff, bank->base
+						+ OMAP1610_GPIO_IRQSTATUS1);
+			__raw_writew(0x0014, bank->base
+						+ OMAP1610_GPIO_SYSCONFIG);
+
+			/* Enable system clock for GPIO module.
+			 * The CAM_CLK_CTRL *is* really the right place. */
+			omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
+						ULPD_CAM_CLK_CTRL);
+		}
+		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
+			__raw_writel(0xffffffff, bank->base
+						+ OMAP7XX_GPIO_INT_MASK);
+			__raw_writel(0x00000000, bank->base
+						+ OMAP7XX_GPIO_INT_STATUS);
+		}
+	}
+}
+
+static void __init omap_gpio_chip_init(struct gpio_bank *bank)
+{
+	int j, bank_width = 16;
+	static int gpio;
+
+	if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX)
+		bank_width = 32; /* 7xx has 32-bit GPIOs */
+
+	if ((bank->method == METHOD_GPIO_24XX) ||
+			(bank->method == METHOD_GPIO_44XX))
+		bank_width = 32;
+
+	bank->mod_usage = 0;
+	/* REVISIT eventually switch from OMAP-specific gpio structs
+	 * over to the generic ones
+	 */
+	bank->chip.request = omap_gpio_request;
+	bank->chip.free = omap_gpio_free;
+	bank->chip.direction_input = gpio_input;
+	bank->chip.get = gpio_get;
+	bank->chip.direction_output = gpio_output;
+	bank->chip.set_debounce = gpio_debounce;
+	bank->chip.set = gpio_set;
+	bank->chip.to_irq = gpio_2irq;
+	if (bank_is_mpuio(bank)) {
+		bank->chip.label = "mpuio";
+#ifdef CONFIG_ARCH_OMAP16XX
+		bank->chip.dev = &omap_mpuio_device.dev;
+#endif
+		bank->chip.base = OMAP_MPUIO(0);
+	} else {
+		bank->chip.label = "gpio";
+		bank->chip.base = gpio;
+		gpio += bank_width;
+	}
+	bank->chip.ngpio = bank_width;
+
+	gpiochip_add(&bank->chip);
+
+	for (j = bank->virtual_irq_start;
+		     j < bank->virtual_irq_start + bank_width; j++) {
+		lockdep_set_class(&irq_desc[j].lock, &gpio_lock_class);
+		set_irq_chip_data(j, bank);
+		if (bank_is_mpuio(bank))
+			set_irq_chip(j, &mpuio_irq_chip);
+		else
+			set_irq_chip(j, &gpio_irq_chip);
+		set_irq_handler(j, handle_simple_irq);
+		set_irq_flags(j, IRQF_VALID);
+	}
+	set_irq_chained_handler(bank->irq, gpio_irq_handler);
+	set_irq_data(bank->irq, bank);
+}
+
 static int __init _omap_gpio_init(void)
 {
 	int i;
-	int gpio = 0;
 	struct gpio_bank *bank;
 	int bank_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
 	char clk_name[11];
@@ -1830,7 +1940,6 @@ static int __init _omap_gpio_init(void)
 	}
 #endif
 	for (i = 0; i < gpio_bank_count; i++) {
-		int j, gpio_count = 16;
 
 		bank = &gpio_bank[i];
 		spin_lock_init(&bank->lock);
@@ -1842,107 +1951,8 @@ static int __init _omap_gpio_init(void)
 			continue;
 		}
 
-		if (bank_is_mpuio(bank))
-			__raw_writew(0xffff, bank->base + OMAP_MPUIO_GPIO_MASKIT);
-		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
-			__raw_writew(0xffff, bank->base + OMAP1510_GPIO_INT_MASK);
-			__raw_writew(0x0000, bank->base + OMAP1510_GPIO_INT_STATUS);
-		}
-		if (cpu_is_omap16xx() && bank->method == METHOD_GPIO_1610) {
-			__raw_writew(0x0000, bank->base + OMAP1610_GPIO_IRQENABLE1);
-			__raw_writew(0xffff, bank->base + OMAP1610_GPIO_IRQSTATUS1);
-			__raw_writew(0x0014, bank->base + OMAP1610_GPIO_SYSCONFIG);
-		}
-		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
-			__raw_writel(0xffffffff, bank->base + OMAP7XX_GPIO_INT_MASK);
-			__raw_writel(0x00000000, bank->base + OMAP7XX_GPIO_INT_STATUS);
-
-			gpio_count = 32; /* 7xx has 32-bit GPIOs */
-		}
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-		if ((bank->method == METHOD_GPIO_24XX) ||
-				(bank->method == METHOD_GPIO_44XX)) {
-			static const u32 non_wakeup_gpios[] = {
-				0xe203ffc0, 0x08700040
-			};
-
-			if (cpu_is_omap44xx()) {
-				__raw_writel(0xffffffff, bank->base +
-						OMAP4_GPIO_IRQSTATUSCLR0);
-				__raw_writew(0x0015, bank->base +
-						OMAP4_GPIO_SYSCONFIG);
-				__raw_writel(0x00000000, bank->base +
-						 OMAP4_GPIO_DEBOUNCENABLE);
-				/*
-				 * Initialize interface clock ungated,
-				 * module enabled
-				 */
-				__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
-			} else {
-				__raw_writel(0x00000000, bank->base +
-						OMAP24XX_GPIO_IRQENABLE1);
-				__raw_writel(0xffffffff, bank->base +
-						OMAP24XX_GPIO_IRQSTATUS1);
-				__raw_writew(0x0015, bank->base +
-						OMAP24XX_GPIO_SYSCONFIG);
-				__raw_writel(0x00000000, bank->base +
-						OMAP24XX_GPIO_DEBOUNCE_EN);
-
-				/*
-				 * Initialize interface clock ungated,
-				 * module enabled
-				 */
-				__raw_writel(0, bank->base +
-						OMAP24XX_GPIO_CTRL);
-			}
-			if (cpu_is_omap24xx() &&
-			    i < ARRAY_SIZE(non_wakeup_gpios))
-				bank->non_wakeup_gpios = non_wakeup_gpios[i];
-			gpio_count = 32;
-		}
-#endif
-
-		bank->mod_usage = 0;
-		/* REVISIT eventually switch from OMAP-specific gpio structs
-		 * over to the generic ones
-		 */
-		bank->chip.request = omap_gpio_request;
-		bank->chip.free = omap_gpio_free;
-		bank->chip.direction_input = gpio_input;
-		bank->chip.get = gpio_get;
-		bank->chip.direction_output = gpio_output;
-		bank->chip.set_debounce = gpio_debounce;
-		bank->chip.set = gpio_set;
-		bank->chip.to_irq = gpio_2irq;
-		if (bank_is_mpuio(bank)) {
-			bank->chip.label = "mpuio";
-#ifdef CONFIG_ARCH_OMAP16XX
-			bank->chip.dev = &omap_mpuio_device.dev;
-#endif
-			bank->chip.base = OMAP_MPUIO(0);
-		} else {
-			bank->chip.label = "gpio";
-			bank->chip.base = gpio;
-			gpio += gpio_count;
-		}
-		bank->chip.ngpio = gpio_count;
-
-		gpiochip_add(&bank->chip);
-
-		for (j = bank->virtual_irq_start;
-		     j < bank->virtual_irq_start + gpio_count; j++) {
-			lockdep_set_class(&irq_desc[j].lock, &gpio_lock_class);
-			set_irq_chip_data(j, bank);
-			if (bank_is_mpuio(bank))
-				set_irq_chip(j, &mpuio_irq_chip);
-			else
-				set_irq_chip(j, &gpio_irq_chip);
-			set_irq_handler(j, handle_simple_irq);
-			set_irq_flags(j, IRQF_VALID);
-		}
-		set_irq_chained_handler(bank->irq, gpio_irq_handler);
-		set_irq_data(bank->irq, bank);
+		omap_gpio_mod_init(bank, i);
+		omap_gpio_chip_init(bank);
 
 		if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 			sprintf(clk_name, "gpio%d_dbck", i + 1);
@@ -1952,17 +1962,6 @@ static int __init _omap_gpio_init(void)
 		}
 	}
 
-	/* Enable system clock for GPIO module.
-	 * The CAM_CLK_CTRL *is* really the right place. */
-	if (cpu_is_omap16xx())
-		omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04, ULPD_CAM_CLK_CTRL);
-
-	/* Enable autoidle for the OCP interface */
-	if (cpu_is_omap24xx())
-		omap_writel(1 << 0, 0x48019010);
-	if (cpu_is_omap34xx())
-		omap_writel(1 << 0, 0x48306814);
-
 	omap_gpio_show_rev();
 
 	return 0;
-- 
1.7.0.4

