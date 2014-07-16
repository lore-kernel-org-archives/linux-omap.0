From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/5] tty: serial: 8250 core: add runtime pm
Date: Wed, 16 Jul 2014 16:45:02 +0200
Message-ID: <1405521903-5877-5-git-send-email-bigeasy@linutronix.de>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mika.westerberg@linux.intel.com
List-Id: linux-omap@vger.kernel.org

While comparing the OMAP-serial and the 8250 part of this I noticed tha=
t
the the latter does not use runtime-pm. Here are the pieces. It is
basically a get before first register access and a last_busy + put afte=
r
last access.
If I understand this correct, it should do nothing as long as
pm_runtime_use_autosuspend() + pm_runtime_enable() isn't invoked on the
device.

v3=E2=80=A6v4:
	- added runtime to the console code
	- removed device_may_wakeup() from serial8250_set_sleep()

Cc: mika.westerberg@linux.intel.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 98 +++++++++++++++++++++++++++++=
+++-----
 1 file changed, 85 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8=
250/8250_core.c
index 714f954..aceaea1 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -38,6 +38,7 @@
 #include <linux/nmi.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #ifdef CONFIG_SPARC
 #include <linux/sunserialcore.h>
 #endif
@@ -553,10 +554,11 @@ static void serial8250_set_sleep(struct uart_8250=
_port *p, int sleep)
 	 * offset but the UART channel may only write to the corresponding
 	 * bit.
 	 */
+	pm_runtime_get_sync(p->port.dev);
 	if ((p->port.type =3D=3D PORT_XR17V35X) ||
 	   (p->port.type =3D=3D PORT_XR17D15X)) {
 		serial_out(p, UART_EXAR_SLEEP, sleep ? 0xff : 0);
-		return;
+		goto out;
 	}
=20
 	if (p->capabilities & UART_CAP_SLEEP) {
@@ -572,6 +574,9 @@ static void serial8250_set_sleep(struct uart_8250_p=
ort *p, int sleep)
 			serial_out(p, UART_LCR, 0);
 		}
 	}
+out:
+	pm_runtime_mark_last_busy(p->port.dev);
+	pm_runtime_put_autosuspend(p->port.dev);
 }
=20
 #ifdef CONFIG_SERIAL_8250_RSA
@@ -1280,6 +1285,7 @@ static void serial8250_stop_tx(struct uart_port *=
port)
 	struct uart_8250_port *up =3D
 		container_of(port, struct uart_8250_port, port);
=20
+	pm_runtime_get_sync(port->dev);
 	__stop_tx(up);
