From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] serial: 8250: Revert "tty: serial: 8250_core: read only RX
 if there is something in the FIFO"
Date: Sun, 15 Feb 2015 18:32:16 +0100
Message-ID: <20150215173216.GA8660@linutronix.de>
References: <54DA43F8.9090904@hurleysoftware.com>
 <54DBB531.2030504@hurleysoftware.com>
 <20150211200313.GE2531@atomide.com>
 <54DBBE9E.90104@hurleysoftware.com>
 <54DC6832.3070507@linutronix.de>
 <54DCD584.3010500@hurleysoftware.com>
 <20150212192333.GA18882@linutronix.de>
 <54DD053A.8060905@hurleysoftware.com>
 <20150213185115.GF5482@linutronix.de>
 <20150213231519.GF8670@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150213231519.GF8670@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Nicolas Schichan <nschichan@freebox.fr>, Tony Lindgren <tony@atomide.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This reverts commit 0aa525d11859c1a4d5b78fdc704148e2ae03ae13.

The conditional RX-FIFO read seems to cause spurious interrupts and we
see just:
|serial8250: too much work for irq29

The previous behaviour was "default" for decades and Marvell's 88f6282 SoC
might not be the only that relies on it. Therefore the Omap fix is
reverted for now.

Fixes: 0aa525d11859 ("tty: serial: 8250_core: read only RX if there is
something in the FIFO")
Reported-By: Nicolas Schichan <nschichan@freebox.fr>
Debuged-By: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
* Russell King - ARM Linux | 2015-02-13 23:15:19 [+0000]:

>On Fri, Feb 13, 2015 at 07:51:16PM +0100, Sebastian Andrzej Siewior wrote:
>> Something like this maybe?
>
>My personal feeling is that as 0aa525d11859 was wrong, it should be
>reverted and this should be another attempt to fix the problem.  In
>other words, there should be two patches, one a revert of the previously
>known bad commit and this one having another go at it.
>
>I feel that would be a better approach, since then we don't end up
>with this change building on a previously know buggy change.  It
>would also make the changes to this solution from the previous,
>known-to-work-for-decades code more obvious.

Okay. So here is the revert.

 drivers/tty/serial/8250/8250_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e3b9570a1eff..deae122c9c4b 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2138,8 +2138,8 @@ int serial8250_do_startup(struct uart_port *port)
 	/*
 	 * Clear the interrupt registers.
 	 */
-	if (serial_port_in(port, UART_LSR) & UART_LSR_DR)
-		serial_port_in(port, UART_RX);
+	serial_port_in(port, UART_LSR);
+	serial_port_in(port, UART_RX);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 
@@ -2300,8 +2300,8 @@ int serial8250_do_startup(struct uart_port *port)
 	 * saved flags to avoid getting false values from polling
 	 * routines or the previous session.
 	 */
-	if (serial_port_in(port, UART_LSR) & UART_LSR_DR)
-		serial_port_in(port, UART_RX);
+	serial_port_in(port, UART_LSR);
+	serial_port_in(port, UART_RX);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 	up->lsr_saved_flags = 0;
@@ -2394,8 +2394,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 * Read data port to reset things, and then unlink from
 	 * the IRQ chain.
 	 */
-	if (serial_port_in(port, UART_LSR) & UART_LSR_DR)
-		serial_port_in(port, UART_RX);
+	serial_port_in(port, UART_RX);
 	serial8250_rpm_put(up);
 
 	del_timer_sync(&up->timer);
-- 
2.1.4
