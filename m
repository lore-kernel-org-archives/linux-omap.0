From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 1/2] serial: 8250: add UPF_NO_EMPTY_FIFO_READ flag
Date: Mon, 16 Nov 2009 16:53:40 -0600
Message-ID: <1258412020-31946-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36591 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824AbZKPWxx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 17:53:53 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAGMrxi4032195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 16:53:59 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

OMAP3630 and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
Empty RX fifo read causes an abort. OMAP1/2/3 do not have this restriction.

So interoduce a flag in 8250 driver: UPF_NO_EMPTY_FIFO_READ

If this flag is specified for an 8250 port, then first check if rx fifo has
contents, and only then proceed to read the fifo.

The change affects only boards passing this flag in port data and hence is
non-disruptive for other boards.

First reported/fixed on omap4430 by Shilimkar, Santosh

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Shilimkar, Santosh <santosh.shilimkar@ti.com>
---
 drivers/serial/8250.c       |   30 +++++++++++++++++++++++++-----
 include/linux/serial_core.h |    1 +
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 737b4c9..03c890e 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1245,7 +1245,11 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 #endif
 	serial_outp(up, UART_MCR, save_mcr);
 	serial8250_clear_fifos(up);
-	serial_in(up, UART_RX);
+	if (up->port.flags & UPF_NO_EMPTY_FIFO_READ) {
+		if (serial_inp(up, UART_LSR) & UART_LSR_DR)
+			serial_in(up, UART_RX);
+	} else
+		serial_in(up, UART_RX);
 	if (up->capabilities & UART_CAP_UUE)
 		serial_outp(up, UART_IER, UART_IER_UUE);
 	else
@@ -1289,7 +1293,11 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	}
 	serial_outp(up, UART_IER, 0x0f);	/* enable all intrs */
 	(void)serial_inp(up, UART_LSR);
-	(void)serial_inp(up, UART_RX);
+	if (up->port.flags & UPF_NO_EMPTY_FIFO_READ) {
+		if (serial_inp(up, UART_LSR) & UART_LSR_DR)
+			(void)serial_inp(up, UART_RX);
+	} else
+		(void)serial_inp(up, UART_RX);
 	(void)serial_inp(up, UART_IIR);
 	(void)serial_inp(up, UART_MSR);
 	serial_outp(up, UART_TX, 0xFF);
@@ -1984,7 +1992,11 @@ static int serial8250_startup(struct uart_port *port)
 	 * Clear the interrupt registers.
 	 */
 	(void) serial_inp(up, UART_LSR);
-	(void) serial_inp(up, UART_RX);
+	if (up->port.flags & UPF_NO_EMPTY_FIFO_READ) {
+		if (serial_inp(up, UART_LSR) & UART_LSR_DR)
+			(void) serial_inp(up, UART_RX);
+	} else
+		(void) serial_inp(up, UART_RX);
 	(void) serial_inp(up, UART_IIR);
 	(void) serial_inp(up, UART_MSR);
 
@@ -2141,7 +2153,11 @@ dont_test_tx_en:
 	 * routines or the previous session.
 	 */
 	serial_inp(up, UART_LSR);
-	serial_inp(up, UART_RX);
+	if (up->port.flags & UPF_NO_EMPTY_FIFO_READ) {
+		if (serial_inp(up, UART_LSR) & UART_LSR_DR)
+			serial_inp(up, UART_RX);
+	} else
+		serial_inp(up, UART_RX);
 	serial_inp(up, UART_IIR);
 	serial_inp(up, UART_MSR);
 	up->lsr_saved_flags = 0;
@@ -2207,7 +2223,11 @@ static void serial8250_shutdown(struct uart_port *port)
 	 * Read data port to reset things, and then unlink from
 	 * the IRQ chain.
 	 */
-	(void) serial_in(up, UART_RX);
+	if (up->port.flags & UPF_NO_EMPTY_FIFO_READ) {
+		if (serial_inp(up, UART_LSR) & UART_LSR_DR)
+			(void) serial_inp(up, UART_RX);
+	} else
+		(void) serial_in(up, UART_RX);
 
 	del_timer_sync(&up->timer);
 	up->timer.function = serial8250_timeout;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index db532ce..0d65bb3 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -308,6 +308,7 @@ struct uart_port {
 #define UPF_SPD_WARP		((__force upf_t) (0x1010))
 #define UPF_SKIP_TEST		((__force upf_t) (1 << 6))
 #define UPF_AUTO_IRQ		((__force upf_t) (1 << 7))
+#define UPF_NO_EMPTY_FIFO_READ	((__force upf_t) (1 << 8))
 #define UPF_HARDPPS_CD		((__force upf_t) (1 << 11))
 #define UPF_LOW_LATENCY		((__force upf_t) (1 << 13))
 #define UPF_BUGGY_UART		((__force upf_t) (1 << 14))
-- 
1.6.5.1.69.g36942

