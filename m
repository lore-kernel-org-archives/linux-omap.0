From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 5/5] OMAP: Zoom2: Release Dbg board detect gpio
Date: Fri, 21 Aug 2009 13:11:20 -0500
Message-ID: <1250878280-10667-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43989 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755441AbZHUSLy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Aug 2009 14:11:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: Vikram Pandita <vikram.pandita@ti.com>

Release the Dbg board detection gpio once its purpose is served

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/board-zoom-debugboard.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 4dd714d..d80e448 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -130,6 +130,7 @@ static inline void __init zoom2_init_quaduart(void)
 static inline int omap_zoom2_debugboard_detect(void)
 {
 	int debug_board_detect = 0;
+	int ret = 1;
 
 	debug_board_detect = ZOOM2_SMSC911X_GPIO;
 
@@ -141,10 +142,10 @@ static inline int omap_zoom2_debugboard_detect(void)
 	gpio_direction_input(debug_board_detect);
 
 	if (!gpio_get_value(debug_board_detect)) {
-		gpio_free(debug_board_detect);
-		return 0;
+		ret = 0;
 	}
-	return 1;
+	gpio_free(debug_board_detect);
+	return ret;
 }
 
 static struct platform_device *zoom2_devices[] __initdata = {
-- 
1.6.3.3.334.g916e1

