From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 6/7] OMAP: Serial: Allow UART parameters to be configured from board file
Date: Mon, 28 Feb 2011 20:09:17 +0530
Message-ID: <1298903958-6496-7-git-send-email-govindraj.raja@ti.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35787 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab1B1OQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 09:16:09 -0500
In-Reply-To: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Deepak K <deepak.k@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

The following UART parameters are defined within the UART driver:

1). Whether the UART uses DMA (dma_enabled), by default set to 0
2). The size of dma buffer (set to 4096 bytes)
3). The time after which the dma should stop if no more data is received.
4). The idle timeout (DEFAULT_TIMEOUT) that sets the can_sleep flag after
    uart inactivity.
5). Add default serial pads to board data if no pad info is available from
    board file to avoid breaking uart wakeup capability from rx pad.

Different UARTs may be used for different purpose such as the console,
for interfacing bluetooth chip, for interfacing to a modem chip, etc.
Therefore, it is necessary to be able to customize the above settings
for a given board on a per UART basis.

This change allows these parameters to be configured from the board file
and allows the parameters to be configured for each UART independently.

If a board does not define its own custom parameters for the UARTs, then
use the default parameters in the structure "omap_serial_default_info".
The default parameters are defined to be the same as the current settings
in the UART driver to avoid breaking the UART for any board. By default,
make all boards use the default UART parameters.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Deepak K <deepak.k@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c           |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c           |    4 +-
 arch/arm/mach-omap2/board-4430sdp.c           |    3 +-
 arch/arm/mach-omap2/board-am3517evm.c         |    3 +-
 arch/arm/mach-omap2/board-apollon.c           |    3 +-
 arch/arm/mach-omap2/board-cm-t35.c            |    3 +-
 arch/arm/mach-omap2/board-cm-t3517.c          |    3 +-
 arch/arm/mach-omap2/board-devkit8000.c        |    3 +-
 arch/arm/mach-omap2/board-generic.c           |    3 +-
 arch/arm/mach-omap2/board-h4.c                |    3 +-
 arch/arm/mach-omap2/board-igep0020.c          |    3 +-
 arch/arm/mach-omap2/board-igep0030.c          |    3 +-
 arch/arm/mach-omap2/board-ldp.c               |    3 +-
 arch/arm/mach-omap2/board-n8x0.c              |    9 +-
 arch/arm/mach-omap2/board-omap3beagle.c       |    3 +-
 arch/arm/mach-omap2/board-omap3evm.c          |    3 +-
 arch/arm/mach-omap2/board-omap3logic.c        |    3 +-
 arch/arm/mach-omap2/board-omap3pandora.c      |    3 +-
 arch/arm/mach-omap2/board-omap3stalker.c      |    3 +-
 arch/arm/mach-omap2/board-omap3touchbook.c    |    3 +-
 arch/arm/mach-omap2/board-omap4panda.c        |    3 +-
 arch/arm/mach-omap2/board-overo.c             |    3 +-
 arch/arm/mach-omap2/board-rm680.c             |    3 +-
 arch/arm/mach-omap2/board-rx51.c              |    3 +-
 arch/arm/mach-omap2/board-ti8168evm.c         |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c  |    3 +-
 arch/arm/mach-omap2/serial.c                  |  108 +++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap-serial.h |   14 +++-
 arch/arm/plat-omap/include/plat/serial.h      |    6 +-
 drivers/tty/serial/omap-serial.c              |   10 +-
 30 files changed, 177 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index cc42d47..0cfa3c7 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -38,6 +38,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <plat/gpmc-smc91x.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -249,7 +250,7 @@ static void __init omap_2430sdp_init(void)
 	omap2430_i2c_init();
 
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
-	omap_serial_init();
+	omap_serial_init(NULL);
 	omap2_hsmmc_init(mmc);
 	omap2_usbfs_init(&sdp2430_usb_config);
 
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 8950ecc..7d7df08 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -39,8 +39,8 @@
 #include <plat/gpmc.h>
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
-
 #include <plat/gpmc-smc91x.h>
+#include <plat/omap-serial.h>
 
 #include "board-flash.h"
 #include "mux.h"
