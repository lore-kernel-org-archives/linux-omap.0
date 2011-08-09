From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib implementations
Date: Tue, 09 Aug 2011 09:08:01 +0100
Message-ID: <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41958 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab1HIIIM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 04:08:12 -0400
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>Grant Likely <grant.likely@secretlab.ca>Nicolas Pitre <nico@fluxnic.net>

Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
into asm/gpio.h.  This is basically the include of asm-generic/gpio.h
and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
as described in Documentation/gpio.txt

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/gpio.h                 |   10 ++++++++++
 arch/arm/mach-at91/include/mach/gpio.h      |    5 +----
 arch/arm/mach-ep93xx/include/mach/gpio.h    |    7 +------
 arch/arm/mach-exynos4/include/mach/gpio.h   |    5 +----
 arch/arm/mach-gemini/include/mach/gpio.h    |    5 +----
 arch/arm/mach-ks8695/include/mach/gpio.h    |   11 ++---------
 arch/arm/mach-lpc32xx/include/mach/gpio.h   |   17 +----------------
 arch/arm/mach-msm/include/mach/gpio.h       |    5 +----
 arch/arm/mach-mxs/include/mach/gpio.h       |    6 +-----
 arch/arm/mach-realview/include/mach/gpio.h  |    6 +-----
 arch/arm/mach-s3c2410/include/mach/gpio.h   |    5 +----
 arch/arm/mach-s3c64xx/include/mach/gpio.h   |    6 +-----
 arch/arm/mach-s5p64x0/include/mach/gpio.h   |    6 +-----
 arch/arm/mach-s5pc100/include/mach/gpio.h   |    6 +-----
 arch/arm/mach-s5pv210/include/mach/gpio.h   |    6 +-----
 arch/arm/mach-shmobile/include/mach/gpio.h  |   15 +--------------
 arch/arm/mach-tegra/include/mach/gpio.h     |    6 +-----
 arch/arm/mach-versatile/include/mach/gpio.h |    6 +-----
 arch/arm/mach-vt8500/include/mach/gpio.h    |    6 +-----
 arch/arm/mach-w90x900/include/mach/gpio.h   |    5 +----
 arch/arm/plat-mxc/include/mach/gpio.h       |    5 +----
 arch/arm/plat-nomadik/include/plat/gpio.h   |   11 +----------
 arch/arm/plat-omap/include/plat/gpio.h      |   15 +--------------
 arch/arm/plat-orion/include/plat/gpio.h     |    6 ++----
 arch/arm/plat-spear/include/plat/gpio.h     |    6 +-----
 25 files changed, 36 insertions(+), 151 deletions(-)

diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
index 166a7a3..15e8970 100644
--- a/arch/arm/include/asm/gpio.h
+++ b/arch/arm/include/asm/gpio.h
@@ -4,4 +4,14 @@
 /* not all ARM platforms necessarily support this API ... */
 #include <mach/gpio.h>
 
+#ifdef __ARM_GPIOLIB_TRIVIAL
+/* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
+#include <asm-generic/gpio.h>
+
+/* The trivial gpiolib dispatchers */
+#define gpio_get_value  __gpio_get_value
+#define gpio_set_value  __gpio_set_value
+#define gpio_cansleep   __gpio_cansleep
+#endif
+
 #endif /* _ARCH_ARM_GPIO_H */
diff --git a/arch/arm/mach-at91/include/mach/gpio.h b/arch/arm/mach-at91/include/mach/gpio.h
index 056dc66..6ddc1a6 100644
--- a/arch/arm/mach-at91/include/mach/gpio.h
+++ b/arch/arm/mach-at91/include/mach/gpio.h
@@ -214,11 +214,8 @@ extern void at91_gpio_resume(void);
  */
 
 #include <asm/errno.h>
-#include <asm-generic/gpio.h>		/* cansleep wrappers */
 
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 
 #define gpio_to_irq(gpio) (gpio)
 #define irq_to_gpio(irq)  (irq)
