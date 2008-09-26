From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 9/9] i2c: move twl4030-madc to new registration style
Date: Fri, 26 Sep 2008 20:46:44 +0300
Message-ID: <20080926174643.GA9890@frodo>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <1222427996-7018-9-git-send-email-felipe.balbi@nokia.com> <1222427996-7018-10-git-send-email-felipe.balbi@nokia.com> <200809261009.12639.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39155 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbYIZRq5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 13:46:57 -0400
Content-Disposition: inline
In-Reply-To: <200809261009.12639.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mikko Ylinen <mikko.k.ylinen@nokia.com>

On Fri, Sep 26, 2008 at 10:09:12AM -0700, David Brownell wrote:
> On Friday 26 September 2008, Felipe Balbi wrote:
> > =A0arch/arm/mach-omap2/board-2430sdp.c =A0 =A0 | =A0 =A06 +
> > =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 | =A0 =A06 +
> > =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 | =A0 =A06 +
> > =A0arch/arm/mach-omap2/board-omap2evm.c =A0 =A0| =A0 =A06 +
> > =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 =A06 +
> > =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0| =A0 =A06 +
> > =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 | =A0 =A06 +
>=20
> The MADC stuff gave me:
>=20
> arch/arm/mach-omap2/board-omap3beagle.c:118: error: 'TWL4030_MADC_IMR=
1' undeclared here (not in a function)
> arch/arm/mach-omap2/board-omap3beagle.c:119: error: 'TWL4030_MADC_ISR=
1' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-omap2/board-omap3beagle.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [arch/arm/mach-omap2] Error 2
>   CC      kernel/panic.o
>=20
> Ditto for Overo.
>=20
>=20
> Passing those registers in platform data seems bizarre.
> Doesn't the MADC code know its own register offsets??

there two of them. i[ms]r[12].

> The platform data should probably say which ADC channels
> are wired up...
>=20
> And no ADC lines are even hooked up on Beagle, so the right
> fix is just to not provide madc platform data on beagle.
> Probably the same is true on some other boards.

Yeah, i wasn't sure if beagle and overo were using them, so I put
anyways.

> Plus:  MADC is just a set of ADC channels, right?
> If so, the driver should have a comment saying that.

Mikko should comment on that as he wrote the driver.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
