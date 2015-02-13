From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 03/16] tty: serial: 8250_core: read only RX if there is
 something in the FIFO
Date: Fri, 13 Feb 2015 19:51:16 +0100
Message-ID: <20150213185115.GF5482@linutronix.de>
References: <54D9441B.7070403@hurleysoftware.com>
 <54D9F3C7.5000809@freebox.fr>
 <54DA43F8.9090904@hurleysoftware.com>
 <54DBB531.2030504@hurleysoftware.com>
 <20150211200313.GE2531@atomide.com>
 <54DBBE9E.90104@hurleysoftware.com>
 <54DC6832.3070507@linutronix.de>
 <54DCD584.3010500@hurleysoftware.com>
 <20150212192333.GA18882@linutronix.de>
 <54DD053A.8060905@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33037 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbbBMSvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2015 13:51:21 -0500
Content-Disposition: inline
In-Reply-To: <54DD053A.8060905@hurleysoftware.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Tony Lindgren <tony@atomide.com>, Nicolas Schichan <nschichan@freebox.fr>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Something like this maybe?

Subject: [PATCH] serial: 8250: skip empty RX-read only on OMAP

The conditional RX-FIFO read seems to cause spurious interrupts and we
see just:
|serial8250: too much work for irq29

The previous behaviour was "default" for decades and Marvell's 88f6282 SoC
might not be the only that relies on it. Therefore this patch moves this
special OMAP3630 behaviour befind a BUG field.

Fixes: 0aa525d11859 ("tty: serial: 8250_core: read only RX if there is
       something in the FIFO")

Reported-By: Nicolas Schichan <nschichan@freebox.fr>
Debuged-By: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_core.c | 10 ++++++++--
 drivers/tty/serial/8250/8250_omap.c |  1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index b00836851061..b6899fd69c7e 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -84,6 +84,7 @@ struct serial8250_config {
 #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
 #define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
+#define UART_BUG_RXEMPT	(1 << 5)	/* UART can not read empty FIFO */
 
 #define PROBE_RSA	(1 << 0)
 #define PROBE_ANY	(~0)
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e3b9570a1eff..185386178023 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2137,8 +2137,13 @@ int serial8250_do_startup(struct uart_port *port)
 
 	/*
 	 * Clear the interrupt registers.
+	 *
+	 * This (and later) unsolicied read of the RX FIFO seems to clear the
+	 * RX timeout condition which otherwise generates spurious interrupt.
+	 * This behaviour has been observed on Marvell's 88f6282 SoC.
 	 */
-	if (serial_port_in(port, UART_LSR) & UART_LSR_DR)
+	if (!(up->bugs & UART_BUG_RXEMPT) ||
+	    (serial_port_in(port, UART_LSR) & UART_LSR_DR))
 		serial_port_in(port, UART_RX);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
@@ -2300,7 +2305,8 @@ int serial8250_do_startup(struct uart_port *port)
 	 * saved flags to avoid getting false values from polling
 	 * routines or the previous session.
 	 */
-	if (serial_port_in(port, UART_LSR) & UART_LSR_DR)
+	if (!(up->bugs & UART_BUG_RXEMPT) ||
+	    (serial_port_in(port, UART_LSR) & UART_LSR_DR))
 		serial_port_in(port, UART_RX);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index fe6d2e51da09..a7ead2fa6a32 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1021,6 +1021,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.fifosize = 64;
 	up.tx_loadsz = 64;
 	up.capabilities = UART_CAP_FIFO;
+	up.bugs = UART_BUG_RXEMPT;
 #ifdef CONFIG_PM
 	/*
 	 * Runtime PM is mostly transparent. However to do it right we need to a
-- 
2.1.4

