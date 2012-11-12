From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/5] OMAP: RX51: remove use of vram
Date: Mon, 12 Nov 2012 12:25:04 +0200
Message-ID: <1352715906-16946-4-git-send-email-tomi.valkeinen@ti.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35786 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906Ab2KLKZV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 05:25:21 -0500
In-Reply-To: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

As omapfb no longer uses omap specific vram allocator we can remove the
vram pre-allocation from rx51 board file.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-rx51-video.c |   14 --------------
 arch/arm/mach-omap2/board-rx51.c       |    3 ---
 2 files changed, 17 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index c22e111..46f4fc9 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -16,7 +16,6 @@
 #include <linux/mm.h>
 #include <asm/mach-types.h>
 #include <video/omapdss.h>
-#include <plat/vram.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include "board-rx51.h"
@@ -87,17 +86,4 @@ static int __init rx51_video_init(void)
 }
 
 subsys_initcall(rx51_video_init);
-
-void __init rx51_video_mem_init(void)
-{
-	/*
-	 * GFX 864x480x32bpp
-	 * VID1/2 1280x720x32bpp double buffered
-	 */
-	omap_vram_set_sdram_vram(PAGE_ALIGN(864 * 480 * 4) +
-			2 * PAGE_ALIGN(1280 * 720 * 4 * 2), 0);
-}
-
-#else
-void __init rx51_video_mem_init(void) { }
 #endif /* defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE) */
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 7bbb05d..6e0de6f 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -34,8 +34,6 @@
 
 #define RX51_GPIO_SLEEP_IND 162
 
-extern void rx51_video_mem_init(void);
-
 static struct gpio_led gpio_leds[] = {
 	{
 		.name	= "sleep_ind",
@@ -112,7 +110,6 @@ static void __init rx51_init(void)
 
 static void __init rx51_reserve(void)
 {
-	rx51_video_mem_init();
 	omap_reserve();
 }
 
-- 
1.7.10.4

