From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/17] OMAPFB1: remove unnecessary includes
Date: Wed,  5 Sep 2012 11:25:40 +0300
Message-ID: <1346833555-31258-3-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:39905 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757911Ab2IEI0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:17 -0400
Received: by lbbgj3 with SMTP id gj3so189781lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:15 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove unnecessary includes from the old omapfb driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap/hwa742.c        |    1 -
 drivers/video/omap/lcd_ams_delta.c |    1 -
 drivers/video/omap/lcd_palmte.c    |    1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/video/omap/hwa742.c b/drivers/video/omap/hwa742.c
index 9f1d23c..f349ee6 100644
--- a/drivers/video/omap/hwa742.c
+++ b/drivers/video/omap/hwa742.c
@@ -27,7 +27,6 @@
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 
-#include <plat/dma.h>
 #include "omapfb.h"
 
 #define HWA742_REV_CODE_REG       0x0
diff --git a/drivers/video/omap/lcd_ams_delta.c b/drivers/video/omap/lcd_ams_delta.c
index d3a3113..5cca6b3 100644
--- a/drivers/video/omap/lcd_ams_delta.c
+++ b/drivers/video/omap/lcd_ams_delta.c
@@ -28,7 +28,6 @@
 #include <linux/gpio.h>
 
 #include <plat/board-ams-delta.h>
-#include <mach/hardware.h>
 
 #include "omapfb.h"
 
diff --git a/drivers/video/omap/lcd_palmte.c b/drivers/video/omap/lcd_palmte.c
index 88c31eb..ff4fb62 100644
--- a/drivers/video/omap/lcd_palmte.c
+++ b/drivers/video/omap/lcd_palmte.c
@@ -23,7 +23,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <plat/fpga.h>
 #include "omapfb.h"
 
 static int palmte_panel_init(struct lcd_panel *panel,
-- 
1.7.9.5

