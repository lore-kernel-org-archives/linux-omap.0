From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/2] ARM: OMAP1: use IS_ENABLED() instead of checking for built-in or module
Date: Thu, 11 Aug 2016 15:29:44 -0400
Message-ID: <1470943785-21282-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
built-in or as a module, use that macro instead of open coding the same.

Using the macro makes the code more readable by helping abstract away some
of the Kconfig built-in and module enable details.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/mach-omap1/board-h2-mmc.c     |  2 +-
 arch/arm/mach-omap1/board-h2.c         |  2 +-
 arch/arm/mach-omap1/board-h3-mmc.c     |  2 +-
 arch/arm/mach-omap1/board-h3.c         |  2 +-
 arch/arm/mach-omap1/board-htcherald.c  |  4 ++--
 arch/arm/mach-omap1/board-innovator.c  |  4 ++--
 arch/arm/mach-omap1/board-nokia770.c   |  4 ++--
 arch/arm/mach-omap1/board-sx1-mmc.c    |  2 +-
 arch/arm/mach-omap1/devices.c          | 10 +++++-----
 arch/arm/mach-omap1/fb.c               |  2 +-
 arch/arm/mach-omap1/include/mach/usb.h |  2 +-
 arch/arm/mach-omap1/mmc.h              |  2 +-
 arch/arm/mach-omap1/usb.c              |  6 +++---
 13 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index 7119ef28e0ad..357be2debc9d 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -19,7 +19,7 @@
 #include "board-h2.h"
 #include "mmc.h"
 
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if IS_ENABLED(CONFIG_MMC_OMAP)
 
 static int mmc_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index cd146ed0538d..675254ee4b1e 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -349,7 +349,7 @@ static struct omap_usb_config h2_usb_config __initdata = {
 #if IS_ENABLED(CONFIG_USB_OMAP)
 	.hmc_mode	= 19,	/* 0:host(off) 1:dev|otg 2:disabled */
 	/* .hmc_mode	= 21,*/	/* 0:host(off) 1:dev(loopback) 2:host(loopback) */
-#elif	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+#elif	IS_ENABLED(CONFIG_USB_OHCI_HCD)
 	/* needs OTG cable, or NONSTANDARD (B-to-MiniB) */
 	.hmc_mode	= 20,	/* 1:dev|otg(off) 1:host 2:disabled */
 #endif
diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index 43aab63cbc39..4f58bfa5e754 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -20,7 +20,7 @@
 #include "board-h3.h"
 #include "mmc.h"
 
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if IS_ENABLED(CONFIG_MMC_OMAP)
 
 static int mmc_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index f7c8c63dd532..e62f9d454f10 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -368,7 +368,7 @@ static struct omap_usb_config h3_usb_config __initdata = {
 
 #if IS_ENABLED(CONFIG_USB_OMAP)
 	.hmc_mode       = 19,   /* 0:host(off) 1:dev|otg 2:disabled */
-#elif  defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+#elif IS_ENABLED(CONFIG_USB_OHCI_HCD)
 	/* NONSTANDARD CABLE NEEDED (B-to-Mini-B) */
 	.hmc_mode       = 20,   /* 1:dev|otg(off) 1:host 2:disabled */
 #endif
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 9525ef9bc6c0..e424df901dbd 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -401,7 +401,7 @@ static struct platform_device lcd_device = {
 };
 
 /* MMC Card */
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if IS_ENABLED(CONFIG_MMC_OMAP)
 static struct omap_mmc_platform_data htc_mmc1_data = {
 	.nr_slots                       = 1,
 	.switch_slot                    = NULL,
@@ -586,7 +586,7 @@ static void __init htcherald_init(void)
 
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if IS_ENABLED(CONFIG_MMC_OMAP)
 	htc_mmc_data[0] = &htc_mmc1_data;
 	omap1_init_mmc(htc_mmc_data, 1);
 #endif
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index ae90bd02b3bf..67e188271643 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -315,7 +315,7 @@ static struct omap_usb_config h2_usb_config __initdata = {
 #if IS_ENABLED(CONFIG_USB_OMAP)
 	.hmc_mode	= 19,	/* 0:host(off) 1:dev|otg 2:disabled */
 	/* .hmc_mode	= 21,*/	/* 0:host(off) 1:dev(loopback) 2:host(loopback) */
-#elif	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+#elif	IS_ENABLED(CONFIG_USB_OHCI_HCD)
 	/* NONSTANDARD CABLE NEEDED (B-to-Mini-B) */
 	.hmc_mode	= 20,	/* 1:dev|otg(off) 1:host 2:disabled */
 #endif
@@ -328,7 +328,7 @@ static struct omap_lcd_config innovator1610_lcd_config __initdata = {
 };
 #endif
 
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if IS_ENABLED(CONFIG_MMC_OMAP)
 
 static int mmc_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index dd3a3ad797ea..ee8d9f553db4 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -159,7 +159,7 @@ static struct omap_usb_config nokia770_usb_config __initdata = {
 	.extcon		= "tahvo-usb",
 };
 
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if IS_ENABLED(CONFIG_MMC_OMAP)
 
 #define NOKIA770_GPIO_MMC_POWER		41
 #define NOKIA770_GPIO_MMC_SWITCH	23
@@ -216,7 +216,7 @@ static inline void nokia770_mmc_init(void)
 }
 #endif
 
-#if defined(CONFIG_I2C_CBUS_GPIO) || defined(CONFIG_I2C_CBUS_GPIO_MODULE)
+#if IS_ENABLED(CONFIG_I2C_CBUS_GPIO)
 static struct i2c_cbus_platform_data nokia770_cbus_data = {
 	.clk_gpio = OMAP_MPUIO(9),
 	.dat_gpio = OMAP_MPUIO(10),
diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/board-sx1-mmc.c
index a9373570bbb1..79f0af8bfae0 100644
--- a/arch/arm/mach-omap1/board-sx1-mmc.c
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -20,7 +20,7 @@
 
 #include "mmc.h"
 
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if IS_ENABLED(CONFIG_MMC_OMAP)
 
 static int mmc_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 8c8be861fff2..baaf902b7016 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -33,7 +33,7 @@
 #include "mmc.h"
 #include "sram.h"
 
-#if defined(CONFIG_RTC_DRV_OMAP) || defined(CONFIG_RTC_DRV_OMAP_MODULE)
+#if IS_ENABLED(CONFIG_RTC_DRV_OMAP)
 
 #define	OMAP_RTC_BASE		0xfffb4800
 
@@ -72,7 +72,7 @@ static inline void omap_init_mbox(void) { }
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if IS_ENABLED(CONFIG_MMC_OMAP)
 
 static inline void omap1_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			int controller_nr)
@@ -230,7 +230,7 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 /*-------------------------------------------------------------------------*/
 
 /* OMAP7xx SPI support */
-#if defined(CONFIG_SPI_OMAP_100K) || defined(CONFIG_SPI_OMAP_100K_MODULE)
+#if IS_ENABLED(CONFIG_SPI_OMAP_100K)
 
 struct platform_device omap_spi1 = {
 	.name           = "omap1_spi100k",
@@ -312,7 +312,7 @@ static inline void omap_init_sti(void) {}
  * mcbsp1..3	= 5..7
  */
 
-#if defined(CONFIG_SPI_OMAP_UWIRE) || defined(CONFIG_SPI_OMAP_UWIRE_MODULE)
+#if IS_ENABLED(CONFIG_SPI_OMAP_UWIRE)
 
 #define	OMAP_UWIRE_BASE		0xfffb3000
 
@@ -418,7 +418,7 @@ static int __init omap1_init_devices(void)
 }
 arch_initcall(omap1_init_devices);
 
-#if defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
+#if IS_ENABLED(CONFIG_OMAP_WATCHDOG)
 
 static struct resource wdt_resources[] = {
 	{
diff --git a/arch/arm/mach-omap1/fb.c b/arch/arm/mach-omap1/fb.c
index c770d45c7226..ddab04087b7a 100644
--- a/arch/arm/mach-omap1/fb.c
+++ b/arch/arm/mach-omap1/fb.c
@@ -33,7 +33,7 @@
 
 #include <asm/mach/map.h>
 
-#if defined(CONFIG_FB_OMAP) || defined(CONFIG_FB_OMAP_MODULE)
+#if IS_ENABLED(CONFIG_FB_OMAP)
 
 static bool omapfb_lcd_configured;
 static struct omapfb_platform_data omapfb_config;
diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1/include/mach/usb.h
index 2c263051dc51..a7c5559caef2 100644
--- a/arch/arm/mach-omap1/include/mach/usb.h
+++ b/arch/arm/mach-omap1/include/mach/usb.h
@@ -12,7 +12,7 @@
 
 void omap_otg_init(struct omap_usb_config *config);
 
-#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
+#if IS_ENABLED(CONFIG_USB)
 void omap1_usb_init(struct omap_usb_config *pdata);
 #else
 static inline void omap1_usb_init(struct omap_usb_config *pdata)
diff --git a/arch/arm/mach-omap1/mmc.h b/arch/arm/mach-omap1/mmc.h
index 39c2b13de884..d7b46880e4ca 100644
--- a/arch/arm/mach-omap1/mmc.h
+++ b/arch/arm/mach-omap1/mmc.h
@@ -7,7 +7,7 @@
 #define OMAP1_MMC1_BASE		0xfffb7800
 #define OMAP1_MMC2_BASE		0xfffb7c00	/* omap16xx only */
 
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if IS_ENABLED(CONFIG_MMC_OMAP)
 void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers);
 #else
diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 4118db50d5e8..2506e598a067 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -136,7 +136,7 @@ omap_otg_init(struct omap_usb_config *config)
 	}
 #endif
 
-#if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+#if	IS_ENABLED(CONFIG_USB_OHCI_HCD)
 	if (config->otg || config->register_host) {
 		struct platform_device *ohci_device = config->ohci_device;
 		int status;
@@ -221,7 +221,7 @@ static inline void udc_device_init(struct omap_usb_config *pdata)
 
 #endif
 
-#if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+#if	IS_ENABLED(CONFIG_USB_OHCI_HCD)
 
 /* The dmamask must be set for OHCI to work */
 static u64 ohci_dmamask = ~(u32)0;
@@ -612,7 +612,7 @@ static void __init omap_1510_usb_init(struct omap_usb_config *config)
 	}
 #endif
 
-#if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+#if	IS_ENABLED(CONFIG_USB_OHCI_HCD)
 	if (config->register_host) {
 		int status;
 
-- 
2.5.5
