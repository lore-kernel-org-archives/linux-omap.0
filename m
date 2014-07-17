From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 5/5] tty: serial: Add 8250-core based omap driver
Date: Thu, 17 Jul 2014 09:42:19 +0200
Message-ID: <20140717074219.GA29193@linutronix.de>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
 <1405521903-5877-6-git-send-email-bigeasy@linutronix.de>
 <20140717070859.GD18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140717070859.GD18374@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren | 2014-07-17 00:09:00 [-0700]:

>Seems to boot a bit further now with output from serial console
>initially, then I'm getting the following error again that's probably
>related to clocks not enabled when the registers are accessed:

It is (mostly) the same thing as before. We have additionally 
omap_8250_startup() in the backtrace but it is the same thing.
So you  say I miss a clock? Looking through serial8250_do_startup() I see:
- pm_runtime_get_sync(port->dev); which should get the clocks up
- serial8250_clear_fifos() which does a write at address + 8. Seems to 
  work. 
- serial_port_in(port, UART_LSR); does a read at address + 0x14, seems 
  to work.
- serial_port_in(port, UART_RX); does a read at address + 0. This is 
  probably the bad one.

Now comparing with omap-serial I noticed that I do a 32bit access
instead a 16bit.
Could you please try the following hack:

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 2e4a93b..94af5a3 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -420,13 +420,13 @@ static void mem_serial_out(struct uart_port *p, int offset, int value)
 static void mem32_serial_out(struct uart_port *p, int offset, int value)
 {
 	offset = offset << p->regshift;
-	writel(value, p->membase + offset);
+	writew(value, p->membase + offset);
 }
 
 static unsigned int mem32_serial_in(struct uart_port *p, int offset)
 {
 	offset = offset << p->regshift;
-	return readl(p->membase + offset);
+	return readw(p->membase + offset);
 }
 
 static unsigned int io_serial_in(struct uart_port *p, int offset)


besides that, I don't see what could be different.

>Regards,
>
>Tony

Sebastian
