From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 09/24] SERIAL: core: add hardware assisted s/w flow control
 support
Date: Sat, 06 Oct 2012 13:42:03 +0100
Message-ID: <E1TKThj-0002mw-IE@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Ports which are capable of handling s/w flow control in hardware to
know when the s/w flow control termios settings are changed.  Add a
flag to allow the low level serial drivers to indicate that they
support this, and these changes should be propagated to them.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/serial_core.c |   16 ++++++++++++++--
 include/linux/serial_core.h      |    2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95e6e32..ec6d029 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1197,7 +1197,19 @@ static void uart_set_termios(struct tty_struct *tty,
 	struct uart_port *uport = state->uart_port;
 	unsigned long flags;
 	unsigned int cflag = tty->termios->c_cflag;
+	unsigned int iflag_mask = IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK;
+	bool sw_changed = false;
 
+	/*
+	 * Drivers doing software flow control also need to know
+	 * about changes to these input settings.
+	 */
+	if (uport->flags & UPF_SOFT_FLOW) {
+		iflag_mask |= IXANY|IXON|IXOFF;
+		sw_changed =
+		   tty->termios->c_cc[VSTART] != old_termios->c_cc[VSTART] ||
+		   tty->termios->c_cc[VSTOP] != old_termios->c_cc[VSTOP];
+	}
 
 	/*
 	 * These are the bits that are used to setup various
@@ -1205,11 +1217,11 @@ static void uart_set_termios(struct tty_struct *tty,
 	 * bits in c_cflag; c_[io]speed will always be set
 	 * appropriately by set_termios() in tty_ioctl.c
 	 */
-#define RELEVANT_IFLAG(iflag)	((iflag) & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
 	if ((cflag ^ old_termios->c_cflag) == 0 &&
 	    tty->termios->c_ospeed == old_termios->c_ospeed &&
 	    tty->termios->c_ispeed == old_termios->c_ispeed &&
-	    RELEVANT_IFLAG(tty->termios->c_iflag ^ old_termios->c_iflag) == 0) {
+	    ((tty->termios->c_iflag ^ old_termios->c_iflag) & iflag_mask) == 0 &&
+	    !sw_changed) {
 		return;
 	}
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 0253c20..be3f8d9 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -356,6 +356,8 @@ struct uart_port {
 #define UPF_BUGGY_UART		((__force upf_t) (1 << 14))
 #define UPF_NO_TXEN_TEST	((__force upf_t) (1 << 15))
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) (1 << 16))
+/* Port has hardware-assisted s/w flow control */
+#define UPF_SOFT_FLOW		((__force upf_t) (1 << 22))
 #define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
 #define UPF_SHARE_IRQ		((__force upf_t) (1 << 24))
 #define UPF_EXAR_EFR		((__force upf_t) (1 << 25))
-- 
1.7.4.4

