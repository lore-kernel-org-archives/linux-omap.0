From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/14] omap2: Convert ARCH_OMAP24XX to ARCH_OMAP2
Date: Tue, 26 Jan 2010 12:12:55 -0800
Message-ID: <20100126201255.15382.49933.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60750 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab0AZUMh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 15:12:37 -0500
In-Reply-To: <20100126200646.15382.52167.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Convert ARCH_OMAP24XX to ARCH_OMAP2

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig                |   16 +++-----
 arch/arm/mach-omap2/Makefile               |    2 +
 arch/arm/mach-omap2/clockdomains.h         |    6 ++-
 arch/arm/mach-omap2/io.c                   |    2 +
 arch/arm/mach-omap2/mux.c                  |    2 +
 arch/arm/mach-omap2/powerdomains.h         |    2 +
 arch/arm/mach-omap2/powerdomains24xx.h     |    4 +-
 arch/arm/plat-omap/Kconfig                 |    4 +-
 arch/arm/plat-omap/devices.c               |    2 +
 arch/arm/plat-omap/gpio.c                  |   56 ++++++++++++++--------------
 arch/arm/plat-omap/i2c.c                   |    4 +-
 arch/arm/plat-omap/include/plat/cpu.h      |    8 ++--
 arch/arm/plat-omap/include/plat/mcbsp.h    |    2 +
 arch/arm/plat-omap/include/plat/menelaus.h |    2 +
 arch/arm/plat-omap/include/plat/mux.h      |    2 +
 arch/arm/plat-omap/include/plat/omap24xx.h |    6 ++-
 arch/arm/plat-omap/sram.c                  |    2 +
 drivers/char/hw_random/Kconfig             |    2 +
 drivers/mfd/Kconfig                        |    2 +
 drivers/net/smc911x.h                      |    2 +
 drivers/spi/Kconfig                        |    2 +
 drivers/watchdog/Kconfig                   |    2 +
 sound/soc/omap/omap-mcbsp.c                |    2 +
 23 files changed, 65 insertions(+), 69 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 606bf04..69a6b2b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -1,19 +1,15 @@
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
-config ARCH_OMAP24XX
-	bool "OMAP24xx Based System"
-	depends on ARCH_OMAP2
-
 config ARCH_OMAP2420
 	bool "OMAP2420 support"
-	depends on ARCH_OMAP24XX
+	depends on ARCH_OMAP2
 	select OMAP_DM_TIMER
 	select ARCH_OMAP_OTG
 
 config ARCH_OMAP2430
 	bool "OMAP2430 support"
-	depends on ARCH_OMAP24XX
+	depends on ARCH_OMAP2
 
 config ARCH_OMAP34XX
 	bool "OMAP34xx Based System"
@@ -42,7 +38,7 @@ comment "OMAP Board Type"
 
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
-	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+	depends on ARCH_OMAP2
 
 config MACH_OMAP2_TUSB6010
 	bool
@@ -51,16 +47,16 @@ config MACH_OMAP2_TUSB6010
 
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
-	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+	depends on ARCH_OMAP2
 	select OMAP_DEBUG_DEVICES
 
 config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
-	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+	depends on ARCH_OMAP2
 
 config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
