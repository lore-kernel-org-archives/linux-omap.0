From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] Adapt twl4030 power code to new twl4030 code
Date: Wed, 8 Oct 2008 00:16:49 -0700
Message-ID: <200810080016.49188.david-b@pacbell.net>
References: <1223390050-11499-1-git-send-email-peter.de-schrijver@nokia.com> <200810070919.55138.david-b@pacbell.net> <20081008064913.GA4542@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:41378 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751917AbYJHHQv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 03:16:51 -0400
In-Reply-To: <20081008064913.GA4542@codecarver.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 07 October 2008, Peter 'p2' De Schrijver wrote:
> > And I can't help but wonder why this isn't just part of
> > the twl4030-core code, without even a platform device/driver.
>=20
> If you think all this script loading stuff can go into twl4030-core, =
I
> can make a patch to move it there.

Well, link it with twl-core, call it as a subroutine,
add some kind of header to hold the subroutine decl.
Not unlike the linkage structure "today".

Right now I'm thinking the {core, irq, "power"} structure
will be OK, if the "irq" gets generalized so it's not just
the one SIH module (which I have, partially done) ... and
the "power" bits lose the board-specific stuff.

=20
> > I didn't move it to drivers/mfd because it seemed almost all
> > SDP-specific. =A0But to the extent that it's something generic
> > and "part of the core", maybe that's where it should be.
> > Not necessarily part of the same file.
> >=20
>=20
> It's not SDP specific, but it is OMAP specific I think. At least I ca=
n't
> see use cases outside OMAP2/3.

We'll know when/if this is used on non-OMAP hardware!

Likely not soon.  I'd like to have the code build cleanly
on most hardware, so we get the build fixes and API update
that implies.  That's mostly IRQ cleanup.  Board designers
will do what they want, and I suspect you're right there.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
