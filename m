From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc3-git 1/2] regulator: twl4030 regulators
Date: Sun, 8 Feb 2009 16:04:29 -0800
Message-ID: <200902081604.29905.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <20090208232922.GA16966@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:41265 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753262AbZBIAEb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Feb 2009 19:04:31 -0500
In-Reply-To: <20090208232922.GA16966@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Sunday 08 February 2009, Mark Brown wrote:
> > +=A0=A0=A0=A0=A0/* Constrain board-specific capabilities according =
to what
> > +=A0=A0=A0=A0=A0 * this driver and the chip itself can actually do.
> > +=A0=A0=A0=A0=A0 */
> > +=A0=A0=A0=A0=A0c =3D &initdata->constraints;
> > +=A0=A0=A0=A0=A0if (!c->min_uV || c->min_uV < min_uV)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c->min_uV =3D min_uV;
>=20
> If we're going to do this I think it'd be better to push it into the
> core and let the regulators pass in a set of constraints so that the
> behaviour will be consistent between drivers.

Maybe, but there is no such mechanism right yet.
When it's created, then this could switch over.


> I'd also expect to have the registration fail or at least issue a
> warning if the code kicks in since that indicates that the board
> constraints have been set up incorrectly.

A warning might make sense in some cases ... that's
something I would expect to see from the regulator
core, though.  Example, I see no "max < min" checks
triggering registration errors.


> There's a reasonable chance=20
> that the fixed up constraints will still need to be changed for the
> board to be configured properly and things may end up being driven ou=
t
> of spec, potentially causing damage.

I don't see that happening ... all that code does is
tighten existing constraints to match what the hardware
can do.  The result is just a subset of the range the
board already said was OK.  If no valid subset exists,
that's a board design bug ... albeit one the regulator
core could detect.  (E.g. those "max < min" checks that
don't currently exist.)

I can easily imagine having things partially set up, and
not really caring whether, on a particular board, those
initial constraints are really the most specific ones
applicable.  One component tolerates a range of 1V8..3V6
maybe, but on any given board it can be hooked up to any
supply that's even partially in-range.

If I hook such a component up to a supply supporting 1V2
through 2V5, it's really no worry that the 1V2..1V8 part
of that range won't be used; or if 2V5..3V6 could also
work.  Those options really don't matter at all.  The
only significant part is that only the 1V8..2V5 will be
software-accessible on that board.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
