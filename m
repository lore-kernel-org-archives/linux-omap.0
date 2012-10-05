From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 07/15] ARM: OMAP2+: onenand: header cleanup
Date: Fri, 5 Oct 2012 21:24:06 +0530
Message-ID: <4a5b5b27c74ef2a18dfcea7102104924812946b3.1349450454.git.afzal@ti.com>
References: <cover.1349450454.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41210 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843Ab2JEPyR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 11:54:17 -0400
In-Reply-To: <cover.1349450454.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

For common arm zImage existing onenand header file
in platform specific location was moved to generic
platform data location, but it contained more than
platform data, remove it. New local header has been
created for exposing functions.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-flash.c               |  1 +
 arch/arm/mach-omap2/board-igep0020.c            |  1 +
 arch/arm/mach-omap2/board-n8x0.c                |  1 +
 arch/arm/mach-omap2/board-rm680.c               |  1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c    |  1 +
 arch/arm/mach-omap2/gpmc-onenand.c              |  1 +
 arch/arm/mach-omap2/gpmc-onenand.h              | 24 ++++++++++++++++++++++++
 include/linux/platform_data/mtd-onenand-omap2.h | 19 +++----------------
 8 files changed, 33 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpmc-onenand.h

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index f8b30cb..de68fdf 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -25,6 +25,7 @@
 
 #include "common.h"
 #include "board-flash.h"
+#include "gpmc-onenand.h"
 
 #define REG_FPGA_REV			0x10
 #define REG_FPGA_DIP_SWITCH_INPUT2	0x60
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index f6b3ed0..83c6efa 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -43,6 +43,7 @@
 #include "common-board-devices.h"
 #include "board-flash.h"
 #include "control.h"
+#include "gpmc-onenand.h"
 
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index d95f727..92b1916 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -32,6 +32,7 @@
 #include <plat/mmc.h>
 
 #include "mux.h"
+#include "gpmc-onenand.h"
 
 #define TUSB6010_ASYNC_CS	1
 #define TUSB6010_SYNC_CS	4
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 45997bf..154cf33 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -33,6 +33,7 @@
 #include "hsmmc.h"
 #include "sdram-nokia.h"
 #include "common-board-devices.h"
+#include "gpmc-onenand.h"
 
 static struct regulator_consumer_supply rm680_vemmc_consumers[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1"),
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ed85fb8..aa6a2a4 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -54,6 +54,7 @@
 #include "mux.h"
 #include "hsmmc.h"
 #include "common-board-devices.h"
+#include "gpmc-onenand.h"
 
 #define SYSTEM_REV_B_USES_VAUX3	0x1699
 #define SYSTEM_REV_S_USES_VAUX3 0x8
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index f0b677a..29671cc 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -23,6 +23,7 @@
 #include <plat/gpmc.h>
 
 #include "soc.h"
+#include "gpmc-onenand.h"
 
 #define	ONENAND_IO_SIZE	SZ_128K
 
diff --git a/arch/arm/mach-omap2/gpmc-onenand.h b/arch/arm/mach-omap2/gpmc-onenand.h
new file mode 100644
index 0000000..216f23a
--- /dev/null
+++ b/arch/arm/mach-omap2/gpmc-onenand.h
@@ -0,0 +1,24 @@
+/*
+ *  arch/arm/mach-omap2/gpmc-onenand.h
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef	__OMAP2_GPMC_ONENAND_H
+#define	__OMAP2_GPMC_ONENAND_H
+
+#include <linux/platform_data/mtd-onenand-omap2.h>
+
+#if IS_ENABLED(CONFIG_MTD_ONENAND_OMAP2)
+extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
+#else
+#define board_onenand_data	NULL
+static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
+{
+}
+#endif
+
+#endif
diff --git a/include/linux/platform_data/mtd-onenand-omap2.h b/include/linux/platform_data/mtd-onenand-omap2.h
index ef9c60d..685af7e 100644
--- a/include/linux/platform_data/mtd-onenand-omap2.h
+++ b/include/linux/platform_data/mtd-onenand-omap2.h
@@ -9,6 +9,9 @@
  * published by the Free Software Foundation.
  */
 
+#ifndef	__MTD_ONENAND_OMAP2_H
+#define	__MTD_ONENAND_OMAP2_H
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
@@ -27,20 +30,4 @@ struct omap_onenand_platform_data {
 	u8			regulator_can_sleep;
 	u8			skip_initial_unlocking;
 };
-
-#define ONENAND_MAX_PARTITIONS 8
-
-#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
-	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
-
-extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
-
-#else
-
-#define board_onenand_data	NULL
-
-static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
-{
-}
-
 #endif
-- 
1.7.12

