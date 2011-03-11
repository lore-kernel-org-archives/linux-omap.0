From: sricharan <r.sricharan@ti.com>
Subject: [PATCH V4 4/5] omap4: board-omap4panda: Initialise the serial pads.
Date: Fri, 11 Mar 2011 11:34:46 +0530
Message-ID: <1299823486-27192-3-git-send-email-r.sricharan@ti.com>
References: <1299823486-27192-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34478 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab1CKGEd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 01:04:33 -0500
In-Reply-To: <1299823486-27192-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, b-cousson@ti.com, santosh.shilimkar@ti.com

Use the mux framework to initialise the serial pads.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
V1: Initial Patch.
V2: Remove flags that were to be used for only testing.
V3: Add dummy initialisation for uart0.
V4: Use the Macro for muxing the static pads.

 arch/arm/mach-omap2/board-omap4panda.c |   69 +++++++++++++++++++++++++++++++-
 1 files changed, 68 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index a94ce07..1dd4401 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -463,8 +463,75 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP4_MUX(SDMMC5_DAT3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+
+static struct omap_device_pad serial2_pads[] __initdata = {
+	OMAP_MUX_STATIC("uart2_cts.uart2_cts",
+			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart2_rts.uart2_rts",
+			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart2_rx.uart2_rx",
+			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart2_tx.uart2_tx",
+			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
+};
+
+static struct omap_device_pad serial3_pads[] __initdata = {
+	OMAP_MUX_STATIC("uart3_cts_rctx.uart3_cts_rctx",
+			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart3_rts_sd.uart3_rts_sd",
+			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart3_rx_irrx.uart3_rx_irrx",
+			 OMAP_PIN_INPUT | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart3_tx_irtx.uart3_tx_irtx",
+			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
+};
+
+static struct omap_device_pad serial4_pads[] __initdata = {
+	OMAP_MUX_STATIC("uart4_rx.uart4_rx",
+			 OMAP_PIN_INPUT | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart4_tx.uart4_tx",
+			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
+};
+
+static struct omap_board_data serial2_data = {
+	.id             = 1,
+	.pads           = serial2_pads,
+	.pads_cnt       = ARRAY_SIZE(serial2_pads),
+};
+
+static struct omap_board_data serial3_data = {
+	.id             = 2,
+	.pads           = serial3_pads,
+	.pads_cnt       = ARRAY_SIZE(serial3_pads),
+};
+
+static struct omap_board_data serial4_data = {
+	.id             = 3,
+	.pads           = serial4_pads,
+	.pads_cnt       = ARRAY_SIZE(serial4_pads),
+};
+
+static inline void board_serial_init(void)
+{
+	struct omap_board_data bdata;
+	bdata.flags     = 0;
+	bdata.pads      = NULL;
+	bdata.pads_cnt  = 0;
+	bdata.id        = 0;
+	/* pass dummy data for UART1 */
+	omap_serial_init_port(&bdata);
+
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
 
 static void __init omap4_panda_init(void)
@@ -481,7 +548,7 @@ static void __init omap4_panda_init(void)
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	platform_device_register(&omap_vwlan_device);
-	omap_serial_init();
+	board_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
 	omap4_ehci_init();
 	usb_musb_init(&musb_board_data);
-- 
1.7.0.4

