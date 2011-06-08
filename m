From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v3 12/12] OMAP4: Serial: Set TX_FIFO_THRESHOLD if uart in dma mode for es2.0
Date: Wed, 8 Jun 2011 16:53:14 +0530
Message-ID: <1307532194-13039-13-git-send-email-govindraj.raja@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40241 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277Ab1FHLXo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Jun 2011 07:23:44 -0400
In-Reply-To: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

>From OMAP4430 ES2.0 onwards if uart is configured in dma mode we need to set
uart tx threshold value using the new register UART_TX_DMA_THRESHOLD, this
register can used if UART_MDR3 bit(2) is set. We have to ensure
tx_threshold + tx_trigger <= 63 from es2.0 onwards. By default we are using
tx_trigger of 1 so we can set threshold to 62 to satisfy above criteria.
Without the threshold setting we hit dma_sync lost errors on tx channel
leading to data loss on rx side

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |    4 ++++
 arch/arm/plat-omap/include/plat/omap-serial.h |   11 +++++++++++
 drivers/tty/serial/omap-serial.c              |    5 +++++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 0a95c95..437fc0b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -401,6 +401,10 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 	if (bdata->id == omap_uart_con_id)
 		pdata->console_uart = true;
 
+	if (pdata->dma_enabled &&
+			cpu_is_omap44xx() && omap_rev() > OMAP4430_REV_ES1_0)
+		pdata->errata |= OMAP4_UART_ERRATA_i659_TX_THR;
+
 	od = omap_device_build(name, bdata->id, oh, pdata,
 				sizeof(*pdata), omap_uart_latency,
 				ARRAY_SIZE(omap_uart_latency), false);
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 69e6d4b..0d10f72 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -56,12 +56,23 @@
 #define DEFAULT_RXDMA_BUFSIZE	4096		/* RX DMA buffer size */
 #define DEFAULT_AUTOSUSPEND_DELAY (30 * HZ) /* Runtime autosuspend (msecs) */
 
+/*
+ * (Errata i659) - From OMAP4430 ES 2.0 onwards set
+ * tx_threshold while using UART in DMA Mode
+ * and ensure tx_threshold + tx_trigger <= 63
+ */
+#define UART_MDR3		0x20
+#define UART_TX_DMA_THRESHOLD	0x21
+#define SET_DMA_TX_THRESHOLD	BIT(2)
+/* Setting TX Threshold Level to 62 */
+#define TX_FIFO_THR_LVL		0x3E
 
 #define OMAP_MAX_HSUART_PORTS	4
 
 #define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
 
 #define UART_ERRATA_i202_MDR1_ACCESS	BIT(0)
+#define OMAP4_UART_ERRATA_i659_TX_THR	BIT(1)
 
 struct omap_uart_port_info {
 	bool			dma_enabled;	/* To specify DMA Mode */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index dbe76f3..a9645ac 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -818,6 +818,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
 	if (up->use_dma) {
+		if (up->errata & OMAP4_UART_ERRATA_i659_TX_THR) {
+			serial_out(up, UART_MDR3, SET_DMA_TX_THRESHOLD);
+			serial_out(up, UART_TX_DMA_THRESHOLD, TX_FIFO_THR_LVL);
+		}
+
 		serial_out(up, UART_TI752_TLR, 0);
 		serial_out(up, UART_OMAP_SCR,
 			(UART_FCR_TRIGGER_4 | UART_FCR_TRIGGER_8));
-- 
1.7.0.4

