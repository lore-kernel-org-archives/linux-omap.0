From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 02/11] SERIAL: core: add hardware assisted s/w flow control
 support
Date: Tue, 16 Oct 2012 11:58:23 +0100
Message-ID: <E1TO4qt-0000Vq-CK@rmk-PC.arm.linux.org.uk>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53214 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab2JPK62 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 06:58:28 -0400
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Ports which are capable of handling s/w flow control in hardware to
know when the s/w flow control termios settings are changed.  Add a
flag to allow the low level serial drivers to indicate that they
support this, and these changes should be propagated to them.

Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/serial_core.c |   16 ++++++++++++++--
 include/linux/serial_core.h      |    2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index bc2065d..bd10bbd 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1213,7 +1213,19 @@ static void uart_set_termios(struct tty_struct *tty,
 	struct uart_port *uport = state->uart_port;
 	unsigned long flags;
 	unsigned int cflag = tty->termios.c_cflag;
+	unsigned int iflag_mask = IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK;
+	bool sw_changed = false;
 
+	/*
+	 * Drivers doing software flow control also need to know
+	 * about changes to these input settings.
+	 */
+	if (uport->flags & UPF_SOFT_FLOW) {
+		iflag_mask |= IXANY|IXON|IXOFF;
+		sw_changed =
+		   tty->termios.c_cc[VSTART] != old_termios->c_cc[VSTART] ||
+		   tty->termios.c_cc[VSTOP] != old_termios->c_cc[VSTOP];
+	}
 
 	/*
 	 * These are the bits that are used to setup various
@@ -1221,11 +1233,11 @@ static void uart_set_termios(struct tty_struct *tty,
 	 * bits in c_cflag; c_[io]speed will always be set
 	 * appropriately by set_termios() in tty_ioctl.c
 	 */
-#define RELEVANT_IFLAG(iflag)	((iflag) & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
 	if ((cflag ^ old_termios->c_cflag) == 0 &&
 	    tty->termios.c_ospeed == old_termios->c_ospeed &&
 	    tty->termios.c_ispeed == old_termios->c_ispeed &&
-	    RELEVANT_IFLAG(tty->termios.c_iflag ^ old_termios->c_iflag) == 0) {
+	    ((tty->termios.c_iflag ^ old_termios->c_iflag) & iflag_mask) == 0 &&
+	    !sw_changed) {
 		return;
 	}
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3c43022..0005138 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -163,6 +163,8 @@ struct uart_port {
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

