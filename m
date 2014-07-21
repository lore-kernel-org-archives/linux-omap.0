From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] tty: serial: Add 8250-core based omap driver
Date: Mon, 21 Jul 2014 02:35:28 -0700
Message-ID: <20140721093528.GS18374@atomide.com>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
 <1405521903-5877-6-git-send-email-bigeasy@linutronix.de>
 <20140717070859.GD18374@atomide.com>
 <20140717074219.GA29193@linutronix.de>
 <20140717081232.GH18374@atomide.com>
 <53C7A01C.50107@linutronix.de>
 <20140718062456.GJ18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36073 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754071AbaGUJgy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 05:36:54 -0400
Content-Disposition: inline
In-Reply-To: <20140718062456.GJ18374@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

* Tony Lindgren <tony@atomide.com> [140717 23:28]:
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140717 03:09]:
> > On 07/17/2014 10:12 AM, Tony Lindgren wrote:
> > > Hmm it could be that it works for a while because the clocks are =
on
> > > from the bootloader and pm_runtime calls won't do anything. This
> > > could happen if the interconnect data based on the ti,hwmods entr=
y
> > > is not getting matched to the new driver. This gets initialized w=
hen
> > > the device entry gets created in omap_device_build_from_dt().
> > >=20
> > > Or maybe something now affects the clock aliases? It seems that w=
e
> > > are still missing the clocks entries in the .dtsi files, see the
> > > mappings with $ git grep uart drivers/clk/ti/
> >=20
> > I've been looking for something completely different while I notice=
d
> > this:
> >=20
> > in drivers/tty/serial/omap-serial.c
> > | static struct platform_driver serial_omap_driver =3D {
> > |         .driver         =3D {
> > |                 .name   =3D DRIVER_NAME,
> > |         },
> > | };
> > |
> >=20
> > and DRIVER_NAME should come from include/linux/platform_data/serial=
-omap.h
> > Looking further, I've found arch/arm/mach-omap2/serial.c:
> > | void __init omap_serial_init_port(struct omap_board_data *bdata,
> > |                         struct omap_uart_port_info *info)
> > | {
> > |         char *name
> > =E2=80=A6
> > |	name =3D DRIVER_NAME;
> > =E2=80=A6
> > |	pdev =3D omap_device_build(name, uart->num, oh, pdata, pdata_size=
);
> > =E2=80=A6
> > |
> >=20
> > Would this explain it?
>=20
> That would explain it for legacy booting, but not for device tree
> based booting. I can try to debug it further on Monday.

Looks like the following is needed to avoid the error, no idea why..
But this is what we also do in omap-serial.c. It may be needed in
other places too?

Also, no luck yet on runtime PM. If the console is enabled omap won't
idle, and if no serial console is enabled, it just hangs. Will try
to debug this part further, it may be also related to the above.

Regards,

Tony

--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2066,8 +2066,8 @@ int serial8250_do_startup(struct uart_port *port)
 	/*
 	 * Clear the interrupt registers.
 	 */
-	serial_port_in(port, UART_LSR);
-	serial_port_in(port, UART_RX);
+	if (serial_port_in(port, UART_LSR) & UART_LSR_DR)
+		serial_port_in(port, UART_RX);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
=20
@@ -2228,8 +2228,8 @@ dont_test_tx_en:
 	 * saved flags to avoid getting false values from polling
 	 * routines or the previous session.
 	 */
-	serial_port_in(port, UART_LSR);
-	serial_port_in(port, UART_RX);
+	if (serial_port_in(port, UART_LSR) & UART_LSR_DR)
+		serial_port_in(port, UART_RX);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 	up->lsr_saved_flags =3D 0;
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
