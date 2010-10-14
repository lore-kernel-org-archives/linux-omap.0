From: Samreen <samreen@ti.com>
Subject: [PATCH 2/2] OMAP3: Enable display on ZOOM2/3/3630SDP
Date: Thu, 14 Oct 2010 16:57:09 +0530
Message-ID: <1287055629-25153-3-git-send-email-samreen@ti.com>
References: <1287055629-25153-1-git-send-email-samreen@ti.com>
 <1287055629-25153-2-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58804 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab0JNLb7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 07:31:59 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9EBVwnr000465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 06:31:58 -0500
In-Reply-To: <1287055629-25153-2-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kishore Y <kishore.y@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>

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
index b359c3f..d6ba94a 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -210,6 +210,7 @@ static void __init omap_sdp_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 	omap_serial_init();
 	zoom_peripherals_init();
+	zoom_display_init();
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_sdp);
 	enable_board_wakeup_source();
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 3ad9ecf..1db4d95 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -138,6 +138,7 @@ static void __init omap_zoom2_init(void)
 	board_nand_init(zoom_nand_partitions,
 			ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
 	zoom_debugboard_init();
+	zoom_display_init();
 }
 
 MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 6ca0b83..6e012f6 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -117,6 +117,7 @@ static void __init omap_zoom_init(void)
 	board_nand_init(zoom_nand_partitions,
 			 ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
 	zoom_debugboard_init();
+	zoom_display_init();
 
 	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
 	usb_ehci_init(&ehci_pdata);
-- 
1.5.6.3

