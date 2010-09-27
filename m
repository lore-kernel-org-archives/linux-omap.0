From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 13/13 v3] OMAP3: SERIAL: Initialize all omap-uarts for zoom
     boards
Date: Mon, 27 Sep 2010 20:21:05 +0530 (IST)
Message-ID: <43830.10.24.255.17.1285599065.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41590 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932578Ab0I0OvL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Sep 2010 10:51:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Anand Gadiyar <gadiyar@ti.com>

Iniatize all omap-uarts for zoom boards.
Now zoom_peripheral_init will initialise
all uarts for 3630. 3630sdp_board_init call
zoom_peripheral_init so we can now remove
serial_init from 3630sdp board init as
zoom_peripheral_init now will do that the
same.

Signed-off-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/board-3630sdp.c          |    1 -
 arch/arm/mach-omap2/board-zoom-peripherals.c |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index b359c3f..d510451 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -208,7 +208,6 @@ static struct flash_partitions sdp_flash_partitions[] = {
 static void __init omap_sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
-	omap_serial_init();
 	zoom_peripherals_init();
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_sdp);
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6b39849..641765a 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -282,4 +282,5 @@ void __init zoom_peripherals_init(void)
 	omap_i2c_init();
 	usb_musb_init(&musb_board_data);
 	enable_board_wakeup_source();
+	omap_serial_init();
 }
-- 
1.6.3.3