@@ -798,7 +798,7 @@ static void __init omap_3430sdp_init(void)
 	spi_register_board_info(sdp3430_spi_board_info,
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
-	omap_serial_init();
+	omap_serial_init(NULL);
 	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 1a943be..9687aec 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -36,6 +36,7 @@
 #include <plat/usb.h>
 #include <plat/mmc.h>
 #include <plat/omap4-keypad.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -643,7 +644,7 @@ static void __init omap_4430sdp_init(void)
 	omap4_i2c_init();
 	omap_sfh7741prox_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
-	omap_serial_init();
+	omap_serial_init(NULL);
 	omap4_twl6030_hsmmc_init(mmc);
 
 	usb_musb_init(&musb_board_data);
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 634fe65..bbc79a4 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -36,6 +36,7 @@
 #include <plat/usb.h>
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "control.h"
@@ -487,7 +488,7 @@ static void __init am3517_evm_init(void)
 
 	am3517_evm_i2c_init();
 	omap_display_init(&am3517_evm_dss_data);
-	omap_serial_init();
+	omap_serial_init(NULL);
 
 	/* Configure GPIO for EHCI port */
 	omap_mux_init_gpio(57, OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 4ef4aad..e021cdb 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -39,6 +39,7 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/gpmc.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "control.h"
@@ -342,7 +343,7 @@ static void __init omap_apollon_init(void)
 	 * if not needed.
 	 */
 	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
-	omap_serial_init();
+	omap_serial_init(NULL);
 }
 
 static void __init omap_apollon_map_io(void)
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 7311824..8ecde7e 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -48,6 +48,7 @@
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
 #include <plat/mcspi.h>
+#include <plat/omap-serial.h>
 
 #include <mach/hardware.h>
 
@@ -788,7 +789,7 @@ static struct omap_musb_board_data musb_board_data = {
 static void __init cm_t35_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	cm_t35_init_i2c();
 	cm_t35_init_nand();
 	cm_t35_init_ads7846();
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 38bef6d..a1c0d87 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -43,6 +43,7 @@
 #include <plat/usb.h>
 #include <plat/nand.h>
 #include <plat/gpmc.h>
+#include <plat/omap-serial.h>
 
 #include <mach/am35xx.h>
 
@@ -292,7 +293,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 static void __init cm_t3517_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	cm_t3517_init_leds();
 	cm_t3517_init_nand();
 	cm_t3517_init_rtc();
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 54abdd0..28fac56 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -47,6 +47,7 @@
 #include <plat/usb.h>
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
+#include <plat/omap-serial.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
@@ -784,7 +785,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 static void __init devkit8000_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
-	omap_serial_init();
+	omap_serial_init(NULL);
 
 	omap_dm9000_init();
 
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 682da92..450128b 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -29,6 +29,7 @@
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/omap-serial.h>
 
 static struct omap_board_config_kernel generic_config[] = {
 };
@@ -43,7 +44,7 @@ static void __init omap_generic_init_early(void)
 
 static void __init omap_generic_init(void)
 {
-	omap_serial_init();
+	omap_serial_init(NULL);
 }
 
 static void __init omap_generic_map_io(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index f6a3872..6481bab 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -39,6 +39,7 @@
 #include <plat/menelaus.h>
 #include <plat/dma.h>
 #include <plat/gpmc.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "control.h"
@@ -370,7 +371,7 @@ static void __init omap_h4_init(void)
 
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
 	omap2_usbfs_init(&h4_usb_config);
-	omap_serial_init();
+	omap_serial_init(NULL);
 }
 
 static void __init omap_h4_map_io(void)
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 54e6318..9223b9b 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -34,6 +34,7 @@
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
 #include <plat/onenand.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -686,7 +687,7 @@ static void __init igep2_init(void)
 	igep2_i2c_init();
 	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
 	omap_display_init(&igep2_dss_data);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index d75028e..c593a5c 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -31,6 +31,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <plat/onenand.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -432,7 +433,7 @@ static void __init igep3_init(void)
 	/* Register I2C busses and drivers */
 	igep3_i2c_init();
 	platform_add_devices(igep3_devices, ARRAY_SIZE(igep3_devices));
-	omap_serial_init();
+	omap_serial_init(NULL);
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index a3fae56..ff93da7 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -40,6 +40,7 @@
 #include <plat/common.h>
 #include <plat/gpmc.h>
 #include <mach/board-zoom.h>
+#include <plat/omap-serial.h>
 
 #include <asm/delay.h>
 #include <plat/usb.h>
@@ -430,7 +431,7 @@ static void __init omap_ldp_init(void)
 	spi_register_board_info(ldp_spi_board_info,
 				ARRAY_SIZE(ldp_spi_board_info));
 	ads7846_dev_init();
-	omap_serial_init();
+	omap_serial_init(NULL);
 	usb_musb_init(&musb_board_data);
 	board_nand_init(ldp_nand_partitions,
 		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS, 0);
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index b36cbd2..7347256 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -33,6 +33,7 @@
 #include <plat/onenand.h>
 #include <plat/mmc.h>
 #include <plat/serial.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 
@@ -662,22 +663,22 @@ static inline void board_serial_init(void)
 	bdata.pads_cnt = 0;
 
 	bdata.id = 0;
-	omap_serial_init_port(&bdata);
+	omap_serial_init_port(&bdata, NULL);
 
 	bdata.id = 1;
-	omap_serial_init_port(&bdata);
+	omap_serial_init_port(&bdata, NULL);
 
 	bdata.id = 2;
 	bdata.pads = serial2_pads;
 	bdata.pads_cnt = ARRAY_SIZE(serial2_pads);
-	omap_serial_init_port(&bdata);
+	omap_serial_init_port(&bdata, NULL);
 }
 
 #else
 
 static inline void board_serial_init(void)
 {
-	omap_serial_init();
+	omap_serial_init(NULL);
 }
 
 #endif
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index a1faea3..e6c0299 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -45,6 +45,7 @@
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -613,7 +614,7 @@ static void __init omap3_beagle_init(void)
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_display_init(&beagle_dss_data);
-	omap_serial_init();
+	omap_serial_init(NULL);
 
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
 	gpio_request(170, "DVI_nPD");
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 5364147..0b793f1 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -46,6 +46,7 @@
 #include <plat/mcspi.h>
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -831,7 +832,7 @@ static void __init omap3_evm_init(void)
 	spi_register_board_info(omap3evm_spi_board_info,
 				ARRAY_SIZE(omap3evm_spi_board_info));
 
-	omap_serial_init();
+	omap_serial_init(NULL);
 
 	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
 	usb_nop_xceiv_register();
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index b726943..0b5ba52 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -44,6 +44,7 @@
 #include <plat/gpmc-smsc911x.h>
 #include <plat/gpmc.h>
 #include <plat/sdrc.h>
+#include <plat/omap-serial.h>
 
 #define OMAP3LOGIC_SMSC911X_CS			1
 
@@ -212,7 +213,7 @@ static void __init omap3logic_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3torpedo_fix_pbias_voltage();
 	omap3logic_i2c_init();
-	omap_serial_init();
+	omap_serial_init(NULL);
 	board_mmc_init();
 	board_smsc911x_init();
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 17ef547..6f84247 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -48,6 +48,7 @@
 #include <plat/usb.h>
 #include <plat/display.h>
 #include <plat/nand.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -703,7 +704,7 @@ static void __init omap3pandora_init(void)
 	platform_add_devices(omap3pandora_devices,
 			ARRAY_SIZE(omap3pandora_devices));
 	omap_display_init(&pandora_dss_data);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap3pandora_ads7846_init();
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 07006c3..629bdce 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -41,6 +41,7 @@
 #include <plat/usb.h>
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
+#include <plat/omap-serial.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
@@ -639,7 +640,7 @@ static void __init omap3_stalker_init(void)
 	spi_register_board_info(omap3stalker_spi_board_info,
 				ARRAY_SIZE(omap3stalker_spi_board_info));
 
-	omap_serial_init();
+	omap_serial_init(NULL);
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	ads7846_dev_init();
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 6a60f79..c6bf289 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -48,6 +48,7 @@
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -519,7 +520,7 @@ static void __init omap3_touchbook_init(void)
 	omap3_touchbook_i2c_init();
 	platform_add_devices(omap3_touchbook_devices,
 			ARRAY_SIZE(omap3_touchbook_devices));
-	omap_serial_init();
+	omap_serial_init(NULL);
 
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
 	gpio_request(176, "DVI_nPD");
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 3dd241b..2245ed1 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -39,6 +39,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
+#include <plat/omap-serial.h>
 #include "timer-gp.h"
 
 #include "hsmmc.h"
@@ -470,7 +471,7 @@ static void __init omap4_panda_init(void)
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	platform_device_register(&omap_vwlan_device);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	omap4_twl6030_hsmmc_init(mmc);
 	omap4_ehci_init();
 	usb_musb_init(&musb_board_data);
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index a33ec0e..960a3ea 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -46,6 +46,7 @@
 #include <mach/hardware.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -450,7 +451,7 @@ static void __init overo_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	overo_i2c_init();
 	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
-	omap_serial_init();
+	omap_serial_init(NULL);
 	overo_flash_init();
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index bdebcb7..bd4b7ad 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -27,6 +27,7 @@
 #include <plat/gpmc.h>
 #include <plat/common.h>
 #include <plat/onenand.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -162,7 +163,7 @@ static struct omap_musb_board_data rm680_musb_data = {
 static void __init rm680_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	usb_musb_init(&rm680_musb_data);
 	rm680_peripherals_init();
 }
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 3cf72fe..08619e9 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -29,6 +29,7 @@
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <plat/usb.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "pm.h"
@@ -127,7 +128,7 @@ static struct omap_musb_board_data musb_board_data = {
 static void __init rx51_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	usb_musb_init(&musb_board_data);
 	rx51_peripherals_init();
 
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index f2b0971..c4f83ed 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -42,7 +42,7 @@ static void __init ti8168_evm_init_irq(void)
 
 static void __init ti8168_evm_init(void)
 {
-	omap_serial_init();
+	omap_serial_init(NULL);
 }
 
 static void __init ti8168_evm_map_io(void)
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index e0e040f..82ca121 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -26,6 +26,7 @@
 
 #include <plat/common.h>
 #include <plat/usb.h>
+#include <plat/omap-serial.h>
 
 #include <mach/board-zoom.h>
 
@@ -394,5 +395,5 @@ void __init zoom_peripherals_init(void)
 	platform_device_register(&omap_vwlan_device);
 	usb_musb_init(&musb_board_data);
 	enable_board_wakeup_source();
-	omap_serial_init();
+	omap_serial_init(NULL);
 }
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 755f4aa..530e9e3 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -44,6 +44,15 @@
 
 static int omap_uart_con_id __initdata = -1;
 
