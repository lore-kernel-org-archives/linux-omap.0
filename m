From: sricharan <r.sricharan@ti.com>
Subject: [PATCH 5/5] OMAP4: serial: Initialise the uart mux pins
Date: Mon, 15 Nov 2010 13:08:05 +0530
Message-ID: <1289806685-20688-6-git-send-email-r.sricharan@ti.com>
References: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33022 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757592Ab0KOHf3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 02:35:29 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAF7ZQZa018107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 01:35:28 -0600
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAF7ZO9e024066
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 13:05:25 +0530 (IST)
In-Reply-To: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Use the mux framework to initialise the uart mux pins.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/serial.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index ba8a5cc..6890054 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -44,6 +44,7 @@
 #include "cm.h"
 #include "prm-regbits-34xx.h"
 #include "control.h"
+#include "mux.h"
 
 #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
@@ -839,6 +840,41 @@ void __init omap_serial_init_port(int port)
 		uart->errata |= UART_ERRATA_i202_MDR1_ACCESS;
 }
 
+/*
+ * omap_serial_init_mux() - Initialize the PINMUX configurations
+ * for all supported UART modules.
+ */
+static void __init omap_serial_init_mux(void)
+{
+	if (cpu_is_omap44xx()) {
+		/* UART 2 MUX */
+		omap_mux_init_signal("uart2_cts.uart2_cts",
+					OMAP_PIN_INPUT_PULLUP);
+		omap_mux_init_signal("uart2_rts.uart2_rts",
+					OMAP_PIN_OUTPUT);
+		omap_mux_init_signal("uart2_rx.uart2_rx",
+					OMAP_PIN_INPUT_PULLUP);
+		omap_mux_init_signal("uart2_tx.uart2_tx",
+					OMAP_PIN_OUTPUT);
+
+		/* UART 3 MUX */
+		omap_mux_init_signal("uart3_cts_rctx.uart3_cts_rctx",
+					OMAP_PIN_INPUT_PULLUP);
+		omap_mux_init_signal("uart3_rts_sd.uart3_rts_sd",
+					OMAP_PIN_OUTPUT);
+		omap_mux_init_signal("uart3_rx_irrx.uart3_rx_irrx",
+					OMAP_PIN_INPUT);
+		omap_mux_init_signal("uart3_tx_irtx.uart3_tx_irtx",
+					OMAP_PIN_OUTPUT);
+
+		/* UART 4 MUX */
+		omap_mux_init_signal("uart4_rx.uart4_rx",
+					OMAP_PIN_INPUT);
+		omap_mux_init_signal("uart4_tx.uart4_tx",
+					OMAP_PIN_OUTPUT);
+	}
+}
+
 /**
  * omap_serial_init() - intialize all supported serial ports
  *
@@ -850,6 +886,8 @@ void __init omap_serial_init(void)
 {
 	struct omap_uart_state *uart;
 
+	omap_serial_init_mux();
+
 	list_for_each_entry(uart, &uart_list, node)
 		omap_serial_init_port(uart->num);
 }
-- 
1.7.0.4

