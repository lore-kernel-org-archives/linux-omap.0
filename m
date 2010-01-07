From: Lesly A M <x0080970@ti.com>
Subject: [PATCH] omap3: pm: Add T2 Keypad as a wakeup source
Date: Thu,  7 Jan 2010 15:17:12 +0530
Message-ID: <1262857632-24364-1-git-send-email-x0080970@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49658 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab0AGJfJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 04:35:09 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o079Z62B007856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 03:35:08 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Teerth Reddy <teerth@ti.com>

Changes for setting the padconf value for sys_nirq line which is
connected to T2 INTR1. This will fix the T2 keypad wakeup.

Signed-off-by: Lesly A M <x0080970@ti.com>
Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 8dd277c..64d4db0 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -24,6 +24,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 
+#include "mux.h"
 #include "mmc-twl4030.h"
 
 /* Zoom2 has Qwerty keyboard*/
@@ -263,9 +264,17 @@ static int __init omap_i2c_init(void)
 	return 0;
 }
 
+static void enable_board_wakeup_source(void)
+{
+	/* T2 interrupt line (keypad) */
+	omap_mux_init_signal("sys_nirq",
+		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
+}
+
 void __init zoom_peripherals_init(void)
 {
 	omap_i2c_init();
 	omap_serial_init();
 	usb_musb_init();
+	enable_board_wakeup_source();
 }
-- 
1.6.0.4

