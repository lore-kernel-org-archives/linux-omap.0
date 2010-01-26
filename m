From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/14] omap3: Replace ARCH_OMAP34XX with ARCH_OMAP3
Date: Tue, 26 Jan 2010 12:12:58 -0800
Message-ID: <20100126201258.15382.13494.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58243 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab0AZUMj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 15:12:39 -0500
In-Reply-To: <20100126200646.15382.52167.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Replace ARCH_OMAP34XX with ARCH_OMAP3

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig                |   37 ++++++++----------
 arch/arm/mach-omap2/clockdomains.h         |    6 +--
 arch/arm/mach-omap2/io.c                   |    4 +-
 arch/arm/mach-omap2/mcbsp.c                |    2 -
 arch/arm/mach-omap2/mux.c                  |    4 +-
 arch/arm/mach-omap2/mux.h                  |    2 -
 arch/arm/mach-omap2/omap_hwmod_34xx.h      |    2 -
 arch/arm/mach-omap2/powerdomains.h         |    2 -
 arch/arm/mach-omap2/powerdomains34xx.h     |    4 +-
 arch/arm/plat-omap/Kconfig                 |    5 +-
 arch/arm/plat-omap/common.c                |    2 -
 arch/arm/plat-omap/gpio.c                  |   58 ++++++++++++++--------------
 arch/arm/plat-omap/i2c.c                   |    8 ++--
 arch/arm/plat-omap/include/plat/cpu.h      |    8 ++--
 arch/arm/plat-omap/include/plat/io.h       |    2 -
 arch/arm/plat-omap/include/plat/mcbsp.h    |    8 ++--
 arch/arm/plat-omap/include/plat/omap34xx.h |    6 +--
 arch/arm/plat-omap/mcbsp.c                 |    6 +--
 arch/arm/plat-omap/sram.c                  |    2 -
 drivers/net/smc911x.h                      |    2 -
 drivers/spi/Kconfig                        |    2 -
 drivers/spi/omap2_mcspi.c                  |    2 -
 drivers/usb/Kconfig                        |    2 -
 drivers/usb/host/ehci-hcd.c                |    2 -
 drivers/usb/musb/Kconfig                   |    6 +--
 drivers/usb/musb/musb_core.c               |    2 -
 drivers/usb/musb/musb_core.h               |    2 -
 drivers/w1/masters/Kconfig                 |    2 -
 drivers/watchdog/Kconfig                   |    2 -
 sound/soc/omap/omap-mcbsp.c                |    6 +--
 sound/soc/omap/omap-mcbsp.h                |    2 -
 31 files changed, 98 insertions(+), 102 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 69a6b2b..317b8cb 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -11,14 +11,9 @@ config ARCH_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP2
 
-config ARCH_OMAP34XX
-	bool "OMAP34xx Based System"
-	depends on ARCH_OMAP3
-	select USB_ARCH_HAS_EHCI
-
 config ARCH_OMAP3430
 	bool "OMAP3430 support"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select ARCH_OMAP_OTG
 
 config OMAP_PACKAGE_CBC
@@ -60,42 +55,42 @@ config MACH_OMAP_2430SDP
 
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP_LDP
 	bool "OMAP3 LDP board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OVERO
 	bool "Gumstix Overo board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3517EVM
 	bool "OMAP3517/ AM3517 EVM board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3_TOUCHBOOK
 	bool "OMAP3 Touch Book"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select BACKLIGHT_CLASS_DEVICE
 
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_NOKIA_N800
@@ -116,33 +111,33 @@ config MACH_NOKIA_N8X0
 
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP_ZOOM2
 	bool "OMAP3 Zoom2 board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP_ZOOM3
 	bool "OMAP3630 Zoom3 board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBP
 
 config MACH_CM_T35
 	bool "CompuLab CM-T35 module"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CUS
 	select OMAP_MUX
 
 config MACH_IGEP0020
 	bool "IGEP0020"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP_3630SDP
 	bool "OMAP3630 SDP board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	select OMAP_PACKAGE_CBP
 
 config MACH_OMAP_4430SDP
@@ -158,7 +153,7 @@ config OMAP3_EMU
 
 config OMAP3_SDRC_AC_TIMING
 	bool "Enable SDRC AC timing register changes"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3
 	default n
 	help
 	  If you know that none of your system initiators will attempt to
diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index c9dac60..b37b084 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -143,7 +143,7 @@ static struct clockdomain dss_24xx_clkdm = {
  * 34xx clockdomains
  */
 
-#if defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP3)
 
 static struct clockdomain mpu_34xx_clkdm = {
 	.name		= "mpu_clkdm",
@@ -290,7 +290,7 @@ static struct clockdomain dpll5_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
 
-#endif   /* CONFIG_ARCH_OMAP34XX */
+#endif   /* CONFIG_ARCH_OMAP3 */
 
 /*
  * Clockdomain-powerdomain hwsup dependencies (34XX only)
@@ -338,7 +338,7 @@ static struct clockdomain *clockdomains_omap[] = {
 	&dss_24xx_clkdm,
 #endif
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 	&mpu_34xx_clkdm,
 	&neon_clkdm,
 	&iva2_clkdm,
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2bfde71..ee13ca9 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -123,7 +123,7 @@ static struct map_desc omap243x_io_desc[] __initdata = {
 #endif
 #endif
 
-#ifdef	CONFIG_ARCH_OMAP34XX
+#ifdef	CONFIG_ARCH_OMAP3
 static struct map_desc omap34xx_io_desc[] __initdata = {
 	{
 		.virtual	= L3_34XX_VIRT,
@@ -267,7 +267,7 @@ void __init omap243x_map_common_io()
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 void __init omap34xx_map_common_io()
 {
 	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index baa4517..4b6e515 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -119,7 +119,7 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 #define OMAP2430_MCBSP_PDATA_SZ		0
 #endif
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 	{
 		.phys_base	= OMAP34XX_MCBSP1_BASE,
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 30e077f..d64b401 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -369,7 +369,7 @@ int __init omap2_mux_init(void)
 
 /*----------------------------------------------------------------------------*/
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 static LIST_HEAD(muxmodes);
 static DEFINE_MUTEX(muxmode_mutex);
 
@@ -1010,5 +1010,5 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 	return 0;
 }
 
-#endif	/* CONFIG_ARCH_OMAP34XX */
+#endif	/* CONFIG_ARCH_OMAP3 */
 
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index f8c2e7a..480abc5 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -102,7 +102,7 @@ struct omap_board_mux {
 	u16	value;
 };
 
-#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_ARCH_OMAP3)
 
 /**
  * omap_mux_init_gpio - initialize a signal based on the GPIO number
diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-omap2/omap_hwmod_34xx.h
index b6076b9..2e629dc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
+++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
@@ -12,7 +12,7 @@
 #ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD34XX_H
 #define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD34XX_H
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 
 #include <plat/omap_hwmod.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
index 7b4a436..d5d753c 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -167,7 +167,7 @@ static struct powerdomain *powerdomains_omap[] __initdata = {
 	&mdm_pwrdm,
 #endif
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 	&iva2_pwrdm,
 	&mpu_34xx_pwrdm,
 	&neon_pwrdm,
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 588f7e0..2d0cae0 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -32,7 +32,7 @@
  * 34XX-specific powerdomains, dependencies
  */
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 
 /*
  * 3430: PM_WKDEP_{PER,USBHOST}: CORE, IVA2, MPU, WKUP
@@ -386,7 +386,7 @@ static struct powerdomain dpll5_pwrdm = {
 };
 
 
-#endif    /* CONFIG_ARCH_OMAP34XX */
+#endif    /* CONFIG_ARCH_OMAP3 */
 
 
 #endif
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index df497fc..1e22392 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -30,6 +30,7 @@ config ARCH_OMAP3
 	bool "TI OMAP3"
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
+	select USB_ARCH_HAS_EHCI
 
 config ARCH_OMAP4
 	bool "TI OMAP4"
@@ -124,7 +125,7 @@ config OMAP_MPU_TIMER
 
 config OMAP_32K_TIMER
 	bool "Use 32KHz timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP34XX || ARCH_OMAP4
+	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
 	help
 	  Select this option if you want to enable the OMAP 32KHz timer.
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
@@ -145,7 +146,7 @@ config OMAP_32K_TIMER_HZ
 
 config OMAP_DM_TIMER
 	bool "Use dual-mode timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP34XX || ARCH_OMAP4
+	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
 	help
 	 Select this option if you want to use OMAP Dual-Mode timers.
 
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 7cbc0a2..4f29e8c 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -127,7 +127,7 @@ static cycle_t omap2430_32k_read(struct clocksource *cs)
 #define omap2430_32k_read	NULL
 #endif
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 static cycle_t omap34xx_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10);
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index f67d120..c8b581f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -178,11 +178,11 @@ struct gpio_bank {
 	u16 virtual_irq_start;
 	int method;
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2) ||  \
-		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
+		defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 			defined(CONFIG_ARCH_OMAP4)
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
@@ -276,7 +276,7 @@ static struct gpio_bank gpio_bank_243x[5] = {
 
 #endif
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 static struct gpio_bank gpio_bank_34xx[6] = {
 	{ OMAP34XX_GPIO1_BASE, NULL, INT_34XX_GPIO_BANK1, IH_GPIO_BASE,
 		METHOD_GPIO_24XX },
@@ -426,7 +426,7 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 		reg += OMAP7XX_GPIO_DIR_CONTROL;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_OE;
 		break;
@@ -493,7 +493,7 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 			l &= ~(1 << gpio);
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg += OMAP24XX_GPIO_SETDATAOUT;
@@ -546,7 +546,7 @@ static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 		reg += OMAP7XX_GPIO_DATA_INPUT;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_DATAIN;
 		break;
@@ -592,7 +592,7 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 		reg += OMAP7XX_GPIO_DATA_OUTPUT;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 		defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_DATAOUT;
@@ -684,7 +684,7 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
 }
 EXPORT_SYMBOL(omap_set_gpio_debounce_time);
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 				defined(CONFIG_ARCH_OMAP4)
 static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 						int trigger)
