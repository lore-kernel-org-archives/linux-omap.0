From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 09:06:53 -0800
Message-ID: <20120208170653.GA3492@kroah.com>
References: <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205012556.GG1426@atomide.com>
 <20120205125904.GB11372@n2100.arm.linux.org.uk>
 <20120205172925.GS20333@atomide.com>
 <20120205175809.GF17309@n2100.arm.linux.org.uk>
 <20120205182910.GK1426@atomide.com>
 <87lioegtk9.fsf@ti.com>
 <87y5sei1qz.fsf@ti.com>
 <CANOLnOMXdgBv_aGeK7ngD-d07QLRTR22iqD-4571LAuN0PV1FQ@mail.gmail.com>
 <87k43xfee3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43131 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757334Ab2BHRHC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 12:07:02 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3299921012
	for <linux-omap@vger.kernel.org>; Wed,  8 Feb 2012 12:07:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <87k43xfee3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Wed, Feb 08, 2012 at 09:01:24AM -0800, Kevin Hilman wrote:
> Grazvydas Ignotas <notasas@gmail.com> writes:
>=20
> > On Wed, Feb 8, 2012 at 2:53 AM, Kevin Hilman <khilman@ti.com> wrote=
:
> >> Kevin Hilman <khilman@ti.com> writes:
> >>
> >>> This one is indeed strange. =A0I have not seen this on the 34xx d=
evices
> >>> I'm using (3430/n900, 3530/Overo, 3630/Zoom3).
> >>
> >> OK, I've reproduced this on v3.3-rc2.
> >>
> >> The reason I wasn't seeing this is because I'm using the fixes Pau=
l has
> >> already posted that fix this problem:
> >>
> >> =A0 =A0 =A0 =A0http://marc.info/?l=3Dlinux-arm-kernel&m=3D13275467=
6814391&w=3D2
> >>
> >> Kevin
> >
> > But it looks like these are now queued for 3.4 in tty tree?
>=20
> I believe they were targettted for 3.3-rc.
>=20
> Paul, Greg, can you confirm?

I have no idea what you are refering to here, please be much more
specific.  You can look at the linux-next tree to answer your question
yourself as well...

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
