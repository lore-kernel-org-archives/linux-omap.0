From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc 2.6.29-rc6 1/2] regulator: enumerate voltages
Date: Wed, 25 Feb 2009 15:47:52 -0800
Message-ID: <200902251547.53256.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200902251412.26855.david-b@pacbell.net> <20090225230123.GA5715@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:38927 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755552AbZBYXr4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2009 18:47:56 -0500
In-Reply-To: <20090225230123.GA5715@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Wednesday 25 February 2009, Mark Brown wrote:
> > =A0=A0=A0=A0=A0=A0get_voltage() {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0read selector from hardwa=
re
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0map selector to voltage
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return that voltage
> > =A0=A0=A0=A0=A0=A0}
>=20
> > So it's trivial for similar code to take the selector as
> > a function parameter, and do the same thing. =A0Repackage
> > the existing code a bit; bzzt, done!
>=20
> Yes, that's a reasonable point (though I'd still like to see the maxi=
mum
> turn into a static value now I think about it).

At the regulator_desc level, that's trivial; I'll do that
in the patch you'll see.

In terms of the consumer interface, not -- "struct regulator"
is opaque to consumers, and everything is a functional accessor.
So I'll leave that as-is.


> > It will be fairly common for the regulator to support voltages
> > that are disallowed by the machine constraints, though. =A0That
> > can produce "holes" too; and not necessarily only for the lowest
> > or highest selector codes.
>
> At present only continous ranges are possible, though. =A0I can't thi=
nk of
> any systems I've seen that'd want discontinous constraints, though I'=
m
> sure there are some.

Consider a regulator where voltage selectors 0..3 correspond to
voltages

	{ 3.3V, 1.8V, 4.2V, 5.0V }

With machine constraints that say voltages go from 3V to 4.5V ...

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