=20
 	/*
@@ -1289,6 +1295,8 @@ static void serial8250_stop_tx(struct uart_port *=
port)
 		up->acr |=3D UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
=20
 static void serial8250_start_tx(struct uart_port *port)
@@ -1296,8 +1304,9 @@ static void serial8250_start_tx(struct uart_port =
*port)
 	struct uart_8250_port *up =3D
 		container_of(port, struct uart_8250_port, port);
=20
+	pm_runtime_get_sync(port->dev);
 	if (up->dma && !serial8250_tx_dma(up)) {
-		return;
+		goto out;
 	} else if (!(up->ier & UART_IER_THRI)) {
 		up->ier |=3D UART_IER_THRI;
 		serial_port_out(port, UART_IER, up->ier);
@@ -1318,6 +1327,9 @@ static void serial8250_start_tx(struct uart_port =
*port)
 		up->acr &=3D ~UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
+out:
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
=20
 static void serial8250_throttle(struct uart_port *port)
@@ -1335,9 +1347,14 @@ static void serial8250_stop_rx(struct uart_port =
*port)
 	struct uart_8250_port *up =3D
 		container_of(port, struct uart_8250_port, port);
=20
+	pm_runtime_get_sync(port->dev);
+
 	up->ier &=3D ~UART_IER_RLSI;
 	up->port.read_status_mask &=3D ~UART_LSR_DR;
 	serial_port_out(port, UART_IER, up->ier);
+
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
=20
 static void serial8250_enable_ms(struct uart_port *port)
@@ -1350,7 +1367,10 @@ static void serial8250_enable_ms(struct uart_por=
t *port)
 		return;
=20
 	up->ier |=3D UART_IER_MSI;
+	pm_runtime_get_sync(port->dev);
 	serial_port_out(port, UART_IER, up->ier);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
=20
 /*
@@ -1540,9 +1560,17 @@ EXPORT_SYMBOL_GPL(serial8250_handle_irq);
=20
 static int serial8250_default_handle_irq(struct uart_port *port)
 {
-	unsigned int iir =3D serial_port_in(port, UART_IIR);
+	unsigned int iir;
+	int ret;
+
+	pm_runtime_get_sync(port->dev);
+
+	iir =3D serial_port_in(port, UART_IIR);
+	ret =3D serial8250_handle_irq(port, iir);
=20
-	return serial8250_handle_irq(port, iir);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+	return ret;
 }
=20
 /*
@@ -1800,11 +1828,16 @@ static unsigned int serial8250_tx_empty(struct =
uart_port *port)
 	unsigned long flags;
 	unsigned int lsr;
=20
+	pm_runtime_get_sync(port->dev);
+
 	spin_lock_irqsave(&port->lock, flags);
 	lsr =3D serial_port_in(port, UART_LSR);
 	up->lsr_saved_flags |=3D lsr & LSR_SAVE_FLAGS;
 	spin_unlock_irqrestore(&port->lock, flags);
=20
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+
 	return (lsr & BOTH_EMPTY) =3D=3D BOTH_EMPTY ? TIOCSER_TEMT : 0;
 }
=20
@@ -1815,7 +1848,10 @@ static unsigned int serial8250_get_mctrl(struct =
uart_port *port)
 	unsigned int status;
 	unsigned int ret;
=20
+	pm_runtime_get_sync(port->dev);
 	status =3D serial8250_modem_status(up);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
=20
 	ret =3D 0;
 	if (status & UART_MSR_DCD)
@@ -1848,7 +1884,10 @@ static void serial8250_set_mctrl(struct uart_por=
t *port, unsigned int mctrl)
=20
 	mcr =3D (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
=20
+	pm_runtime_get_sync(port->dev);
 	serial_port_out(port, UART_MCR, mcr);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
=20
 static void serial8250_break_ctl(struct uart_port *port, int break_sta=
te)
@@ -1857,6 +1896,7 @@ static void serial8250_break_ctl(struct uart_port=
 *port, int break_state)
 		container_of(port, struct uart_8250_port, port);
 	unsigned long flags;
=20
+	pm_runtime_get_sync(port->dev);
 	spin_lock_irqsave(&port->lock, flags);
 	if (break_state =3D=3D -1)
 		up->lcr |=3D UART_LCR_SBC;
@@ -1864,6 +1904,8 @@ static void serial8250_break_ctl(struct uart_port=
 *port, int break_state)
 		up->lcr &=3D ~UART_LCR_SBC;
 	serial_port_out(port, UART_LCR, up->lcr);
 	spin_unlock_irqrestore(&port->lock, flags);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
=20
 /*
@@ -1908,12 +1950,23 @@ static void wait_for_xmitr(struct uart_8250_por=
t *up, int bits)
=20
 static int serial8250_get_poll_char(struct uart_port *port)
 {
-	unsigned char lsr =3D serial_port_in(port, UART_LSR);
+	unsigned char lsr;
+	int status;
=20
-	if (!(lsr & UART_LSR_DR))
-		return NO_POLL_CHAR;
+	pm_runtime_get_sync(port->dev);
=20
-	return serial_port_in(port, UART_RX);
+	lsr =3D serial_port_in(port, UART_LSR);
+
+	if (!(lsr & UART_LSR_DR)) {
+		status =3D NO_POLL_CHAR;
+		goto out;
+	}
+
+	status =3D serial_port_in(port, UART_RX);
+out:
+	pm_runtime_mark_last_busy(up->dev);
+	pm_runtime_put_autosuspend(up->dev);
+	return status;
 }
=20
=20
@@ -1924,6 +1977,7 @@ static void serial8250_put_poll_char(struct uart_=
port *port,
 	struct uart_8250_port *up =3D
 		container_of(port, struct uart_8250_port, port);
=20
+	pm_runtime_get_sync(up->dev);
 	/*
 	 *	First save the IER then disable the interrupts
 	 */
