From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] regulator core: fix double-free in regulator_register() error path
Date: Tue, 28 Apr 2009 04:47:52 -0700
Message-ID: <200904280447.52954.david-b@pacbell.net>
References: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com> <200904280232.56329.david-b@pacbell.net> <20090428110052.GH14626@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:38525 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755200AbZD1Lry (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Apr 2009 07:47:54 -0400
In-Reply-To: <20090428110052.GH14626@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, linux-kernel@vger.kernel.org

On Tuesday 28 April 2009, Mark Brown wrote:
> On Tue, Apr 28, 2009 at 02:32:56AM -0700, David Brownell wrote:
> > On Tuesday 28 April 2009, Mark Brown wrote:
> > > >
> > > > For the record, that "incomplete constraints" message is bogus.
> > > > On that board, VAUX3 has a complete set of constraints: =A0it m=
ay
> > > > only emit 2.8V.
> > > >=20
> > > > What it lacks is something entirely different: =A0driver suppor=
t
> > > > for the LCD which uses the regulator framework,
> > >=20
> > > It's not VAUX3 that it's saying has incomplete constraints, it's =
the
> > > board as a whole - if the constraints for the board were fully sp=
ecified
> >
> > No; driver support !=3D constraint.  Only one of the
> > issues is packaged as a "constraint".
>=20
> Driver support isn't particularly relevant here.

It's the *entire* point.  The driver is talking directly
to the regulator, bypassing this framework.  The constraints
on that regulator are fully defined ... and then bypassed.


> > > > Mark and/or Liam ... you might want to fix that diagnostic, to
> > > > avoid leading more developers astray!
>=20
> > > Probably shove a "board has" in there or something I guess.
>=20
> > How about:  "VAUX3 board support is incomplete".
> > That's accurate.
>=20
> No.  The constraints being complete is a property of the board as a
> whole and not the particular regulator.

Except ... that "constraint" isn't the issue, it's
unexpected driver behavior.  And "board" is exactly
what I said, so I don't know why you're arguing.
(For the "fun" of it?)

Board support includes full driver support, as well
as board setup (constraints).  That's the common way
to factor it, at any rate -- a "board support package"
addresses both, and they need to work together.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
