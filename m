From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/13] ARM: OMAP: No need to include board-perseus2.h or
	board-fsample.h from hardware.h
Date: Thu, 26 Feb 2009 15:53:35 -0800
Message-ID: <20090226235334.20192.1769.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50072 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbZBZXxi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 18:53:38 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Move defines to the board file and remove the now
unnecessary headers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-fsample.c              |   34 ++++++++++++++-
 arch/arm/plat-omap/include/mach/board-fsample.h  |   51 ----------------------
 arch/arm/plat-omap/include/mach/board-perseus2.h |   39 -----------------
 arch/arm/plat-omap/include/mach/hardware.h       |    8 ---
 4 files changed, 33 insertions(+), 99 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/board-fsample.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-perseus2.h

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 3030829..19e0e92 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -34,7 +34,39 @@
 #include <mach/keypad.h>
 #include <mach/common.h>
 #include <mach/board.h>
-#include <mach/board-fsample.h>
+
+/* fsample is pretty close to p2-sample */
+
+#define fsample_cpld_read(reg) __raw_readb(reg)
+#define fsample_cpld_write(val, reg) __raw_writeb(val, reg)
+
+#define FSAMPLE_CPLD_BASE    0xE8100000
+#define FSAMPLE_CPLD_SIZE    SZ_4K
+#define FSAMPLE_CPLD_START   0x05080000
+
+#define FSAMPLE_CPLD_REG_A   (FSAMPLE_CPLD_BASE + 0x00)
+#define FSAMPLE_CPLD_SWITCH  (FSAMPLE_CPLD_BASE + 0x02)
+#define FSAMPLE_CPLD_UART    (FSAMPLE_CPLD_BASE + 0x02)
+#define FSAMPLE_CPLD_REG_B   (FSAMPLE_CPLD_BASE + 0x04)
+#define FSAMPLE_CPLD_VERSION (FSAMPLE_CPLD_BASE + 0x06)
+#define FSAMPLE_CPLD_SET_CLR (FSAMPLE_CPLD_BASE + 0x06)
+
+#define FSAMPLE_CPLD_BIT_BT_RESET         0
+#define FSAMPLE_CPLD_BIT_LCD_RESET        1
+#define FSAMPLE_CPLD_BIT_CAM_PWDN         2
+#define FSAMPLE_CPLD_BIT_CHARGER_ENABLE   3
+#define FSAMPLE_CPLD_BIT_SD_MMC_EN        4
+#define FSAMPLE_CPLD_BIT_aGPS_PWREN       5
+#define FSAMPLE_CPLD_BIT_BACKLIGHT        6
+#define FSAMPLE_CPLD_BIT_aGPS_EN_RESET    7
+#define FSAMPLE_CPLD_BIT_aGPS_SLEEPx_N    8
+#define FSAMPLE_CPLD_BIT_OTG_RESET        9
+
+#define fsample_cpld_set(bit) \
+    fsample_cpld_write((((bit) & 15) << 4) | 0x0f, FSAMPLE_CPLD_SET_CLR)
+
+#define fsample_cpld_clear(bit) \
+    fsample_cpld_write(0xf0 | ((bit) & 15), FSAMPLE_CPLD_SET_CLR)
 
 static int fsample_keymap[] = {
 	KEY(0,0,KEY_UP),
diff --git a/arch/arm/plat-omap/include/mach/board-fsample.h b/arch/arm/plat-omap/include/mach/board-fsample.h
deleted file mode 100644
index cb3c5ae..0000000
--- a/arch/arm/plat-omap/include/mach/board-fsample.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/board-fsample.h
- *
- * Board-specific goodies for TI F-Sample.
- *
- * Copyright (C) 2006 Google, Inc.
- * Author: Brian Swetland <swetland@google.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_OMAP_FSAMPLE_H
-#define __ASM_ARCH_OMAP_FSAMPLE_H
-
-/* fsample is pretty close to p2-sample */
-#include <mach/board-perseus2.h>
-
-#define fsample_cpld_read(reg) __raw_readb(reg)
-#define fsample_cpld_write(val, reg) __raw_writeb(val, reg)
-
-#define FSAMPLE_CPLD_BASE    0xE8100000
-#define FSAMPLE_CPLD_SIZE    SZ_4K
-#define FSAMPLE_CPLD_START   0x05080000
-
-#define FSAMPLE_CPLD_REG_A   (FSAMPLE_CPLD_BASE + 0x00)
-#define FSAMPLE_CPLD_SWITCH  (FSAMPLE_CPLD_BASE + 0x02)
-#define FSAMPLE_CPLD_UART    (FSAMPLE_CPLD_BASE + 0x02)
-#define FSAMPLE_CPLD_REG_B   (FSAMPLE_CPLD_BASE + 0x04)
-#define FSAMPLE_CPLD_VERSION (FSAMPLE_CPLD_BASE + 0x06)
-#define FSAMPLE_CPLD_SET_CLR (FSAMPLE_CPLD_BASE + 0x06)
-
-#define FSAMPLE_CPLD_BIT_BT_RESET         0
-#define FSAMPLE_CPLD_BIT_LCD_RESET        1
-#define FSAMPLE_CPLD_BIT_CAM_PWDN         2
-#define FSAMPLE_CPLD_BIT_CHARGER_ENABLE   3
-#define FSAMPLE_CPLD_BIT_SD_MMC_EN        4
-#define FSAMPLE_CPLD_BIT_aGPS_PWREN       5
-#define FSAMPLE_CPLD_BIT_BACKLIGHT        6
-#define FSAMPLE_CPLD_BIT_aGPS_EN_RESET    7
-#define FSAMPLE_CPLD_BIT_aGPS_SLEEPx_N    8
-#define FSAMPLE_CPLD_BIT_OTG_RESET        9
-
-#define fsample_cpld_set(bit) \
-    fsample_cpld_write((((bit) & 15) << 4) | 0x0f, FSAMPLE_CPLD_SET_CLR)
-
-#define fsample_cpld_clear(bit) \
-    fsample_cpld_write(0xf0 | ((bit) & 15), FSAMPLE_CPLD_SET_CLR)
-
-#endif
diff --git a/arch/arm/plat-omap/include/mach/board-perseus2.h b/arch/arm/plat-omap/include/mach/board-perseus2.h
deleted file mode 100644
index c06c3d7..0000000
--- a/arch/arm/plat-omap/include/mach/board-perseus2.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- *  arch/arm/plat-omap/include/mach/board-perseus2.h
- *
- *  Copyright 2003 by Texas Instruments Incorporated
- *    OMAP730 / Perseus2 support by Jean Pihet
- *
- * Copyright (C) 2001 RidgeRun, Inc. (http://www.ridgerun.com)
- * Author: RidgeRun, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#ifndef __ASM_ARCH_OMAP_PERSEUS2_H
-#define __ASM_ARCH_OMAP_PERSEUS2_H
-
-#include <mach/fpga.h>
-
-#ifndef OMAP_SDRAM_DEVICE
-#define OMAP_SDRAM_DEVICE		D256M_1X16_4B
-#endif
-
-#endif
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 6589ddb..5b59188 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -302,14 +302,6 @@
 #include "board-h2.h"
 #endif
 
-#ifdef CONFIG_MACH_OMAP_PERSEUS2
-#include "board-perseus2.h"
-#endif
-
-#ifdef CONFIG_MACH_OMAP_FSAMPLE
-#include "board-fsample.h"
-#endif
-
 #ifdef CONFIG_MACH_OMAP_H3
 #include "board-h3.h"
 #endif

