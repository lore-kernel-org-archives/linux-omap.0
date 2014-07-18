From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] tty: serial: Add 8250-core based omap driver
Date: Thu, 17 Jul 2014 23:24:56 -0700
Message-ID: <20140718062456.GJ18374@atomide.com>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
 <1405521903-5877-6-git-send-email-bigeasy@linutronix.de>
 <20140717070859.GD18374@atomide.com>
 <20140717074219.GA29193@linutronix.de>
 <20140717081232.GH18374@atomide.com>
 <53C7A01C.50107@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53C7A01C.50107@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140717 03:09]:
> On 07/17/2014 10:12 AM, Tony Lindgren wrote:
> > Hmm it could be that it works for a while because the clocks are on
> > from the bootloader and pm_runtime calls won't do anything. This
> > could happen if the interconnect data based on the ti,hwmods entry
> > is not getting matched to the new driver. This gets initialized whe=
n
> > the device entry gets created in omap_device_build_from_dt().
> >=20
> > Or maybe something now affects the clock aliases? It seems that we
> > are still missing the clocks entries in the .dtsi files, see the
> > mappings with $ git grep uart drivers/clk/ti/
>=20
> I've been looking for something completely different while I noticed
> this:
>=20
> in drivers/tty/serial/omap-serial.c
> | static struct platform_driver serial_omap_driver =3D {
> |         .driver         =3D {
> |                 .name   =3D DRIVER_NAME,
> |         },
> | };
> |
>=20
> and DRIVER_NAME should come from include/linux/platform_data/serial-o=
map.h
> Looking further, I've found arch/arm/mach-omap2/serial.c:
> | void __init omap_serial_init_port(struct omap_board_data *bdata,
> |                         struct omap_uart_port_info *info)
> | {
> |         char *name
> =E2=80=A6
> |	name =3D DRIVER_NAME;
> =E2=80=A6
> |	pdev =3D omap_device_build(name, uart->num, oh, pdata, pdata_size);
> =E2=80=A6
> |
>=20
> Would this explain it?

That would explain it for legacy booting, but not for device tree
based booting. I can try to debug it further on Monday.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
