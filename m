From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 19:06:19 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202031900460.9453@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <alpine.DEB.2.00.1202031255330.27947@utopia.booyaka.com>
 <20120204085940.2de44594@notabene.brown> <alpine.DEB.2.00.1202031532540.27947@utopia.booyaka.com> <20120204110131.7378b8fe@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120204110131.7378b8fe@notabene.brown>
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Neil

On Sat, 4 Feb 2012, NeilBrown wrote:

> Guess what happens if I set autosuspend_delay_ms to 0?
> Massive transmit problems.  Driver can hardly get anything out before the
> UART's fclk is cut...

Just reproduced this on 35xx BeagleBoard.  Looks like the UART is indeed 
going idle while the TX FIFO has bytes in it.

Here's a patch that helps.  It seems to work down to an 
autosuspend_delay_ms of 1 ms.  Without it, the best I can get is 8 ms.

Of course, ideally it should work fine at autosuspend_delay_ms = 0, so 
likely there's some other infelicity that we're currently missing.

Neil, care to give this a test and confirm it on your setup?

Will also give the CLOCKACTIVITY bits a quick test.


- Paul

>From 3b8a272e7af23abe472c594da9bce514a0468a80 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 3 Feb 2012 19:00:03 -0700
Subject: [PATCH] UART idle TX bug test

The UART driver messes around with the SYSCONFIG bits behind the hwmod 
code's back.  For debugging purposes, prevent the hwmod code from changing 
the SYSCONFIG register.  That in turn should allow the SIDLEMODE no-idle 
setting to persist through the length of the MPU's involvement with the 
transmit operation, which it currently does not.

Then, prevent the UART from being put back into no-idle until we get the 
TX empty interrupt from the UART.  That should ensure that the TX FIFO is 
drained before allowing the UART to go into idle.

---
 arch/arm/mach-omap2/omap_hwmod.c |    4 ++--
 drivers/tty/serial/omap-serial.c |    9 +++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5192cab..bfd7e24 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -980,7 +980,7 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	sf = oh->class->sysc->sysc_flags;
 
-	if (sf & SYSC_HAS_SIDLEMODE) {
+	if (strcmp(oh->name, "uart3") && sf & SYSC_HAS_SIDLEMODE) {
 		idlemode = (oh->flags & HWMOD_SWSUP_SIDLE) ?
 			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
 		_set_slave_idlemode(oh, idlemode, &v);
@@ -1047,7 +1047,7 @@ static void _idle_sysc(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	sf = oh->class->sysc->sysc_flags;
 
-	if (sf & SYSC_HAS_SIDLEMODE) {
+	if (strcmp(oh->name, "uart3") && sf & SYSC_HAS_SIDLEMODE) {
 		idlemode = (oh->flags & HWMOD_SWSUP_SIDLE) ?
 			HWMOD_IDLEMODE_FORCE : HWMOD_IDLEMODE_SMART;
 		_set_slave_idlemode(oh, idlemode, &v);
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 72fa783..fbefcf2 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -159,9 +159,6 @@ static void serial_omap_stop_tx(struct uart_port *port)
 		serial_out(up, UART_IER, up->ier);
 	}
 
-	if (!up->use_dma && pdata->set_forceidle)
-		pdata->set_forceidle(up->pdev);
-
 	pm_runtime_mark_last_busy(&up->pdev->dev);
 	pm_runtime_put_autosuspend(&up->pdev->dev);
 }
@@ -251,6 +248,7 @@ ignore_char:
 static void transmit_chars(struct uart_omap_port *up)
 {
 	struct circ_buf *xmit = &up->port.state->xmit;
+	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;	
 	int count;
 
 	if (up->port.x_char) {
@@ -261,6 +259,8 @@ static void transmit_chars(struct uart_omap_port *up)
 	}
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
 		serial_omap_stop_tx(&up->port);
+		if (!up->use_dma && pdata->set_forceidle)
+			pdata->set_forceidle(up->pdev);
 		return;
 	}
 	count = up->port.fifosize / 4;
@@ -274,9 +274,6 @@ static void transmit_chars(struct uart_omap_port *up)
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&up->port);
-
-	if (uart_circ_empty(xmit))
-		serial_omap_stop_tx(&up->port);
 }
 
 static inline void serial_omap_enable_ier_thri(struct uart_omap_port *up)
-- 
1.7.9

