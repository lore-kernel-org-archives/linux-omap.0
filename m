From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 1/4] serial: core: Rework hw-assisted flow control support
Date: Sun, 25 Jan 2015 14:44:51 -0500
Message-ID: <1422215094-3216-2-git-send-email-peter@hurleysoftware.com>
References: <1422215094-3216-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:54438 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659AbbAYTpI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jan 2015 14:45:08 -0500
Received: by mail-qg0-f41.google.com with SMTP id q108so4427139qgd.0
        for <linux-omap@vger.kernel.org>; Sun, 25 Jan 2015 11:45:06 -0800 (PST)
In-Reply-To: <1422215094-3216-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

hw-assisted flow control support was added to the serial core
in v3.8 with commits,
dba05832cbe4f ("SERIAL: core: add hardware assisted h/w flow control support")
2cbacafd7af0f ("SERIAL: core: add hardware assisted s/w flow control support")
9aba8d5b01119 ("SERIAL: core: add throttle/unthrottle callbacks for hardware
                assisted flow control")
Since then, additional requirements for serial core support have arisen.
Specifically,
1. Separate tx and rx flow control settings for UARTs which only support
   tx flow control (ie., autoCTS).
2. Disable sw-assisted CTS flow control in autoCTS mode
3. Support for RTS flow control by serial core and userspace in autoRTS mode

Distinguish mode from capability; introduce UPSTAT_AUTORTS, UPSTAT_AUTOCTS
and UPSTAT_AUTOXOFF which, when set by the uart driver, enable serial core
support for hw-assisted rx, hw-assisted tx and hw-assisted in-band/IXOFF
rx flow control, respectively. [Note: hw-assisted in-band/IXON tx flow
control does not require serial core support/intervention and can be
enabled by the uart driver when required.]

These modes must be set/reset in the driver's set_termios() method, based
on termios settings, and thus can be safely queried in any context in which
one of the port lock, port mutex or termios rwsem are held. Set these modes
in the 2 in-tree drivers, omap-serial and 8250_omap, which currently
use UPF_HARD_FLOW/UPF_SOFT_FLOW support.

Retain UPF_HARD_FLOW and UPF_SOFT_FLOW as capabilities; re-define
UPF_HARD_FLOW as both UPF_AUTO_RTS and UPF_AUTO_CTS to allow for distinct
and separate rx and tx flow control capabilities.

Disable sw-assisted CTS flow control when UPSTAT_AUTOCTS is enabled.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_omap.c |  7 +++-
 drivers/tty/serial/omap-serial.c    |  7 +++-
 drivers/tty/serial/serial_core.c    | 76 ++++++++++++++-----------------------
 include/linux/serial_core.h         | 21 ++++++++--
 4 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 316c37b..4473881 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -421,8 +421,11 @@ static void omap_8250_set_termios(struct uart_port *port,
 
 	priv->efr = 0;
 	up->mcr &= ~(UART_MCR_RTS | UART_MCR_XONANY);
+	up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
+
 	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
 		/* Enable AUTORTS and AUTOCTS */
+		up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
 		priv->efr |= UART_EFR_CTS | UART_EFR_RTS;
 	} else	if (up->port.flags & UPF_SOFT_FLOW) {
 		/*
@@ -438,8 +441,10 @@ static void omap_8250_set_termios(struct uart_port *port,
 		 * Enable XON/XOFF flow control on output.
 		 * Transmit XON1, XOFF1
 		 */
-		if (termios->c_iflag & IXOFF)
+		if (termios->c_iflag & IXOFF) {
+			up->port.status |= UPSTAT_AUTOXOFF;
 			priv->efr |= OMAP_UART_SW_TX;
+		}
 
 		/*
 		 * IXANY Flag:
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 2e1073d..b28cdca 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1053,8 +1053,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
 
+	up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
+
 	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
 		/* Enable AUTORTS and AUTOCTS */
+		up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
 		up->efr |= UART_EFR_CTS | UART_EFR_RTS;
 
 		/* Ensure MCR RTS is asserted */
@@ -1081,8 +1084,10 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		 * Enable XON/XOFF flow control on output.
 		 * Transmit XON1, XOFF1
 		 */
-		if (termios->c_iflag & IXOFF)
+		if (termios->c_iflag & IXOFF) {
+			up->port.status |= UPSTAT_AUTOXOFF;
 			up->efr |= OMAP_UART_SW_TX;
+		}
 
 		/*
 		 * IXANY Flag:
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 37dc808..a21b15c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -179,14 +179,6 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 			if (tty->termios.c_cflag & CBAUD)
 				uart_set_mctrl(uport, TIOCM_RTS | TIOCM_DTR);
 		}
-
-		spin_lock_irq(&uport->lock);
-		if (uart_cts_enabled(uport) &&
-		    !(uport->ops->get_mctrl(uport) & TIOCM_CTS))
-			uport->hw_stopped = 1;
-		else
-			uport->hw_stopped = 0;
-		spin_unlock_irq(&uport->lock);
 	}
 
 	/*
@@ -442,6 +434,7 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 {
 	struct uart_port *uport = state->uart_port;
 	struct ktermios *termios;
+	int hw_stopped;
 
 	/*
 	 * If we have no tty, termios, or the port does not exist,
@@ -466,6 +459,18 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 		uport->status &= ~UPSTAT_DCD_ENABLE;
 	else
 		uport->status |= UPSTAT_DCD_ENABLE;
+
+	/* reset sw-assisted CTS flow control based on (possibly) new mode */
+	hw_stopped = uport->hw_stopped;
+	uport->hw_stopped = uart_softcts_mode(uport) &&
+				!(uport->ops->get_mctrl(uport) & TIOCM_CTS);
+	if (uport->hw_stopped) {
+		if (!hw_stopped)
+			uport->ops->stop_tx(uport);
+	} else {
+		if (hw_stopped)
+			__uart_start(tty);
+	}
 	spin_unlock_irq(&uport->lock);
 }
 
@@ -619,22 +624,22 @@ static void uart_throttle(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port = state->uart_port;
-	upf_t mask = 0;
+	upstat_t mask = 0;
 
 	if (I_IXOFF(tty))
-		mask |= UPF_SOFT_FLOW;
+		mask |= UPSTAT_AUTOXOFF;
 	if (tty->termios.c_cflag & CRTSCTS)
-		mask |= UPF_HARD_FLOW;
+		mask |= UPSTAT_AUTORTS;
 
-	if (port->flags & mask) {
+	if (port->status & mask) {
 		port->ops->throttle(port);
-		mask &= ~port->flags;
+		mask &= ~port->status;
 	}
 
-	if (mask & UPF_SOFT_FLOW)
+	if (mask & UPSTAT_AUTOXOFF)
 		uart_send_xchar(tty, STOP_CHAR(tty));
 
-	if (mask & UPF_HARD_FLOW)
+	if (mask & UPSTAT_AUTORTS)
 		uart_clear_mctrl(port, TIOCM_RTS);
 }
 
@@ -642,22 +647,22 @@ static void uart_unthrottle(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port = state->uart_port;
-	upf_t mask = 0;
+	upstat_t mask = 0;
 
 	if (I_IXOFF(tty))
-		mask |= UPF_SOFT_FLOW;
+		mask |= UPSTAT_AUTOXOFF;
 	if (tty->termios.c_cflag & CRTSCTS)
-		mask |= UPF_HARD_FLOW;
+		mask |= UPSTAT_AUTORTS;
 
-	if (port->flags & mask) {
+	if (port->status & mask) {
 		port->ops->unthrottle(port);
-		mask &= ~port->flags;
+		mask &= ~port->status;
 	}
 
-	if (mask & UPF_SOFT_FLOW)
+	if (mask & UPSTAT_AUTOXOFF)
 		uart_send_xchar(tty, START_CHAR(tty));
 
-	if (mask & UPF_HARD_FLOW)
+	if (mask & UPSTAT_AUTORTS)
 		uart_set_mctrl(port, TIOCM_RTS);
 }
 
@@ -1351,30 +1356,6 @@ static void uart_set_termios(struct tty_struct *tty,
 			mask |= TIOCM_RTS;
 		uart_set_mctrl(uport, mask);
 	}
-
-	/*
-	 * If the port is doing h/w assisted flow control, do nothing.
-	 * We assume that port->hw_stopped has never been set.
-	 */
-	if (uport->flags & UPF_HARD_FLOW)
-		return;
-
-	/* Handle turning off CRTSCTS */
-	if ((old_termios->c_cflag & CRTSCTS) && !(cflag & CRTSCTS)) {
-		spin_lock_irq(&uport->lock);
-		uport->hw_stopped = 0;
-		__uart_start(tty);
-		spin_unlock_irq(&uport->lock);
-	}
-	/* Handle turning on CRTSCTS */
-	else if (!(old_termios->c_cflag & CRTSCTS) && (cflag & CRTSCTS)) {
-		spin_lock_irq(&uport->lock);
-		if (!(uport->ops->get_mctrl(uport) & TIOCM_CTS)) {
-			uport->hw_stopped = 1;
-			uport->ops->stop_tx(uport);
-		}
-		spin_unlock_irq(&uport->lock);
-	}
 }
 
 /*
@@ -2853,7 +2834,7 @@ void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
 
 	uport->icount.cts++;
 
-	if (uart_cts_enabled(uport)) {
+	if (uart_softcts_mode(uport)) {
 		if (uport->hw_stopped) {
 			if (status) {
 				uport->hw_stopped = 0;
@@ -2866,6 +2847,7 @@ void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
 				uport->ops->stop_tx(uport);
 			}
 		}
+
 	}
 }
 EXPORT_SYMBOL_GPL(uart_handle_cts_change);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a0c7033..baf3e1d 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -191,8 +191,10 @@ struct uart_port {
 #define UPF_NO_TXEN_TEST	((__force upf_t) (1 << 15))
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) ASYNC_MAGIC_MULTIPLIER /* 16 */ )
 
-/* Port has hardware-assisted h/w flow control (iow, auto-RTS *not* auto-CTS) */
-#define UPF_HARD_FLOW		((__force upf_t) (1 << 21))
+/* Port has hardware-assisted h/w flow control */
+#define UPF_AUTO_CTS		((__force upf_t) (1 << 20))
+#define UPF_AUTO_RTS		((__force upf_t) (1 << 21))
+#define UPF_HARD_FLOW		((__force upf_t) (UPF_AUTO_CTS | UPF_AUTO_RTS))
 /* Port has hardware-assisted s/w flow control */
 #define UPF_SOFT_FLOW		((__force upf_t) (1 << 22))
 #define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
@@ -214,11 +216,17 @@ struct uart_port {
 #error Change mask not equivalent to userspace-visible bit defines
 #endif
 
-	/* status must be updated while holding port lock */
+	/*
+	 * Must hold termios_rwsem, port mutex and port lock to change;
+	 * can hold any one lock to read.
+	 */
 	upstat_t		status;
 
 #define UPSTAT_CTS_ENABLE	((__force upstat_t) (1 << 0))
 #define UPSTAT_DCD_ENABLE	((__force upstat_t) (1 << 1))
+#define UPSTAT_AUTORTS		((__force upstat_t) (1 << 2))
+#define UPSTAT_AUTOCTS		((__force upstat_t) (1 << 3))
+#define UPSTAT_AUTOXOFF		((__force upstat_t) (1 << 4))
 
 	int			hw_stopped;		/* sw-assisted CTS flow state */
 	unsigned int		mctrl;			/* current modem ctrl settings */
@@ -392,6 +400,13 @@ static inline bool uart_cts_enabled(struct uart_port *uport)
 	return !!(uport->status & UPSTAT_CTS_ENABLE);
 }
 
+static inline bool uart_softcts_mode(struct uart_port *uport)
+{
+	upstat_t mask = UPSTAT_CTS_ENABLE | UPSTAT_AUTOCTS;
+
+	return ((uport->status & mask) == UPSTAT_CTS_ENABLE);
+}
+
 /*
  * The following are helper functions for the low level drivers.
  */
-- 
2.2.2

