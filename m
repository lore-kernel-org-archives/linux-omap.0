From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v3 for-next] OMAP: DMA: Use some define rather than a hexadecimal constant for LCD register
Date: Mon, 16 Nov 2009 21:40:18 +0100
Message-ID: <200911162140.19988.jkrzyszt@tis.icnet.pl>
References: <20091114005710.GI3684@atomide.com> <200911150052.23303.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:51986 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753854AbZKPUkh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Nov 2009 15:40:37 -0500
In-Reply-To: <200911150052.23303.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

The patch corrects the issue introduced with my previous patch:
        "OMAP: DMA: Fix omapfb/lcdc on OMAP1510 broken when PM set"
as pointed out by OMAP subsystem maintainer.

Created and tested against linux-omap for-next,
commit 155a75d9725e66e5ec8a383822957dee52427057

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
This version creates a new OMAP1 machine specific header file instead of 
modifying an OMAP platform common one.

Thanks,
Janusz

diff -uprN a/arch/arm/mach-omap1/include/mach/lcdc.h b/arch/arm/mach-omap1/include/mach/lcdc.h
--- a/arch/arm/mach-omap1/include/mach/lcdc.h	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/arm/mach-omap1/include/mach/lcdc.h	2009-11-16 21:13:33.000000000 +0100
@@ -0,0 +1,59 @@
+/*
+ * Header file for OMAP1 internal LCD controller
+ *
+ * Extracted from drivers/video/omap/lcdc.c
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Author: Imre Deak <imre.deak@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#ifndef __ARCH_OMAP_LCDC_H__
+#define __ARCH_OMAP_LCDC_H__
+
+#define OMAP_LCDC_BASE			0xfffec000
+#define OMAP_LCDC_SIZE			256
+#define OMAP_LCDC_IRQ			INT_LCD_CTRL
+
+#define OMAP_LCDC_CONTROL		(OMAP_LCDC_BASE + 0x00)
+#define OMAP_LCDC_TIMING0		(OMAP_LCDC_BASE + 0x04)
+#define OMAP_LCDC_TIMING1		(OMAP_LCDC_BASE + 0x08)
+#define OMAP_LCDC_TIMING2		(OMAP_LCDC_BASE + 0x0c)
+#define OMAP_LCDC_STATUS		(OMAP_LCDC_BASE + 0x10)
+#define OMAP_LCDC_SUBPANEL		(OMAP_LCDC_BASE + 0x14)
+#define OMAP_LCDC_LINE_INT		(OMAP_LCDC_BASE + 0x18)
+#define OMAP_LCDC_DISPLAY_STATUS	(OMAP_LCDC_BASE + 0x1c)
+
+#define OMAP_LCDC_STAT_DONE		(1 << 0)
+#define OMAP_LCDC_STAT_VSYNC		(1 << 1)
+#define OMAP_LCDC_STAT_SYNC_LOST	(1 << 2)
+#define OMAP_LCDC_STAT_ABC		(1 << 3)
+#define OMAP_LCDC_STAT_LINE_INT		(1 << 4)
+#define OMAP_LCDC_STAT_FUF		(1 << 5)
+#define OMAP_LCDC_STAT_LOADED_PALETTE	(1 << 6)
+
+#define OMAP_LCDC_CTRL_LCD_EN		(1 << 0)
+#define OMAP_LCDC_CTRL_LCD_TFT		(1 << 7)
+#define OMAP_LCDC_CTRL_LINE_IRQ_CLR_SEL	(1 << 10)
+
+#define OMAP_LCDC_IRQ_VSYNC		(1 << 2)
+#define OMAP_LCDC_IRQ_DONE		(1 << 3)
+#define OMAP_LCDC_IRQ_LOADED_PALETTE	(1 << 4)
+#define OMAP_LCDC_IRQ_LINE_NIRQ		(1 << 5)
+#define OMAP_LCDC_IRQ_LINE		(1 << 6)
+#define OMAP_LCDC_IRQ_MASK		(((1 << 5) - 1) << 2)
+
+#endif
diff -uprN a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
--- a/arch/arm/plat-omap/dma.c	2009-11-14 23:48:41.000000000 +0100
+++ b/arch/arm/plat-omap/dma.c	2009-11-16 21:14:50.000000000 +0100
@@ -36,6 +36,10 @@
 
 #include <plat/tc.h>
 
+#ifdef CONFIG_ARCH_OMAP1
+#include <mach/lcdc.h>
+#endif
+
 #undef DEBUG
 
 #ifndef CONFIG_ARCH_OMAP1
@@ -1125,7 +1129,7 @@ int omap_dma_running(void)
 	 * when it gets enabled, so assume DMA running if LCD enabled.
 	 */
 	if (cpu_is_omap1510())
