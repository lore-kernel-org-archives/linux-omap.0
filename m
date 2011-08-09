From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 13/13] ARM: gpio: make trivial GPIOLIB implementation the
 default
Date: Tue, 09 Aug 2011 09:08:42 +0100
Message-ID: <E1QqhMg-0003an-GW@rmk-PC.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41976 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab1HIIIx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 04:08:53 -0400
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>Grant Likely <grant.likely@secretlab.ca>Nicolas Pitre <nico@fluxnic.net>

Rather than marking the mach/gpio.h header files which want to use the
trivial GPIOLIB implementation, mark those which do not want to use it
instead.  This means that by default, you get the trivial implementation
and only have to do something extra if you need to.  This should
encourage the use of the trivial default implementation.

As an additional bonus, several gpio.h header files become empty.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/gpio.h                 |    2 +-
 arch/arm/include/asm/hardware/iop3xx-gpio.h |    2 ++
 arch/arm/mach-at91/include/mach/gpio.h      |    2 --
 arch/arm/mach-davinci/include/mach/gpio.h   |    2 ++
 arch/arm/mach-ep93xx/include/mach/gpio.h    |    3 ---
 arch/arm/mach-exynos4/include/mach/gpio.h   |    2 --
 arch/arm/mach-gemini/include/mach/gpio.h    |    2 --
 arch/arm/mach-ixp4xx/include/mach/gpio.h    |    2 ++
 arch/arm/mach-ks8695/include/mach/gpio.h    |    2 --
 arch/arm/mach-lpc32xx/include/mach/gpio.h   |    2 --
 arch/arm/mach-msm/include/mach/gpio.h       |   22 +---------------------
 arch/arm/mach-mxs/include/mach/gpio.h       |    3 ---
 arch/arm/mach-realview/include/mach/gpio.h  |    2 +-
 arch/arm/mach-s3c2410/include/mach/gpio.h   |    2 --
 arch/arm/mach-s3c64xx/include/mach/gpio.h   |    2 --
 arch/arm/mach-s5p64x0/include/mach/gpio.h   |    2 --
 arch/arm/mach-s5pc100/include/mach/gpio.h   |    2 --
 arch/arm/mach-s5pv210/include/mach/gpio.h   |    2 --
 arch/arm/mach-sa1100/include/mach/gpio.h    |    2 ++
 arch/arm/mach-shmobile/include/mach/gpio.h  |    6 ++++--
 arch/arm/mach-tegra/include/mach/gpio.h     |    2 --
 arch/arm/mach-u300/include/mach/gpio.h      |    2 ++
 arch/arm/mach-versatile/include/mach/gpio.h |    2 +-
 arch/arm/mach-vt8500/include/mach/gpio.h    |    2 +-
 arch/arm/mach-w90x900/include/mach/gpio.h   |    2 --
 arch/arm/plat-mxc/include/mach/gpio.h       |    3 ---
 arch/arm/plat-nomadik/include/plat/gpio.h   |    2 --
 arch/arm/plat-omap/include/plat/gpio.h      |    2 --
 arch/arm/plat-orion/include/plat/gpio.h     |    2 --
 arch/arm/plat-pxa/include/plat/gpio.h       |    2 ++
 arch/arm/plat-spear/include/plat/gpio.h     |   20 +-------------------
 31 files changed, 22 insertions(+), 85 deletions(-)

diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
index 5032224..11ad0bf 100644
--- a/arch/arm/include/asm/gpio.h
+++ b/arch/arm/include/asm/gpio.h
@@ -4,7 +4,7 @@
 /* not all ARM platforms necessarily support this API ... */
 #include <mach/gpio.h>
 
