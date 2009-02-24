From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc3-git 1/2] regulator: twl4030 regulators
Date: Mon, 23 Feb 2009 18:22:27 -0800
Message-ID: <200902231822.27422.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200902231443.16334.david-b@pacbell.net> <20090224005536.GC3601@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n17.bullet.mail.mud.yahoo.com ([68.142.206.144]:22135 "HELO
	n17.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754274AbZBXCWb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2009 21:22:31 -0500
In-Reply-To: <20090224005536.GC3601@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Monday 23 February 2009, Mark Brown wrote:
> > > Yeah, I kind of agree. =A0To avoid confusion from changing the na=
mes I'd
> > > be tempted to go for something like "regulator driver constraints=
" but
> > > it's not desparately nice.
>=20
> > Hence my suggestion: =A0{regulator,machine,consumer} constraints,
> > going from bottom up. =A0They aren't driver constraints; they
> > are hardware constraints: =A0regulators can't supply arbitrary
> > voltages.
>=20
> Trouble is that the term regulator gets very overloaded and causes
> confusion.

That's why one of the *first* jobs in architecture is to
ensure the terminology doesn't easily overload ... there's
always trouble when it isn't.  Despite early groans from
peanut galleries about "language lawyering" and "wanting
to code in C not English", etc.  ;)

Thing is, there's already overloading here.  Two types
of regulator -- "struct regulator_dev" wrapping hardware,
and the "struct regulator" is a client/consumer handle.
(And thus confusing to me, since it sounds like the more
fundamental concept, but instead it's a few layers up.)

If you're concerned about overloading terminology, then
best to address it sooner than later.  I've noticed you
using the "consumer", "machine", and "regulator" terms
more or less like I suggested, and those make sense; but
the current struct names don't encourage that usage.  It's
possible to adjust usage before changing names in "C".
Thankfully, in Linux global name struct changes are not
rejected out of hand.


> There's also fun and games to be had with accuracy once you=20
> start looking too closely at the discrete voltages.

Yes; the patch I sent is explicitly making those available.

But I ignored issues like "+/- 3% accurate output" for LDOs
(or switchers) ... if anyone really needs to address them,
patches will be needed.  For now I only care that a 3.1 Volt
output can match both MMC_VDD_30_31 and MMC_VDD_31_32! ;)

- Dave



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
