From: Samreen <samreen@ti.com>
Subject: [PATCH v3 2/2] OMAP3: Enable display on ZOOM2/3/3630SDP
Date: Mon, 15 Nov 2010 11:39:04 +0530
Message-ID: <1289801344-3100-3-git-send-email-samreen@ti.com>
References: <1289801344-3100-1-git-send-email-samreen@ti.com>
 <1289801344-3100-2-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39568 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755187Ab0KOGO3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Nov 2010 01:14:29 -0500
In-Reply-To: <1289801344-3100-2-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org
Cc: Mukund Mittal <mmittal@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vikram Pandita <vikram.pandita@ti.com>, Kishore Y <kishore.y@ti.com>, Samreen <samreen@ti.com>

From: Kishore Y <kishore.y@ti.com>

Enable Display on zoom2, zoom3 and 3630sdp boards.

Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Kishore Y <kishore.y@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 arch/arm/mach-omap2/board-3630sdp.c |    1 +
 arch/arm/mach-omap2/board-zoom2.c   |    1 +
 arch/arm/mach-omap2/board-zoom3.c   |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index bbcf580..bf990b6 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -209,6 +209,7 @@ static void __init omap_sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 	zoom_peripherals_init();
+	zoom_display_init();
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_sdp);
 	enable_board_wakeup_source();
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 2992a9f..1cd6414 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -105,6 +105,7 @@ static void __init omap_zoom2_init(void)
 	board_nand_init(zoom_nand_partitions,
 			ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
 	zoom_debugboard_init();
+	zoom_display_init();
 }
 
 MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 5adde12..1523369 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -118,6 +118,7 @@ static void __init omap_zoom_init(void)
 	board_nand_init(zoom_nand_partitions,
 			 ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
 	zoom_debugboard_init();
+	zoom_display_init();
 
 	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
 	usb_ehci_init(&ehci_pdata);
-- 
1.5.6.3

