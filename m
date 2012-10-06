From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 11/24] SERIAL: core: add throttle/unthrottle callbacks for
 hardware assisted flow control
Date: Sat, 06 Oct 2012 13:42:44 +0100
Message-ID: <E1TKTiO-0002n7-En@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add two callbacks for hardware assisted flow control; we need to know
when the tty layers want us to stop and restart due to their buffer
levels.

Call a driver specific throttle/unthrottle function if and only if the
driver indicates that it is using an enabled hardware assisted flow
control method, otherwise fall back to the non-hardware assisted
methods.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/serial_core.c |   31 +++++++++++++++++++++++++++----
 include/linux/serial_core.h      |    2 ++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 02b10bc..4dd609e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -610,27 +610,50 @@ static void uart_send_xchar(struct tty_struct *tty, char ch)
 static void uart_throttle(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
+	struct uart_port *port = state->uart_port;
+	uint32_t mask = 0;
 
 	if (I_IXOFF(tty))
+		mask |= UPF_SOFT_FLOW;
+	if (tty->termios->c_cflag & CRTSCTS)
+		mask |= UPF_HARD_FLOW;
+
+	if (port->flags & mask) {
+		port->ops->throttle(port);
+		mask &= ~port->flags;
+	}
+
+	if (mask & UPF_SOFT_FLOW)
 		uart_send_xchar(tty, STOP_CHAR(tty));
 
-	if (tty->termios->c_cflag & CRTSCTS)
-		uart_clear_mctrl(state->uart_port, TIOCM_RTS);
+	if (mask & UPF_HARD_FLOW)
+		uart_clear_mctrl(port, TIOCM_RTS);
 }
 
 static void uart_unthrottle(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port = state->uart_port;
+	uint32_t mask = 0;
 
-	if (I_IXOFF(tty)) {
+	if (I_IXOFF(tty))
+		mask |= UPF_SOFT_FLOW;
+	if (tty->termios->c_cflag & CRTSCTS)
+		mask |= UPF_HARD_FLOW;
+
+	if (port->flags & mask) {
+		port->ops->unthrottle(port);
+		mask &= ~port->flags;
+	}
+
+	if (mask & UPF_SOFT_FLOW) {
 		if (port->x_char)
 			port->x_char = 0;
 		else
 			uart_send_xchar(tty, START_CHAR(tty));
 	}
 
-	if (tty->termios->c_cflag & CRTSCTS)
+	if (mask & UPF_HARD_FLOW)
 		uart_set_mctrl(port, TIOCM_RTS);
 }
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 8e8500e..b17d4c9 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -240,6 +240,8 @@ struct uart_ops {
 	unsigned int	(*get_mctrl)(struct uart_port *);
 	void		(*stop_tx)(struct uart_port *);
 	void		(*start_tx)(struct uart_port *);
+	void		(*throttle)(struct uart_port *);
+	void		(*unthrottle)(struct uart_port *);
 	void		(*send_xchar)(struct uart_port *, char ch);
 	void		(*stop_rx)(struct uart_port *);
 	void		(*enable_ms)(struct uart_port *);
-- 
1.7.4.4

