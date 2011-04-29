From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2 07/12] OMAP: Serial: Allow UART parameters to be configured from board file
Date: Fri, 29 Apr 2011 18:09:51 +0530
Message-ID: <1304080796-625-8-git-send-email-govindraj.raja@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Deepak K <deepak.k@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Jon Hunter <jon-hunter@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Deepak K <deepak.k@ti.com>

The following UART parameters are defined within the UART driver:

1). Whether the UART uses DMA (dma_enabled), by default set to 0
2). The size of dma buffer (set to 4096 bytes)
3). The time after which the dma should stop if no more data is received.
4). The auto suspend delay that will be passed for pm_runtime_autosuspend
    where uart will be disabled after timeout

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

Signed-off-by: Deepak K <deepak.k@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c           |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c           |    9 ++++---
 arch/arm/mach-omap2/board-4430sdp.c           |   11 +++++----
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
 arch/arm/mach-omap2/board-n8x0.c              |    9 ++++---
 arch/arm/mach-omap2/board-omap3beagle.c       |    3 +-
 arch/arm/mach-omap2/board-omap3evm.c          |    3 +-
 arch/arm/mach-omap2/board-omap3logic.c        |    3 +-
 arch/arm/mach-omap2/board-omap3pandora.c      |    3 +-
 arch/arm/mach-omap2/board-omap3stalker.c      |    3 +-
 arch/arm/mach-omap2/board-omap3touchbook.c    |    3 +-
 arch/arm/mach-omap2/board-omap4panda.c        |   11 +++++----
 arch/arm/mach-omap2/board-overo.c             |    3 +-
 arch/arm/mach-omap2/board-rm680.c             |    3 +-
 arch/arm/mach-omap2/board-rx51.c              |    3 +-
 arch/arm/mach-omap2/board-ti8168evm.c         |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c  |    3 +-
 arch/arm/mach-omap2/serial.c                  |   28 +++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap-serial.h |   14 +++++++++--
 arch/arm/plat-omap/include/plat/serial.h      |    6 +++-
 drivers/tty/serial/omap-serial.c              |    8 ++----
 30 files changed, 109 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 1fa6bb8..88f969b 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -38,6 +38,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <plat/gpmc-smc91x.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -250,7 +251,7 @@ static void __init omap_2430sdp_init(void)
 	omap2430_i2c_init();
 
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
-	omap_serial_init();
+	omap_serial_init(NULL);
 	omap2_hsmmc_init(mmc);
 	omap2_usbfs_init(&sdp2430_usb_config);
 
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 9afd087..7912174 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -32,6 +32,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/mcspi.h>
+#include <plat/omap-serial.h>
 #include <plat/board.h>
 #include <plat/usb.h>
 #include <plat/common.h>
