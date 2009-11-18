From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH] ZOOM2: PM: Add T2 keypad as wakeup source for Zoom2
Date: Wed, 18 Nov 2009 15:12:41 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA9F0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56737 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636AbZKRJmk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 04:42:40 -0500
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
 arch/arm/mach-omap2/board-zoom-peripherals.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index f14baa3..d5ed73f 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -21,6 +21,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/mux.h>
 #include <plat/common.h>
 #include <plat/usb.h>
 
@@ -259,9 +260,15 @@ static int __init omap_i2c_init(void)
 	return 0;
 }
 
+static void enable_board_wakeup_source(void)
+{
+	omap_cfg_reg(AF26_34XX_SYS_NIRQ); /* T2 interrupt line */
+}
+
 void __init zoom_peripherals_init(void)
 {
 	omap_i2c_init();
 	omap_serial_init();
 	usb_musb_init();
+	enable_board_wakeup_source();
 }
