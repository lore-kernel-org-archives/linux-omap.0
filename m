From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 08/10] ARM: OMAP1: Get rid of <mach/ams-delta-fiq.h>
Date: Fri, 22 Jun 2018 00:41:26 +0200
Message-ID: <20180621224128.17623-8-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621224128.17623-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "David S . Miller " <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Split the header file into two parts and move them to directories where
they belong.

Information on internal structure of FIQ buffer is moved to
<linux/platform_data/ams-delta-fiq.h> for ams-delta-serio driver use.

Other information used by ams-delta board init file and FIQ code is
made local to mach-omap1 root directory.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: rebased on v4.18-rc1, no conflicts

 MAINTAINERS                                        |  1 +
 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |  5 +--
 arch/arm/mach-omap1/ams-delta-fiq.c                |  7 ++--
 arch/arm/mach-omap1/ams-delta-fiq.h                | 41 ++++++++++++++++++++++
 arch/arm/mach-omap1/board-ams-delta.c              |  2 +-
 drivers/input/serio/ams_delta_serio.c              |  3 +-
 .../linux/platform_data}/ams-delta-fiq.h           | 27 +++-----------
 7 files changed, 56 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/mach-omap1/ams-delta-fiq.h
 rename {arch/arm/mach-omap1/include/mach => include/linux/platform_data}/ams-delta-fiq.h (71%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..c78b7dc42a81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10391,6 +10391,7 @@ F:	arch/arm/plat-omap/
 F:	arch/arm/configs/omap1_defconfig
 F:	drivers/i2c/busses/i2c-omap.c
 F:	include/linux/platform_data/i2c-omap.h
+F:	include/linux/platform_data/ams-delta-fiq.h
 
 OMAP2+ SUPPORT
 M:	Tony Lindgren <tony@atomide.com>
diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index bf608441b357..ddc27638ba2a 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -14,11 +14,12 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/assembler.h>
+#include <linux/platform_data/ams-delta-fiq.h>
 
+#include <asm/assembler.h>
 #include <mach/board-ams-delta.h>
-#include <mach/ams-delta-fiq.h>
 
+#include "ams-delta-fiq.h"
 #include "iomap.h"
 #include "soc.h"
 
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index 5a6c59ac9b5f..e72935034d42 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -19,12 +19,13 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/platform_data/ams-delta-fiq.h>
 
 #include <mach/board-ams-delta.h>
 
 #include <asm/fiq.h>
 
-#include <mach/ams-delta-fiq.h>
+#include "ams-delta-fiq.h"
 
 static struct fiq_handler fh = {
 	.name	= "ams-delta-fiq"
@@ -35,8 +36,8 @@ static struct fiq_handler fh = {
  * The FIQ and IRQ isrs can both read and write it.
  * It is structured as a header section several 32bit slots,
  * followed by the circular buffer where the FIQ isr stores
- * keystrokes received from the qwerty keyboard.
- * See ams-delta-fiq.h for details of offsets.
+ * keystrokes received from the qwerty keyboard.  See
+ * <linux/platform_data/ams-delta-fiq.h> for details of offsets.
  */
 unsigned int fiq_buffer[1024];
 EXPORT_SYMBOL(fiq_buffer);
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.h b/arch/arm/mach-omap1/ams-delta-fiq.h
new file mode 100644
index 000000000000..3f691d68aa62
--- /dev/null
+++ b/arch/arm/mach-omap1/ams-delta-fiq.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * arch/arm/mach-omap1/ams-delta-fiq.h
+ *
+ * Taken from the original Amstrad modifications to fiq.h
+ *
+ * Copyright (c) 2004 Amstrad Plc
+ * Copyright (c) 2006 Matt Callow
+ * Copyright (c) 2010 Janusz Krzysztofik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __AMS_DELTA_FIQ_H
+#define __AMS_DELTA_FIQ_H
+
+#include <mach/irqs.h>
+
+/*
+ * Interrupt number used for passing control from FIQ to IRQ.
+ * IRQ12, described as reserved, has been selected.
+ */
+#define INT_DEFERRED_FIQ	INT_1510_RES12
+/*
+ * Base address of an interrupt handler that the INT_DEFERRED_FIQ belongs to.
+ */
+#if (INT_DEFERRED_FIQ < IH2_BASE)
+#define DEFERRED_FIQ_IH_BASE	OMAP_IH1_BASE
+#else
+#define DEFERRED_FIQ_IH_BASE	OMAP_IH2_BASE
+#endif
+
+#ifndef __ASSEMBLER__
+extern unsigned char qwerty_fiqin_start, qwerty_fiqin_end;
+
+extern void __init ams_delta_init_fiq(struct gpio_chip *chip);
+#endif
+
+#endif
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index f15c0793c34b..fe9a3e7cbfeb 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -41,10 +41,10 @@
 #include <mach/mux.h>
 
 #include <mach/hardware.h>
-#include <mach/ams-delta-fiq.h>
 #include "camera.h"
 #include <mach/usb.h>
 
+#include "ams-delta-fiq.h"
 #include "iomap.h"
 #include "common.h"
 
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 7952a29f9540..2602f7cff5ae 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -22,6 +22,7 @@
  */
 #include <linux/gpio.h>
 #include <linux/irq.h>
+#include <linux/platform_data/ams-delta-fiq.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/serio.h>
@@ -30,8 +31,6 @@
 
 #include <mach/board-ams-delta.h>
 
-#include <mach/ams-delta-fiq.h>
-
 #define DRIVER_NAME	"ams-delta-serio"
 
 MODULE_AUTHOR("Matt Callow");
diff --git a/arch/arm/mach-omap1/include/mach/ams-delta-fiq.h b/include/linux/platform_data/ams-delta-fiq.h
similarity index 71%
rename from arch/arm/mach-omap1/include/mach/ams-delta-fiq.h
rename to include/linux/platform_data/ams-delta-fiq.h
index a9769ff396bc..dc0f835ea918 100644
--- a/arch/arm/mach-omap1/include/mach/ams-delta-fiq.h
+++ b/include/linux/platform_data/ams-delta-fiq.h
@@ -1,5 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
- * arch/arm/mach-omap1/include/ams-delta-fiq.h
+ * include/linux/platform_data/ams-delta-fiq.h
  *
  * Taken from the original Amstrad modifications to fiq.h
  *
@@ -11,24 +13,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef __AMS_DELTA_FIQ_H
-#define __AMS_DELTA_FIQ_H
-
-#include <mach/irqs.h>
-
-/*
- * Interrupt number used for passing control from FIQ to IRQ.
- * IRQ12, described as reserved, has been selected.
- */
-#define INT_DEFERRED_FIQ	INT_1510_RES12
-/*
- * Base address of an interrupt handler that the INT_DEFERRED_FIQ belongs to.
- */
-#if (INT_DEFERRED_FIQ < IH2_BASE)
-#define DEFERRED_FIQ_IH_BASE	OMAP_IH1_BASE
-#else
-#define DEFERRED_FIQ_IH_BASE	OMAP_IH2_BASE
-#endif
+#ifndef __LINUX_PLATFORM_DATA_AMS_DELTA_FIQ_H
+#define __LINUX_PLATFORM_DATA_AMS_DELTA_FIQ_H
 
 /*
  * These are the offsets from the beginning of the fiq_buffer. They are put here
@@ -71,9 +57,6 @@
 
 #ifndef __ASSEMBLER__
 extern unsigned int fiq_buffer[];
-extern unsigned char qwerty_fiqin_start, qwerty_fiqin_end;
-
-extern void __init ams_delta_init_fiq(struct gpio_chip *chip);
 #endif
 
 #endif
-- 
2.16.4
