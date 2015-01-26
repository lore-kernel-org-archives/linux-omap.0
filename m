From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Mon, 26 Jan 2015 11:16:58 +0100
Message-ID: <3668717.H6LOeCvYZ4@wuerfel>
References: <1421171865-5209-1-git-send-email-tony@atomide.com> <2871852.qm0MoZvdlF@wuerfel> <201501242314.58201@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:64647 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589AbbAZKRr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2015 05:17:47 -0500
In-Reply-To: <201501242314.58201@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org

On Saturday 24 January 2015 23:14:58 Pali Roh=E1r wrote:
> On Saturday 24 January 2015 23:08:00 Arnd Bergmann wrote:
> > On Saturday 24 January 2015 13:00:00 Pali Roh=E1r wrote:
> > > Another regression for DT setup (which does not occur for
> > > board code):
> > >=20
> > > omap_hsmmc driver does not export slot_name sysfs entry
> > > because it not supported by DT yet. Entry slot_name is used
> > > by userspace application to determinate if mmc block device
> > > is internal eMMC memory or external uSD card. So support
> > > for this property also in DT is needed.
> >=20
> > > Here is simple patch which fix this problem:
> > The sysfs file only exists for the two OMAP drivers, and the
> > naming is used only by board-n8x0, board-rx51 and
> > board-omap3logic.
> >=20
> > It may be better to add a board-specific hack for these to
> > keep the existing user space working but not spread the use
> > of this file anywhere else.
>=20
> Why? omap_hsmmc.c has already support for slot_name sysfs entry,=20
> just it is not filled from DT data (only from platform_data)...

It's a highly nonstandard interface, none of the other controllers
support it, and even changing the the other omap machines to use
the same strings might break existing user space that might rely
on whatever gets printed in those properties today.

We should limit the use of those strings to the boards that
are known to run software that requires them to avoid regressions.
We could also define a standard way of finding out whether an
mmc device is removable. We already have the MMC_CAP_NONREMOVABLE
flag in the kernel and could have a read-only boolean attribute
in sysfs for it.

Putting a "name" property into DT because some random user space
requires a particular name to show up in sysfs however does not
seem a legitimate hardware description.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
