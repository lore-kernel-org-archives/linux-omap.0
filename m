From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Wed, 3 Dec 2014 17:52:04 +0100
Message-ID: <20141203165204.GD26685@amd>
References: <20141027200008.GR2560@atomide.com>
 <201411270038.01312@pali>
 <20141127011203.GR2817@atomide.com>
 <201411271232.47231@pali>
 <20141128202719.GU2817@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55711 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbaLCQwH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2014 11:52:07 -0500
Content-Disposition: inline
In-Reply-To: <20141128202719.GU2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri 2014-11-28 12:27:19, Tony Lindgren wrote:
> * Pali Roh=E1r <pali.rohar@gmail.com> [141127 03:34]:
> > On Thursday 27 November 2014 02:12:04 Tony Lindgren wrote:
> > >=20
> > > Thinking about this probably the best long term solution is
> > > to pass optional board_revision in the kernel cmdline that
> > > can be parsed early and copied to system_rev variable.
> > >=20
> >=20
> > Not possible. Our bootloader is closed & proprietary. I tried to=20
> > replace it with u-boot I was not able to do that. So we will use=20
> > that Nokia closed bootloader forever and it can provide data only=20
> > in ATAG structure.
>=20
> I'm using just mainline u-boot flashed as kernel for nolo that
> then loads the kernel.
>=20
> For passing the board revision using the pass through u-boot is
> probably the best long term solution. U-boot can read the ATAGs
> from nolo and modify the .dtb for the revision information.
>=20
> Are you saying there are some issues with that?

Plenty :-).

Basically, u-boot is great for production (select one of kernels and
boot it), but pretty much unusable for development:

1) It does not support backlight, so you are interacting blind

2) Setup to load kernels over usb would probably be interesting

3) It makes kernel fail in interesting ways depending on phase of
moon.

Please, keep nolo supported. Debugging kernel & user space is bad,
debugging u-boot & kernel & user space would be even worse.

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