-	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+	depends on ARCH_OMAP2
 
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c48b3f4..2cd3cd6 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -40,7 +40,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 # Power Management
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
-obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index c4ee076..c9dac60 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -94,7 +94,7 @@ static struct clockdomain mdm_clkdm = {
  * 24XX-only clockdomains
  */
 
-#if defined(CONFIG_ARCH_OMAP24XX)
+#if defined(CONFIG_ARCH_OMAP2)
 
 static struct clockdomain dsp_clkdm = {
 	.name		= "dsp_clkdm",
@@ -136,7 +136,7 @@ static struct clockdomain dss_24xx_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
 };
 
-#endif   /* CONFIG_ARCH_OMAP24XX */
+#endif   /* CONFIG_ARCH_OMAP2 */
 
 
 /*
@@ -330,7 +330,7 @@ static struct clockdomain *clockdomains_omap[] = {
 	&mdm_clkdm,
 #endif
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#ifdef CONFIG_ARCH_OMAP2
 	&dsp_clkdm,
 	&gfx_24xx_clkdm,
 	&core_l3_24xx_clkdm,
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index fcae090..2bfde71 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -53,7 +53,7 @@
  * default mapping provided here.
  */
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#ifdef CONFIG_ARCH_OMAP2
 static struct map_desc omap24xx_io_desc[] __initdata = {
 	{
 		.virtual	= L3_24XX_VIRT,
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 3f59bd1..30e077f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -75,7 +75,7 @@ void omap_mux_write_array(struct omap_board_mux *board_mux)
 	}
 }
 
-#if defined(CONFIG_ARCH_OMAP24XX) && defined(CONFIG_OMAP_MUX)
+#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_OMAP_MUX)
 
 static struct omap_mux_cfg arch_mux_cfg;
 
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
index 057b2e3..7b4a436 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -157,7 +157,7 @@ static struct powerdomain *powerdomains_omap[] __initdata = {
 	&gfx_pwrdm,
 	&wkup_pwrdm,
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#ifdef CONFIG_ARCH_OMAP2
 	&dsp_pwrdm,
 	&mpu_24xx_pwrdm,
 	&core_24xx_pwrdm,
diff --git a/arch/arm/mach-omap2/powerdomains24xx.h b/arch/arm/mach-omap2/powerdomains24xx.h
index bd249a4..13ee5ba 100644
--- a/arch/arm/mach-omap2/powerdomains24xx.h
+++ b/arch/arm/mach-omap2/powerdomains24xx.h
@@ -30,7 +30,7 @@
 
 /* 24XX powerdomains and dependencies */
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#ifdef CONFIG_ARCH_OMAP2
 
 
 /* Wakeup dependency source arrays */
@@ -164,7 +164,7 @@ static struct powerdomain core_24xx_pwrdm = {
 	},
 };
 
-#endif	   /* CONFIG_ARCH_OMAP24XX */
+#endif	   /* CONFIG_ARCH_OMAP2 */
 
 
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index f195457..df497fc 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -124,7 +124,7 @@ config OMAP_MPU_TIMER
 
 config OMAP_32K_TIMER
 	bool "Use 32KHz timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX || ARCH_OMAP4
+	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP34XX || ARCH_OMAP4
 	help
 	  Select this option if you want to enable the OMAP 32KHz timer.
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
@@ -145,7 +145,7 @@ config OMAP_32K_TIMER_HZ
 
 config OMAP_DM_TIMER
 	bool "Use dual-mode timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX || ARCH_OMAP4
+	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP34XX || ARCH_OMAP4
 	help
 	 Select this option if you want to use OMAP Dual-Mode timers.
 
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 30b5db7..59f92c8 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -244,7 +244,7 @@ fail:
 
 #if defined(CONFIG_HW_RANDOM_OMAP) || defined(CONFIG_HW_RANDOM_OMAP_MODULE)
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#ifdef CONFIG_ARCH_OMAP2
 #define	OMAP_RNG_BASE		0x480A0000
 #else
 #define	OMAP_RNG_BASE		0xfffe5000
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 14b1907..f67d120 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -177,12 +177,12 @@ struct gpio_bank {
 	u16 irq;
 	u16 virtual_irq_start;
 	int method;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) ||  \
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2) ||  \
 		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
 			defined(CONFIG_ARCH_OMAP4)
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
@@ -248,7 +248,7 @@ static struct gpio_bank gpio_bank_7xx[7] = {
 };
 #endif
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#ifdef CONFIG_ARCH_OMAP2
 
 static struct gpio_bank gpio_bank_242x[4] = {
 	{ OMAP242X_GPIO1_BASE, NULL, INT_24XX_GPIO_BANK1, IH_GPIO_BASE,
@@ -426,7 +426,7 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 		reg += OMAP7XX_GPIO_DIR_CONTROL;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_OE;
 		break;
@@ -493,7 +493,7 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 			l &= ~(1 << gpio);
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg += OMAP24XX_GPIO_SETDATAOUT;
@@ -546,7 +546,7 @@ static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 		reg += OMAP7XX_GPIO_DATA_INPUT;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_DATAIN;
 		break;
@@ -592,7 +592,7 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 		reg += OMAP7XX_GPIO_DATA_OUTPUT;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
 		defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_DATAOUT;
@@ -684,7 +684,7 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
 }
 EXPORT_SYMBOL(omap_set_gpio_debounce_time);
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
 				defined(CONFIG_ARCH_OMAP4)
 static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 						int trigger)
