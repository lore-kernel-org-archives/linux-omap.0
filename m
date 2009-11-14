From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v2 for-next] OMAP: DMA: Use some define rather than a hexadecimal constant for LCD register
Date: Sun, 15 Nov 2009 00:52:21 +0100
Message-ID: <200911150052.23303.jkrzyszt@tis.icnet.pl>
References: <20091114005710.GI3684@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:56193 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbZKNXwx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Nov 2009 18:52:53 -0500
In-Reply-To: <20091114005710.GI3684@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

The patch corrects the issue introduced with my previous patch:
        "OMAP: DMA: Fix omapfb/lcdc on OMAP1510 broken when PM set"
as pointed out by OMAP subsystem maintainer.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
Saturday 14 November 2009 01:57:10 Tony Lindgren napisa=C5=82(a):
> Looks like this patch needs to be refreshed against linux-omap
> for-next branch.

Refreshed against commit 155a75d9725e66e5ec8a383822957dee52427057

Thanks,
Janusz

diff -upr a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
--- a/arch/arm/plat-omap/dma.c	2009-11-14 23:48:41.000000000 +0100
+++ b/arch/arm/plat-omap/dma.c	2009-11-15 00:02:39.000000000 +0100
@@ -34,6 +34,7 @@
 #include <mach/hardware.h>
 #include <plat/dma.h>
=20
+#include <plat/omapfb.h>
 #include <plat/tc.h>
=20
 #undef DEBUG
@@ -1125,7 +1126,7 @@ int omap_dma_running(void)
 	 * when it gets enabled, so assume DMA running if LCD enabled.
 	 */
 	if (cpu_is_omap1510())
-		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
+		if (omap_readw(OMAP_LCDC_CONTROL) & OMAP_LCDC_CTRL_LCD_EN)
 			return 1;
=20
 	/* Check if LCD DMA is running */
diff -upr a/arch/arm/plat-omap/include/plat/omapfb.h b/arch/arm/plat-om=
ap/include/plat/omapfb.h
--- a/arch/arm/plat-omap/include/plat/omapfb.h	2009-11-14 23:48:41.0000=
00000 +0100
+++ b/arch/arm/plat-omap/include/plat/omapfb.h	2009-11-14 23:59:51.0000=
00000 +0100
@@ -170,6 +170,38 @@ enum omapfb_update_mode {
=20
 #include <plat/board.h>
=20
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
 #define OMAP_LCDC_INV_VSYNC             0x0001
 #define OMAP_LCDC_INV_HSYNC             0x0002
 #define OMAP_LCDC_INV_PIX_CLOCK         0x0004
diff -upr a/drivers/video/omap/lcdc.c b/drivers/video/omap/lcdc.c
--- a/drivers/video/omap/lcdc.c	2009-11-14 23:49:16.000000000 +0100
+++ b/drivers/video/omap/lcdc.c	2009-11-14 23:59:51.000000000 +0100
@@ -38,38 +38,6 @@
=20
 #define MODULE_NAME			"lcdc"
=20
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
=20
 enum lcdc_load_mode {
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
