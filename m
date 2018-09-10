From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta-fiq: Use <linux/platform_data/gpio-omap.h>
Date: Mon, 10 Sep 2018 19:47:22 +0200
Message-ID: <20180910174722.15679-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Instead of defining symbols already defined in
linux/platform_data/gpio-omap.h, use that header file.

Since we include the header into an assembler code, prevent C only bits
from being read in.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/ams-delta-fiq-handler.S | 12 +++---------
 include/linux/platform_data/gpio-omap.h     |  4 ++++
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index 2e2a17364dc9..7c9fb7fe0070 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -15,6 +15,7 @@
 
 #include <linux/linkage.h>
 #include <linux/platform_data/ams-delta-fiq.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <asm/assembler.h>
 
@@ -24,17 +25,10 @@
 #include "soc.h"
 
 /*
- * GPIO related definitions, copied from arch/arm/plat-omap/gpio.c.
- * Unfortunately, those were not placed in a separate header file.
+ * OMAP1510 GPIO related symbol copied from arch/arm/mach-omap1/gpio15xx.c.
+ * Unfortunately, it was not placed in a separate header file.
  */
 #define OMAP1510_GPIO_BASE		0xFFFCE000
-#define OMAP1510_GPIO_DATA_INPUT	0x00
-#define OMAP1510_GPIO_DATA_OUTPUT	0x04
-#define OMAP1510_GPIO_DIR_CONTROL	0x08
-#define OMAP1510_GPIO_INT_CONTROL	0x0c
-#define OMAP1510_GPIO_INT_MASK		0x10
-#define OMAP1510_GPIO_INT_STATUS	0x14
-#define OMAP1510_GPIO_PIN_CONTROL	0x18
 
 /* GPIO register bitmasks */
 #define KEYBRD_DATA_MASK		(0x1 << AMS_DELTA_GPIO_PIN_KEYBRD_DATA)
diff --git a/include/linux/platform_data/gpio-omap.h b/include/linux/platform_data/gpio-omap.h
index 8612855691b2..ed071f76b642 100644
--- a/include/linux/platform_data/gpio-omap.h
+++ b/include/linux/platform_data/gpio-omap.h
@@ -24,8 +24,10 @@
 #ifndef __ASM_ARCH_OMAP_GPIO_H
 #define __ASM_ARCH_OMAP_GPIO_H
 
+#ifndef __ASSEMBLER__
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#endif
 
 #define OMAP1_MPUIO_BASE			0xfffb5000
 
@@ -157,6 +159,7 @@
 #define OMAP_MPUIO(nr)		(OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr)	((nr) >= OMAP_MAX_GPIO_LINES)
 
+#ifndef __ASSEMBLER__
 struct omap_gpio_reg_offs {
 	u16 revision;
 	u16 direction;
@@ -215,5 +218,6 @@ static inline void omap2_gpio_resume_after_idle(void)
 {
 }
 #endif
+#endif /* __ASSEMBLER__ */
 
 #endif
-- 
2.16.4
