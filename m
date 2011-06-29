From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 5/9] TEMP: Serial: Added mux support
Date: Wed, 29 Jun 2011 12:04:59 +0300
Message-ID: <1309338303-2086-6-git-send-email-t-kristo@ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45692 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130Ab1F2JFT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 05:05:19 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5T95IT2031287
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:18 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5T95IYg004556
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:18 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5T95GCR009169
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:18 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This should be replaced with a proper implementation.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/serial.c |   66 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 067a86b..822c9b8 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -851,17 +851,79 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
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
+#define OMAP3_SERIAL_MUX_IN_PU (OMAP_PIN_INPUT_PULLUP | \
+	OMAP_PIN_OFF_INPUT_PULLDOWN | OMAP_OFFOUT_EN | OMAP_MUX_MODE0)
+#define OMAP3_SERIAL_MUX_IN_PD (OMAP_PIN_INPUT_PULLDOWN | \
+	OMAP_PIN_OFF_INPUT_PULLDOWN | OMAP_OFFOUT_EN | OMAP_MUX_MODE0)
+#define OMAP3_SERIAL_MUX_IN (OMAP_PIN_INPUT | OMAP_PIN_OFF_INPUT_PULLDOWN | \
+		OMAP_OFFOUT_EN | OMAP_MUX_MODE0)
+#define OMAP3_SERIAL_MUX_OUT (OMAP_PIN_OUTPUT | OMAP_OFF_EN | OMAP_MUX_MODE0)
+#define OMAP4_SERIAL_MUX_IN_PU (OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0)
+#define OMAP4_SERIAL_MUX_OUT (OMAP_PIN_OUTPUT | OMAP_MUX_MODE0)
+#define OMAP4_SERIAL_MUX_IN (OMAP_PIN_INPUT | OMAP_MUX_MODE0)
+
+#define OMAP_SERIAL_NUM_PADS_PER_PORT 4
+
+static const struct serial_mux_conf serial_mux_data[] = {
+	{ "uart1_cts.uart1_cts", OMAP3_SERIAL_MUX_IN, 0, },
+	{ "uart1_rts.uart1_rts", OMAP3_SERIAL_MUX_OUT, 0, },
+	{ "uart1_rx.uart1_rx", OMAP3_SERIAL_MUX_IN, 0, },
+	{ "uart1_tx.uart1_tx", OMAP3_SERIAL_MUX_OUT, 0, },
+	{ "uart2_cts.uart2_cts", OMAP3_SERIAL_MUX_IN_PU,
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
+	{ "uart4_rx.uart4_rx", 0, OMAP4_SERIAL_MUX_IN, },
+	{ "uart4_tx.uart4_tx", 0, OMAP4_SERIAL_MUX_OUT, },
+	{ NULL, 0, 0, },
+	{ NULL, 0, 0, },
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
+			if (cpu_is_omap34xx())
+				pads[i].enable = serial_mux_data[idx].omap3_mux;
+			if (cpu_is_omap44xx())
+				pads[i].enable = serial_mux_data[idx].omap4_mux;
+			if (pads[i].enable)
+				bdata.pads_cnt++;
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


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