@@ -856,7 +856,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 			goto bad;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		set_24xx_gpio_triggering(bank, gpio, trigger);
@@ -937,7 +937,7 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 		reg += OMAP7XX_GPIO_INT_STATUS;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQSTATUS1;
 		break;
@@ -954,7 +954,7 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	__raw_writel(gpio_mask, reg);
 
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	reg = bank->base + OMAP24XX_GPIO_IRQSTATUS2;
 #endif
 #if defined(CONFIG_ARCH_OMAP4)
@@ -1008,7 +1008,7 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 		inv = 1;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQENABLE1;
 		mask = 0xffffffff;
@@ -1077,7 +1077,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
 			l |= gpio_mask;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg += OMAP24XX_GPIO_SETIRQENABLE1;
@@ -1131,7 +1131,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
@@ -1227,7 +1227,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(1 << offset, reg);
 	}
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 				defined(CONFIG_ARCH_OMAP4)
 	if (bank->method == METHOD_GPIO_24XX) {
 		/* Disable wake-up during idle for dynamic tick */
@@ -1286,7 +1286,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	if (bank->method == METHOD_GPIO_7XX)
 		isr_reg = bank->base + OMAP7XX_GPIO_INT_STATUS;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	if (bank->method == METHOD_GPIO_24XX)
 		isr_reg = bank->base + OMAP24XX_GPIO_IRQSTATUS1;
 #endif
@@ -1766,7 +1766,7 @@ static int __init _omap_gpio_init(void)
 		gpio_bank = gpio_bank_243x;
 	}
 #endif
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 	if (cpu_is_omap34xx()) {
 		gpio_bank_count = OMAP34XX_NR_GPIOS;
 		gpio_bank = gpio_bank_34xx;
@@ -1809,7 +1809,7 @@ static int __init _omap_gpio_init(void)
 			gpio_count = 32; /* 7xx has 32-bit GPIOs */
 		}
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 				defined(CONFIG_ARCH_OMAP4)
 		if (bank->method == METHOD_GPIO_24XX) {
 			static const u32 non_wakeup_gpios[] = {
@@ -1904,7 +1904,7 @@ static int __init _omap_gpio_init(void)
 }
 
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2) || \
-		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
+		defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 {
 	int i;
@@ -1927,7 +1927,7 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		case METHOD_GPIO_24XX:
 			wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
@@ -1975,7 +1975,7 @@ static int omap_gpio_resume(struct sys_device *dev)
 			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		case METHOD_GPIO_24XX:
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
@@ -2013,7 +2013,7 @@ static struct sys_device omap_gpio_device = {
 
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 				defined(CONFIG_ARCH_OMAP4)
 
 static int workaround_enabled;
@@ -2030,7 +2030,7 @@ void omap2_gpio_prepare_for_retention(void)
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		bank->saved_datain = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
 		l1 = __raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		l2 = __raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
@@ -2045,7 +2045,7 @@ void omap2_gpio_prepare_for_retention(void)
 		bank->saved_risingdetect = l2;
 		l1 &= ~bank->enabled_non_wakeup_gpios;
 		l2 &= ~bank->enabled_non_wakeup_gpios;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
 #endif
@@ -2074,7 +2074,7 @@ void omap2_gpio_resume_after_retention(void)
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(bank->saved_risingdetect,
@@ -2113,7 +2113,7 @@ void omap2_gpio_resume_after_retention(void)
 
 		if (gen) {
 			u32 old0, old1;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 			old0 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			old1 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 			__raw_writel(old0 | gen, bank->base +
@@ -2144,7 +2144,7 @@ void omap2_gpio_resume_after_retention(void)
 
 #endif
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 /* save the registers of bank 2-6 */
 void omap_gpio_save_context(void)
 {
@@ -2241,7 +2241,7 @@ static int __init omap_gpio_sysinit(void)
 	mpuio_init();
 
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2) || \
-		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
+		defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		if (ret == 0) {
 			ret = sysdev_class_register(&omap_gpio_sysclass);
@@ -2301,7 +2301,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 
 			irqstat = irq_desc[irq].status;
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2) ||	\
-		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
+		defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 			if (is_in && ((bank->suspend_wakeup & mask)
 					|| irqstat & IRQ_TYPE_SENSE_MASK)) {
 				char	*trigger = NULL;
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 7773bce..96d2781 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -50,10 +50,10 @@ static const char name[] = "i2c_omap";
 
 static struct resource i2c_resources[][2] = {
 	{ I2C_RESOURCE_BUILDER(0, 0) },
-#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_24XX_I2C2_IRQ) },
 #endif
-#if	defined(CONFIG_ARCH_OMAP34XX)
+#if	defined(CONFIG_ARCH_OMAP3)
 	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_34XX_I2C3_IRQ) },
 #endif
 };
@@ -72,10 +72,10 @@ static struct resource i2c_resources[][2] = {
 static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
 static struct platform_device omap_i2c_devices[] = {
 	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
-#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
 #endif
-#if	defined(CONFIG_ARCH_OMAP34XX)
+#if	defined(CONFIG_ARCH_OMAP3)
 	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
 #endif
 };
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index ae5679e..b41ea3d 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -114,7 +114,7 @@ unsigned int omap_rev(void);
 #  define OMAP_NAME omap16xx
 # endif
 #endif
-#if (defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX))
+#if (defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
 # if (defined(OMAP_NAME) || defined(MULTI_OMAP1))
 #  error "OMAP1 and OMAP2 can't be selected at the same time"
 # endif
@@ -240,7 +240,7 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 #  define cpu_is_omap242x()		is_omap242x()
 #  define cpu_is_omap243x()		is_omap243x()
 # endif
-# if defined(CONFIG_ARCH_OMAP34XX)
+# if defined(CONFIG_ARCH_OMAP3)
 #  undef  cpu_is_omap34xx
 #  undef  cpu_is_omap343x
 #  define cpu_is_omap34xx()		is_omap34xx()
@@ -259,7 +259,7 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 #  undef  cpu_is_omap243x
 #  define cpu_is_omap243x()		1
 # endif
-# if defined(CONFIG_ARCH_OMAP34XX)
+# if defined(CONFIG_ARCH_OMAP3)
 #  undef  cpu_is_omap34xx
 #  define cpu_is_omap34xx()		1
 # endif
@@ -382,7 +382,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_omap2430()		is_omap2430()
 #endif
 
-#if defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP3)
 # undef cpu_is_omap3430
 # undef cpu_is_omap3503
 # undef cpu_is_omap3515
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 19257bb..eef914d 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -284,7 +284,7 @@ static inline void omap243x_map_common_io(void)
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 extern void omap34xx_map_common_io(void);
 #else
 static inline void omap34xx_map_common_io(void)
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 9515062..0d7e536 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -103,7 +103,7 @@
 #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
 
-#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX) || \
+#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 	defined(CONFIG_ARCH_OMAP4)
 
 #define OMAP_MCBSP_REG_DRR2	0x00
@@ -374,7 +374,7 @@ struct omap_mcbsp_platform_data {
 	u8 dma_rx_sync, dma_tx_sync;
 	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 	u16 buffer_size;
 #endif
 };
@@ -410,7 +410,7 @@ struct omap_mcbsp {
 	struct omap_mcbsp_platform_data *pdata;
 	struct clk *iclk;
 	struct clk *fclk;
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 	int dma_op_mode;
 	u16 max_tx_thres;
 	u16 max_rx_thres;
@@ -423,7 +423,7 @@ int omap_mcbsp_init(void);
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 					int size);
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
 void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
 u16 omap_mcbsp_get_max_tx_threshold(unsigned int id);
diff --git a/arch/arm/plat-omap/include/plat/omap34xx.h b/arch/arm/plat-omap/include/plat/omap34xx.h
index 077f059..2845fdc 100644
--- a/arch/arm/plat-omap/include/plat/omap34xx.h
+++ b/arch/arm/plat-omap/include/plat/omap34xx.h
@@ -21,8 +21,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#ifndef __ASM_ARCH_OMAP34XX_H
-#define __ASM_ARCH_OMAP34XX_H
+#ifndef __ASM_ARCH_OMAP3_H
+#define __ASM_ARCH_OMAP3_H
 
 /*
  * Please place only base defines here and put the rest in device
@@ -82,5 +82,5 @@
 
 #define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
 
-#endif /* __ASM_ARCH_OMAP34XX_H */
+#endif /* __ASM_ARCH_OMAP3_H */
 
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index f757672..c1eb615 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -198,7 +198,7 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 }
 EXPORT_SYMBOL(omap_mcbsp_config);
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 /*
  * omap_mcbsp_set_tx_threshold configures how to deal
  * with transmit threshold. the threshold value and handler can be
@@ -1107,7 +1107,7 @@ void omap_mcbsp_set_spi_mode(unsigned int id,
 }
 EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 #define max_thres(m)			(mcbsp->pdata->buffer_size)
 #define valid_threshold(m, val)		((val) <= max_thres(m))
 #define THRESHOLD_PROP_BUILDER(prop)					\
@@ -1246,7 +1246,7 @@ static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
 #else
 static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp) {}
 static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp) {}
-#endif /* CONFIG_ARCH_OMAP34XX */
+#endif /* CONFIG_ARCH_OMAP3 */
 
 /*
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index e0cbb93..51f4dfb 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -53,7 +53,7 @@
 #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
 #define OMAP4_SRAM_PUB_VA	(OMAP4_SRAM_VA + 0x4000)
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 #define SRAM_BOOTLOADER_SZ	0x00
 #else
 #define SRAM_BOOTLOADER_SZ	0x80
diff --git a/drivers/net/smc911x.h b/drivers/net/smc911x.h
index 1477ff8..3269292 100644
--- a/drivers/net/smc911x.h
+++ b/drivers/net/smc911x.h
@@ -42,7 +42,7 @@
   #define SMC_USE_16BIT		0
   #define SMC_USE_32BIT		1
   #define SMC_IRQ_SENSE		IRQF_TRIGGER_LOW
-#elif defined(CONFIG_ARCH_OMAP34XX)
+#elif defined(CONFIG_ARCH_OMAP3)
   #define SMC_USE_16BIT		0
   #define SMC_USE_32BIT		1
   #define SMC_IRQ_SENSE		IRQF_TRIGGER_LOW
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 23bd252..66c35d7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -164,7 +164,7 @@ config SPI_OMAP_UWIRE
 
 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP24xx/OMAP34xx"
-	depends on ARCH_OMAP2 || ARCH_OMAP34XX
+	depends on ARCH_OMAP2 || ARCH_OMAP3
 	help
 	  SPI master controller for OMAP24xx/OMAP34xx Multichannel SPI
 	  (McSPI) modules.
diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index bf5f95a..715c518 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -1014,7 +1014,7 @@ static u8 __initdata spi2_txdma_id[] = {
 	OMAP24XX_DMA_SPI2_TX1,
 };
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX) \
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
 	|| defined(CONFIG_ARCH_OMAP4)
 static u8 __initdata spi3_rxdma_id[] = {
 	OMAP24XX_DMA_SPI3_RX0,
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 81aac7f..4f5bb56 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -61,7 +61,7 @@ config USB_ARCH_HAS_EHCI
 	default y if ARCH_W90X900
 	default y if ARCH_AT91SAM9G45
 	default y if ARCH_MXC
-	default y if ARCH_OMAP34XX
+	default y if ARCH_OMAP3
 	default PCI
 
 # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 1ec3857..d8d6d34 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1118,7 +1118,7 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ehci_hcd_au1xxx_driver
 #endif
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 #include "ehci-omap.c"
 #define        PLATFORM_DRIVER         ehci_hcd_omap_driver
 #endif
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index d9db864..b4c783c 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -37,7 +37,7 @@ config USB_MUSB_SOC
 	depends on USB_MUSB_HDRC
 	default y if ARCH_DAVINCI
 	default y if ARCH_OMAP2430
-	default y if ARCH_OMAP34XX
+	default y if ARCH_OMAP3
 	default y if (BF54x && !BF544)
 	default y if (BF52x && !BF522 && !BF523)
 
@@ -48,7 +48,7 @@ comment "OMAP 243x high speed USB support"
 	depends on USB_MUSB_HDRC && ARCH_OMAP2430
 
 comment "OMAP 343x high speed USB support"
-	depends on USB_MUSB_HDRC && ARCH_OMAP34XX
+	depends on USB_MUSB_HDRC && ARCH_OMAP3
 
 comment "Blackfin high speed USB Support"
 	depends on USB_MUSB_HDRC && ((BF54x && !BF544) || (BF52x && !BF522 && !BF523))
@@ -153,7 +153,7 @@ config MUSB_PIO_ONLY
 config USB_INVENTRA_DMA
 	bool
 	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
-	default ARCH_OMAP2430 || ARCH_OMAP34XX || BLACKFIN
+	default ARCH_OMAP2430 || ARCH_OMAP3 || BLACKFIN
 	help
 	  Enable DMA transfers using Mentor's engine.
 
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5eb9318..738efd8 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1000,7 +1000,7 @@ static void musb_shutdown(struct platform_device *pdev)
  * more than selecting one of a bunch of predefined configurations.
  */
 #if defined(CONFIG_USB_TUSB6010) || \
-	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
 static ushort __initdata fifo_mode = 4;
 #else
 static ushort __initdata fifo_mode = 2;
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 03d5090..5514c7e 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -562,7 +562,7 @@ extern void musb_hnp_stop(struct musb *musb);
 extern int musb_platform_set_mode(struct musb *musb, u8 musb_mode);
 
 #if defined(CONFIG_USB_TUSB6010) || defined(CONFIG_BLACKFIN) || \
-	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
 extern void musb_platform_try_idle(struct musb *musb, unsigned long timeout);
 #else
 #define musb_platform_try_idle(x, y)		do {} while (0)
diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 3195fb8..80b3b12 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -60,7 +60,7 @@ config W1_MASTER_GPIO
 
 config HDQ_MASTER_OMAP
 	tristate "OMAP HDQ driver"
-	depends on ARCH_OMAP2430 || ARCH_OMAP34XX
+	depends on ARCH_OMAP2430 || ARCH_OMAP3
 	help
 	  Say Y here if you want support for the 1-wire or HDQ Interface
 	  on an OMAP processor.
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index a1e12ff..9eefeec 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -194,7 +194,7 @@ config EP93XX_WATCHDOG
 
 config OMAP_WATCHDOG
 	tristate "OMAP Watchdog"
-	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP34XX
+	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP3
 	help
 	  Support for TI OMAP1610/OMAP1710/OMAP2420/OMAP3430 watchdog.  Say 'Y'
 	  here to enable the OMAP1610/OMAP1710/OMAP2420/OMAP3430 watchdog timer.
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 26e728d..c0039b3 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -82,11 +82,11 @@ static const int omap1_dma_reqs[][2] = {};
 static const unsigned long omap1_mcbsp_port[][2] = {};
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 static const int omap24xx_dma_reqs[][2] = {
 	{ OMAP24XX_DMA_MCBSP1_TX, OMAP24XX_DMA_MCBSP1_RX },
 	{ OMAP24XX_DMA_MCBSP2_TX, OMAP24XX_DMA_MCBSP2_RX },
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
 	{ OMAP24XX_DMA_MCBSP3_TX, OMAP24XX_DMA_MCBSP3_RX },
 	{ OMAP24XX_DMA_MCBSP4_TX, OMAP24XX_DMA_MCBSP4_RX },
 	{ OMAP24XX_DMA_MCBSP5_TX, OMAP24XX_DMA_MCBSP5_RX },
@@ -124,7 +124,7 @@ static const unsigned long omap2430_mcbsp_port[][2] = {
 static const unsigned long omap2430_mcbsp_port[][2] = {};
 #endif
 
-#if defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP3)
 static const unsigned long omap34xx_mcbsp_port[][2] = {
 	{ OMAP34XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR,
 	  OMAP34XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR },
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index 647d2f9..1968d03 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -50,7 +50,7 @@ enum omap_mcbsp_div {
 #undef  NUM_LINKS
 #define NUM_LINKS	3
 #endif
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
 #undef  NUM_LINKS
 #define NUM_LINKS	5
 #endif

