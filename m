From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/16] OMAP: N770: remove HWA742 platform data
Date: Tue, 24 Jan 2012 12:00:21 +0200
Message-ID: <1327399231-20826-7-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:39670 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755824Ab2AXKBD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:01:03 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

In an effort to clean up the old omapfb driver, this patch removes
HWA742 (the display chip used in N770) platform data. This can be done
as N770 is the only user of HWA742, and the platform data contains only
one field, te_connected, which we can just presume to be true in the
HWA742 driver.

This allows us to remove omapfb_set_ctrl_platform_data(), and the
mechanism to pass the platform data, in a later patch.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap1/board-nokia770.c     |    6 ------
 arch/arm/plat-omap/include/plat/hwa742.h |    8 --------
 drivers/video/omap/hwa742.c              |   21 +++++----------------
 3 files changed, 5 insertions(+), 30 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/hwa742.h

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index f9efc03..7155d8c 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -31,7 +31,6 @@
 #include <plat/board.h>
 #include <plat/keypad.h>
 #include "common.h"
-#include <plat/hwa742.h>
 #include <plat/lcd_mipid.h>
 #include <plat/mmc.h>
 #include <plat/clock.h>
@@ -150,14 +149,9 @@ static struct spi_board_info nokia770_spi_board_info[] __initdata = {
 	},
 };
 
-static struct hwa742_platform_data nokia770_hwa742_platform_data = {
-	.te_connected		= 1,
-};
-
 static void __init hwa742_dev_init(void)
 {
 	clk_add_alias("hwa_sys_ck", NULL, "bclk", NULL);
-	omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
 }
 
 /* assume no Mini-AB port */
diff --git a/arch/arm/plat-omap/include/plat/hwa742.h b/arch/arm/plat-omap/include/plat/hwa742.h
deleted file mode 100644
index 886248d..0000000
--- a/arch/arm/plat-omap/include/plat/hwa742.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef _HWA742_H
-#define _HWA742_H
-
-struct hwa742_platform_data {
-	unsigned	te_connected:1;
-};
-
-#endif
diff --git a/drivers/video/omap/hwa742.c b/drivers/video/omap/hwa742.c
index 084aa0a..9f1d23c 100644
--- a/drivers/video/omap/hwa742.c
+++ b/drivers/video/omap/hwa742.c
@@ -28,7 +28,6 @@
 #include <linux/interrupt.h>
 
 #include <plat/dma.h>
-#include <plat/hwa742.h>
 #include "omapfb.h"
 
 #define HWA742_REV_CODE_REG       0x0
@@ -942,7 +941,6 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
 	unsigned long sys_clk, pix_clk;
 	int extif_mem_div;
 	struct omapfb_platform_data *omapfb_conf;
-	struct hwa742_platform_data *ctrl_conf;
 
 	BUG_ON(!fbdev->ext_if || !fbdev->int_ctrl);
 
@@ -951,13 +949,6 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
 	hwa742.int_ctrl = fbdev->int_ctrl;
 
 	omapfb_conf = fbdev->dev->platform_data;
-	ctrl_conf = omapfb_conf->ctrl_platform_data;
-
-	if (ctrl_conf == NULL) {
-		dev_err(fbdev->dev, "HWA742: missing platform data\n");
-		r = -ENOENT;
-		goto err1;
-	}
 
 	hwa742.sys_ck = clk_get(NULL, "hwa_sys_ck");
 
@@ -995,14 +986,12 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
 		goto err4;
 	}
 
-	if (ctrl_conf->te_connected) {
-		if ((r = setup_tearsync(pix_clk, extif_mem_div)) < 0) {
-			dev_err(hwa742.fbdev->dev,
-			       "HWA742: can't setup tearing synchronization\n");
-			goto err4;
-		}
-		hwa742.te_connected = 1;
+	if ((r = setup_tearsync(pix_clk, extif_mem_div)) < 0) {
+		dev_err(hwa742.fbdev->dev,
+			"HWA742: can't setup tearing synchronization\n");
+		goto err4;
 	}
+	hwa742.te_connected = 1;
 
 	hwa742.max_transmit_size = hwa742.extif->max_transmit_size;
 
-- 
1.7.4.1