diff --git a/arch/arm/mach-ep93xx/include/mach/gpio.h b/arch/arm/mach-ep93xx/include/mach/gpio.h
index c57152c..fbc770e 100644
--- a/arch/arm/mach-ep93xx/include/mach/gpio.h
+++ b/arch/arm/mach-ep93xx/include/mach/gpio.h
@@ -100,12 +100,7 @@
 #define EP93XX_GPIO_LINE_MAX_IRQ	EP93XX_GPIO_LINE_F(7)
 
 /* new generic GPIO API - see Documentation/gpio.txt */
-
-#include <asm-generic/gpio.h>
-
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 
 /*
  * Map GPIO A0..A7  (0..7)  to irq 64..71,
diff --git a/arch/arm/mach-exynos4/include/mach/gpio.h b/arch/arm/mach-exynos4/include/mach/gpio.h
index be9266b..b2e3595 100644
--- a/arch/arm/mach-exynos4/include/mach/gpio.h
+++ b/arch/arm/mach-exynos4/include/mach/gpio.h
@@ -13,9 +13,6 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H __FILE__
 
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
 #define gpio_to_irq	__gpio_to_irq
 
 /* Practically, GPIO banks up to GPZ are the configurable gpio banks */
@@ -151,6 +148,6 @@ enum s5p_gpio_number {
 #define ARCH_NR_GPIOS		(EXYNOS4_GPZ(EXYNOS4_GPIO_Z_NR) +	\
 				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
 
-#include <asm-generic/gpio.h>
+#define __ARM_GPIOLIB_TRIVIAL
 
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-gemini/include/mach/gpio.h b/arch/arm/mach-gemini/include/mach/gpio.h
index 3bc2c70..20c0a36 100644
--- a/arch/arm/mach-gemini/include/mach/gpio.h
+++ b/arch/arm/mach-gemini/include/mach/gpio.h
@@ -13,11 +13,8 @@
 #define __MACH_GPIO_H__
 
 #include <mach/irqs.h>
-#include <asm-generic/gpio.h>
 
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 
 #define gpio_to_irq(x)	((x) + GPIO_IRQ_BASE)
 #define irq_to_gpio(x)	((x) - GPIO_IRQ_BASE)
diff --git a/arch/arm/mach-ks8695/include/mach/gpio.h b/arch/arm/mach-ks8695/include/mach/gpio.h
index 86312d4..c13952c 100644
--- a/arch/arm/mach-ks8695/include/mach/gpio.h
+++ b/arch/arm/mach-ks8695/include/mach/gpio.h
@@ -40,17 +40,10 @@ extern int ks8695_gpio_interrupt(unsigned int pin, unsigned int type);
  */
 extern int irq_to_gpio(unsigned int irq);
 
-#include <asm-generic/gpio.h>
-
-/* If it turns out that we need to optimise GPIO access for the
- * Micrel's GPIOs, then these can be changed to check their argument
- * directly as static inlines. However for now it's probably not
- * worthwhile.
- */
-#define gpio_get_value __gpio_get_value
-#define gpio_set_value __gpio_set_value
 #define gpio_to_irq __gpio_to_irq
 
+#define __ARM_GPIOLIB_TRIVIAL
+
 /* Register the GPIOs */
 extern void ks8695_register_gpios(void);
 
diff --git a/arch/arm/mach-lpc32xx/include/mach/gpio.h b/arch/arm/mach-lpc32xx/include/mach/gpio.h
index 67d03da..0ca6c27 100644
--- a/arch/arm/mach-lpc32xx/include/mach/gpio.h
+++ b/arch/arm/mach-lpc32xx/include/mach/gpio.h
@@ -19,8 +19,6 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H
 
-#include <asm-generic/gpio.h>
-
 /*
  * Note!
  * Muxed GP pins need to be setup to the GP state in the board level
@@ -51,20 +49,7 @@
  */
 #define LPC32XX_GPIO(x, y) ((x) + (y))
 
-static inline int gpio_get_value(unsigned gpio)
-{
-	return __gpio_get_value(gpio);
-}
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	__gpio_set_value(gpio, value);
-}
-
-static inline int gpio_cansleep(unsigned gpio)
-{
-	return __gpio_cansleep(gpio);
-}
+#define __ARM_GPIOLIB_TRIVIAL
 
 static inline int gpio_to_irq(unsigned gpio)
 {
diff --git a/arch/arm/mach-msm/include/mach/gpio.h b/arch/arm/mach-msm/include/mach/gpio.h
index 36ad50d..bc75e20 100644
--- a/arch/arm/mach-msm/include/mach/gpio.h
+++ b/arch/arm/mach-msm/include/mach/gpio.h
@@ -16,11 +16,8 @@
 #ifndef __ASM_ARCH_MSM_GPIO_H
 #define __ASM_ARCH_MSM_GPIO_H
 
-#include <asm-generic/gpio.h>
+#define __ARM_GPIOLIB_TRIVIAL
 
-#define gpio_get_value  __gpio_get_value
-#define gpio_set_value  __gpio_set_value
-#define gpio_cansleep   __gpio_cansleep
 #define gpio_to_irq     __gpio_to_irq
 
 #endif /* __ASM_ARCH_MSM_GPIO_H */
diff --git a/arch/arm/mach-mxs/include/mach/gpio.h b/arch/arm/mach-mxs/include/mach/gpio.h
index 828cccc..bb44c8d 100644
--- a/arch/arm/mach-mxs/include/mach/gpio.h
+++ b/arch/arm/mach-mxs/include/mach/gpio.h
@@ -20,14 +20,10 @@
 #ifndef __MACH_MXS_GPIO_H__
 #define __MACH_MXS_GPIO_H__
 
-#include <asm-generic/gpio.h>
-
 #define MXS_GPIO_NR(bank, nr)	((bank) * 32 + (nr))
 
 /* use gpiolib dispatchers */
-#define gpio_get_value		__gpio_get_value
-#define gpio_set_value		__gpio_set_value
-#define gpio_cansleep		__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 #define gpio_to_irq		__gpio_to_irq
 
 #define irq_to_gpio(irq)	((irq) - MXS_GPIO_IRQ_START)
diff --git a/arch/arm/mach-realview/include/mach/gpio.h b/arch/arm/mach-realview/include/mach/gpio.h
index 94ff276..bd11dc5 100644
--- a/arch/arm/mach-realview/include/mach/gpio.h
+++ b/arch/arm/mach-realview/include/mach/gpio.h
@@ -1,6 +1,2 @@
-#include <asm-generic/gpio.h>
-
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 #define gpio_to_irq	__gpio_to_irq
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-s3c2410/include/mach/gpio.h
index f7f6b07..998ef4c 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
@@ -11,9 +11,7 @@
  * published by the Free Software Foundation.
 */
 
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 #define gpio_to_irq	__gpio_to_irq
 
 /* some boards require extra gpio capacity to support external
@@ -28,7 +26,6 @@
 #define ARCH_NR_GPIOS	(256 + CONFIG_S3C24XX_GPIO_EXTRA)
 #endif
 
-#include <asm-generic/gpio.h>
 #include <mach/gpio-nrs.h>
 #include <mach/gpio-fns.h>
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio.h b/arch/arm/mach-s3c64xx/include/mach/gpio.h
index 0d46e99..6958b3f 100644
--- a/arch/arm/mach-s3c64xx/include/mach/gpio.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio.h
@@ -12,9 +12,7 @@
  * published by the Free Software Foundation.
 */
 
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 #define gpio_to_irq	__gpio_to_irq
 
 /* GPIO bank sizes */
@@ -96,5 +94,3 @@ enum s3c_gpio_number {
 #define BOARD_NR_GPIOS 16
 
 #define ARCH_NR_GPIOS	(GPIO_BOARD_START + BOARD_NR_GPIOS)
-
-#include <asm-generic/gpio.h>
diff --git a/arch/arm/mach-s5p64x0/include/mach/gpio.h b/arch/arm/mach-s5p64x0/include/mach/gpio.h
index adb5f29..a25160b 100644
--- a/arch/arm/mach-s5p64x0/include/mach/gpio.h
+++ b/arch/arm/mach-s5p64x0/include/mach/gpio.h
@@ -13,9 +13,7 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H __FILE__
 
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 #define gpio_to_irq	__gpio_to_irq
 
 /* GPIO bank sizes */
@@ -134,6 +132,4 @@ enum s5p6450_gpio_number {
 
 #define ARCH_NR_GPIOS		(S5P64X0_GPIO_END + CONFIG_SAMSUNG_GPIO_EXTRA)
 
-#include <asm-generic/gpio.h>
-
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-s5pc100/include/mach/gpio.h
index 29a8a12..f515bfb 100644
--- a/arch/arm/mach-s5pc100/include/mach/gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
@@ -15,9 +15,7 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H __FILE__
 
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 #define gpio_to_irq	__gpio_to_irq
 
 /* GPIO bank sizes */
@@ -146,6 +144,4 @@ enum s5p_gpio_number {
 /* define the number of gpios we need to the one after the MP04() range */
 #define ARCH_NR_GPIOS		(S5PC100_GPIO_END + 1)
 
-#include <asm-generic/gpio.h>
-
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-s5pv210/include/mach/gpio.h
index a5a1e33..27f2139 100644
--- a/arch/arm/mach-s5pv210/include/mach/gpio.h
+++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
@@ -13,9 +13,7 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H __FILE__
 
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 #define gpio_to_irq	__gpio_to_irq
 
 /* Practically, GPIO banks up to MP03 are the configurable gpio banks */
@@ -142,6 +140,4 @@ enum s5p_gpio_number {
 #define ARCH_NR_GPIOS		(S5PV210_MP05(S5PV210_GPIO_MP05_NR) +	\
 				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
 
-#include <asm-generic/gpio.h>
-
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-shmobile/include/mach/gpio.h b/arch/arm/mach-shmobile/include/mach/gpio.h
index 2b1bb9e..e8feff0 100644
--- a/arch/arm/mach-shmobile/include/mach/gpio.h
+++ b/arch/arm/mach-shmobile/include/mach/gpio.h
@@ -18,20 +18,7 @@
 
 #ifdef CONFIG_GPIOLIB
 
-static inline int gpio_get_value(unsigned gpio)
-{
-	return __gpio_get_value(gpio);
-}
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	__gpio_set_value(gpio, value);
-}
-
-static inline int gpio_cansleep(unsigned gpio)
-{
-	return __gpio_cansleep(gpio);
-}
+#define __ARM_GPIOLIB_TRIVIAL
 
 static inline int gpio_to_irq(unsigned gpio)
 {
diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
index 196f114..d51be09 100644
--- a/arch/arm/mach-tegra/include/mach/gpio.h
+++ b/arch/arm/mach-tegra/include/mach/gpio.h
@@ -25,11 +25,7 @@
 
 #define TEGRA_NR_GPIOS		INT_GPIO_NR
 
-#include <asm-generic/gpio.h>
-
-#define gpio_get_value		__gpio_get_value
-#define gpio_set_value		__gpio_set_value
-#define gpio_cansleep		__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 
 #define TEGRA_GPIO_TO_IRQ(gpio) (INT_GPIO_BASE + (gpio))
 #define TEGRA_IRQ_TO_GPIO(irq) ((irq) - INT_GPIO_BASE)
diff --git a/arch/arm/mach-versatile/include/mach/gpio.h b/arch/arm/mach-versatile/include/mach/gpio.h
index 94ff276..bd11dc5 100644
--- a/arch/arm/mach-versatile/include/mach/gpio.h
+++ b/arch/arm/mach-versatile/include/mach/gpio.h
@@ -1,6 +1,2 @@
-#include <asm-generic/gpio.h>
-
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 #define gpio_to_irq	__gpio_to_irq
diff --git a/arch/arm/mach-vt8500/include/mach/gpio.h b/arch/arm/mach-vt8500/include/mach/gpio.h
index 94ff276..bd11dc5 100644
--- a/arch/arm/mach-vt8500/include/mach/gpio.h
+++ b/arch/arm/mach-vt8500/include/mach/gpio.h
@@ -1,6 +1,2 @@
-#include <asm-generic/gpio.h>
-
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 #define gpio_to_irq	__gpio_to_irq
diff --git a/arch/arm/mach-w90x900/include/mach/gpio.h b/arch/arm/mach-w90x900/include/mach/gpio.h
index 034da3e..60c7846 100644
--- a/arch/arm/mach-w90x900/include/mach/gpio.h
+++ b/arch/arm/mach-w90x900/include/mach/gpio.h
@@ -15,11 +15,8 @@
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm-generic/gpio.h>
 
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 
 static inline int gpio_to_irq(unsigned gpio)
 {
diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 31c820c..4398edd 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -21,7 +21,6 @@
 
 #include <linux/spinlock.h>
 #include <mach/hardware.h>
-#include <asm-generic/gpio.h>
 
 
 /* There's a off-by-one betweem the gpio bank number and the gpiochip */
@@ -29,9 +28,7 @@
 #define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
 
 /* use gpiolib dispatchers */
-#define gpio_get_value		__gpio_get_value
-#define gpio_set_value		__gpio_set_value
-#define gpio_cansleep		__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 
 #define gpio_to_irq(gpio)	(MXC_GPIO_IRQ_START + (gpio))
 #define irq_to_gpio(irq)	((irq) - MXC_GPIO_IRQ_START)
diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
index d5d7e65..569b2c6 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -12,16 +12,7 @@
 #ifndef __ASM_PLAT_GPIO_H
 #define __ASM_PLAT_GPIO_H
 
-#include <asm-generic/gpio.h>
-
-/*
- * These currently cause a function call to happen, they may be optimized
- * if needed by adding cpu-specific defines to identify blocks
- * (see mach-pxa/include/mach/gpio.h as an example using GPLR etc)
- */
-#define gpio_get_value  __gpio_get_value
-#define gpio_set_value  __gpio_set_value
-#define gpio_cansleep   __gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 #define gpio_to_irq     __gpio_to_irq
 
 /*
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 91e8de3..20eedbb 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -222,20 +222,7 @@ extern void omap_gpio_restore_context(void);
 #include <linux/errno.h>
 #include <asm-generic/gpio.h>
 
-static inline int gpio_get_value(unsigned gpio)
-{
-	return __gpio_get_value(gpio);
-}
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	__gpio_set_value(gpio, value);
-}
-
-static inline int gpio_cansleep(unsigned gpio)
-{
-	return __gpio_cansleep(gpio);
-}
+#define __ARM_GPIOLIB_TRIVIAL
 
 static inline int gpio_to_irq(unsigned gpio)
 {
diff --git a/arch/arm/plat-orion/include/plat/gpio.h b/arch/arm/plat-orion/include/plat/gpio.h
index 3075b9f..71c4c6c 100644
--- a/arch/arm/plat-orion/include/plat/gpio.h
+++ b/arch/arm/plat-orion/include/plat/gpio.h
@@ -12,14 +12,12 @@
 #define __PLAT_GPIO_H
 
 #include <linux/init.h>
-#include <asm-generic/gpio.h>
+
+#define __ARM_GPIOLIB_TRIVIAL
 
 /*
  * GENERIC_GPIO primitives.
  */
-#define gpio_get_value  __gpio_get_value
-#define gpio_set_value  __gpio_set_value
-#define gpio_cansleep   __gpio_cansleep
 #define gpio_to_irq     __gpio_to_irq
 
 /*
diff --git a/arch/arm/plat-spear/include/plat/gpio.h b/arch/arm/plat-spear/include/plat/gpio.h
index b857c91..3c6f044 100644
--- a/arch/arm/plat-spear/include/plat/gpio.h
+++ b/arch/arm/plat-spear/include/plat/gpio.h
@@ -14,11 +14,7 @@
 #ifndef __PLAT_GPIO_H
 #define __PLAT_GPIO_H
 
-#include <asm-generic/gpio.h>
-
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
+#define __ARM_GPIOLIB_TRIVIAL
 #define gpio_to_irq	__gpio_to_irq
 
 #endif /* __PLAT_GPIO_H */
-- 
1.7.4.4

