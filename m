From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] omap2+: Initialize serial ports for wake-up events
 for n8x0
Date: Wed, 22 Dec 2010 18:53:09 -0800
Message-ID: <20101223025309.GK7771@atomide.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
 <20101203004531.31687.55661.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:39955 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab0LWCxM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 21:53:12 -0500
Content-Disposition: inline
In-Reply-To: <20101203004531.31687.55661.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [101202 16:35]:
> Use omap_serial_init_port so we can let the serial code handle the
> remuxing of the RX pads.

And finally here's this one updated based on Paul's comments.
Let's not go through the list of all the static pins but
instead let's keep it shorter by only initializing the uart3
rx pin.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Dec 2010 18:42:36 -0800
Subject: [PATCH] omap2+: Initialize serial port for dynamic remuxing for n8x0

Use omap_serial_init_port so we can let the serial code handle the
remuxing of the RX pads. Note that this patch alone is not enough
and additional GPIO related patches are needed.

Only initialize uart3_rx_irrx pin, the other uart pins can be
stay static.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 43af70e..147d900 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -645,6 +645,43 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP2420_MUX(EAC_AC_DOUT, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+
+static struct omap_device_pad serial2_pads[] __initdata = {
+	{
+		.name	= "uart3_rx_irrx.uart3_rx_irrx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_MUX_MODE0,
+		.idle	= OMAP_MUX_MODE3	/* Mux as GPIO for idle */
+	},
+};
+
+static inline void board_serial_init(void)
+{
+	struct omap_board_data bdata;
+
+	bdata.flags = 0;
+	bdata.pads = NULL;
+	bdata.pads_cnt = 0;
+
+	bdata.id = 0;
+	omap_serial_init_port(&bdata);
+
+	bdata.id = 1;
+	omap_serial_init_port(&bdata);
+
+	bdata.id = 2;
+	bdata.pads = serial2_pads;
+	bdata.pads_cnt = ARRAY_SIZE(serial2_pads);
+	omap_serial_init_port(&bdata);
+}
+
+#else
+
+static inline void board_serial_init(void)
+{
+	omap_serial_init();
+}
+
 #endif
 
 static void __init n8x0_init_machine(void)
@@ -659,8 +696,7 @@ static void __init n8x0_init_machine(void)
 	if (machine_is_nokia_n810())
 		i2c_register_board_info(2, n810_i2c_board_info_2,
 					ARRAY_SIZE(n810_i2c_board_info_2));
-
-	omap_serial_init();
+	board_serial_init();
 	gpmc_onenand_init(board_onenand_data);
 	n8x0_mmc_init();
 	n8x0_usb_init();
