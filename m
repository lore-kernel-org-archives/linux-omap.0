From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 3/4] serial: omap: Fix RTS handling
Date: Sun, 25 Jan 2015 14:44:53 -0500
Message-ID: <1422215094-3216-4-git-send-email-peter@hurleysoftware.com>
References: <1422215094-3216-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:54859 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbbAYTpJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jan 2015 14:45:09 -0500
Received: by mail-qa0-f43.google.com with SMTP id v10so4398531qac.2
        for <linux-omap@vger.kernel.org>; Sun, 25 Jan 2015 11:45:08 -0800 (PST)
In-Reply-To: <1422215094-3216-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

The OMAP UART ignores MCR[1] (ie., RTS) when in autoRTS mode. This
makes it impossible for either the serial core or userspace to
manually flow control the sender.

Disable autoRTS mode when RTS is lowered and restore the previous
mode when RTS is raised.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/omap-serial.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index b28cdca..e01b65e 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -681,7 +681,7 @@ static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
-	unsigned char mcr = 0, old_mcr;
+	unsigned char mcr = 0, old_mcr, lcr;
 
 	dev_dbg(up->port.dev, "serial_omap_set_mctrl+%d\n", up->port.line);
 	if (mctrl & TIOCM_RTS)
@@ -701,6 +701,17 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		     UART_MCR_DTR | UART_MCR_RTS);
 	up->mcr = old_mcr | mcr;
 	serial_out(up, UART_MCR, up->mcr);
+
+	/* Turn off autoRTS if RTS is lowered; restore autoRTS if RTS raised */
+	lcr = serial_in(up, UART_LCR);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
+		up->efr |= UART_EFR_RTS;
+	else
+		up->efr &= UART_EFR_RTS;
+	serial_out(up, UART_EFR, up->efr);
+	serial_out(up, UART_LCR, lcr);
+
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 }
@@ -756,8 +767,6 @@ static int serial_omap_startup(struct uart_port *port)
 	 * (they will be reenabled in set_termios())
 	 */
 	serial_omap_clear_fifos(up);
-	/* For Hardware flow control */
-	serial_out(up, UART_MCR, UART_MCR_RTS);
 
 	/*
 	 * Clear the interrupt registers.
@@ -1056,12 +1065,9 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
 
 	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
-		/* Enable AUTORTS and AUTOCTS */
+		/* Enable AUTOCTS (autoRTS is enabled when RTS is raised) */
 		up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
-		up->efr |= UART_EFR_CTS | UART_EFR_RTS;
-
-		/* Ensure MCR RTS is asserted */
-		up->mcr |= UART_MCR_RTS;
+		up->efr |= UART_EFR_CTS;
 	} else {
 		/* Disable AUTORTS and AUTOCTS */
 		up->efr &= ~(UART_EFR_CTS | UART_EFR_RTS);
-- 
2.2.2