-#ifdef __ARM_GPIOLIB_TRIVIAL
+#ifndef __ARM_GPIOLIB_COMPLEX
 /* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
 #include <asm-generic/gpio.h>
 
diff --git a/arch/arm/include/asm/hardware/iop3xx-gpio.h b/arch/arm/include/asm/hardware/iop3xx-gpio.h
index b69d972..9eda7dc 100644
--- a/arch/arm/include/asm/hardware/iop3xx-gpio.h
+++ b/arch/arm/include/asm/hardware/iop3xx-gpio.h
@@ -28,6 +28,8 @@
 #include <mach/hardware.h>
 #include <asm-generic/gpio.h>
 
+#define __ARM_GPIOLIB_COMPLEX
+
 #define IOP3XX_N_GPIOS	8
 
 static inline int gpio_get_value(unsigned gpio)
diff --git a/arch/arm/mach-at91/include/mach/gpio.h b/arch/arm/mach-at91/include/mach/gpio.h
index 6ddc1a6..2b9a1f5 100644
--- a/arch/arm/mach-at91/include/mach/gpio.h
+++ b/arch/arm/mach-at91/include/mach/gpio.h
@@ -215,8 +215,6 @@ extern void at91_gpio_resume(void);
 
 #include <asm/errno.h>
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 #define gpio_to_irq(gpio) (gpio)
 #define irq_to_gpio(irq)  (irq)
 
diff --git a/arch/arm/mach-davinci/include/mach/gpio.h b/arch/arm/mach-davinci/include/mach/gpio.h
index 73fc7a0..14e7bb20 100644
--- a/arch/arm/mach-davinci/include/mach/gpio.h
+++ b/arch/arm/mach-davinci/include/mach/gpio.h
@@ -21,6 +21,8 @@
 #include <mach/irqs.h>
 #include <mach/common.h>
 
+#define __ARM_GPIOLIB_COMPLEX
+
 #define DAVINCI_GPIO_BASE 0x01C67000
 
 enum davinci_gpio_type {
diff --git a/arch/arm/mach-ep93xx/include/mach/gpio.h b/arch/arm/mach-ep93xx/include/mach/gpio.h
index fbc770e..071f676 100644
--- a/arch/arm/mach-ep93xx/include/mach/gpio.h
+++ b/arch/arm/mach-ep93xx/include/mach/gpio.h
@@ -99,9 +99,6 @@
 /* maximum value for irq capable line identifiers */
 #define EP93XX_GPIO_LINE_MAX_IRQ	EP93XX_GPIO_LINE_F(7)
 
-/* new generic GPIO API - see Documentation/gpio.txt */
-#define __ARM_GPIOLIB_TRIVIAL
-
 /*
  * Map GPIO A0..A7  (0..7)  to irq 64..71,
  *          B0..B7  (7..15) to irq 72..79, and
diff --git a/arch/arm/mach-exynos4/include/mach/gpio.h b/arch/arm/mach-exynos4/include/mach/gpio.h
index b91e8b2..80523ca 100644
--- a/arch/arm/mach-exynos4/include/mach/gpio.h
+++ b/arch/arm/mach-exynos4/include/mach/gpio.h
@@ -146,6 +146,4 @@ enum s5p_gpio_number {
 #define ARCH_NR_GPIOS		(EXYNOS4_GPZ(EXYNOS4_GPIO_Z_NR) +	\
 				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-gemini/include/mach/gpio.h b/arch/arm/mach-gemini/include/mach/gpio.h
index 20c0a36..40a0527 100644
--- a/arch/arm/mach-gemini/include/mach/gpio.h
+++ b/arch/arm/mach-gemini/include/mach/gpio.h
@@ -14,8 +14,6 @@
 
 #include <mach/irqs.h>
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 #define gpio_to_irq(x)	((x) + GPIO_IRQ_BASE)
 #define irq_to_gpio(x)	((x) - GPIO_IRQ_BASE)
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/gpio.h b/arch/arm/mach-ixp4xx/include/mach/gpio.h
index 19009bf..83d6b4e 100644
--- a/arch/arm/mach-ixp4xx/include/mach/gpio.h
+++ b/arch/arm/mach-ixp4xx/include/mach/gpio.h
@@ -28,6 +28,8 @@
 #include <linux/kernel.h>
 #include <mach/hardware.h>
 
+#define __ARM_GPIOLIB_COMPLEX
+
 static inline int gpio_request(unsigned gpio, const char *label)
 {
 	return 0;
diff --git a/arch/arm/mach-ks8695/include/mach/gpio.h b/arch/arm/mach-ks8695/include/mach/gpio.h
index 59d6b53..994267b 100644
--- a/arch/arm/mach-ks8695/include/mach/gpio.h
+++ b/arch/arm/mach-ks8695/include/mach/gpio.h
@@ -40,8 +40,6 @@ extern int ks8695_gpio_interrupt(unsigned int pin, unsigned int type);
  */
 extern int irq_to_gpio(unsigned int irq);
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 /* Register the GPIOs */
 extern void ks8695_register_gpios(void);
 
