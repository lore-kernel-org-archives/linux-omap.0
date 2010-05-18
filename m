From: Charulatha V <charu@ti.com>
Subject: [PATCH 01/11] OMAP: GPIO: Modify init() in preparation for platform device implementation
Date: Tue, 18 May 2010 20:20:50 +0530
Message-ID: <1274194260-16401-2-git-send-email-charu@ti.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35805 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757243Ab0EROtz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 May 2010 10:49:55 -0400
In-Reply-To: <1274194260-16401-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

This is in prepartion for implementing GPIO as a platform device.
gpio bank's base addresses are moved from gpio.c to plat/gpio.h.

This patch also modifies omap_gpio_init() to make use of
omap_gpio_chip_init() and omap_gpio_mod_init(). omap_gpio_mod_init() does
the module init by clearing the status register and initializing the
GPIO control register. omap_gpio_chip_init() initializes the chip request,
free, get, set and other function pointers and sets the gpio irq handler.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c              |  277 ++++++++++++++------------------
 arch/arm/plat-omap/include/plat/gpio.h |   68 ++++++++-
 2 files changed, 185 insertions(+), 160 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 45a225d..70deebc 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -31,7 +31,6 @@
 /*
  * OMAP1510 GPIO registers
  */
-#define OMAP1510_GPIO_BASE		0xfffce000
 #define OMAP1510_GPIO_DATA_INPUT	0x00
 #define OMAP1510_GPIO_DATA_OUTPUT	0x04
 #define OMAP1510_GPIO_DIR_CONTROL	0x08
@@ -40,15 +39,9 @@
 #define OMAP1510_GPIO_INT_STATUS	0x14
 #define OMAP1510_GPIO_PIN_CONTROL	0x18
 
-#define OMAP1510_IH_GPIO_BASE		64
-
 /*
  * OMAP1610 specific GPIO registers
  */
-#define OMAP1610_GPIO1_BASE		0xfffbe400
-#define OMAP1610_GPIO2_BASE		0xfffbec00
-#define OMAP1610_GPIO3_BASE		0xfffbb400
-#define OMAP1610_GPIO4_BASE		0xfffbbc00
 #define OMAP1610_GPIO_REVISION		0x0000
 #define OMAP1610_GPIO_SYSCONFIG		0x0010
 #define OMAP1610_GPIO_SYSSTATUS		0x0014
@@ -70,12 +63,6 @@
 /*
  * OMAP7XX specific GPIO registers
  */
-#define OMAP7XX_GPIO1_BASE		0xfffbc000
-#define OMAP7XX_GPIO2_BASE		0xfffbc800
-#define OMAP7XX_GPIO3_BASE		0xfffbd000
-#define OMAP7XX_GPIO4_BASE		0xfffbd800
-#define OMAP7XX_GPIO5_BASE		0xfffbe000
-#define OMAP7XX_GPIO6_BASE		0xfffbe800
 #define OMAP7XX_GPIO_DATA_INPUT		0x00
 #define OMAP7XX_GPIO_DATA_OUTPUT	0x04
 #define OMAP7XX_GPIO_DIR_CONTROL	0x08
@@ -83,22 +70,9 @@
 #define OMAP7XX_GPIO_INT_MASK		0x10
 #define OMAP7XX_GPIO_INT_STATUS		0x14
 
-#define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
-
 /*
  * omap24xx specific GPIO registers
  */
-#define OMAP242X_GPIO1_BASE		0x48018000
-#define OMAP242X_GPIO2_BASE		0x4801a000
-#define OMAP242X_GPIO3_BASE		0x4801c000
-#define OMAP242X_GPIO4_BASE		0x4801e000
-
-#define OMAP243X_GPIO1_BASE		0x4900C000
-#define OMAP243X_GPIO2_BASE		0x4900E000
-#define OMAP243X_GPIO3_BASE		0x49010000
-#define OMAP243X_GPIO4_BASE		0x49012000
-#define OMAP243X_GPIO5_BASE		0x480B6000
-
 #define OMAP24XX_GPIO_REVISION		0x0000
 #define OMAP24XX_GPIO_SYSCONFIG		0x0010
 #define OMAP24XX_GPIO_SYSSTATUS		0x0014
@@ -150,26 +124,6 @@
 #define OMAP4_GPIO_DEBOUNCINGTIME	0x0154
 #define OMAP4_GPIO_CLEARDATAOUT		0x0190
 #define OMAP4_GPIO_SETDATAOUT		0x0194
