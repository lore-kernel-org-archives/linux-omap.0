From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 08/14] TEMP: serial: added mux support
Date: Fri, 9 Dec 2011 16:27:31 +0200
Message-ID: <1323440857-385-9-git-send-email-t-kristo@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54909 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab1LIO2T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:28:19 -0500
In-Reply-To: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com

Just for PRCM chain handler testing purposes. This should be replaced with
a proper implementation.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/serial.c |   71 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 9992dbf..b479b3f 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -839,17 +839,84 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
  * can call this function when they want to have default behaviour
  * for serial ports (e.g initialize them all as serial ports).
  */
+
+struct serial_mux_conf {
+	char *name;
+	int omap3_mux;
+	int omap4_mux;
+};
+
+#define OMAP3_SERIAL_MUX_IN_PU (OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0)
+#define OMAP3_SERIAL_MUX_IN_PD (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE0)
+#define OMAP3_SERIAL_MUX_IN (OMAP_PIN_INPUT | OMAP_MUX_MODE0)
+#define OMAP3_SERIAL_MUX_OUT (OMAP_PIN_OUTPUT | OMAP_MUX_MODE0)
+#define OMAP4_SERIAL_MUX_IN_PU (OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0)
+#define OMAP4_SERIAL_MUX_OUT (OMAP_PIN_OUTPUT | OMAP_MUX_MODE0)
+#define OMAP4_SERIAL_MUX_IN (OMAP_PIN_INPUT | OMAP_MUX_MODE0)
+#define SERIAL_DISABLED OMAP_MUX_MODE7
+
+#define OMAP_SERIAL_NUM_PADS_PER_PORT 4
+
+static const struct serial_mux_conf serial_mux_data[] = {
+	{ "uart1_cts.uart1_cts", OMAP3_SERIAL_MUX_IN, SERIAL_DISABLED, },
+	{ "uart1_rts.uart1_rts", OMAP3_SERIAL_MUX_OUT, SERIAL_DISABLED, },
+	{ "uart1_rx.uart1_rx", OMAP3_SERIAL_MUX_IN, SERIAL_DISABLED, },
+	{ "uart1_tx.uart1_tx", OMAP3_SERIAL_MUX_OUT, SERIAL_DISABLED, },
+	{ "uart2_cts.uart2_cts", OMAP3_SERIAL_MUX_IN,
+		OMAP4_SERIAL_MUX_IN_PU, },
+	{ "uart2_rts.uart2_rts", OMAP3_SERIAL_MUX_OUT, OMAP4_SERIAL_MUX_OUT, },
+	{ "uart2_rx.uart2_rx", OMAP3_SERIAL_MUX_IN, OMAP4_SERIAL_MUX_IN_PU, },
+	{ "uart2_tx.uart2_tx", OMAP3_SERIAL_MUX_OUT, OMAP4_SERIAL_MUX_OUT },
+	{ "uart3_cts_rctx.uart3_cts_rctx", OMAP3_SERIAL_MUX_IN_PD,
+		OMAP4_SERIAL_MUX_IN_PU, },
+	{ "uart3_rts_sd.uart3_rts_sd", OMAP3_SERIAL_MUX_OUT,
+		OMAP4_SERIAL_MUX_OUT, },
+	{ "uart3_rx_irrx.uart3_rx_irrx", OMAP3_SERIAL_MUX_IN,
+		OMAP4_SERIAL_MUX_IN, },
+	{ "uart3_tx_irtx.uart3_tx_irtx", OMAP3_SERIAL_MUX_OUT,
+		OMAP4_SERIAL_MUX_OUT, },
+	{ "uart4_rx.uart4_rx", SERIAL_DISABLED, OMAP4_SERIAL_MUX_IN, },
+	{ "uart4_tx.uart4_tx", SERIAL_DISABLED, OMAP4_SERIAL_MUX_OUT, },
+	{ NULL, SERIAL_DISABLED, SERIAL_DISABLED, },
+	{ NULL, SERIAL_DISABLED, SERIAL_DISABLED, },
+};
+
 void __init omap_serial_init(void)
 {
 	struct omap_uart_state *uart;
 	struct omap_board_data bdata;
+	struct omap_device_pad *pads;
+	int idx;
+	int i;
 
+	pads = kmalloc(sizeof(struct omap_device_pad) * 4, GFP_KERNEL);
 	list_for_each_entry(uart, &uart_list, node) {
 		bdata.id = uart->num;
 		bdata.flags = 0;
-		bdata.pads = NULL;
 		bdata.pads_cnt = 0;
+		bdata.pads = pads;
+
+		for (i = 0; i < OMAP_SERIAL_NUM_PADS_PER_PORT; i++) {
+			idx = bdata.id * OMAP_SERIAL_NUM_PADS_PER_PORT + i;
+			pads[i].name = serial_mux_data[idx].name;
+			pads[i].enable = 0;
+			pads[i].idle = 0;
+			pads[i].flags = 0;
+			if (cpu_is_omap34xx())
+				pads[i].enable = serial_mux_data[idx].omap3_mux;
+			if (cpu_is_omap44xx())
+				pads[i].enable = serial_mux_data[idx].omap4_mux;
+			if (pads[i].enable != SERIAL_DISABLED)
+				bdata.pads_cnt++;
+			if (pads[i].enable & OMAP_PIN_INPUT) {
+				pads[i].flags = OMAP_DEVICE_PAD_REMUX |
+					OMAP_DEVICE_PAD_WAKEUP;
+			}
+			pads[i].idle = pads[i].enable;
+		}
+		if (bdata.pads_cnt == 0)
+			bdata.pads = NULL;
 		omap_serial_init_port(&bdata);
-
 	}
+	kfree(pads);
 }
-- 
1.7.4.1