diff --git a/arch/arm/mach-lpc32xx/include/mach/gpio.h b/arch/arm/mach-lpc32xx/include/mach/gpio.h
index b01cd24..66d31f6 100644
--- a/arch/arm/mach-lpc32xx/include/mach/gpio.h
+++ b/arch/arm/mach-lpc32xx/include/mach/gpio.h
@@ -49,6 +49,4 @@
  */
 #define LPC32XX_GPIO(x, y) ((x) + (y))
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 #endif
diff --git a/arch/arm/mach-msm/include/mach/gpio.h b/arch/arm/mach-msm/include/mach/gpio.h
index 10197a9..40a8c17 100644
--- a/arch/arm/mach-msm/include/mach/gpio.h
+++ b/arch/arm/mach-msm/include/mach/gpio.h
@@ -1,21 +1 @@
-/*
- * Copyright (C) 2007 Google, Inc.
- * Copyright (c) 2009-2010, Code Aurora Forum. All rights reserved.
- * Author: Mike Lockwood <lockwood@android.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-#ifndef __ASM_ARCH_MSM_GPIO_H
-#define __ASM_ARCH_MSM_GPIO_H
-
-#define __ARM_GPIOLIB_TRIVIAL
-
-#endif /* __ASM_ARCH_MSM_GPIO_H */
+/* empty */
diff --git a/arch/arm/mach-mxs/include/mach/gpio.h b/arch/arm/mach-mxs/include/mach/gpio.h
index bf28a1f..bb11e63 100644
--- a/arch/arm/mach-mxs/include/mach/gpio.h
+++ b/arch/arm/mach-mxs/include/mach/gpio.h
@@ -22,9 +22,6 @@
 
 #define MXS_GPIO_NR(bank, nr)	((bank) * 32 + (nr))
 
-/* use gpiolib dispatchers */
-#define __ARM_GPIOLIB_TRIVIAL
-
 #define irq_to_gpio(irq)	((irq) - MXS_GPIO_IRQ_START)
 
 #endif /* __MACH_MXS_GPIO_H__ */
diff --git a/arch/arm/mach-realview/include/mach/gpio.h b/arch/arm/mach-realview/include/mach/gpio.h
index 910974b..40a8c17 100644
--- a/arch/arm/mach-realview/include/mach/gpio.h
+++ b/arch/arm/mach-realview/include/mach/gpio.h
@@ -1 +1 @@
-#define __ARM_GPIOLIB_TRIVIAL
+/* empty */
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-s3c2410/include/mach/gpio.h
index d502d17..6fac70f 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
@@ -11,8 +11,6 @@
  * published by the Free Software Foundation.
 */
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 /* some boards require extra gpio capacity to support external
  * devices that need GPIO.
  */
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio.h b/arch/arm/mach-s3c64xx/include/mach/gpio.h
index 3a8857c..6e34c2f 100644
--- a/arch/arm/mach-s3c64xx/include/mach/gpio.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio.h
@@ -12,8 +12,6 @@
  * published by the Free Software Foundation.
 */
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 /* GPIO bank sizes */
 #define S3C64XX_GPIO_A_NR	(8)
 #define S3C64XX_GPIO_B_NR	(7)
