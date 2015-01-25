From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 2/4] serial: 8250_omap: Use UPSTAT_AUTORTS for RTS handling
Date: Sun, 25 Jan 2015 14:44:52 -0500
Message-ID: <1422215094-3216-3-git-send-email-peter@hurleysoftware.com>
References: <1422215094-3216-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:55180 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632AbbAYTpI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jan 2015 14:45:08 -0500
Received: by mail-qc0-f175.google.com with SMTP id c9so4463178qcz.6
        for <linux-omap@vger.kernel.org>; Sun, 25 Jan 2015 11:45:07 -0800 (PST)
In-Reply-To: <1422215094-3216-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

Commit 88838d3112702 ("serial: omap_8250: Fix RTS handling") fixed
RTS pin control when in autoRTS mode.

New support added in "serial: core: Rework hw-assisted flow control support"
enables a much simpler approach; rather than masking out autoRTS
whenever writing the EFR register, use the UPSTAT_* mode to determine if
autoRTS should be enabled when raising RTS (in omap8250_set_mctrl()).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_omap.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 4473881..59d6e90 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -120,10 +120,11 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	 */
 	lcr = serial_in(up, UART_LCR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-	if (mctrl & TIOCM_RTS)
-		serial_out(up, UART_EFR, priv->efr);
+	if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
+		priv->efr |= UART_EFR_RTS;
 	else
-		serial_out(up, UART_EFR, priv->efr & ~UART_EFR_RTS);
+		priv->efr &= ~UART_EFR_RTS;
+	serial_out(up, UART_EFR, priv->efr);
 	serial_out(up, UART_LCR, lcr);
 }
 
@@ -272,10 +273,7 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_dl_write(up, priv->quot);
 
-	if (up->port.mctrl & TIOCM_RTS)
-		serial_out(up, UART_EFR, priv->efr);
-	else
-		serial_out(up, UART_EFR, priv->efr & ~UART_EFR_RTS);
+	serial_out(up, UART_EFR, priv->efr);
 
 	/* Configure flow control */
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
@@ -424,9 +422,9 @@ static void omap_8250_set_termios(struct uart_port *port,
 	up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
 
 	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
-		/* Enable AUTORTS and AUTOCTS */
+		/* Enable AUTOCTS (autoRTS is enabled when RTS is raised) */
 		up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
-		priv->efr |= UART_EFR_CTS | UART_EFR_RTS;
+		priv->efr |= UART_EFR_CTS;
 	} else	if (up->port.flags & UPF_SOFT_FLOW) {
 		/*
 		 * IXON Flag:
-- 
2.2.2

