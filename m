From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH] ZOOM2: PM: Add T2 keypad as wakeup source for Zoom2
Date: Wed, 18 Nov 2009 14:22:35 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA9A9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44928 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbZKRIwf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 03:52:35 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

From: Lesly A M <x0080970@ti.com>

Zoom2: Add T2 Keypad as a wakeup source
    
Changes for setting the padconf value for sys_nirq line which is
connected to T2 INTR1. This will fix the T2 keypad wakeup.
    
Signed-off-by: Lesly A M <x0080970@ti.com>
Signed-off-by: Teerth Reddy <teerth@ti.com>

---
 arch/arm/mach-omap2/board-zoom2.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 10b50f1..367215c 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -18,6 +18,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include <plat/mux.h>
 #include <plat/common.h>
 #include <plat/board.h>
 
@@ -66,10 +67,16 @@ static struct twl4030_platform_data zoom2_twldata = {
 extern int __init omap_zoom2_debugboard_init(void);
 extern void __init zoom_peripherals_init(void);
 
+static void enable_board_wakeup_source(void)
+{
+	omap_cfg_reg(AF26_34XX_SYS_NIRQ); /* T2 interrupt line */
+}
+
 static void __init omap_zoom2_init(void)
 {
 	zoom_peripherals_init();
 	omap_zoom2_debugboard_init();
+	enable_board_wakeup_source();
 }
 
 static void __init omap_zoom2_map_io(void)
