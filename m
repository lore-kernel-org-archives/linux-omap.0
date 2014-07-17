From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 5/5] tty: serial: Add 8250-core based omap driver
Date: Thu, 17 Jul 2014 12:06:20 +0200
Message-ID: <53C7A01C.50107@linutronix.de>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de> <1405521903-5877-6-git-send-email-bigeasy@linutronix.de> <20140717070859.GD18374@atomide.com> <20140717074219.GA29193@linutronix.de> <20140717081232.GH18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140717081232.GH18374@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On 07/17/2014 10:12 AM, Tony Lindgren wrote:
> Hmm it could be that it works for a while because the clocks are on
> from the bootloader and pm_runtime calls won't do anything. This
> could happen if the interconnect data based on the ti,hwmods entry
> is not getting matched to the new driver. This gets initialized when
> the device entry gets created in omap_device_build_from_dt().
>=20
> Or maybe something now affects the clock aliases? It seems that we
> are still missing the clocks entries in the .dtsi files, see the
> mappings with $ git grep uart drivers/clk/ti/

I've been looking for something completely different while I noticed
this:

in drivers/tty/serial/omap-serial.c
| static struct platform_driver serial_omap_driver =3D {
|         .driver         =3D {
|                 .name   =3D DRIVER_NAME,
|         },
| };
|

and DRIVER_NAME should come from include/linux/platform_data/serial-oma=
p.h
Looking further, I've found arch/arm/mach-omap2/serial.c:
| void __init omap_serial_init_port(struct omap_board_data *bdata,
|                         struct omap_uart_port_info *info)
| {
|         char *name
=85
|	name =3D DRIVER_NAME;
=85
|	pdev =3D omap_device_build(name, uart->num, oh, pdata, pdata_size);
=85
|

Would this explain it?

> Regards,
>=20
> Tony

Sebastian