-		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
+		if (omap_readw(OMAP_LCDC_CONTROL) & OMAP_LCDC_CTRL_LCD_EN)
 			return 1;
 
 	/* Check if LCD DMA is running */
diff -uprN a/drivers/video/omap/lcdc.c b/drivers/video/omap/lcdc.c
--- a/drivers/video/omap/lcdc.c	2009-11-14 23:49:16.000000000 +0100
+++ b/drivers/video/omap/lcdc.c	2009-11-16 21:10:53.000000000 +0100
@@ -31,6 +31,7 @@
 
 #include <plat/dma.h>
 #include <plat/omapfb.h>
+#include <mach/lcdc.h>
 
 #include <asm/mach-types.h>
 
@@ -38,38 +39,6 @@
 
 #define MODULE_NAME			"lcdc"
 
-#define OMAP_LCDC_BASE			0xfffec000
-#define OMAP_LCDC_SIZE			256
-#define OMAP_LCDC_IRQ			INT_LCD_CTRL
-
-#define OMAP_LCDC_CONTROL		(OMAP_LCDC_BASE + 0x00)
-#define OMAP_LCDC_TIMING0		(OMAP_LCDC_BASE + 0x04)
-#define OMAP_LCDC_TIMING1		(OMAP_LCDC_BASE + 0x08)
-#define OMAP_LCDC_TIMING2		(OMAP_LCDC_BASE + 0x0c)
-#define OMAP_LCDC_STATUS		(OMAP_LCDC_BASE + 0x10)
-#define OMAP_LCDC_SUBPANEL		(OMAP_LCDC_BASE + 0x14)
-#define OMAP_LCDC_LINE_INT		(OMAP_LCDC_BASE + 0x18)
-#define OMAP_LCDC_DISPLAY_STATUS	(OMAP_LCDC_BASE + 0x1c)
-
-#define OMAP_LCDC_STAT_DONE		(1 << 0)
-#define OMAP_LCDC_STAT_VSYNC		(1 << 1)
-#define OMAP_LCDC_STAT_SYNC_LOST	(1 << 2)
-#define OMAP_LCDC_STAT_ABC		(1 << 3)
-#define OMAP_LCDC_STAT_LINE_INT		(1 << 4)
-#define OMAP_LCDC_STAT_FUF		(1 << 5)
-#define OMAP_LCDC_STAT_LOADED_PALETTE	(1 << 6)
-
-#define OMAP_LCDC_CTRL_LCD_EN		(1 << 0)
-#define OMAP_LCDC_CTRL_LCD_TFT		(1 << 7)
-#define OMAP_LCDC_CTRL_LINE_IRQ_CLR_SEL	(1 << 10)
-
-#define OMAP_LCDC_IRQ_VSYNC		(1 << 2)
-#define OMAP_LCDC_IRQ_DONE		(1 << 3)
-#define OMAP_LCDC_IRQ_LOADED_PALETTE	(1 << 4)
-#define OMAP_LCDC_IRQ_LINE_NIRQ		(1 << 5)
-#define OMAP_LCDC_IRQ_LINE		(1 << 6)
-#define OMAP_LCDC_IRQ_MASK		(((1 << 5) - 1) << 2)
-
 #define MAX_PALETTE_SIZE		PAGE_SIZE
 
 enum lcdc_load_mode {
