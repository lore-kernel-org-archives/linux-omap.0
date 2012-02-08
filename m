From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 11:53:27 -0800
Message-ID: <20120208195327.GA5223@kroah.com>
References: <20120205125904.GB11372@n2100.arm.linux.org.uk>
 <20120205172925.GS20333@atomide.com>
 <20120205175809.GF17309@n2100.arm.linux.org.uk>
 <20120205182910.GK1426@atomide.com>
 <87lioegtk9.fsf@ti.com>
 <87y5sei1qz.fsf@ti.com>
 <CANOLnOMXdgBv_aGeK7ngD-d07QLRTR22iqD-4571LAuN0PV1FQ@mail.gmail.com>
 <87k43xfee3.fsf@ti.com>
 <20120208170653.GA3492@kroah.com>
 <CANOLnOOTKwtNjWZWXEqsNVy20s8QLwK=2UKGMp8S_Zj6qZH9dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37866 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757247Ab2BHTzo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 14:55:44 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CABCB212C8
	for <linux-omap@vger.kernel.org>; Wed,  8 Feb 2012 14:55:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CANOLnOOTKwtNjWZWXEqsNVy20s8QLwK=2UKGMp8S_Zj6qZH9dg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Wed, Feb 08, 2012 at 07:23:34PM +0200, Grazvydas Ignotas wrote:
> On Wed, Feb 8, 2012 at 7:06 PM, Greg KH <gregkh@linuxfoundation.org> =
wrote:
> > On Wed, Feb 08, 2012 at 09:01:24AM -0800, Kevin Hilman wrote:
> >> Grazvydas Ignotas <notasas@gmail.com> writes:
> >>
> >> > On Wed, Feb 8, 2012 at 2:53 AM, Kevin Hilman <khilman@ti.com> wr=
ote:
> >> >> Kevin Hilman <khilman@ti.com> writes:
> >> >>
> >> >>> This one is indeed strange. =A0I have not seen this on the 34x=
x devices
> >> >>> I'm using (3430/n900, 3530/Overo, 3630/Zoom3).
> >> >>
> >> >> OK, I've reproduced this on v3.3-rc2.
> >> >>
> >> >> The reason I wasn't seeing this is because I'm using the fixes =
Paul has
> >> >> already posted that fix this problem:
> >> >>
> >> >> =A0 =A0 =A0 =A0http://marc.info/?l=3Dlinux-arm-kernel&m=3D13275=
4676814391&w=3D2
> >> >>
> >> >> Kevin
> >> >
> >> > But it looks like these are now queued for 3.4 in tty tree?
> >>
> >> I believe they were targettted for 3.3-rc.
> >>
> >> Paul, Greg, can you confirm?
> >
> > I have no idea what you are refering to here, please be much more
> > specific. =A0You can look at the linux-next tree to answer your que=
stion
> > yourself as well...
>=20
> It's about these patches in gregkh/tty.git tty-next:
> 6bbcbf2 tty: serial: omap-serial: wakeup latency constraint is in
> microseconds, not milliseconds
> edbe5db tty: serial: OMAP: block idle while the UART is transferring
> data in PIO mode
> 5816269 tty: serial: OMAP: use a 1-byte RX FIFO threshold in PIO mode
>=20
> It would look to me like they are queued for 3.4 but Kevin says there
> were intended for 3.3-rc.

Kevin might have wished they would go into 3.3, but given that the firs=
t
round of these patches had to be reverted, I thought it safer to wait
for 3.4.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
