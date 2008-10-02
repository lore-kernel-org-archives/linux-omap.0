From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/2] omap-keypad fixes for OMAP2
Date: Thu, 2 Oct 2008 16:01:17 +0300
Message-ID: <200810021601.18006.peter.ujfalusi@nokia.com>
References: <1222925329-28117-1-git-send-email-peter.ujfalusi@nokia.com> <20081002061237.GB7942@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60776 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbYJBNCr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 09:02:47 -0400
In-Reply-To: <20081002061237.GB7942@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


Hello,

the diff between l-o and mainline are these commits regarding to omap-k=
eypad.c:

commit fdee8764947cde1e6933e7d981ce5b9de00e83e6
Author: Tony Lindgren <tony@atomide.com>
Merge current mainline tree into linux-omap tree

commit ed39c59ff267249e7e789ea3bb64afc1e9afb5bd
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
omap: fix a load of "warning: symbol 'xxx' was not declared. Should it =
be static?"

commit e85a9daa48453a4e7ffedf174b4358cdb444fbbb
Author: David Brownell <dbrownell@users.sourceforge.net>
some drivers switch away from OMAP-specific GPIO calls

Should I take the relevant parts from these commits and send it to linu=
x-input?

Also there are other things broken in the omap-keypad driver.
One thing came to my mind is in the omap_kp_enable_store:=20
No matter what platform the code is running it tries to
enable/disable IRQ number 33 (IH2_BASE + 1), which is not a nice thing
to do...

P=E9ter


On Thursday 02 October 2008 09:12:39 ext Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@nokia.com> [081002 08:29]:
> > Fixes for the omap-keypad driver on OMAP2
> >=20
> > Peter Ujfalusi (2)
> >   OMAP2: omap-keypad: interrupt disable fix
> >   OMAP2: omap-keypad: Enable more than 6 rows
> >=20
> >  drivers/input/keyboard/omap-keypad.c |    6 +-----
> >  1 files changed, 1 insertions(+), 5 deletions(-)
>=20
> Looks good to me, here's my ack:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>
>=20
> Can you please send your series to linux-input@vger.kernel.org
> for inclusion into the mainline kernel? Also cc linux-omap list.
>=20
> You might also want to also include other pending patches sitting in
> linux-omap into your series so we get this driver into sync with
> mainline too.
>=20
> Thanks,
>=20
> Tony
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