@@ -856,7 +856,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 			goto bad;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
 				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		set_24xx_gpio_triggering(bank, gpio, trigger);
@@ -937,7 +937,7 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 		reg += OMAP7XX_GPIO_INT_STATUS;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQSTATUS1;
 		break;
@@ -954,7 +954,7 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	__raw_writel(gpio_mask, reg);
 
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 	reg = bank->base + OMAP24XX_GPIO_IRQSTATUS2;
 #endif
 #if defined(CONFIG_ARCH_OMAP4)
@@ -1008,7 +1008,7 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 		inv = 1;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQENABLE1;
 		mask = 0xffffffff;
@@ -1077,7 +1077,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
 			l |= gpio_mask;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg += OMAP24XX_GPIO_SETIRQENABLE1;
@@ -1131,7 +1131,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
 				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
@@ -1227,7 +1227,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(1 << offset, reg);
 	}
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
 				defined(CONFIG_ARCH_OMAP4)
 	if (bank->method == METHOD_GPIO_24XX) {
 		/* Disable wake-up during idle for dynamic tick */
@@ -1286,7 +1286,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	if (bank->method == METHOD_GPIO_7XX)
 		isr_reg = bank->base + OMAP7XX_GPIO_INT_STATUS;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 	if (bank->method == METHOD_GPIO_24XX)
 		isr_reg = bank->base + OMAP24XX_GPIO_IRQSTATUS1;
 #endif
@@ -1756,7 +1756,7 @@ static int __init _omap_gpio_init(void)
 		bank_size = SZ_2K;
 	}
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#ifdef CONFIG_ARCH_OMAP2
 	if (cpu_is_omap242x()) {
 		gpio_bank_count = 4;
 		gpio_bank = gpio_bank_242x;
@@ -1809,7 +1809,7 @@ static int __init _omap_gpio_init(void)
 			gpio_count = 32; /* 7xx has 32-bit GPIOs */
 		}
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
 				defined(CONFIG_ARCH_OMAP4)
 		if (bank->method == METHOD_GPIO_24XX) {
 			static const u32 non_wakeup_gpios[] = {
@@ -1903,7 +1903,7 @@ static int __init _omap_gpio_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || \
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2) || \
 		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 {
@@ -1927,7 +1927,7 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 		case METHOD_GPIO_24XX:
 			wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
@@ -1975,7 +1975,7 @@ static int omap_gpio_resume(struct sys_device *dev)
 			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 		case METHOD_GPIO_24XX:
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
@@ -2013,7 +2013,7 @@ static struct sys_device omap_gpio_device = {
 
 #endif
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
 				defined(CONFIG_ARCH_OMAP4)
 
 static int workaround_enabled;
@@ -2030,7 +2030,7 @@ void omap2_gpio_prepare_for_retention(void)
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 		bank->saved_datain = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
 		l1 = __raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		l2 = __raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
@@ -2045,7 +2045,7 @@ void omap2_gpio_prepare_for_retention(void)
 		bank->saved_risingdetect = l2;
 		l1 &= ~bank->enabled_non_wakeup_gpios;
 		l2 &= ~bank->enabled_non_wakeup_gpios;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
 #endif
@@ -2074,7 +2074,7 @@ void omap2_gpio_resume_after_retention(void)
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 		__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(bank->saved_risingdetect,
@@ -2113,7 +2113,7 @@ void omap2_gpio_resume_after_retention(void)
 
 		if (gen) {
 			u32 old0, old1;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 			old0 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			old1 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 			__raw_writel(old0 | gen, bank->base +
@@ -2240,7 +2240,7 @@ static int __init omap_gpio_sysinit(void)
 
 	mpuio_init();
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || \
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2) || \
 		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		if (ret == 0) {
@@ -2300,7 +2300,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 /* FIXME for at least omap2, show pullup/pulldown state */
 
 			irqstat = irq_desc[irq].status;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) ||	\
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2) ||	\
 		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 			if (is_in && ((bank->suspend_wakeup & mask)
 					|| irqstat & IRQ_TYPE_SENSE_MASK)) {
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 33fff4e..7773bce 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -50,7 +50,7 @@ static const char name[] = "i2c_omap";
 
 static struct resource i2c_resources[][2] = {
 	{ I2C_RESOURCE_BUILDER(0, 0) },
-#if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_24XX_I2C2_IRQ) },
 #endif
 #if	defined(CONFIG_ARCH_OMAP34XX)
@@ -72,7 +72,7 @@ static struct resource i2c_resources[][2] = {
 static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
 static struct platform_device omap_i2c_devices[] = {
 	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
-#if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
 #endif
 #if	defined(CONFIG_ARCH_OMAP34XX)
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index a162f58..ae5679e 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -114,7 +114,7 @@ unsigned int omap_rev(void);
 #  define OMAP_NAME omap16xx
 # endif
 #endif
-#if (defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX))
+#if (defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX))
 # if (defined(OMAP_NAME) || defined(MULTI_OMAP1))
 #  error "OMAP1 and OMAP2 can't be selected at the same time"
 # endif
@@ -232,7 +232,7 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 #endif
 
 #if defined(MULTI_OMAP2)
-# if defined(CONFIG_ARCH_OMAP24XX)
+# if defined(CONFIG_ARCH_OMAP2)
 #  undef  cpu_is_omap24xx
 #  undef  cpu_is_omap242x
 #  undef  cpu_is_omap243x
@@ -247,7 +247,7 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 #  define cpu_is_omap343x()		is_omap343x()
 # endif
 #else
-# if defined(CONFIG_ARCH_OMAP24XX)
+# if defined(CONFIG_ARCH_OMAP2)
 #  undef  cpu_is_omap24xx
 #  define cpu_is_omap24xx()		1
 # endif
@@ -371,7 +371,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_omap1710()		is_omap1710()
 #endif
 
-#if defined(CONFIG_ARCH_OMAP24XX)
+#if defined(CONFIG_ARCH_OMAP2)
 # undef  cpu_is_omap2420
 # undef  cpu_is_omap2422
 # undef  cpu_is_omap2423
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 4f22e5b..9515062 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -103,7 +103,7 @@
 #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
 
-#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
 	defined(CONFIG_ARCH_OMAP4)
 
 #define OMAP_MCBSP_REG_DRR2	0x00
diff --git a/arch/arm/plat-omap/include/plat/menelaus.h b/arch/arm/plat-omap/include/plat/menelaus.h
index 3122bf6..4a970ec 100644
--- a/arch/arm/plat-omap/include/plat/menelaus.h
+++ b/arch/arm/plat-omap/include/plat/menelaus.h
@@ -40,7 +40,7 @@ extern int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int floor_mV);
 
 extern int menelaus_set_regulator_sleep(int enable, u32 val);
 
-#if defined(CONFIG_ARCH_OMAP24XX) && defined(CONFIG_MENELAUS)
+#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_MENELAUS)
 #define omap_has_menelaus()	1
 #else
 #define omap_has_menelaus()	0
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index 692c90e..c7472a2 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -135,7 +135,7 @@ struct pin_config {
 	const unsigned int 	mux_reg;
 	unsigned char		debug;
 
-#if	defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP24XX)
+#if	defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2)
 	const unsigned char mask_offset;
 	const unsigned char mask;
 
diff --git a/arch/arm/plat-omap/include/plat/omap24xx.h b/arch/arm/plat-omap/include/plat/omap24xx.h
index 696edfc..7055672 100644
--- a/arch/arm/plat-omap/include/plat/omap24xx.h
+++ b/arch/arm/plat-omap/include/plat/omap24xx.h
@@ -23,8 +23,8 @@
  *
  */
 
-#ifndef __ASM_ARCH_OMAP24XX_H
-#define __ASM_ARCH_OMAP24XX_H
+#ifndef __ASM_ARCH_OMAP2_H
+#define __ASM_ARCH_OMAP2_H
 
 /*
  * Please place only base defines here and put the rest in device
@@ -85,5 +85,5 @@
 #define OMAP24XX_SEC_AES_BASE	(OMAP24XX_SEC_BASE + 0x6000)
 #define OMAP24XX_SEC_PKA_BASE	(OMAP24XX_SEC_BASE + 0x8000)
 
-#endif /* __ASM_ARCH_OMAP24XX_H */
+#endif /* __ASM_ARCH_OMAP2_H */
 
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index d8d5094..e0cbb93 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -53,7 +53,7 @@
 #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
 #define OMAP4_SRAM_PUB_VA	(OMAP4_SRAM_VA + 0x4000)
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 #define SRAM_BOOTLOADER_SZ	0x00
 #else
 #define SRAM_BOOTLOADER_SZ	0x80
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 8706026..c0df30f 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -114,7 +114,7 @@ config HW_RANDOM_IXP4XX
 
 config HW_RANDOM_OMAP
 	tristate "OMAP Random Number Generator support"
-	depends on HW_RANDOM && (ARCH_OMAP16XX || ARCH_OMAP24XX)
+	depends on HW_RANDOM && (ARCH_OMAP16XX || ARCH_OMAP2)
 	default HW_RANDOM
  	---help---
  	  This driver provides kernel-side support for the Random Number
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8782978..1380e1c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -94,7 +94,7 @@ config TPS65010
 
 config MENELAUS
 	bool "Texas Instruments TWL92330/Menelaus PM chip"
-	depends on I2C=y && ARCH_OMAP24XX
+	depends on I2C=y && ARCH_OMAP2
 	help
 	  If you say yes here you get support for the Texas Instruments
 	  TWL92330/Menelaus Power Management chip. This include voltage
diff --git a/drivers/net/smc911x.h b/drivers/net/smc911x.h
index 05adb6a..1477ff8 100644
--- a/drivers/net/smc911x.h
+++ b/drivers/net/smc911x.h
@@ -47,7 +47,7 @@
   #define SMC_USE_32BIT		1
   #define SMC_IRQ_SENSE		IRQF_TRIGGER_LOW
   #define SMC_MEM_RESERVED	1
-#elif defined(CONFIG_ARCH_OMAP24XX)
+#elif defined(CONFIG_ARCH_OMAP2)
   #define SMC_USE_16BIT		0
   #define SMC_USE_32BIT		1
   #define SMC_IRQ_SENSE		IRQF_TRIGGER_LOW
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f55eb01..23bd252 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -164,7 +164,7 @@ config SPI_OMAP_UWIRE
 
 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP24xx/OMAP34xx"
-	depends on ARCH_OMAP24XX || ARCH_OMAP34XX
+	depends on ARCH_OMAP2 || ARCH_OMAP34XX
 	help
 	  SPI master controller for OMAP24xx/OMAP34xx Multichannel SPI
 	  (McSPI) modules.
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 088f32f..a1e12ff 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -194,7 +194,7 @@ config EP93XX_WATCHDOG
 
 config OMAP_WATCHDOG
 	tristate "OMAP Watchdog"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX
+	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP34XX
 	help
 	  Support for TI OMAP1610/OMAP1710/OMAP2420/OMAP3430 watchdog.  Say 'Y'
 	  here to enable the OMAP1610/OMAP1710/OMAP2420/OMAP3430 watchdog timer.
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 6bbbd2a..26e728d 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -82,7 +82,7 @@ static const int omap1_dma_reqs[][2] = {};
 static const unsigned long omap1_mcbsp_port[][2] = {};
 #endif
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
 static const int omap24xx_dma_reqs[][2] = {
 	{ OMAP24XX_DMA_MCBSP1_TX, OMAP24XX_DMA_MCBSP1_RX },
 	{ OMAP24XX_DMA_MCBSP2_TX, OMAP24XX_DMA_MCBSP2_RX },

