From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 12/13] ARM: gpio: consolidate gpio_to_irq
Date: Tue, 09 Aug 2011 09:08:22 +0100
Message-ID: <E1QqhMM-0003aj-C7@rmk-PC.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41967 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab1HIIIc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 04:08:32 -0400
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>Grant Likely <grant.likely@secretlab.ca>Nicolas Pitre <nico@fluxnic.net>

Many of the gpio_to_irq implementations use the gpiolib version of this
function.  Provide the standard gpiolib gpio_to_irq() for everyone, but
allow platforms to override it if they wish.  Add the neccessary
overrides for those platforms which do not use the standard definition.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/gpio.h                 |    9 +++++++++
 arch/arm/mach-davinci/include/mach/gpio.h   |    5 -----
 arch/arm/mach-exynos4/include/mach/gpio.h   |    2 --
 arch/arm/mach-ixp4xx/include/mach/gpio.h    |    1 +
 arch/arm/mach-ks8695/include/mach/gpio.h    |    2 --
 arch/arm/mach-lpc32xx/include/mach/gpio.h   |    5 -----
 arch/arm/mach-msm/include/mach/gpio.h       |    2 --
 arch/arm/mach-mxs/include/mach/gpio.h       |    1 -
 arch/arm/mach-realview/include/mach/gpio.h  |    1 -
 arch/arm/mach-s3c2410/include/mach/gpio.h   |    1 -
 arch/arm/mach-s3c64xx/include/mach/gpio.h   |    1 -
 arch/arm/mach-s5p64x0/include/mach/gpio.h   |    1 -
 arch/arm/mach-s5pc100/include/mach/gpio.h   |    1 -
 arch/arm/mach-s5pv210/include/mach/gpio.h   |    1 -
 arch/arm/mach-shmobile/include/mach/gpio.h  |    5 -----
 arch/arm/mach-tegra/include/mach/gpio.h     |    1 +
 arch/arm/mach-u300/include/mach/gpio.h      |    1 +
 arch/arm/mach-versatile/include/mach/gpio.h |    1 -
 arch/arm/mach-vt8500/include/mach/gpio.h    |    1 -
 arch/arm/mach-w90x900/include/mach/gpio.h   |    1 +
 arch/arm/plat-nomadik/include/plat/gpio.h   |    1 -
 arch/arm/plat-omap/include/plat/gpio.h      |    5 -----
 arch/arm/plat-orion/include/plat/gpio.h     |    5 -----
 arch/arm/plat-spear/include/plat/gpio.h     |    1 -
 24 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
index 15e8970..5032224 100644
--- a/arch/arm/include/asm/gpio.h
+++ b/arch/arm/include/asm/gpio.h
@@ -14,4 +14,13 @@
 #define gpio_cansleep   __gpio_cansleep
 #endif
 
+/*
+ * Provide a default gpio_to_irq() which should satisfy every case.
+ * However, some platforms want to do this differently, so allow them
+ * to override it.
+ */
+#ifndef gpio_to_irq
+#define gpio_to_irq	__gpio_to_irq
+#endif
+
 #endif /* _ARCH_ARM_GPIO_H */
diff --git a/arch/arm/mach-davinci/include/mach/gpio.h b/arch/arm/mach-davinci/include/mach/gpio.h
index fbece12..73fc7a0 100644
--- a/arch/arm/mach-davinci/include/mach/gpio.h
+++ b/arch/arm/mach-davinci/include/mach/gpio.h
@@ -147,11 +147,6 @@ static inline int gpio_cansleep(unsigned gpio)
 		return __gpio_cansleep(gpio);
 }
 
