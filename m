From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 6/9] ARM: OMAP1: move omap1_bl pdata out of arch/arm/*
Date: Wed, 29 Aug 2012 02:18:54 +0300
Message-ID: <1346195937-6383-7-git-send-email-grinberg@compulab.co.il>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:34557 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012Ab2H1XTU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 19:19:20 -0400
In-Reply-To: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

omap1 backlight platform data resides inside plat/board.h while it
should be inside include/linux/...
Move the omap1 backlight platform data to
include/linux/platform_data/.

Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap1/board-osk.c         |    1 +
 arch/arm/mach-omap1/board-palmte.c      |    1 +
 arch/arm/mach-omap1/board-palmtt.c      |    1 +
 arch/arm/mach-omap1/board-palmz71.c     |    1 +
 arch/arm/plat-omap/include/plat/board.h |    7 -------
 drivers/video/backlight/omap1_bl.c      |    2 +-
 include/linux/platform_data/omap1_bl.h  |   11 +++++++++++
 7 files changed, 16 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/platform_data/omap1_bl.h

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 8784705..569b687 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -39,6 +39,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/i2c/tps65010.h>
+#include <linux/platform_data/omap1_bl.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 26bcb9d..7bf00ba 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/apm-emulation.h>
 #include <linux/omapfb.h>
+#include <linux/platform_data/omap1_bl.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 4d09944..2cce505 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -27,6 +27,7 @@
 #include <linux/omapfb.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/platform_data/omap1_bl.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 3559803..45ab9f0 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -30,6 +30,7 @@
 #include <linux/omapfb.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/platform_data/omap1_bl.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index 5938c72..d0bc46e 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -19,13 +19,6 @@ struct omap_lcd_config {
 	u8   data_lines;
 };
 
-struct device;
-struct fb_info;
-struct omap_backlight_config {
-	int default_intensity;
-	int (*set_power)(struct device *dev, int state);
-};
-
 /* for TI reference platforms sharing the same debug card */
 extern int debug_card_init(u32 addr, unsigned gpio);
 
diff --git a/drivers/video/backlight/omap1_bl.c b/drivers/video/backlight/omap1_bl.c
index bfdc5fb..92257ef 100644
--- a/drivers/video/backlight/omap1_bl.c
+++ b/drivers/video/backlight/omap1_bl.c
@@ -27,9 +27,9 @@
 #include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/slab.h>
+#include <linux/platform_data/omap1_bl.h>
 
 #include <mach/hardware.h>
-#include <plat/board.h>
 #include <plat/mux.h>
 
 #define OMAPBL_MAX_INTENSITY		0xff
diff --git a/include/linux/platform_data/omap1_bl.h b/include/linux/platform_data/omap1_bl.h
new file mode 100644
index 0000000..881a8e9
--- /dev/null
+++ b/include/linux/platform_data/omap1_bl.h
@@ -0,0 +1,11 @@
+#ifndef __OMAP1_BL_H__
+#define __OMAP1_BL_H__
+
+#include <linux/device.h>
+
+struct omap_backlight_config {
+	int default_intensity;
+	int (*set_power)(struct device *dev, int state);
+};
+
+#endif
-- 
1.7.8.6

