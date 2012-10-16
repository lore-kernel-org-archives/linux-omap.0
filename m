From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 03/11] SERIAL: core: add hardware assisted h/w flow control
 support
Date: Tue, 16 Oct 2012 11:58:43 +0100
Message-ID: <E1TO4rD-0000Vx-Qr@rmk-PC.arm.linux.org.uk>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53216 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab2JPK6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 06:58:48 -0400
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Ports which are handling h/w flow control in hardware must not have
their RTS state altered depending on the tty's hardware-stopped state.
Avoid this additional logic when setting the termios state.

Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/serial_core.c |    7 +++++++
 include/linux/serial_core.h      |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index bd10bbd..9d8796e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1255,6 +1255,13 @@ static void uart_set_termios(struct tty_struct *tty,
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
index 0005138..e2cda5d 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -163,6 +163,8 @@ struct uart_port {
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