-static inline int gpio_to_irq(unsigned gpio)
-{
-	return __gpio_to_irq(gpio);
-}
-
 static inline int irq_to_gpio(unsigned irq)
 {
 	/* don't support the reverse mapping */
diff --git a/arch/arm/mach-exynos4/include/mach/gpio.h b/arch/arm/mach-exynos4/include/mach/gpio.h
index b2e3595..b91e8b2 100644
--- a/arch/arm/mach-exynos4/include/mach/gpio.h
+++ b/arch/arm/mach-exynos4/include/mach/gpio.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H __FILE__
 
-#define gpio_to_irq	__gpio_to_irq
-
 /* Practically, GPIO banks up to GPZ are the configurable gpio banks */
 
 /* GPIO bank sizes */
diff --git a/arch/arm/mach-ixp4xx/include/mach/gpio.h b/arch/arm/mach-ixp4xx/include/mach/gpio.h
index a5f87de..19009bf 100644
--- a/arch/arm/mach-ixp4xx/include/mach/gpio.h
+++ b/arch/arm/mach-ixp4xx/include/mach/gpio.h
@@ -70,6 +70,7 @@ static inline void gpio_set_value(unsigned gpio, int value)
 #include <asm-generic/gpio.h>			/* cansleep wrappers */
 
 extern int gpio_to_irq(int gpio);
+#define gpio_to_irq gpio_to_irq
 extern int irq_to_gpio(unsigned int irq);
 
 #endif
diff --git a/arch/arm/mach-ks8695/include/mach/gpio.h b/arch/arm/mach-ks8695/include/mach/gpio.h
index c13952c..59d6b53 100644
--- a/arch/arm/mach-ks8695/include/mach/gpio.h
+++ b/arch/arm/mach-ks8695/include/mach/gpio.h
@@ -40,8 +40,6 @@ extern int ks8695_gpio_interrupt(unsigned int pin, unsigned int type);
  */
 extern int irq_to_gpio(unsigned int irq);
 
-#define gpio_to_irq __gpio_to_irq
-
 #define __ARM_GPIOLIB_TRIVIAL
 
 /* Register the GPIOs */
diff --git a/arch/arm/mach-lpc32xx/include/mach/gpio.h b/arch/arm/mach-lpc32xx/include/mach/gpio.h
index 0ca6c27..b01cd24 100644
--- a/arch/arm/mach-lpc32xx/include/mach/gpio.h
+++ b/arch/arm/mach-lpc32xx/include/mach/gpio.h
@@ -51,9 +51,4 @@
 
 #define __ARM_GPIOLIB_TRIVIAL
 
-static inline int gpio_to_irq(unsigned gpio)
-{
-	return __gpio_to_irq(gpio);
-}
-
 #endif
diff --git a/arch/arm/mach-msm/include/mach/gpio.h b/arch/arm/mach-msm/include/mach/gpio.h
index bc75e20..10197a9 100644
--- a/arch/arm/mach-msm/include/mach/gpio.h
+++ b/arch/arm/mach-msm/include/mach/gpio.h
@@ -18,6 +18,4 @@
 
 #define __ARM_GPIOLIB_TRIVIAL
 
-#define gpio_to_irq     __gpio_to_irq
-
 #endif /* __ASM_ARCH_MSM_GPIO_H */
diff --git a/arch/arm/mach-mxs/include/mach/gpio.h b/arch/arm/mach-mxs/include/mach/gpio.h
index bb44c8d..bf28a1f 100644
--- a/arch/arm/mach-mxs/include/mach/gpio.h
+++ b/arch/arm/mach-mxs/include/mach/gpio.h
@@ -24,7 +24,6 @@
 
 /* use gpiolib dispatchers */
 #define __ARM_GPIOLIB_TRIVIAL
-#define gpio_to_irq		__gpio_to_irq
 
 #define irq_to_gpio(irq)	((irq) - MXS_GPIO_IRQ_START)
 
diff --git a/arch/arm/mach-realview/include/mach/gpio.h b/arch/arm/mach-realview/include/mach/gpio.h
index bd11dc5..910974b 100644
--- a/arch/arm/mach-realview/include/mach/gpio.h
+++ b/arch/arm/mach-realview/include/mach/gpio.h
@@ -1,2 +1 @@
 #define __ARM_GPIOLIB_TRIVIAL
-#define gpio_to_irq	__gpio_to_irq
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-s3c2410/include/mach/gpio.h
index 998ef4c..d502d17 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
@@ -12,7 +12,6 @@
 */
 
 #define __ARM_GPIOLIB_TRIVIAL
-#define gpio_to_irq	__gpio_to_irq
 
 /* some boards require extra gpio capacity to support external
  * devices that need GPIO.
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio.h b/arch/arm/mach-s3c64xx/include/mach/gpio.h
index 6958b3f..3a8857c 100644
--- a/arch/arm/mach-s3c64xx/include/mach/gpio.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio.h
@@ -13,7 +13,6 @@
 */
 
 #define __ARM_GPIOLIB_TRIVIAL
-#define gpio_to_irq	__gpio_to_irq
 
 /* GPIO bank sizes */
 #define S3C64XX_GPIO_A_NR	(8)
diff --git a/arch/arm/mach-s5p64x0/include/mach/gpio.h b/arch/arm/mach-s5p64x0/include/mach/gpio.h
index a25160b..c3a6aa0 100644
--- a/arch/arm/mach-s5p64x0/include/mach/gpio.h
+++ b/arch/arm/mach-s5p64x0/include/mach/gpio.h
@@ -14,7 +14,6 @@
 #define __ASM_ARCH_GPIO_H __FILE__
 
 #define __ARM_GPIOLIB_TRIVIAL
-#define gpio_to_irq	__gpio_to_irq
 
 /* GPIO bank sizes */
 
diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-s5pc100/include/mach/gpio.h
index f515bfb..0e75641 100644
--- a/arch/arm/mach-s5pc100/include/mach/gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
@@ -16,7 +16,6 @@
 #define __ASM_ARCH_GPIO_H __FILE__
 
 #define __ARM_GPIOLIB_TRIVIAL
-#define gpio_to_irq	__gpio_to_irq
 
 /* GPIO bank sizes */
 #define S5PC100_GPIO_A0_NR	(8)
diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-s5pv210/include/mach/gpio.h
index 27f2139..d348ee2 100644
--- a/arch/arm/mach-s5pv210/include/mach/gpio.h
+++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
@@ -14,7 +14,6 @@
 #define __ASM_ARCH_GPIO_H __FILE__
 
 #define __ARM_GPIOLIB_TRIVIAL
-#define gpio_to_irq	__gpio_to_irq
 
 /* Practically, GPIO banks up to MP03 are the configurable gpio banks */
 
diff --git a/arch/arm/mach-shmobile/include/mach/gpio.h b/arch/arm/mach-shmobile/include/mach/gpio.h
index e8feff0..95e11cf 100644
--- a/arch/arm/mach-shmobile/include/mach/gpio.h
+++ b/arch/arm/mach-shmobile/include/mach/gpio.h
@@ -20,11 +20,6 @@
 
 #define __ARM_GPIOLIB_TRIVIAL
 
-static inline int gpio_to_irq(unsigned gpio)
-{
-	return __gpio_to_irq(gpio);
-}
-
 static inline int irq_to_gpio(unsigned int irq)
 {
 	return -ENOSYS;
diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
index d51be09..5107223 100644
--- a/arch/arm/mach-tegra/include/mach/gpio.h
+++ b/arch/arm/mach-tegra/include/mach/gpio.h
@@ -36,6 +36,7 @@ static inline int gpio_to_irq(unsigned int gpio)
 		return INT_GPIO_BASE + gpio;
 	return -EINVAL;
 }
+#define gpio_to_irq gpio_to_irq
 
 static inline int irq_to_gpio(unsigned int irq)
 {
diff --git a/arch/arm/mach-u300/include/mach/gpio.h b/arch/arm/mach-u300/include/mach/gpio.h
index d5a71ab..3d7b7d1 100644
--- a/arch/arm/mach-u300/include/mach/gpio.h
+++ b/arch/arm/mach-u300/include/mach/gpio.h
@@ -281,6 +281,7 @@ static inline unsigned gpio_to_irq(unsigned gpio)
 {
 	return PIN_TO_PORT(gpio) + IRQ_U300_GPIO_PORT0;
 }
+#define gpio_to_irq gpio_to_irq
 
 static inline unsigned irq_to_gpio(unsigned irq)
 {
diff --git a/arch/arm/mach-versatile/include/mach/gpio.h b/arch/arm/mach-versatile/include/mach/gpio.h
index bd11dc5..910974b 100644
--- a/arch/arm/mach-versatile/include/mach/gpio.h
+++ b/arch/arm/mach-versatile/include/mach/gpio.h
@@ -1,2 +1 @@
 #define __ARM_GPIOLIB_TRIVIAL
-#define gpio_to_irq	__gpio_to_irq
diff --git a/arch/arm/mach-vt8500/include/mach/gpio.h b/arch/arm/mach-vt8500/include/mach/gpio.h
index bd11dc5..910974b 100644
--- a/arch/arm/mach-vt8500/include/mach/gpio.h
+++ b/arch/arm/mach-vt8500/include/mach/gpio.h
@@ -1,2 +1 @@
 #define __ARM_GPIOLIB_TRIVIAL
-#define gpio_to_irq	__gpio_to_irq
diff --git a/arch/arm/mach-w90x900/include/mach/gpio.h b/arch/arm/mach-w90x900/include/mach/gpio.h
index 60c7846..e7d4ed1 100644
--- a/arch/arm/mach-w90x900/include/mach/gpio.h
+++ b/arch/arm/mach-w90x900/include/mach/gpio.h
@@ -22,6 +22,7 @@ static inline int gpio_to_irq(unsigned gpio)
 {
 	return gpio;
 }
+#define gpio_to_irq gpio_to_irq
 
 static inline int irq_to_gpio(unsigned irq)
 {
diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
index 569b2c6..395156a 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -13,7 +13,6 @@
 #define __ASM_PLAT_GPIO_H
 
 #define __ARM_GPIOLIB_TRIVIAL
-#define gpio_to_irq     __gpio_to_irq
 
 /*
  * "nmk_gpio" and "NMK_GPIO" stand for "Nomadik GPIO", leaving
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 20eedbb..f1fdfa5 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -224,11 +224,6 @@ extern void omap_gpio_restore_context(void);
 
 #define __ARM_GPIOLIB_TRIVIAL
 
-static inline int gpio_to_irq(unsigned gpio)
-{
-	return __gpio_to_irq(gpio);
-}
-
 static inline int irq_to_gpio(unsigned irq)
 {
 	int tmp;
diff --git a/arch/arm/plat-orion/include/plat/gpio.h b/arch/arm/plat-orion/include/plat/gpio.h
index 71c4c6c..985c197 100644
--- a/arch/arm/plat-orion/include/plat/gpio.h
+++ b/arch/arm/plat-orion/include/plat/gpio.h
@@ -16,11 +16,6 @@
 #define __ARM_GPIOLIB_TRIVIAL
 
 /*
- * GENERIC_GPIO primitives.
- */
-#define gpio_to_irq     __gpio_to_irq
-
-/*
  * Orion-specific GPIO API extensions.
  */
 void orion_gpio_set_unused(unsigned pin);
diff --git a/arch/arm/plat-spear/include/plat/gpio.h b/arch/arm/plat-spear/include/plat/gpio.h
index 3c6f044..22d9e0f 100644
--- a/arch/arm/plat-spear/include/plat/gpio.h
+++ b/arch/arm/plat-spear/include/plat/gpio.h
@@ -15,6 +15,5 @@
 #define __PLAT_GPIO_H
 
 #define __ARM_GPIOLIB_TRIVIAL
-#define gpio_to_irq	__gpio_to_irq
 
 #endif /* __PLAT_GPIO_H */
-- 
1.7.4.4

