From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 08/24] SERIAL: core: use local variable uport in
 uart_set_termios()
Date: Sat, 06 Oct 2012 13:41:43 +0100
Message-ID: <E1TKThP-0002mr-75@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47249 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756146Ab2JFMlv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 08:41:51 -0400
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

This is to make the following change more clear.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/serial_core.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a21dc8e..95e6e32 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1194,6 +1194,7 @@ static void uart_set_termios(struct tty_struct *tty,
 						struct ktermios *old_termios)
 {
 	struct uart_state *state = tty->driver_data;
+	struct uart_port *uport = state->uart_port;
 	unsigned long flags;
 	unsigned int cflag = tty->termios->c_cflag;
 
@@ -1216,31 +1217,31 @@ static void uart_set_termios(struct tty_struct *tty,
 
 	/* Handle transition to B0 status */
 	if ((old_termios->c_cflag & CBAUD) && !(cflag & CBAUD))
-		uart_clear_mctrl(state->uart_port, TIOCM_RTS | TIOCM_DTR);
+		uart_clear_mctrl(uport, TIOCM_RTS | TIOCM_DTR);
 	/* Handle transition away from B0 status */
 	else if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		unsigned int mask = TIOCM_DTR;
 		if (!(cflag & CRTSCTS) ||
 		    !test_bit(TTY_THROTTLED, &tty->flags))
 			mask |= TIOCM_RTS;
-		uart_set_mctrl(state->uart_port, mask);
+		uart_set_mctrl(uport, mask);
 	}
 
 	/* Handle turning off CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) && !(cflag & CRTSCTS)) {
-		spin_lock_irqsave(&state->uart_port->lock, flags);
+		spin_lock_irqsave(&uport->lock, flags);
 		tty->hw_stopped = 0;
 		__uart_start(tty);
-		spin_unlock_irqrestore(&state->uart_port->lock, flags);
+		spin_unlock_irqrestore(&uport->lock, flags);
 	}
 	/* Handle turning on CRTSCTS */
 	else if (!(old_termios->c_cflag & CRTSCTS) && (cflag & CRTSCTS)) {
-		spin_lock_irqsave(&state->uart_port->lock, flags);
-		if (!(state->uart_port->ops->get_mctrl(state->uart_port) & TIOCM_CTS)) {
+		spin_lock_irqsave(&uport->lock, flags);
+		if (!(uport->ops->get_mctrl(uport) & TIOCM_CTS)) {
 			tty->hw_stopped = 1;
-			state->uart_port->ops->stop_tx(state->uart_port);
+			uport->ops->stop_tx(uport);
 		}
-		spin_unlock_irqrestore(&state->uart_port->lock, flags);
+		spin_unlock_irqrestore(&uport->lock, flags);
 	}
 }
 
-- 
1.7.4.4

