From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Sun, 25 Jan 2015 22:22:58 +0100
Message-ID: <20150125212015.GA14307@amd>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <20150113204219.GJ2419@atomide.com>
 <20150115142536.GC512@earth.universe>
 <201501241300.00723@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35033 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbbAYVXC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jan 2015 16:23:02 -0500
Content-Disposition: inline
In-Reply-To: <201501241300.00723@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Sat 2015-01-24 13:00:00, Pali Roh=E1r wrote:
> On Thursday 15 January 2015 15:25:36 Sebastian Reichel wrote:
> > On Tue, Jan 13, 2015 at 12:42:20PM -0800, Tony Lindgren wrote:
> > > * Arnd Bergmann <arnd@arndb.de> [150113 12:27]:
> > > > On Tuesday 13 January 2015 09:57:41 Tony Lindgren wrote:
> > > > > It seems we can now drop omap3517 legacy booting support
> > > > > to get a bit closer to making all of omap3 boot in
> > > > > device tree only mode.
> > > > >=20
> > > > > All these boards have at least minimal support for
> > > > > booting with device tree, and pretty much anything
> > > > > supported with the legacy board files can be configured
> > > > > also for device tree based booting if not done already.
> > > >=20
> > > > Ah, very nice.
> > > >=20
> > > > Just out of curiosity, what are the remaining showstoppers
> > > > for the 3430 and 3530 based boards?
> > >=20
> > > Not much really. We're now printing a warning to get a
> > > people to upgrade their systems. So with some boards we
> > > need to wait a while.
> > >=20
> > > Then here are the remaining items that I'm aware of:
> > >=20
> > > - A regression at least on some n900 with appended DTB not
> > > booting
> > >=20
> > >   properly any longer reported by Pali
> > >=20
> > > - A regression where the legacy ATAGs don't seem to get
> > > properly
> > >=20
> > >   translated by the uncompress code for atag_rev at least
> > >   reported by Pali
> > >=20
> > > - A few missing .dts files for devkit8000, omap3logic,
> > > omap3stalker,
> > >=20
> > >   omap3pandora and omap3touchbook
> > >=20
> > > Pali and Sebastian probably know best of any other remaining
> > > issues to drop n900 legacy booting.
> >=20
> > Apart from the bugs there is only one feature-wise regression
> > when the system is booted via DT, which is the accelerometer.
> > I will (re)send patches for that in the next days.
> >=20
> > -- Sebastian
>=20
> Another regression for DT setup (which does not occur for board code)=
:
>=20
> omap_hsmmc driver does not export slot_name sysfs entry because
> it not supported by DT yet. Entry slot_name is used by userspace
> application to determinate if mmc block device is internal eMMC
> memory or external uSD card. So support for this property also in
> DT is needed.
>=20
> Here is simple patch which fix this problem:

Thanks!

Does it need line into Documentation/devicetree/ somewhere?

With that,
Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
