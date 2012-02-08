From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 23:34:41 +0000
Message-ID: <20120208233441.GD25414@n2100.arm.linux.org.uk>
References: <20120205172925.GS20333@atomide.com> <20120205175809.GF17309@n2100.arm.linux.org.uk> <20120205182910.GK1426@atomide.com> <87lioegtk9.fsf@ti.com> <87y5sei1qz.fsf@ti.com> <CANOLnOMXdgBv_aGeK7ngD-d07QLRTR22iqD-4571LAuN0PV1FQ@mail.gmail.com> <87k43xfee3.fsf@ti.com> <20120208170653.GA3492@kroah.com> <CANOLnOOTKwtNjWZWXEqsNVy20s8QLwK=2UKGMp8S_Zj6qZH9dg@mail.gmail.com> <20120208195327.GA5223@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44907 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489Ab2BHXe7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 18:34:59 -0500
Content-Disposition: inline
In-Reply-To: <20120208195327.GA5223@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Wed, Feb 08, 2012 at 11:53:27AM -0800, Greg KH wrote:
> On Wed, Feb 08, 2012 at 07:23:34PM +0200, Grazvydas Ignotas wrote:
> > On Wed, Feb 8, 2012 at 7:06 PM, Greg KH <gregkh@linuxfoundation.org=
> wrote:
> > > On Wed, Feb 08, 2012 at 09:01:24AM -0800, Kevin Hilman wrote:
> > >> Grazvydas Ignotas <notasas@gmail.com> writes:
> > >>
> > >> > On Wed, Feb 8, 2012 at 2:53 AM, Kevin Hilman <khilman@ti.com> =
wrote:
> > >> >> Kevin Hilman <khilman@ti.com> writes:
> > >> >>
> > >> >>> This one is indeed strange. =A0I have not seen this on the 3=
4xx devices
> > >> >>> I'm using (3430/n900, 3530/Overo, 3630/Zoom3).
> > >> >>
> > >> >> OK, I've reproduced this on v3.3-rc2.
> > >> >>
> > >> >> The reason I wasn't seeing this is because I'm using the fixe=
s Paul has
> > >> >> already posted that fix this problem:
> > >> >>
> > >> >> =A0 =A0 =A0 =A0http://marc.info/?l=3Dlinux-arm-kernel&m=3D132=
754676814391&w=3D2
> > >> >>
> > >> >> Kevin
> > >> >
> > >> > But it looks like these are now queued for 3.4 in tty tree?
> > >>
> > >> I believe they were targettted for 3.3-rc.
> > >>
> > >> Paul, Greg, can you confirm?
> > >
> > > I have no idea what you are refering to here, please be much more
> > > specific. =A0You can look at the linux-next tree to answer your q=
uestion
> > > yourself as well...
> >=20
> > It's about these patches in gregkh/tty.git tty-next:
> > 6bbcbf2 tty: serial: omap-serial: wakeup latency constraint is in
> > microseconds, not milliseconds
> > edbe5db tty: serial: OMAP: block idle while the UART is transferrin=
g
> > data in PIO mode
> > 5816269 tty: serial: OMAP: use a 1-byte RX FIFO threshold in PIO mo=
de
> >=20
> > It would look to me like they are queued for 3.4 but Kevin says the=
re
> > were intended for 3.3-rc.
>=20
> Kevin might have wished they would go into 3.3, but given that the fi=
rst
> round of these patches had to be reverted, I thought it safer to wait
> for 3.4.

Greg,

There's currently a regression here:

2fd149645eb4 (ARM: OMAP2+: UART: Remove omap_uart_can_sleep and add pm_=
qos)

which causes OMAP3 platforms to spit out 16 characters every couple of
seconds after typing 'dmesg' on the serial console.  This is something
which used to work before the above commit.

The above commit doesn't revert because there's a bunch of other change=
s
in later commits which remove some of the stuff it depends on, so a sim=
ple
revert is out.

What I'd like to see from OMAP folk is whether there's a simple solutio=
n.
If not, then edbe5db looks like it should be targetted for -rc.

However, I've not yet tested edbe5db to confirm whether it solves my
observations (I've not seen it either).
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