diff --git a/arch/arm/mach-s5p64x0/include/mach/gpio.h b/arch/arm/mach-s5p64x0/include/mach/gpio.h
index c3a6aa0..06cd3c9 100644
--- a/arch/arm/mach-s5p64x0/include/mach/gpio.h
+++ b/arch/arm/mach-s5p64x0/include/mach/gpio.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H __FILE__
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 /* GPIO bank sizes */
 
 #define S5P6440_GPIO_A_NR	(6)
diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-s5pc100/include/mach/gpio.h
index 0e75641..5e1a924 100644
--- a/arch/arm/mach-s5pc100/include/mach/gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
@@ -15,8 +15,6 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H __FILE__
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 /* GPIO bank sizes */
 #define S5PC100_GPIO_A0_NR	(8)
 #define S5PC100_GPIO_A1_NR	(5)
diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-s5pv210/include/mach/gpio.h
index d348ee2..6c8b903 100644
--- a/arch/arm/mach-s5pv210/include/mach/gpio.h
+++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H __FILE__
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 /* Practically, GPIO banks up to MP03 are the configurable gpio banks */
 
 /* GPIO bank sizes */
diff --git a/arch/arm/mach-sa1100/include/mach/gpio.h b/arch/arm/mach-sa1100/include/mach/gpio.h
index 7befc10..ab45b43 100644
--- a/arch/arm/mach-sa1100/include/mach/gpio.h
+++ b/arch/arm/mach-sa1100/include/mach/gpio.h
@@ -28,6 +28,8 @@
 #include <asm/irq.h>
 #include <asm-generic/gpio.h>
 
