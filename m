From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2 09/12] OMAP3: Serial: Remove uart pads from 3430 board file.
Date: Fri, 29 Apr 2011 18:09:53 +0530
Message-ID: <1304080796-625-10-git-send-email-govindraj.raja@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

The pad values here are same as the default pad values updated in serial.c file.
Avoid structure duplication and use default pads.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |  100 +----------------------------------
 1 files changed, 1 insertions(+), 99 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 7912174..7dab960 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -651,106 +651,8 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-
-static struct omap_device_pad serial1_pads[] __initdata = {
-	/*
-	 * Note that off output enable is an active low
-	 * signal. So setting this means pin is a
-	 * input enabled in off mode
-	 */
-	OMAP_MUX_STATIC("uart1_cts.uart1_cts",
-			 OMAP_PIN_INPUT |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart1_rts.uart1_rts",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart1_rx.uart1_rx",
-			 OMAP_PIN_INPUT |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart1_tx.uart1_tx",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-};
-
-static struct omap_device_pad serial2_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart2_cts.uart2_cts",
-			 OMAP_PIN_INPUT_PULLUP |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_rts.uart2_rts",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_rx.uart2_rx",
-			 OMAP_PIN_INPUT |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_tx.uart2_tx",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-};
-
-static struct omap_device_pad serial3_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart3_cts_rctx.uart3_cts_rctx",
-			 OMAP_PIN_INPUT_PULLDOWN |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_rts_sd.uart3_rts_sd",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_rx_irrx.uart3_rx_irrx",
-			 OMAP_PIN_INPUT |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_tx_irtx.uart3_tx_irtx",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-};
-
-static struct omap_board_data serial1_data = {
-	.id		= 0,
-	.pads		= serial1_pads,
-	.pads_cnt	= ARRAY_SIZE(serial1_pads),
-};
-
-static struct omap_board_data serial2_data = {
-	.id		= 1,
-	.pads		= serial2_pads,
-	.pads_cnt	= ARRAY_SIZE(serial2_pads),
-};
-
-static struct omap_board_data serial3_data = {
-	.id		= 2,
-	.pads		= serial3_pads,
-	.pads_cnt	= ARRAY_SIZE(serial3_pads),
-};
-
-static inline void board_serial_init(void)
-{
-	omap_serial_init_port(&serial1_data, NULL);
-	omap_serial_init_port(&serial2_data, NULL);
-	omap_serial_init_port(&serial3_data, NULL);
-}
 #else
 #define board_mux	NULL
-
-static inline void board_serial_init(void)
-{
-	omap_serial_init(NULL);
-}
 #endif
 
 /*
@@ -895,7 +797,7 @@ static void __init omap_3430sdp_init(void)
 	spi_register_board_info(sdp3430_spi_board_info,
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
-	board_serial_init();
+	omap_serial_init(NULL);
 	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
-- 
1.7.1

