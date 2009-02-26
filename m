From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/13] ARM: OMAP: No need to include board-palm*.h from
	hardware.h
Date: Thu, 26 Feb 2009 15:59:58 -0800
Message-ID: <20090226235958.20192.70110.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54005 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbZB0AAD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 19:00:03 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Move the defines to the associated board file and remove
the now unnecessary header files.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-palmte.c              |   15 +++++++++++
 arch/arm/mach-omap1/board-palmtt.c              |    7 +++++
 arch/arm/mach-omap1/board-palmz71.c             |   10 +++++++
 arch/arm/mach-omap1/board-sx1-mmc.c             |    1 +
 arch/arm/mach-omap1/board-sx1.c                 |    1 +
 arch/arm/plat-omap/include/mach/board-palmte.h  |   32 -----------------------
 arch/arm/plat-omap/include/mach/board-palmtt.h  |   23 -----------------
 arch/arm/plat-omap/include/mach/board-palmz71.h |   26 -------------------
 arch/arm/plat-omap/include/mach/hardware.h      |   12 ---------
 9 files changed, 34 insertions(+), 93 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/board-palmte.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-palmtt.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-palmz71.h

diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 99f2b43..55d524b 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -43,6 +43,21 @@
 #include <mach/keypad.h>
 #include <mach/common.h>
 
