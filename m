From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Sun, 25 Jan 2015 22:23:15 +0100
Message-ID: <20150125212315.GB14307@amd>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <20150115142536.GC512@earth.universe>
 <201501241300.00723@pali>
 <2871852.qm0MoZvdlF@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35135 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbbAYVXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jan 2015 16:23:17 -0500
Content-Disposition: inline
In-Reply-To: <2871852.qm0MoZvdlF@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Sat 2015-01-24 23:08:00, Arnd Bergmann wrote:
> On Saturday 24 January 2015 13:00:00 Pali Roh=E1r wrote:
> >=20
> > Another regression for DT setup (which does not occur for board cod=
e):
> >=20
> > omap_hsmmc driver does not export slot_name sysfs entry because
> > it not supported by DT yet. Entry slot_name is used by userspace
> > application to determinate if mmc block device is internal eMMC
> > memory or external uSD card. So support for this property also in
> > DT is needed.
> >=20
> > Here is simple patch which fix this problem:
> >=20
>=20
> The sysfs file only exists for the two OMAP drivers, and the naming
> is used only by board-n8x0, board-rx51 and board-omap3logic.
>=20
> It may be better to add a board-specific hack for these to keep the
> existing user space working but not spread the use of this file anywh=
ere
> else.

I'd guess this is going to be useful on more than just n900, and thus
is worth supporting generically...

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
