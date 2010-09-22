From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 13/13 v2] OMAP3: SERIAL: Initialize all omap-uarts for zoom
     boards
Date: Wed, 22 Sep 2010 20:44:52 +0530 (IST)
Message-ID: <37596.172.24.137.131.1285168492.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Anand Gadiyar <gadiyar@ti.com>
List-Id: linux-omap@vger.kernel.org

Iniatize all omap-uarts for zoom boards.
Remove serial_init from 3630sdp board init
as zoom_peripheral_init does the same.

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