@@ -1945,6 +1999,9 @@ static void serial8250_put_poll_char(struct uart_=
port *port,
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
 	serial_port_out(port, UART_IER, ier);
+	pm_runtime_mark_last_busy(up->dev);
+	pm_runtime_put_autosuspend(up->dev);
+
 }
=20
 #endif /* CONFIG_CONSOLE_POLL */
@@ -1971,6 +2028,7 @@ int serial8250_do_startup(struct uart_port *port)
 	if (port->iotype !=3D up->cur_iotype)
 		set_io_from_upio(port);
=20
+	pm_runtime_get_sync(port->dev);
 	if (port->type =3D=3D PORT_16C950) {
 		/* Wake up and initialize UART */
 		up->acr =3D 0;
@@ -1991,7 +2049,6 @@ int serial8250_do_startup(struct uart_port *port)
 	 */
 	enable_rsa(up);
 #endif
-
 	/*
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
@@ -2015,7 +2072,8 @@ int serial8250_do_startup(struct uart_port *port)
 	    (serial_port_in(port, UART_LSR) =3D=3D 0xff)) {
 		printk_ratelimited(KERN_INFO "ttyS%d: LSR safety check engaged!\n",
 				   serial_index(port));
-		return -ENODEV;
+		retval =3D -ENODEV;
+		goto out;
 	}
=20
 	/*
@@ -2100,7 +2158,7 @@ int serial8250_do_startup(struct uart_port *port)
 	} else {
 		retval =3D serial_link_irq_chain(up);
 		if (retval)
-			return retval;
+			goto out;
 	}
=20
 	/*
@@ -2198,8 +2256,11 @@ int serial8250_do_startup(struct uart_port *port=
)
 		outb_p(0x80, icp);
 		inb_p(icp);
 	}
-
-	return 0;
+	retval =3D 0;
+out:
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+	return retval;
 }
 EXPORT_SYMBOL_GPL(serial8250_do_startup);
=20
@@ -2217,6 +2278,7 @@ void serial8250_do_shutdown(struct uart_port *por=
t)
 		container_of(port, struct uart_8250_port, port);
 	unsigned long flags;
=20
+	pm_runtime_get_sync(port->dev);
 	/*
 	 * Disable interrupts from this port
 	 */
@@ -2256,6 +2318,8 @@ void serial8250_do_shutdown(struct uart_port *por=
t)
 	 * the IRQ chain.
 	 */
 	serial_port_in(port, UART_RX);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
=20
 	del_timer_sync(&up->timer);
 	up->timer.function =3D serial8250_timeout;
@@ -2375,6 +2439,7 @@ serial8250_do_set_termios(struct uart_port *port,=
 struct ktermios *termios,
 	 * Ok, we're now changing the port state.  Do it with
 	 * interrupts disabled.
 	 */
+	pm_runtime_get_sync(port->dev);
 	spin_lock_irqsave(&port->lock, flags);
=20
 	/*
@@ -2496,6 +2561,9 @@ serial8250_do_set_termios(struct uart_port *port,=
 struct ktermios *termios,
 	}
 	serial8250_set_mctrl(port, port->mctrl);
 	spin_unlock_irqrestore(&port->lock, flags);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
 		tty_termios_encode_baud_rate(termios, baud, baud);
@@ -2931,6 +2999,8 @@ serial8250_console_write(struct console *co, cons=
t char *s, unsigned int count)
=20
 	touch_nmi_watchdog();
=20
+	pm_runtime_get_sync(port->dev);
+
 	if (port->sysrq || oops_in_progress)
 		locked =3D spin_trylock_irqsave(&port->lock, flags);
 	else
@@ -2967,6 +3037,8 @@ serial8250_console_write(struct console *co, cons=
t char *s, unsigned int count)
=20
 	if (locked)
 		spin_unlock_irqrestore(&port->lock, flags);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
 }
=20
 static int __init serial8250_console_setup(struct console *co, char *o=
ptions)
--=20
2.0.1
