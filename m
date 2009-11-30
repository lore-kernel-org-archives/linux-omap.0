From: Tony Lindgren <tony@atomide.com>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Mon, 30 Nov 2009 11:40:31 -0800
Message-ID: <20091130194031.GV4348@atomide.com>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
 <1259599010.4649.51.camel@thunk>
 <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60909 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbZK3Tkd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 14:40:33 -0500
Content-Disposition: inline
In-Reply-To: <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Peter Barada <peterb@logicpd.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

* Grant Likely <grant.likely@secretlab.ca> [091130 09:01]:
> On Mon, Nov 30, 2009 at 9:36 AM, Peter Barada <peterb@logicpd.com> wr=
ote:
> > On Mon, 2009-11-30 at 10:46 +0200, Mika Westerberg wrote:
> >> Hi Tony,
> >>
> >> Current omap serial driver takes control of all 3 (4 on OMAP3640)
> >> UARTS. However, we have such a setup where UART2 for example is us=
ed
> >> by bluetooth driver. It uses the UART as non-standard way (there a=
re
> >> some Nokia extensions to H4 protocol) so we cannot use the standar=
d
> >> driver for driving the UART but have written special one for that
> >> purpose.
> >>
> >> Question is: Is there any, upstreamable, way of preventing omap se=
rial
> >> driver to do this? Currently this is done with custom #ifdef hacke=
ry to
> >> mach-omap2/serial.c. Alternative solution that comes into mind is =
to
> >> specify UART configuration in board files and let serial driver to=
 use
> >> that instead of hard-coded one. Or do you have some nice alternati=
ves?
> >
> > Previously (back around 2.6.28-rc8) in the board file, the
> > omap_uart_config struct controlled which serial ports were enabled =
on
> > startup. =A0It was used in omap_serial_init, and it looks like that=
 code
> > went away with the following commit:
> > http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.g=
it;a=3Dblobdiff;f=3Darch/arm/mach-omap2/serial.c;h=3D2e17b57f5b23bb6703=
a2d621103585af1d8d729b;hp=3D555e735524381cbf8ef9f20d778ad81f9438e24e;hb=
=3D4355c41a635943d30e9396b95185314343dcb551;hpb=3D7e9ccf7776bb68b5367eb=
0bb35e519df62bea35c
> >
> > I'm kinda in the same boat as I want to use some of the unused seri=
al
> > port pins for GPIO, but they are setup as serial ports....

Sounds like we need something back to specify the ports to use
from board-*.c files. Kevin, got any comments?=20
=20
> Not in mainlined yet, but I'm working on porting flattened device tre=
e
> support to OMAP to solve exactly this sort of problem.  Basically,
> instead of hard coding or #ifdeffing things, a data blob gets handed
> to the kernel at boot time telling it exactly what hardware is presen=
t
> in a consistent, parsable format.  Device drivers then get probed
> based on data in the device tree.  Here's some info on the approach:
>=20
> http://www.elinux.org/Device_Trees
>=20
> I expect to have my prototype ready for review mid-January, and most
> of the common code should be either merged or queued up in linux-next
> by that time.

While device tree is a nice solution to some of the problems, it still
leaves all the issues we already have with buggy and and outdated
bootloaders. So we still need to properly initialize the devices in
the kernel.

Just for reference, most of the omap bootloader bugs seem to be
related to not muxing the pins right or using wrong timings for GPMC.

And then things that mostly change during the board development are
the GPIO pins, but those can be easily rewritten in the board-*.c
files based on the omap_rev.

But at least the device tree is a standard model, while the earlier
omap tag approach was non-standard.

Peter, maybe you've already thought through all this.. But would it be
possible to do lightweight device tree that we just use to populate
the platform data?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
