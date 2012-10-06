From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 22/24] SERIAL: omap: typesafe conversion from uart_port to
 uart_omap_port
Date: Sat, 06 Oct 2012 13:46:27 +0100
Message-ID: <E1TKTlz-0002nq-Tg@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47342 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab2JFMqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 08:46:37 -0400
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |   49 +++++++++++++++++++++-----------------
 1 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6054fc8..a5482da 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -71,6 +71,11 @@
 #define OMAP_UART_MVR_MAJ_SHIFT		8
 #define OMAP_UART_MVR_MIN_MASK		0x3f
 
+static struct uart_omap_port *serial_omap_port(struct uart_port *port)
+{
+	return container_of(port, struct uart_omap_port, port);
+}
+
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
 /* Forward declaration of functions */
@@ -141,7 +146,7 @@ static void serial_omap_stop_rxdma(struct uart_omap_port *up)
 
 static void serial_omap_enable_ms(struct uart_port *port)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 
 	dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->port.line);
 
@@ -153,7 +158,7 @@ static void serial_omap_enable_ms(struct uart_port *port)
 
 static void serial_omap_stop_tx(struct uart_port *port)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;
 
 	if (up->use_dma &&
@@ -186,7 +191,7 @@ static void serial_omap_stop_tx(struct uart_port *port)
 
 static void serial_omap_stop_rx(struct uart_port *port)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 
 	pm_runtime_get_sync(&up->pdev->dev);
 	if (up->use_dma)
@@ -307,7 +312,7 @@ static inline void serial_omap_enable_ier_thri(struct uart_omap_port *up)
 
 static void serial_omap_start_tx(struct uart_port *port)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;
 	struct circ_buf *xmit;
 	unsigned int start;
@@ -375,7 +380,7 @@ static void serial_omap_start_tx(struct uart_port *port)
 
 static void serial_omap_throttle(struct uart_port *port)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	unsigned long flags;
 
 	pm_runtime_get_sync(&up->pdev->dev);
@@ -389,7 +394,7 @@ static void serial_omap_throttle(struct uart_port *port)
 
 static void serial_omap_unthrottle(struct uart_port *port)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	unsigned long flags;
 
 	pm_runtime_get_sync(&up->pdev->dev);
@@ -477,7 +482,7 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 
 static unsigned int serial_omap_tx_empty(struct uart_port *port)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	unsigned long flags = 0;
 	unsigned int ret = 0;
 
@@ -492,7 +497,7 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
 
 static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	unsigned int status;
 	unsigned int ret = 0;
 
@@ -515,7 +520,7 @@ static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 
 static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	unsigned char mcr = 0, old_mcr;
 
 	dev_dbg(up->port.dev, "serial_omap_set_mctrl+%d\n", up->port.line);
@@ -541,7 +546,7 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	unsigned long flags = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->port.line);
@@ -558,7 +563,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 
 static int serial_omap_startup(struct uart_port *port)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	unsigned long flags = 0;
 	int retval;
 
@@ -631,7 +636,7 @@ static int serial_omap_startup(struct uart_port *port)
 
 static void serial_omap_shutdown(struct uart_port *port)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	unsigned long flags = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->port.line);
@@ -673,7 +678,7 @@ static void serial_omap_shutdown(struct uart_port *port)
 
 static int serial_omap_alloc_xmit(struct uart_port *port, struct circ_buf *xmit)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 
 	if (up->use_dma) {
 		xmit->buf = dma_alloc_coherent(NULL, UART_XMIT_SIZE,
@@ -688,7 +693,7 @@ static int serial_omap_alloc_xmit(struct uart_port *port, struct circ_buf *xmit)
 
 static void serial_omap_free_xmit(struct uart_port *port, struct circ_buf *xmit)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 
 	if (up->use_dma) {
 		dma_free_coherent(NULL, UART_XMIT_SIZE,
@@ -710,7 +715,7 @@ static void
 serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 			struct ktermios *old)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	unsigned char cval = 0;
 	unsigned long flags = 0;
 	unsigned int baud, quot;
@@ -963,7 +968,7 @@ static void
 serial_omap_pm(struct uart_port *port, unsigned int state,
 	       unsigned int oldstate)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	unsigned char efr;
 
 	dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->port.line);
@@ -1002,7 +1007,7 @@ static int serial_omap_request_port(struct uart_port *port)
 
 static void serial_omap_config_port(struct uart_port *port, int flags)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 
 	dev_dbg(up->port.dev, "serial_omap_config_port+%d\n",
 							up->port.line);
@@ -1021,7 +1026,7 @@ serial_omap_verify_port(struct uart_port *port, struct serial_struct *ser)
 static const char *
 serial_omap_type(struct uart_port *port)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 
 	dev_dbg(up->port.dev, "serial_omap_type+%d\n", up->port.line);
 	return up->name;
@@ -1064,7 +1069,7 @@ static inline void wait_for_xmitr(struct uart_omap_port *up)
 
 static void serial_omap_poll_put_char(struct uart_port *port, unsigned char ch)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 
 	pm_runtime_get_sync(&up->pdev->dev);
 	wait_for_xmitr(up);
@@ -1074,7 +1079,7 @@ static void serial_omap_poll_put_char(struct uart_port *port, unsigned char ch)
 
 static int serial_omap_poll_get_char(struct uart_port *port)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 	unsigned int status;
 
 	pm_runtime_get_sync(&up->pdev->dev);
@@ -1097,7 +1102,7 @@ static struct uart_driver serial_omap_reg;
 
 static void serial_omap_console_putchar(struct uart_port *port, int ch)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct uart_omap_port *up = serial_omap_port(port);
 
 	wait_for_xmitr(up);
 	serial_out(up, UART_TX, ch);
@@ -1377,7 +1382,7 @@ static void serial_omap_continue_tx(struct uart_omap_port *up)
 
 static void uart_tx_dma_callback(int lch, u16 ch_status, void *data)
 {
-	struct uart_omap_port *up = (struct uart_omap_port *)data;
+	struct uart_omap_port *up = serial_omap_port(data);
 	struct circ_buf *xmit = &up->port.state->xmit;
 
 	xmit->tail = (xmit->tail + up->uart_dma.tx_buf_size) & \
-- 
1.7.4.4

