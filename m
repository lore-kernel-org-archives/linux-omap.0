From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v3 09/11] OMAP3: PM: Smartreflex Class3 initialization from board files.
Date: Wed, 22 Sep 2010 20:15:17 +0530
Message-ID: <1285166719-19352-10-git-send-email-thara@ti.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45272 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754682Ab0IVOpx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 10:45:53 -0400
In-Reply-To: <1285166719-19352-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch enables smartreflex class3 functionality for OMAP3430SDP,
OMAP3630SDP, ZOOM2 and ZOOM3 boards.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |    2 ++
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 67b95b5f..9a04a2e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -47,6 +47,7 @@
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
 #include "pm.h"
+#include "smartreflex-class3.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
@@ -813,6 +814,7 @@ static void __init omap_3430sdp_init(void)
 	sdp3430_display_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
+	sr_class3_init();
 }
 
 MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6b39849..98dffc6 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -26,6 +26,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "smartreflex-class3.h"
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
@@ -282,4 +283,5 @@ void __init zoom_peripherals_init(void)
 	omap_i2c_init();
 	usb_musb_init(&musb_board_data);
 	enable_board_wakeup_source();
+	sr_class3_init();
 }
-- 
1.7.1.GIT

