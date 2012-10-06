From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 20/24] SERIAL: core: add xmit buffer allocation callbacks
Date: Sat, 06 Oct 2012 13:45:47 +0100
Message-ID: <E1TKTlL-0002ni-MB@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47330 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032Ab2JFMp4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 08:45:56 -0400
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

This allows drivers (such as OMAP serial) to allocate and free their
transmit buffers in a sane manner, rather than working around the
buffer allocation provided by serial_core.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/serial_core.c |   23 ++++++++++++++++-------
 include/linux/serial_core.h      |    2 ++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4dd609e..53274ae 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -147,12 +147,18 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	 * buffer.
 	 */
 	if (!state->xmit.buf) {
-		/* This is protected by the per port mutex */
-		page = get_zeroed_page(GFP_KERNEL);
-		if (!page)
-			return -ENOMEM;
+		if (uport->ops->alloc_xmit) {
+			retval = uport->ops->alloc_xmit(uport, &state->xmit);
+			if (retval)
+				return retval;
+		} else {
+			/* This is protected by the per port mutex */
+			page = get_zeroed_page(GFP_KERNEL);
+			if (!page)
+				return -ENOMEM;
 
-		state->xmit.buf = (unsigned char *) page;
+			state->xmit.buf = (unsigned char *) page;
+		}
 		uart_circ_clear(&state->xmit);
 	}
 
@@ -257,7 +263,10 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	 * Free the transmit buffer page.
 	 */
 	if (state->xmit.buf) {
-		free_page((unsigned long)state->xmit.buf);
+		if (uport->ops->free_xmit)
+			uport->ops->free_xmit(uport, &state->xmit);
+		else
+			free_page((unsigned long)state->xmit.buf);
 		state->xmit.buf = NULL;
 	}
 }
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b17d4c9..ebe9af1 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -248,6 +248,8 @@ struct uart_ops {
 	void		(*break_ctl)(struct uart_port *, int ctl);
 	int		(*startup)(struct uart_port *);
 	void		(*shutdown)(struct uart_port *);
+	int		(*alloc_xmit)(struct uart_port *, struct circ_buf *);
+	void		(*free_xmit)(struct uart_port *, struct circ_buf *);
 	void		(*flush_buffer)(struct uart_port *);
 	void		(*set_termios)(struct uart_port *, struct ktermios *new,
 				       struct ktermios *old);
-- 
1.7.4.4