+#define __ARM_GPIOLIB_COMPLEX
+
 static inline int gpio_get_value(unsigned gpio)
 {
 	if (__builtin_constant_p(gpio) && (gpio <= GPIO_MAX))
diff --git a/arch/arm/mach-shmobile/include/mach/gpio.h b/arch/arm/mach-shmobile/include/mach/gpio.h
index 95e11cf..7bf0890 100644
--- a/arch/arm/mach-shmobile/include/mach/gpio.h
+++ b/arch/arm/mach-shmobile/include/mach/gpio.h
@@ -18,13 +18,15 @@
 
 #ifdef CONFIG_GPIOLIB
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 static inline int irq_to_gpio(unsigned int irq)
 {
 	return -ENOSYS;
 }
 
+#else
+
+#define __ARM_GPIOLIB_COMPLEX
+
 #endif /* CONFIG_GPIOLIB */
 
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
index 5107223..e353805 100644
--- a/arch/arm/mach-tegra/include/mach/gpio.h
+++ b/arch/arm/mach-tegra/include/mach/gpio.h
@@ -25,8 +25,6 @@
 
 #define TEGRA_NR_GPIOS		INT_GPIO_NR
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 #define TEGRA_GPIO_TO_IRQ(gpio) (INT_GPIO_BASE + (gpio))
 #define TEGRA_IRQ_TO_GPIO(irq) ((irq) - INT_GPIO_BASE)
 
diff --git a/arch/arm/mach-u300/include/mach/gpio.h b/arch/arm/mach-u300/include/mach/gpio.h
index 3d7b7d1..9a890e2 100644
--- a/arch/arm/mach-u300/include/mach/gpio.h
+++ b/arch/arm/mach-u300/include/mach/gpio.h
@@ -18,6 +18,8 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 
+#define __ARM_GPIOLIB_COMPLEX
+
 /* Switch type depending on platform/chip variant */
 #if defined(CONFIG_MACH_U300_BS2X) || defined(CONFIG_MACH_U300_BS330)
 #define U300_COH901335
diff --git a/arch/arm/mach-versatile/include/mach/gpio.h b/arch/arm/mach-versatile/include/mach/gpio.h
index 910974b..40a8c17 100644
--- a/arch/arm/mach-versatile/include/mach/gpio.h
+++ b/arch/arm/mach-versatile/include/mach/gpio.h
@@ -1 +1 @@
-#define __ARM_GPIOLIB_TRIVIAL
+/* empty */
diff --git a/arch/arm/mach-vt8500/include/mach/gpio.h b/arch/arm/mach-vt8500/include/mach/gpio.h
index 910974b..40a8c17 100644
--- a/arch/arm/mach-vt8500/include/mach/gpio.h
+++ b/arch/arm/mach-vt8500/include/mach/gpio.h
@@ -1 +1 @@
-#define __ARM_GPIOLIB_TRIVIAL
+/* empty */
diff --git a/arch/arm/mach-w90x900/include/mach/gpio.h b/arch/arm/mach-w90x900/include/mach/gpio.h
index e7d4ed1..5385a42 100644
--- a/arch/arm/mach-w90x900/include/mach/gpio.h
+++ b/arch/arm/mach-w90x900/include/mach/gpio.h
@@ -16,8 +16,6 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 static inline int gpio_to_irq(unsigned gpio)
 {
 	return gpio;
diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 4398edd..3e1ffc8 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -27,9 +27,6 @@
 /* range e.g. GPIO_1_5 is gpio 5 under linux */
 #define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
 
-/* use gpiolib dispatchers */
-#define __ARM_GPIOLIB_TRIVIAL
-
 #define gpio_to_irq(gpio)	(MXC_GPIO_IRQ_START + (gpio))
 #define irq_to_gpio(irq)	((irq) - MXC_GPIO_IRQ_START)
 
diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
index 395156a..cf0b78b 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -12,8 +12,6 @@
 #ifndef __ASM_PLAT_GPIO_H
 #define __ASM_PLAT_GPIO_H
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 /*
  * "nmk_gpio" and "NMK_GPIO" stand for "Nomadik GPIO", leaving
  * the "gpio" namespace for generic and cross-machine functions
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index f1fdfa5..9e86ee0 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -222,8 +222,6 @@ extern void omap_gpio_restore_context(void);
 #include <linux/errno.h>
 #include <asm-generic/gpio.h>
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 static inline int irq_to_gpio(unsigned irq)
 {
 	int tmp;
diff --git a/arch/arm/plat-orion/include/plat/gpio.h b/arch/arm/plat-orion/include/plat/gpio.h
index 985c197..f7d7630 100644
--- a/arch/arm/plat-orion/include/plat/gpio.h
+++ b/arch/arm/plat-orion/include/plat/gpio.h
@@ -13,8 +13,6 @@
 
 #include <linux/init.h>
 
-#define __ARM_GPIOLIB_TRIVIAL
-
 /*
  * Orion-specific GPIO API extensions.
  */
diff --git a/arch/arm/plat-pxa/include/plat/gpio.h b/arch/arm/plat-pxa/include/plat/gpio.h
index 1ddd2b9..6fc41db 100644
--- a/arch/arm/plat-pxa/include/plat/gpio.h
+++ b/arch/arm/plat-pxa/include/plat/gpio.h
@@ -1,6 +1,8 @@
 #ifndef __PLAT_GPIO_H
 #define __PLAT_GPIO_H
 
+#define __ARM_GPIOLIB_COMPLEX
+
 struct irq_data;
 
 /*
diff --git a/arch/arm/plat-spear/include/plat/gpio.h b/arch/arm/plat-spear/include/plat/gpio.h
index 22d9e0f..40a8c17 100644
--- a/arch/arm/plat-spear/include/plat/gpio.h
+++ b/arch/arm/plat-spear/include/plat/gpio.h
@@ -1,19 +1 @@
-/*
- * arch/arm/plat-spear/include/plat/gpio.h
- *
- * GPIO macros for SPEAr platform
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __PLAT_GPIO_H
-#define __PLAT_GPIO_H
-
-#define __ARM_GPIOLIB_TRIVIAL
-
-#endif /* __PLAT_GPIO_H */
+/* empty */
-- 
1.7.4.4