+static struct omap_uart_port_info omap_serial_default_info[] = {
+	{
+		.dma_enabled	= 0,
+		.dma_rx_buf_size = DEFAULT_RXDMA_BUFSIZE,
+		.dma_rx_timeout = DEFAULT_RXDMA_TIMEOUT,
+		.idle_timeout	= DEFAULT_IDLE_TIMEOUT,
+	},
+};
+
 static int uart_idle_hwmod(struct omap_device *od)
 {
 	omap_hwmod_idle(od->hwmods[0]);
@@ -66,6 +75,54 @@ static struct omap_device_pm_latency omap_uart_latency[] = {
 	},
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_device_pad default_serial0_pads[] __initdata = {
+	{
+		.name	= "uart1_rx.uart1_rx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad default_serial1_pads[] __initdata = {
+	{
+		.name	= "uart2_rx.uart2_rx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad default_serial2_pads[] __initdata = {
+	{
+		.name	= "uart3_rx_irrx.uart3_rx_irrx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad default_omap36xx_serial3_pads[] __initdata = {
+	{
+		.name	= "gpmc_wait3.uart4_rx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_MUX_MODE2,
+	},
+};
+
+static struct omap_device_pad default_omap4_serial3_pads[] __initdata = {
+	{
+		.name	= "uart4_rx.uart4_rx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_MUX_MODE0,
+	},
+};
+#else
+static struct omap_device_pad default_serial0_pads[] __initdata = {};
+static struct omap_device_pad default_serial1_pads[] __initdata = {};
+static struct omap_device_pad default_serial2_pads[] __initdata = {};
+static struct omap_device_pad default_omap36xx_serial3_pads[] __initdata = {};
+static struct omap_device_pad default_omap4_serial3_pads[] __initdata = {};
+#endif
+
 static void omap_uart_idle_init(struct omap_uart_port_info *uart,
 				unsigned short num)
 {
@@ -164,6 +221,7 @@ core_initcall(omap_serial_early_init);
 /**
  * omap_serial_init_port() - initialize single serial port
  * @bdata: port specific board data pointer
+ * @info: platform specific data pointer
  *
  * This function initialies serial driver for given port only.
  * Platforms can call this function instead of omap_serial_init()
@@ -172,7 +230,8 @@ core_initcall(omap_serial_early_init);
  * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
  * use only one of the two.
  */
-void __init omap_serial_init_port(struct omap_board_data *bdata)
+void __init omap_serial_init_port(struct omap_board_data *bdata,
+			struct omap_uart_port_info *info)
 {
 	struct omap_hwmod *oh;
 	struct omap_device *od;
@@ -190,6 +249,9 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	if (!oh)
 		return;
 
+	if (info == NULL)
+		info = omap_serial_default_info;
+
 	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
 		pr_err("Memory allocation for UART pdata failed\n");
@@ -204,6 +266,10 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 	pdata->uartclk = OMAP24XX_BASE_BAUD * 16;
 	pdata->flags = UPF_BOOT_AUTOCONF;
+	pdata->dma_enabled = info->dma_enabled;
+	pdata->dma_rx_buf_size = info->dma_rx_buf_size;
+	pdata->dma_rx_timeout = info->dma_rx_timeout;
+	pdata->idle_timeout = info->idle_timeout;
 	if (bdata->id == omap_uart_con_id)
 		pdata->console_uart = true;
 
@@ -222,21 +288,53 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 /**
  * omap_serial_init() - initialize all supported serial ports
+ * @info: platform specific data pointer
  *
  * Initializes all available UARTs as serial ports. Platforms
  * can call this function when they want to have default behaviour
  * for serial ports (e.g initialize them all as serial ports).
  */
-void __init omap_serial_init(void)
+void __init omap_serial_init(struct omap_uart_port_info *info)
 {
 	struct omap_board_data bdata;
 	u8 i;
 
+	if (info == NULL)
+		info = omap_serial_default_info;
+
 	for (i = 0; i < OMAP_MAX_HSUART_PORTS; i++) {
 		bdata.id = i;
 		bdata.flags = 0;
-		bdata.pads = NULL;
-		bdata.pads_cnt = 0;
-		omap_serial_init_port(&bdata);
+		switch (i) {
+		case 0:
+			bdata.pads = default_serial0_pads;
+			bdata.pads_cnt = ARRAY_SIZE(default_serial0_pads);
+			break;
+		case 1:
+			bdata.pads = default_serial1_pads;
+			bdata.pads_cnt = ARRAY_SIZE(default_serial1_pads);
+			break;
+		case 2:
+			bdata.pads = default_serial2_pads;
+			bdata.pads_cnt = ARRAY_SIZE(default_serial2_pads);
+			break;
+		case 3:
+			if (cpu_is_omap44xx()) {
+				bdata.pads = default_omap4_serial3_pads;
+				bdata.pads_cnt =
+					ARRAY_SIZE(default_omap4_serial3_pads);
+			} else {
+				bdata.pads = default_omap36xx_serial3_pads;
+				bdata.pads_cnt =
+					ARRAY_SIZE(default_omap36xx_serial3_pads);
+			}
+			break;
+		default:
+			bdata.pads = NULL;
+			bdata.pads_cnt = 0;
+			break;
+		}
+
+		omap_serial_init_port(&bdata, info);
 	}
 }
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index f9bc7ef..4f12d6c 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -51,7 +51,11 @@
 
 #define OMAP_UART_DMA_CH_FREE	-1
 
-#define RX_TIMEOUT		(3 * HZ)
+#define RX_TIMEOUT		(3 * HZ)	/* RX DMA timeout (jiffies) */
+#define DEFAULT_RXDMA_TIMEOUT	1		/* RX DMA polling rate (us) */
+#define DEFAULT_RXDMA_BUFSIZE	4096		/* RX DMA buffer size */
+#define DEFAULT_IDLE_TIMEOUT	(5 * HZ)	/* UART idle timeout (secs) */
+
 #define OMAP_MAX_HSUART_PORTS	4
 
 #define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
@@ -64,6 +68,9 @@ struct omap_uart_port_info {
 	upf_t			flags;		/* UPF_* flags */
 	unsigned int		errata;
 	unsigned int		console_uart;
+	unsigned int		dma_rx_buf_size;/* DMA Rx Buffer Size */
+	unsigned int		dma_rx_timeout;	/* DMA RX timeout */
+	unsigned int		idle_timeout;	/* OMAP UART idle timeout */
 
 	void __iomem *wk_st;
 	void __iomem *wk_en;
@@ -91,8 +98,8 @@ struct uart_omap_dma {
 	spinlock_t		rx_lock;
 	/* timer to poll activity on rx dma */
 	struct timer_list	rx_timer;
-	int			rx_buf_size;
-	int			rx_timeout;
+	unsigned int		rx_buf_size;
+	unsigned int		rx_timeout;
 };
 
 struct uart_omap_port {
@@ -120,6 +127,7 @@ struct uart_omap_port {
 	char			name[20];
 	unsigned long		port_activity;
 	struct timer_list	inactivity_timer;
+	unsigned int		idle_timeout;
 	unsigned int		errata;
 	int			can_sleep;
 
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 6339848..2ed24b3 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -103,9 +103,11 @@
 #ifndef __ASSEMBLER__
 
 struct omap_board_data;
+struct omap_uart_port_info;
 
-extern void omap_serial_init(void);
-extern void omap_serial_init_port(struct omap_board_data *bdata);
+extern void omap_serial_init(struct omap_uart_port_info *platform_data);
+extern void omap_serial_init_port(struct omap_board_data *bdata,
+		struct omap_uart_port_info *platform_data);
 extern void omap_uart_prepare_idle(int num);
 extern void omap_uart_resume_idle(int num);
 #endif
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index bc877b9..008645c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -47,8 +47,6 @@
 #define omap_uart_console(port)	NULL
 #endif
 
-#define OMAP_UART_CLK_PUT_DELAY (5 * HZ)
-
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
 /* Forward declaration of functions */
@@ -139,7 +137,7 @@ static void serial_omap_port_enable(struct uart_omap_port *up)
 	}
 
 	up->can_sleep = 0;
-	mod_timer(&up->inactivity_timer, jiffies + OMAP_UART_CLK_PUT_DELAY);
+	mod_timer(&up->inactivity_timer, jiffies + up->idle_timeout);
 }
 
 void omap_uart_prepare_idle(int num)
@@ -1412,16 +1410,18 @@ static int serial_omap_probe(struct platform_device *pdev)
 		up->uart_dma.uart_dma_tx = dma_tx->start;
 		up->uart_dma.uart_dma_rx = dma_rx->start;
 		up->use_dma = 1;
-		up->uart_dma.rx_buf_size = 4096;
-		up->uart_dma.rx_timeout = 2;
+		up->uart_dma.rx_buf_size = omap_up_info->dma_rx_buf_size;
+		up->uart_dma.rx_timeout = omap_up_info->dma_rx_timeout;
 		spin_lock_init(&(up->uart_dma.tx_lock));
 		spin_lock_init(&(up->uart_dma.rx_lock));
 		up->uart_dma.tx_dma_channel = OMAP_UART_DMA_CH_FREE;
 		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
 	}
+
 	init_timer(&(up->inactivity_timer));
 	up->inactivity_timer.function = serial_omap_inactivity_timer;
 	up->inactivity_timer.data = up->pdev->id;
+	up->idle_timeout = omap_up_info->idle_timeout;
 
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_irq_safe(&pdev->dev);
-- 
1.7.1

