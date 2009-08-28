From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP: Zoom2: release debug board detect gpio line
Date: Fri, 28 Aug 2009 11:28:47 +0300
Message-ID: <1251448127-27336-3-git-send-email-khilman@deeprootsystems.com>
References: <1251448127-27336-1-git-send-email-khilman@deeprootsystems.com>
 <1251448127-27336-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:62772 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbZH1I2y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 04:28:54 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so1464180bwz.37
        for <linux-omap@vger.kernel.org>; Fri, 28 Aug 2009 01:28:56 -0700 (PDT)
In-Reply-To: <1251448127-27336-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vikram Pandita <vikram.pandita@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

Release the Dbg board detection gpio once its purpose is served

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-zoom-debugboard.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index e0948c9..1f13e2a 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -129,6 +129,7 @@ static inline void __init zoom2_init_quaduart(void)
 static inline int omap_zoom2_debugboard_detect(void)
 {
 	int debug_board_detect = 0;
+	int ret = 1;
 
 	debug_board_detect = ZOOM2_SMSC911X_GPIO;
 
@@ -140,10 +141,10 @@ static inline int omap_zoom2_debugboard_detect(void)
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
1.6.4