-/*
- * omap34xx specific GPIO registers
- */
-
-#define OMAP34XX_GPIO1_BASE		0x48310000
-#define OMAP34XX_GPIO2_BASE		0x49050000
-#define OMAP34XX_GPIO3_BASE		0x49052000
-#define OMAP34XX_GPIO4_BASE		0x49054000
-#define OMAP34XX_GPIO5_BASE		0x49056000
-#define OMAP34XX_GPIO6_BASE		0x49058000
-
-/*
- * OMAP44XX  specific GPIO registers
- */
-#define OMAP44XX_GPIO1_BASE             0x4a310000
-#define OMAP44XX_GPIO2_BASE             0x48055000
-#define OMAP44XX_GPIO3_BASE             0x48057000
-#define OMAP44XX_GPIO4_BASE             0x48059000
-#define OMAP44XX_GPIO5_BASE             0x4805B000
-#define OMAP44XX_GPIO6_BASE             0x4805D000
 
 struct gpio_bank {
 	unsigned long pbase;
@@ -181,14 +135,12 @@ struct gpio_bank {
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
@@ -1669,6 +1621,122 @@ static void __init omap_gpio_show_rev(void)
  */
 static struct lock_class_key gpio_lock_class;
 
+static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
+{
+	if (cpu_class_is_omap2()) {
+		static const u32 non_wakeup_gpios[] = {
+			0xe203ffc0, 0x08700040
+		};
+		if (id < ARRAY_SIZE(non_wakeup_gpios))
+			bank->non_wakeup_gpios = non_wakeup_gpios[id];
+
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
+			/* Enable autoidle for the OCP interface */
+			omap_writel(1 << 0, 0x48306814);
+		} else if (cpu_is_omap24xx())
+			/* Enable autoidle for the OCP interface */
+			omap_writel(1 << 0, 0x48019010);
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
+	int j, gpio_bank_bits = 16;
+	static int gpio;
+
+	if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX)
+		gpio_bank_bits = 32; /* 7xx has 32-bit GPIOs */
+
+	if ((bank->method == METHOD_GPIO_24XX) ||
+			(bank->method == METHOD_GPIO_44XX))
+		gpio_bank_bits = 32;
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
+		gpio += gpio_bank_bits;
+	}
+	bank->chip.ngpio = gpio_bank_bits;
+
+	gpiochip_add(&bank->chip);
+
+	for (j = bank->virtual_irq_start;
+		     j < bank->virtual_irq_start + gpio_bank_bits; j++) {
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
@@ -1779,7 +1847,6 @@ static int __init _omap_gpio_init(void)
 	}
 #endif
 	for (i = 0; i < gpio_bank_count; i++) {
-		int j, gpio_count = 16;
 
 		bank = &gpio_bank[i];
 		spin_lock_init(&bank->lock);
@@ -1791,105 +1858,8 @@ static int __init _omap_gpio_init(void)
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
-			if (i < ARRAY_SIZE(non_wakeup_gpios))
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
@@ -1899,17 +1869,6 @@ static int __init _omap_gpio_init(void)
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
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index de7c547..a06acb6 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -29,7 +29,8 @@
 #include <linux/io.h>
 #include <mach/irqs.h>
 
-#define OMAP1_MPUIO_BASE			0xfffb5000
+#define OMAP1_MPUIO_BASE		0xfffb5000
+#define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
 
 #if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
 
@@ -62,8 +63,73 @@
 #define OMAP_MPUIO_LATCH		0x34
 #endif
 
+/*
+ * OMAP1510 GPIO base addresses
+ */
+#define OMAP1510_GPIO_BASE		0xfffce000
+#define OMAP1510_IH_GPIO_BASE		64
+
+/*
+ * OMAP1610 GPIO base addresses
+ */
+#define OMAP1610_GPIO1_BASE		0xfffbe400
+#define OMAP1610_GPIO2_BASE		0xfffbec00
+#define OMAP1610_GPIO3_BASE		0xfffbb400
+#define OMAP1610_GPIO4_BASE		0xfffbbc00
+
+/*
+ * OMAP7XX GPIO base addresses
+ */
+#define OMAP7XX_GPIO1_BASE		0xfffbc000
+#define OMAP7XX_GPIO2_BASE		0xfffbc800
+#define OMAP7XX_GPIO3_BASE		0xfffbd000
+#define OMAP7XX_GPIO4_BASE		0xfffbd800
+#define OMAP7XX_GPIO5_BASE		0xfffbe000
+#define OMAP7XX_GPIO6_BASE		0xfffbe800
+
+/*
+ * omap24xx GPIO base addresses
+ */
+#define OMAP242X_GPIO1_BASE		0x48018000
+#define OMAP242X_GPIO2_BASE		0x4801a000
+#define OMAP242X_GPIO3_BASE		0x4801c000
+#define OMAP242X_GPIO4_BASE		0x4801e000
+
+#define OMAP243X_GPIO1_BASE		0x4900C000
+#define OMAP243X_GPIO2_BASE		0x4900E000
+#define OMAP243X_GPIO3_BASE		0x49010000
+#define OMAP243X_GPIO4_BASE		0x49012000
+#define OMAP243X_GPIO5_BASE		0x480B6000
+
+/*
+ * omap34xx GPIO base addresses
+ */
+#define OMAP34XX_GPIO1_BASE		0x48310000
+#define OMAP34XX_GPIO2_BASE		0x49050000
+#define OMAP34XX_GPIO3_BASE		0x49052000
+#define OMAP34XX_GPIO4_BASE		0x49054000
+#define OMAP34XX_GPIO5_BASE		0x49056000
+#define OMAP34XX_GPIO6_BASE		0x49058000
+
 #define OMAP34XX_NR_GPIOS		6
 
+/*
+ * OMAP44XX GPIO base addresses
+ */
+#define OMAP44XX_GPIO1_BASE             0x4a310000
+#define OMAP44XX_GPIO2_BASE             0x48055000
+#define OMAP44XX_GPIO3_BASE             0x48057000
+#define OMAP44XX_GPIO4_BASE             0x48059000
+#define OMAP44XX_GPIO5_BASE             0x4805B000
+#define OMAP44XX_GPIO6_BASE             0x4805D000
+
+#define METHOD_MPUIO		0
+#define METHOD_GPIO_1510	1
+#define METHOD_GPIO_1610	2
+#define METHOD_GPIO_7XX		3
+#define METHOD_GPIO_24XX	5
+#define METHOD_GPIO_44XX	6
+
 #define OMAP_MPUIO(nr)		(OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr)	((nr) >= OMAP_MAX_GPIO_LINES)
 
-- 
1.6.3.3

