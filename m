From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 10/24] SERIAL: core: add hardware assisted h/w flow control
 support
Date: Sat, 06 Oct 2012 13:42:24 +0100
Message-ID: <E1TKTi4-0002n2-0b@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Ports which are handling h/w flow control in hardware must not have
their RTS state altered depending on the tty's hardware-stopped state.
Avoid this additional logic when setting the termios state.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/serial_core.c |    7 +++++++
 include/linux/serial_core.h      |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ec6d029..02b10bc 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1239,6 +1239,13 @@ static void uart_set_termios(struct tty_struct *tty,
 		uart_set_mctrl(uport, mask);
 	}
 
+	/*
+	 * If the port is doing h/w assisted flow control, do nothing.
+	 * We assume that tty->hw_stopped has never been set.
+	 */
+	if (uport->flags & UPF_HARD_FLOW)
+		return;
+
 	/* Handle turning off CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) && !(cflag & CRTSCTS)) {
 		spin_lock_irqsave(&uport->lock, flags);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index be3f8d9..8e8500e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -356,6 +356,8 @@ struct uart_port {
 #define UPF_BUGGY_UART		((__force upf_t) (1 << 14))
 #define UPF_NO_TXEN_TEST	((__force upf_t) (1 << 15))
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) (1 << 16))
+/* Port has hardware-assisted h/w flow control (iow, auto-RTS *not* auto-CTS) */
+#define UPF_HARD_FLOW		((__force upf_t) (1 << 21))
 /* Port has hardware-assisted s/w flow control */
 #define UPF_SOFT_FLOW		((__force upf_t) (1 << 22))
 #define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
-- 
1.7.4.4