+#define PALMTE_USBDETECT_GPIO	0
+#define PALMTE_USB_OR_DC_GPIO	1
+#define PALMTE_TSC_GPIO		4
+#define PALMTE_PINTDAV_GPIO	6
+#define PALMTE_MMC_WP_GPIO	8
+#define PALMTE_MMC_POWER_GPIO	9
+#define PALMTE_HDQ_GPIO		11
+#define PALMTE_HEADPHONES_GPIO	14
+#define PALMTE_SPEAKER_GPIO	15
+#define PALMTE_DC_GPIO		OMAP_MPUIO(2)
+#define PALMTE_MMC_SWITCH_GPIO	OMAP_MPUIO(4)
+#define PALMTE_MMC1_GPIO	OMAP_MPUIO(6)
+#define PALMTE_MMC2_GPIO	OMAP_MPUIO(7)
+#define PALMTE_MMC3_GPIO	OMAP_MPUIO(11)
+
 static void __init omap_palmte_init_irq(void)
 {
 	omap1_init_common_hw();
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 1cbc127..9dc9d79 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -43,6 +43,13 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
+#define PALMTT_USBDETECT_GPIO	0
+#define PALMTT_CABLE_GPIO	1
+#define PALMTT_LED_GPIO		3
+#define PALMTT_PENIRQ_GPIO	6
+#define PALMTT_MMC_WP_GPIO	8
+#define PALMTT_HDQ_GPIO		11
+
 static int palmtt_keymap[] = {
 	KEY(0, 0, KEY_ESC),
 	KEY(0, 1, KEY_SPACE),
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index baf5efb..a2f99a4 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -46,6 +46,16 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
+#define PALMZ71_USBDETECT_GPIO	0
+#define PALMZ71_PENIRQ_GPIO	6
+#define PALMZ71_MMC_WP_GPIO	8
+#define PALMZ71_HDQ_GPIO 	11
+
+#define PALMZ71_HOTSYNC_GPIO	OMAP_MPUIO(1)
+#define PALMZ71_CABLE_GPIO	OMAP_MPUIO(2)
+#define PALMZ71_SLIDER_GPIO	OMAP_MPUIO(3)
+#define PALMZ71_MMC_IN_GPIO	OMAP_MPUIO(4)
+
 static void __init
 omap_palmz71_init_irq(void)
 {
diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/board-sx1-mmc.c
index 66a4d7d..58a46e4 100644
--- a/arch/arm/mach-omap1/board-sx1-mmc.c
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -17,6 +17,7 @@
 #include <mach/hardware.h>
 #include <mach/mmc.h>
 #include <mach/gpio.h>
+#include <mach/board-sx1.h>
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 28c76a1..ab277d4 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -41,6 +41,7 @@
 #include <mach/board.h>
 #include <mach/common.h>
 #include <mach/keypad.h>
+#include <mach/board-sx1.h>
 
 /* Write to I2C device */
 int sx1_i2c_write_byte(u8 devaddr, u8 regoffset, u8 value)
diff --git a/arch/arm/plat-omap/include/mach/board-palmte.h b/arch/arm/plat-omap/include/mach/board-palmte.h
deleted file mode 100644
index 6906cde..0000000
--- a/arch/arm/plat-omap/include/mach/board-palmte.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/board-palmte.h
- *
- * Hardware definitions for the Palm Tungsten E device.
- *
- * Maintainters :	http://palmtelinux.sf.net
- *			palmtelinux-developpers@lists.sf.net
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __OMAP_BOARD_PALMTE_H
-#define __OMAP_BOARD_PALMTE_H
-
-#define PALMTE_USBDETECT_GPIO	0
-#define PALMTE_USB_OR_DC_GPIO	1
-#define PALMTE_TSC_GPIO		4
-#define PALMTE_PINTDAV_GPIO	6
-#define PALMTE_MMC_WP_GPIO	8
-#define PALMTE_MMC_POWER_GPIO	9
-#define PALMTE_HDQ_GPIO		11
-#define PALMTE_HEADPHONES_GPIO	14
-#define PALMTE_SPEAKER_GPIO	15
-#define PALMTE_DC_GPIO		OMAP_MPUIO(2)
-#define PALMTE_MMC_SWITCH_GPIO	OMAP_MPUIO(4)
-#define PALMTE_MMC1_GPIO	OMAP_MPUIO(6)
-#define PALMTE_MMC2_GPIO	OMAP_MPUIO(7)
-#define PALMTE_MMC3_GPIO	OMAP_MPUIO(11)
-
-#endif	/* __OMAP_BOARD_PALMTE_H */
diff --git a/arch/arm/plat-omap/include/mach/board-palmtt.h b/arch/arm/plat-omap/include/mach/board-palmtt.h
deleted file mode 100644
index e79f382..0000000
--- a/arch/arm/plat-omap/include/mach/board-palmtt.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/board-palmte.h
- *
- * Hardware definitions for the Palm Tungsten|T device.
- *
- * Maintainters :	Marek Vasut <marek.vasut@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __OMAP_BOARD_PALMTT_H
-#define __OMAP_BOARD_PALMTT_H
-
-#define PALMTT_USBDETECT_GPIO	0
-#define PALMTT_CABLE_GPIO	1
-#define PALMTT_LED_GPIO		3
-#define PALMTT_PENIRQ_GPIO	6
-#define PALMTT_MMC_WP_GPIO	8
-#define PALMTT_HDQ_GPIO		11
-
-#endif	/* __OMAP_BOARD_PALMTT_H */
diff --git a/arch/arm/plat-omap/include/mach/board-palmz71.h b/arch/arm/plat-omap/include/mach/board-palmz71.h
deleted file mode 100644
index b1d7d57..0000000
--- a/arch/arm/plat-omap/include/mach/board-palmz71.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/board-palmz71.h
- *
- * Hardware definitions for the Palm Zire71 device.
- *
- * Maintainters :	Marek Vasut <marek.vasut@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __OMAP_BOARD_PALMZ71_H
-#define __OMAP_BOARD_PALMZ71_H
-
-#define PALMZ71_USBDETECT_GPIO	0
-#define PALMZ71_PENIRQ_GPIO	6
-#define PALMZ71_MMC_WP_GPIO	8
-#define PALMZ71_HDQ_GPIO 	11
-
-#define PALMZ71_HOTSYNC_GPIO	OMAP_MPUIO(1)
-#define PALMZ71_CABLE_GPIO	OMAP_MPUIO(2)
-#define PALMZ71_SLIDER_GPIO	OMAP_MPUIO(3)
-#define PALMZ71_MMC_IN_GPIO	OMAP_MPUIO(4)
-
-#endif	/* __OMAP_BOARD_PALMZ71_H */
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 201a8fa..194ed49 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -318,18 +318,6 @@
 #include "board-voiceblue.h"
 #endif
 
-#ifdef CONFIG_MACH_OMAP_PALMTE
-#include "board-palmte.h"
-#endif
-
-#ifdef CONFIG_MACH_OMAP_PALMZ71
-#include "board-palmz71.h"
-#endif
-
-#ifdef CONFIG_MACH_OMAP_PALMTT
-#include "board-palmtt.h"
-#endif
-
 #ifdef CONFIG_MACH_SX1
 #include "board-sx1.h"
 #endif

