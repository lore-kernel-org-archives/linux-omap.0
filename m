From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 7/9] ARM: OMAP1: move lcd pdata out of arch/arm/*
Date: Wed, 29 Aug 2012 02:18:55 +0300
Message-ID: <1346195937-6383-8-git-send-email-grinberg@compulab.co.il>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:39803 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116Ab2H1XTU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 19:19:20 -0400
In-Reply-To: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

omap1 lcd platform data resides inside plat/board.h while it
should be inside include/linux/...
Move the omap1 lcd platform data to include/linux/omapfb.h.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap1/board-ams-delta.c   |    1 -
 arch/arm/mach-omap1/board-fsample.c     |    1 -
 arch/arm/mach-omap1/board-htcherald.c   |    1 -
 arch/arm/mach-omap1/board-nokia770.c    |    1 -
 arch/arm/mach-omap1/board-palmte.c      |    1 -
 arch/arm/mach-omap1/board-palmtt.c      |    1 -
 arch/arm/mach-omap1/board-palmz71.c     |    1 -
 arch/arm/mach-omap1/board-perseus2.c    |    1 -
 arch/arm/mach-omap1/board-sx1.c         |    1 -
 arch/arm/plat-omap/fb.c                 |    2 --
 arch/arm/plat-omap/include/plat/board.h |    7 -------
 include/linux/omapfb.h                  |    7 ++++++-
 12 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index c534698..c162369 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -37,7 +37,6 @@
 #include <plat/board-ams-delta.h>
 #include <plat/keypad.h>
 #include <plat/mux.h>
-#include <plat/board.h>
 
 #include <mach/hardware.h>
 #include <mach/ams-delta-fiq.h>
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 6872f3f..6d98552 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -32,7 +32,6 @@
 #include <plat/flash.h>
 #include <plat/fpga.h>
 #include <plat/keypad.h>
-#include <plat/board.h>
 
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index b3f6e94..b9771b5 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -42,7 +42,6 @@
 #include <asm/mach/arch.h>
 
 #include <plat/omap7xx.h>
-#include <plat/board.h>
 #include <plat/keypad.h>
 #include <plat/mmc.h>
 
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 2c0ca8f..ec01f03 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -26,7 +26,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/mux.h>
-#include <plat/board.h>
 #include <plat/keypad.h>
 #include <plat/lcd_mipid.h>
 #include <plat/mmc.h>
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 7bf00ba..49f8d74 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -38,7 +38,6 @@
 #include <plat/mux.h>
 #include <plat/tc.h>
 #include <plat/dma.h>
-#include <plat/board.h>
 #include <plat/irda.h>
 #include <plat/keypad.h>
 
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 2cce505..01523cd 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -38,7 +38,6 @@
 #include <plat/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
-#include <plat/board.h>
 #include <plat/irda.h>
 #include <plat/keypad.h>
 
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 45ab9f0..a7abce6 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -40,7 +40,6 @@
 #include <plat/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
-#include <plat/board.h>
 #include <plat/irda.h>
 #include <plat/keypad.h>
 
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 703d55e..277e0bc 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -32,7 +32,6 @@
 #include <plat/fpga.h>
 #include <plat/flash.h>
 #include <plat/keypad.h>
-#include <plat/board.h>
 
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 8c665bd..2e1fff2 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -38,7 +38,6 @@
 #include <plat/dma.h>
 #include <plat/irda.h>
 #include <plat/tc.h>
-#include <plat/board.h>
 #include <plat/keypad.h>
 #include <plat/board-sx1.h>
 
diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index dd6f92c..bcbb9d5 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -33,8 +33,6 @@
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
 
-#include <plat/board.h>
-
 #if defined(CONFIG_FB_OMAP) || defined(CONFIG_FB_OMAP_MODULE)
 
 static bool omapfb_lcd_configured;
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index d0bc46e..2ddc198 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -12,13 +12,6 @@
 
 #include <linux/types.h>
 
-struct omap_lcd_config {
-	char panel_name[16];
-	char ctrl_name[16];
-	s16  nreset_gpio;
-	u8   data_lines;
-};
-
 /* for TI reference platforms sharing the same debug card */
 extern int debug_card_init(u32 addr, unsigned gpio);
 
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index 4ff57e8..85af818 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -220,7 +220,12 @@ struct omapfb_display_info {
 
 #ifdef __KERNEL__
 
-#include <plat/board.h>
+struct omap_lcd_config {
+	char panel_name[16];
+	char ctrl_name[16];
+	s16  nreset_gpio;
+	u8   data_lines;
+};
 
 struct omapfb_platform_data {
 	struct omap_lcd_config		lcd;
-- 
1.7.8.6