@@ -739,16 +740,16 @@ static struct omap_board_data serial3_data = {
 
 static inline void board_serial_init(void)
 {
-	omap_serial_init_port(&serial1_data);
-	omap_serial_init_port(&serial2_data);
-	omap_serial_init_port(&serial3_data);
+	omap_serial_init_port(&serial1_data, NULL);
+	omap_serial_init_port(&serial2_data, NULL);
+	omap_serial_init_port(&serial3_data, NULL);
 }
 #else
 #define board_mux	NULL
 
 static inline void board_serial_init(void)
 {
-	omap_serial_init();
+	omap_serial_init(NULL);
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 56702c5..c7651bd 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -37,6 +37,7 @@
 #include <plat/mmc.h>
 #include <plat/omap4-keypad.h>
 #include <plat/display.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -762,18 +763,18 @@ static inline void board_serial_init(void)
 	bdata.pads_cnt	= 0;
 	bdata.id	= 0;
 	/* pass dummy data for UART1 */
-	omap_serial_init_port(&bdata);
+	omap_serial_init_port(&bdata, NULL);
 
-	omap_serial_init_port(&serial2_data);
-	omap_serial_init_port(&serial3_data);
-	omap_serial_init_port(&serial4_data);
+	omap_serial_init_port(&serial2_data, NULL);
+	omap_serial_init_port(&serial3_data, NULL);
+	omap_serial_init_port(&serial4_data, NULL);
 }
 #else
 #define board_mux	NULL
 
 static inline void board_serial_init(void)
 {
-	omap_serial_init();
+	omap_serial_init(NULL);
 }
  #endif
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index ce7d5e6..9b9ad68 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -36,6 +36,7 @@
 #include <plat/usb.h>
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "control.h"
@@ -490,7 +491,7 @@ static void __init am3517_evm_init(void)
 
 	am3517_evm_i2c_init();
 	omap_display_init(&am3517_evm_dss_data);
-	omap_serial_init();
+	omap_serial_init(NULL);
 
 	/* Configure GPIO for EHCI port */
 	omap_mux_init_gpio(57, OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index f4f8374..0e1075a 100644
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
index b5772c1..7e5df0a 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -48,6 +48,7 @@
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
 #include <plat/mcspi.h>
+#include <plat/omap-serial.h>
 
 #include <mach/hardware.h>
 
@@ -729,7 +730,7 @@ static void __init cm_t35_init(void)
 	omap_board_config = cm_t35_config;
 	omap_board_config_size = ARRAY_SIZE(cm_t35_config);
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	cm_t35_init_i2c();
 	cm_t35_init_nand();
 	cm_t35_init_ads7846();
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index a27e3ee..1ba508b 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -43,6 +43,7 @@
 #include <plat/usb.h>
 #include <plat/nand.h>
 #include <plat/gpmc.h>
+#include <plat/omap-serial.h>
 
 #include <mach/am35xx.h>
 
@@ -291,7 +292,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 static void __init cm_t3517_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	omap_board_config = cm_t3517_config;
 	omap_board_config_size = ARRAY_SIZE(cm_t3517_config);
 	cm_t3517_init_leds();
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 65f9fde..fcf8c0d 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -47,6 +47,7 @@
 #include <plat/usb.h>
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
+#include <plat/omap-serial.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
@@ -786,7 +787,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 static void __init devkit8000_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
-	omap_serial_init();
+	omap_serial_init(NULL);
 
 	omap_dm9000_init();
 
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 73e3c31..0974c2a 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -29,6 +29,7 @@
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/omap-serial.h>
 
 static struct omap_board_config_kernel generic_config[] = {
 };
@@ -41,7 +42,7 @@ static void __init omap_generic_init_early(void)
 
 static void __init omap_generic_init(void)
 {
-	omap_serial_init();
+	omap_serial_init(NULL);
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
 }
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index bac7933..ef7204b 100644
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
 	h4_init_flash();
 }
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5b9bde7..b0fd9d6 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -34,6 +34,7 @@
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
 #include <plat/onenand.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -647,7 +648,7 @@ static void __init igep2_init(void)
 	igep2_i2c_init();
 	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
 	omap_display_init(&igep2_dss_data);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
 
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index 2cf86c3..b12bdcf 100644
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
 	usbhs_init(&usbhs_bdata);
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ea9f049..93fcbd9 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -40,6 +40,7 @@
 #include <plat/common.h>
 #include <plat/gpmc.h>
 #include <mach/board-zoom.h>
+#include <plat/omap-serial.h>
 
 #include <asm/delay.h>
 #include <plat/usb.h>
@@ -404,7 +405,7 @@ static void __init omap_ldp_init(void)
 	spi_register_board_info(ldp_spi_board_info,
 				ARRAY_SIZE(ldp_spi_board_info));
 	ads7846_dev_init();
-	omap_serial_init();
+	omap_serial_init(NULL);
 	usb_musb_init(&musb_board_data);
 	board_nand_init(ldp_nand_partitions,
 		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS, 0);
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index e710cd9..2d526de 100644
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
index 33007fd..e2a6758 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -40,6 +40,7 @@
 #include <asm/mach/flash.h>
 
 #include <plat/board.h>
+#include <plat/omap-serial.h>
 #include <plat/common.h>
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
@@ -662,7 +663,7 @@ static void __init omap3_beagle_init(void)
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_display_init(&beagle_dss_data);
-	omap_serial_init();
+	omap_serial_init(NULL);
 
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
 	gpio_request(170, "DVI_nPD");
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3fc85c6..803a790 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -46,6 +46,7 @@
 #include <plat/mcspi.h>
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -795,7 +796,7 @@ static void __init omap3_evm_init(void)
 	spi_register_board_info(omap3evm_spi_board_info,
 				ARRAY_SIZE(omap3evm_spi_board_info));
 
-	omap_serial_init();
+	omap_serial_init(NULL);
 
 	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
 	usb_nop_xceiv_register();
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index a49e6cf..6fbb8dd 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -44,6 +44,7 @@
 #include <plat/gpmc-smsc911x.h>
 #include <plat/gpmc.h>
 #include <plat/sdrc.h>
+#include <plat/omap-serial.h>
 
 #define OMAP3LOGIC_SMSC911X_CS			1
 
@@ -211,7 +212,7 @@ static void __init omap3logic_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3torpedo_fix_pbias_voltage();
 	omap3logic_i2c_init();
-	omap_serial_init();
+	omap_serial_init(NULL);
 	board_mmc_init();
 	board_smsc911x_init();
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 07dba88..ef9ba3e 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -48,6 +48,7 @@
 #include <plat/usb.h>
 #include <plat/display.h>
 #include <plat/nand.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -702,7 +703,7 @@ static void __init omap3pandora_init(void)
 	platform_add_devices(omap3pandora_devices,
 			ARRAY_SIZE(omap3pandora_devices));
 	omap_display_init(&pandora_dss_data);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap3pandora_ads7846_init();
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 848016c..de234c0 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -41,6 +41,7 @@
 #include <plat/usb.h>
 #include <plat/display.h>
 #include <plat/panel-generic-dpi.h>
+#include <plat/omap-serial.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
@@ -605,7 +606,7 @@ static void __init omap3_stalker_init(void)
 	spi_register_board_info(omap3stalker_spi_board_info,
 				ARRAY_SIZE(omap3stalker_spi_board_info));
 
-	omap_serial_init();
+	omap_serial_init(NULL);
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
 	ads7846_dev_init();
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 127cb17..8acf724 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -48,6 +48,7 @@
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -518,7 +519,7 @@ static void __init omap3_touchbook_init(void)
 	omap3_touchbook_i2c_init();
 	platform_add_devices(omap3_touchbook_devices,
 			ARRAY_SIZE(omap3_touchbook_devices));
-	omap_serial_init();
+	omap_serial_init(NULL);
 
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
 	gpio_request(176, "DVI_nPD");
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index f3a7b10..68eb722 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -40,6 +40,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
+#include <plat/omap-serial.h>
 #include <plat/panel-generic-dpi.h>
 #include "timer-gp.h"
 
@@ -577,18 +578,18 @@ static inline void board_serial_init(void)
 	bdata.pads_cnt  = 0;
 	bdata.id        = 0;
 	/* pass dummy data for UART1 */
-	omap_serial_init_port(&bdata);
+	omap_serial_init_port(&bdata, NULL);
 
-	omap_serial_init_port(&serial2_data);
-	omap_serial_init_port(&serial3_data);
-	omap_serial_init_port(&serial4_data);
+	omap_serial_init_port(&serial2_data, NULL);
+	omap_serial_init_port(&serial3_data, NULL);
+	omap_serial_init_port(&serial4_data, NULL);
 }
 #else
 #define board_mux	NULL
 
 static inline void board_serial_init(void)
 {
-	omap_serial_init();
+	omap_serial_init(NULL);
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4016166..4944c02 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -52,6 +52,7 @@
 #include <plat/mcspi.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -653,7 +654,7 @@ static void __init overo_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	overo_i2c_init();
 	omap_display_init(&overo_dss_data);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	overo_flash_init();
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 2af8b05..f3fa27b 100644
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
index f8ba20a..8340314 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -29,6 +29,7 @@
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <plat/usb.h>
+#include <plat/omap-serial.h>
 
 #include "mux.h"
 #include "pm.h"
@@ -127,7 +128,7 @@ static void __init rx51_init(void)
 	omap_board_config = rx51_config;
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap3_pm_init_cpuidle(rx51_cpuidle_params);
-	omap_serial_init();
+	omap_serial_init(NULL);
 	usb_musb_init(&musb_board_data);
 	rx51_peripherals_init();
 
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index 09fa7bf..90de40d 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -40,7 +40,7 @@ static void __init ti8168_evm_init_irq(void)
 
 static void __init ti8168_evm_init(void)
 {
-	omap_serial_init();
+	omap_serial_init(NULL);
 	omap_board_config = ti8168_evm_config;
 	omap_board_config_size = ARRAY_SIZE(ti8168_evm_config);
 }
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 8dee754..e35400c 100644
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
index 314d82f..b1b7ad6 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -44,6 +44,15 @@
 
 static int omap_uart_con_id __initdata = -1;
 
+static struct omap_uart_port_info omap_serial_default_info[] = {
+	{
+		.dma_enabled	= 0,
+		.dma_rx_buf_size = DEFAULT_RXDMA_BUFSIZE,
+		.dma_rx_timeout = DEFAULT_RXDMA_TIMEOUT,
+		.auto_sus_timeout = DEFAULT_AUTOSUSPEND_DELAY,
+	},
+};
+
 static int uart_idle_hwmod(struct omap_device *od)
 {
 	omap_hwmod_idle(od->hwmods[0]);
@@ -307,6 +316,7 @@ core_initcall(omap_serial_early_init);
 /**
  * omap_serial_init_port() - initialize single serial port
  * @bdata: port specific board data pointer
+ * @info: platform specific data pointer
  *
  * This function initialies serial driver for given port only.
  * Platforms can call this function instead of omap_serial_init()
@@ -315,7 +325,8 @@ core_initcall(omap_serial_early_init);
  * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
  * use only one of the two.
  */
-void __init omap_serial_init_port(struct omap_board_data *bdata)
+void __init omap_serial_init_port(struct omap_board_data *bdata,
+			struct omap_uart_port_info *info)
 {
 	struct omap_hwmod *oh;
 	struct omap_device *od;
@@ -333,6 +344,9 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	if (!oh)
 		return;
 
+	if (info == NULL)
+		info = omap_serial_default_info;
+
 	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
 		pr_err("Memory allocation for UART pdata failed\n");
@@ -348,6 +362,10 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	pdata->uartclk = OMAP24XX_BASE_BAUD * 16;
 	pdata->flags = UPF_BOOT_AUTOCONF;
 	pdata->enable_wakeup = omap_uart_wakeup_enable;
+	pdata->dma_enabled = info->dma_enabled;
+	pdata->dma_rx_buf_size = info->dma_rx_buf_size;
+	pdata->dma_rx_timeout = info->dma_rx_timeout;
+	pdata->auto_sus_timeout = info->auto_sus_timeout;
 	if (bdata->id == omap_uart_con_id)
 		pdata->console_uart = true;
 
@@ -366,16 +384,20 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
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
@@ -384,5 +406,7 @@ void __init omap_serial_init(void)
 
 		if (cpu_is_omap44xx() || cpu_is_omap34xx())
 			omap_serial_fill_default_pads(&bdata);
+
+		omap_serial_init_port(&bdata, info);
 	}
 }
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index ac30de8..4e2dcdc 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -51,7 +51,12 @@
 
 #define OMAP_UART_DMA_CH_FREE	-1
 
-#define RX_TIMEOUT		(3 * HZ)
+#define RX_TIMEOUT		(3 * HZ)	/* RX DMA timeout (jiffies) */
+#define DEFAULT_RXDMA_TIMEOUT	1		/* RX DMA polling rate (us) */
+#define DEFAULT_RXDMA_BUFSIZE	4096		/* RX DMA buffer size */
+#define DEFAULT_AUTOSUSPEND_DELAY (30 * HZ) /* Runtime autosuspend (msecs) */
+
+
 #define OMAP_MAX_HSUART_PORTS	4
 
 #define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
@@ -64,6 +69,9 @@ struct omap_uart_port_info {
 	upf_t			flags;		/* UPF_* flags */
 	unsigned int		errata;
 	unsigned int		console_uart;
+	unsigned int		dma_rx_buf_size;/* DMA Rx Buffer Size */
+	unsigned int		dma_rx_timeout;	/* DMA RX timeout */
+	unsigned int		auto_sus_timeout; /* Auto_suspend timeout */
 
 	void (*enable_wakeup)(struct platform_device *, bool);
 	void __iomem *wk_st;
@@ -92,8 +100,8 @@ struct uart_omap_dma {
 	spinlock_t		rx_lock;
 	/* timer to poll activity on rx dma */
 	struct timer_list	rx_timer;
-	int			rx_buf_size;
-	int			rx_timeout;
+	unsigned int		rx_buf_size;
+	unsigned int		rx_timeout;
 };
 
 struct uart_omap_port {
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index ab1761a..a18668d 100644
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
 #endif
 
 #endif
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index b275321..c525537 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -44,8 +44,6 @@
 #include <plat/omap-serial.h>
 #include <plat/omap_device.h>
 
-#define OMAP_UART_AUTOSUSPEND_DELAY (30 * HZ) /* Value is msecs */
-
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
 /* Forward declaration of functions */
@@ -1386,8 +1384,8 @@ static int serial_omap_probe(struct platform_device *pdev)
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
@@ -1396,7 +1394,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
-			OMAP_UART_AUTOSUSPEND_DELAY);
+			omap_up_info->auto_sus_timeout);
 
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_irq_safe(&pdev->dev);
-- 
1.7.1

