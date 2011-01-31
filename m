From: sricharan <r.sricharan@ti.com>
Subject: [PATCH v2 3/5] omap3: board-3430sdp: Initialise the serial pads.
Date: Mon, 31 Jan 2011 19:52:50 +0530
Message-ID: <1296483770-21915-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37160 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab1AaOUl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 09:20:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: r.sricharan@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pswan.com, gadiyar@ti.com, b-cousson@ti.com

Corrected a checkpatch warning.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   86 ++++++++++++++++++++++++++++++++++-
 1 files changed, 85 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 3b39ef1..896fcde 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -663,6 +663,90 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+
+static struct omap_device_pad serial1_pads[] __initdata = {
+	{ .name   = "uart1_cts.uart1_cts",
+	  .enable = OMAP_PIN_INPUT|
+		    OMAP_PIN_OFF_INPUT_PULLDOWN |
+		    OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart1_rts.uart1_rts",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart1_rx.uart1_rx",
+	  .enable = OMAP_PIN_INPUT | OMAP_PIN_OFF_INPUT_PULLDOWN |
+		    OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart1_tx.uart1_tx",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad serial2_pads[] __initdata = {
+	{ .name   = "uart2_cts.uart2_cts",
+	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_INPUT_PULLDOWN |
+		    OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart2_rts.uart2_rts",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart2_rx.uart2_rx",
+	  .enable = OMAP_PIN_INPUT | OMAP_PIN_OFF_INPUT_PULLDOWN |
+		    OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart2_tx.uart2_tx",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad serial3_pads[] __initdata = {
+	{ .name   = "uart3_cts_rctx.uart3_cts_rctx",
+	  .enable = OMAP_PIN_INPUT_PULLDOWN |
+		    OMAP_PIN_OFF_INPUT_PULLDOWN | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart3_rts_sd.uart3_rts_sd",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart3_rx_irrx.uart3_rx_irrx",
+	  .enable = OMAP_PIN_INPUT | OMAP_PIN_OFF_INPUT_PULLDOWN |
+		    OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart3_tx_irtx.uart3_tx_irtx",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_board_data serial1_data = {
+	.id		= 0,
+	.pads		= serial1_pads,
+	.pads_cnt	= ARRAY_SIZE(serial1_pads),
+};
+
+static struct omap_board_data serial2_data = {
+	.id		= 1,
+	.pads		= serial2_pads,
+	.pads_cnt	= ARRAY_SIZE(serial2_pads),
+};
+
+static struct omap_board_data serial3_data = {
+	.id		= 2,
+	.pads		= serial3_pads,
+	.pads_cnt	= ARRAY_SIZE(serial3_pads),
+};
+
+static inline void board_serial_init(void)
+{
+	omap_serial_init_port(&serial1_data);
+	omap_serial_init_port(&serial2_data);
+	omap_serial_init_port(&serial3_data);
+}
+#else
+#define board_mux	NULL
+
+static inline void board_serial_init(void)
+{
+	omap_serial_init();
+}
 #endif
 
 /*
@@ -804,7 +888,7 @@ static void __init omap_3430sdp_init(void)
 	spi_register_board_info(sdp3430_spi_board_info,
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
-	omap_serial_init();
+	board_serial_init();
 	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_3430);
-- 
1.7.0.4

