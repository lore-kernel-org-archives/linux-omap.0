From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH] ARM: OMAP: Clean up header file duplication
Date: Mon, 15 Sep 2008 06:02:13 +0300
Message-ID: <1221447733-2596-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53255 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYIODCm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Sep 2008 23:02:42 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8F32bU0009872
	for <linux-omap@vger.kernel.org>; Mon, 15 Sep 2008 06:02:39 +0300
Received: from oreo.research.nokia.com (esdhcp04066.research.nokia.com [172.21.40.66])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8F32DIO003223
	for <linux-omap@vger.kernel.org>; Mon, 15 Sep 2008 06:02:14 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap1/board-h2-mmc.c     |    1 -
 arch/arm/mach-omap1/board-h3-mmc.c     |    1 -
 arch/arm/mach-omap1/board-h3.c         |    1 -
 arch/arm/mach-omap2/board-h4.c         |    1 -
 arch/arm/mach-omap2/board-n800-mmc.c   |    1 -
 arch/arm/mach-omap2/board-omap3evm.c   |    2 --
 drivers/input/keyboard/innovator_ps2.c |    1 -
 drivers/mtd/nand/omap-hw.c             |    1 -
 drivers/mtd/nand/omap-nand-flash.c     |    2 --
 drivers/mtd/onenand/omap2.c            |    1 -
 sound/oss/omap-audio-tsc2101.c         |    1 -
 11 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index 37031e0..d2cddf1 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -14,7 +14,6 @@
 
 #include <mach/mmc.h>
 #include <mach/gpio.h>
-#include <mach/mmc.h>
 
 #ifdef CONFIG_MMC_OMAP
 static int slot_cover_open;
diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index 44e9d53..541fa6e 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -14,7 +14,6 @@
 
 #include <mach/mmc.h>
 #include <mach/gpio.h>
-#include <mach/mmc.h>
 
 #ifdef CONFIG_MMC_OMAP
 static int slot_cover_open;
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 0c1b001..eaba9f3 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -28,7 +28,6 @@
 #include <linux/input.h>
 #include <linux/i2c/tps65010.h>
 #include <linux/clk.h>
-#include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc210x.h>
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index c65358b..733e134 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -18,7 +18,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
-#include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/err.h>
 #include <linux/clk.h>
diff --git a/arch/arm/mach-omap2/board-n800-mmc.c b/arch/arm/mach-omap2/board-n800-mmc.c
index bcbba94..b8aa7a3 100644
--- a/arch/arm/mach-omap2/board-n800-mmc.c
+++ b/arch/arm/mach-omap2/board-n800-mmc.c
@@ -17,7 +17,6 @@
 
 #include <mach/mmc.h>
 #include <mach/gpio.h>
-#include <mach/mmc.h>
 
 #ifdef CONFIG_MMC_OMAP
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 92f70ce..dbbf1db 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -27,8 +27,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <linux/io.h>
-#include <linux/delay.h>
 
 #include <mach/gpio.h>
 #include <mach/keypad.h>
diff --git a/drivers/input/keyboard/innovator_ps2.c b/drivers/input/keyboard/innovator_ps2.c
index b3c4a06..5f88839 100644
--- a/drivers/input/keyboard/innovator_ps2.c
+++ b/drivers/input/keyboard/innovator_ps2.c
@@ -82,7 +82,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/delay.h>
-#include <linux/types.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
diff --git a/drivers/mtd/nand/omap-hw.c b/drivers/mtd/nand/omap-hw.c
index 1eb19ce..7eb9894 100644
--- a/drivers/mtd/nand/omap-hw.c
+++ b/drivers/mtd/nand/omap-hw.c
@@ -27,7 +27,6 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/types.h>
diff --git a/drivers/mtd/nand/omap-nand-flash.c b/drivers/mtd/nand/omap-nand-flash.c
index 63a7968..6b8fb44 100644
--- a/drivers/mtd/nand/omap-nand-flash.c
+++ b/drivers/mtd/nand/omap-nand-flash.c
@@ -26,8 +26,6 @@
 #include <asm/mach/flash.h>
 #include <mach/tc.h>
 
-#include <asm/io.h>
-#include <mach/hardware.h>
 #include <mach/nand.h>
 
 #define	DRIVER_NAME	"omapnand"
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 24dd54f..a9885d1 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -38,7 +38,6 @@
 #include <mach/gpmc.h>
 #include <mach/onenand.h>
 #include <mach/gpio.h>
-#include <mach/gpmc.h>
 #include <mach/pm.h>
 
 #include <linux/dma-mapping.h>
diff --git a/sound/oss/omap-audio-tsc2101.c b/sound/oss/omap-audio-tsc2101.c
index 9cbb0e8..4931ecf 100644
--- a/sound/oss/omap-audio-tsc2101.c
+++ b/sound/oss/omap-audio-tsc2101.c
@@ -39,7 +39,6 @@
 #include <mach/hardware.h>
 #include <mach/dma.h>
 #include <asm/io.h>
-#include <mach/hardware.h>
 
 #include <mach/mux.h>
 #include <mach/io.h>
-- 
1.5.5.1.357.g1af8b

