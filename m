From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] omap2+: Initialize serial ports for wake-up events for
	n8x0
Date: Thu, 02 Dec 2010 16:45:31 -0800
Message-ID: <20101203004531.31687.55661.stgit@baageli.muru.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:19840 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080Ab0LCApi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 19:45:38 -0500
In-Reply-To: <20101203004040.31687.9476.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Use omap_serial_init_port so we can let the serial code handle the
remuxing of the RX pads.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c |   66 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index d022301..e3429b4 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -29,6 +29,7 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/omap_device.h>
 #include <plat/menelaus.h>
 #include <mach/irqs.h>
 #include <plat/mcspi.h>
@@ -754,8 +755,68 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP2420_MUX(EAC_AC_DOUT, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+
+static struct omap_device_pad serial0_pads[] __initdata = {
+	{ .name	= "uart1_rx.uart1_rx", .enable	= OMAP_MUX_MODE0 },
+	{ .name	= "uart1_tx.uart1_tx", .enable	= OMAP_MUX_MODE0 },
+};
+
+static struct omap_device_pad n800_serial1_pads[] __initdata = {
+	{ .name	= "uart2_rx.uart2_rx", .enable	= OMAP_MUX_MODE7, },
+	{
+		.name	= "uart2_tx.uart2_tx",
+		.enable	= OMAP_PULL_ENA | OMAP_MUX_MODE7,
+	},
+};
+
+static struct omap_device_pad n810_serial1_pads[] __initdata = {
+	{ .name	= "uart2_rx.uart2_rx", .enable	= OMAP_MUX_MODE0, },
+	{ .name	= "uart2_tx.uart2_tx", .enable	= OMAP_MUX_MODE0, },
+};
+
+static struct omap_device_pad serial2_pads[] __initdata = {
+	{
+		.name	= "uart3_rx_irrx.uart3_rx_irrx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_MUX_MODE0,
+		.idle	= OMAP_MUX_MODE3	/* Mux as GPIO for idle */
+	},
+	{ .name	= "uart3_tx_irtx.uart3_tx_irtx", .enable = OMAP_MUX_MODE0, },
+};
+
+static struct omap_device_board_data serial0_data = {
+	.id		= 0,
+	.pads		= serial0_pads,
+	.pads_cnt	= ARRAY_SIZE(serial0_pads),
+};
+
+static struct omap_device_board_data serial1_data = {
+	.id		= 1,
+};
+
+static struct omap_device_board_data serial2_data = {
+	.id		= 2,
+	.pads		= serial2_pads,
+	.pads_cnt	= ARRAY_SIZE(serial2_pads),
+};
+
+static inline void board_serial_init(int is_n800)
+{
+	if (is_n800) {
+		serial1_data.pads = n800_serial1_pads;
+		serial1_data.pads_cnt = ARRAY_SIZE(n800_serial1_pads);
+	} else {
+		serial1_data.pads = n810_serial1_pads;
+		serial1_data.pads_cnt = ARRAY_SIZE(n810_serial1_pads);
+	}
+	omap_serial_init_port(&serial0_data);
+	omap_serial_init_port(&serial1_data);
+	omap_serial_init_port(&serial2_data);
+}
 #else
-#define board_mux	NULL
+static inline void board_serial_init(void)
+	omap_serial_init();
+}
 #endif
 
 static void __init n8x0_init_machine(void)
@@ -772,8 +833,7 @@ static void __init n8x0_init_machine(void)
 	if (machine_is_nokia_n810())
 		i2c_register_board_info(2, n810_i2c_board_info_2,
 					ARRAY_SIZE(n810_i2c_board_info_2));
-
-	omap_serial_init();
+	board_serial_init(machine_is_nokia_n800());
 	n8x0_onenand_init();
 	n8x0_mmc_init();
 	n8x0_usb_init();

