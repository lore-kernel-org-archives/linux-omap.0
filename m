From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/13] ARM: OMAP: No need to include board-overo.h from
	hardware.h
Date: Thu, 26 Feb 2009 16:06:23 -0800
Message-ID: <20090227000623.20192.59078.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59310 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbZB0AG3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 19:06:29 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Move the defines to the associated board file and remove
the now unnecessary header file.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-overo.c             |    7 ++++++-
 arch/arm/plat-omap/include/mach/board-overo.h |   26 -------------------------
 2 files changed, 6 insertions(+), 27 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/board-overo.h

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 82b3dc5..b92313c 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -37,7 +37,6 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-overo.h>
 #include <mach/board.h>
 #include <mach/common.h>
 #include <mach/gpio.h>
@@ -47,6 +46,12 @@
 
 #include "mmc-twl4030.h"
 
+#define OVERO_GPIO_BT_XGATE	15
+#define OVERO_GPIO_W2W_NRESET	16
+#define OVERO_GPIO_BT_NRESET	164
+#define OVERO_GPIO_USBH_CPEN	168
+#define OVERO_GPIO_USBH_NRESET	183
+
 #define NAND_BLOCK_SIZE SZ_128K
 #define GPMC_CS0_BASE  0x60
 #define GPMC_CS_SIZE   0x30
diff --git a/arch/arm/plat-omap/include/mach/board-overo.h b/arch/arm/plat-omap/include/mach/board-overo.h
deleted file mode 100644
index 7ecae66..0000000
--- a/arch/arm/plat-omap/include/mach/board-overo.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * board-overo.h (Gumstix Overo)
- *
- * Initial code: Steve Sakoman <steve@sakoman.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef __ASM_ARCH_OVERO_H
-#define __ASM_ARCH_OVERO_H
-
-#define OVERO_GPIO_BT_XGATE	15
-#define OVERO_GPIO_W2W_NRESET	16
-#define OVERO_GPIO_BT_NRESET	164
-#define OVERO_GPIO_USBH_CPEN	168
-#define OVERO_GPIO_USBH_NRESET	183
-
-#endif /* ____ASM_ARCH_OVERO_H */
-

