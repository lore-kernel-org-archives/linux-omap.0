From: sricharan <r.sricharan@ti.com>
Subject: [PATCH 2/5] omap4: board-4430sdp: Initialise the serial pads
Date: Fri, 28 Jan 2011 10:38:15 +0530
Message-ID: <1296191298-17545-3-git-send-email-r.sricharan@ti.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46076 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab1A1FGJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 00:06:09 -0500
In-Reply-To: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r.sricharan@ti.com, linux-omap@vger.kernel.org
Cc: santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com

Use the mux framework to initialise the serial pads.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   73 ++++++++++++++++++++++++++++++++++-
 1 files changed, 72 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 1cb208b..d77f099 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -537,8 +537,79 @@ static void __init omap_sfh7741prox_init(void)
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+
+static struct omap_device_pad serial2_pads[] __initdata = {
+	{ .name   = "uart2_cts.uart2_cts",
+	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	  .flags  = OMAP_DEVICE_PAD_REMUX_IDLE,
+	  .idle   = OMAP_MUX_MODE7,
+	},
+	{ .name   = "uart2_rts.uart2_rts",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart2_rx.uart2_rx",
+	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart2_tx.uart2_tx",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad serial3_pads[] __initdata = {
+	{ .name   = "uart3_cts_rctx.uart3_cts_rctx",
+	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart3_rts_sd.uart3_rts_sd",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart3_rx_irrx.uart3_rx_irrx",
+	  .enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart3_tx_irtx.uart3_tx_irtx",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad serial4_pads[] __initdata = {
+	{ .name   = "uart4_rx.uart4_rx",
+	  .enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart4_tx.uart4_tx",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
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
+static struct omap_board_data serial4_data = {
+	.id		= 3,
+	.pads		= serial4_pads,
+	.pads_cnt	= ARRAY_SIZE(serial4_pads),
+};
+
+static inline void board_serial_init(void)
+{
+	omap_serial_init_port(&serial2_data);
+	omap_serial_init_port(&serial3_data);
+	omap_serial_init_port(&serial4_data);
+}
 #else
 #define board_mux	NULL
+
+static inline void board_serial_init(void)
+{
+	omap_serial_init();
+}
 #endif
 
 static void __init omap_4430sdp_init(void)
@@ -553,7 +624,7 @@ static void __init omap_4430sdp_init(void)
 	omap4_i2c_init();
 	omap_sfh7741prox_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
-	omap_serial_init();
+	board_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
 	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
 	usb_nop_xceiv_register();
-- 
1.7.0.4

