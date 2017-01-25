From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 18:49:49 +0000
Message-ID: <20170125184949.x2wkoo7kbaaajkjk@sirena.org.uk>
References: <20170125000641.25520-1-furquan@chromium.org>
 <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
 <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
 <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
 <20170125182319.GB25470@leverpostej>
 <20170125182955.uznr5ehpx4dabcon@sirena.org.uk>
 <20170125183420.GC25470@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m2wbrdgsmguypckw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125183420.GC25470@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Furquan Shaikh <furquan@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, ACPI
List-Id: linux-omap@vger.kernel.org


--m2wbrdgsmguypckw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2017 at 06:34:20PM +0000, Mark Rutland wrote:
> On Wed, Jan 25, 2017 at 06:29:55PM +0000, Mark Brown wrote:

> > > Mark, this was added in this cycle; can we please rip that out for now?

> > If it's instantiated directly we probably should.

> I think that given the larger problem that needs to be addressed here,
> and how the us of DSD properties muddies the water, it would be
> preferable to remove it until we have some consensus.

Can you send a patch with a writeup please?

> > I think there's a reasonable chance that any ACPI specs could be written
> > in such a way as to allow transparent support in Linux, the main thing
> > I'd worry about is naming issues.

> I think it's certainly possible to handle this so that drivers don't
> largely have to care. I also think there is some massaging the needs to
> be done (e.g. tables of names or some indirection for ACPI/DT
> differences), and a unified API that tries to completely hide that is
> not truly possible.

Given how little consumers can assume about what they'll be allowed/able
to do on a given system the naming should be about it - if anything else
leaks through I'd be a bit worried.

--m2wbrdgsmguypckw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliI80wACgkQJNaLcl1U
h9BWHAf/chblqjRrhy7ISRo+p8FnYmmOXh2WvjIeJfrJdeK3R8er0Q/Ig66UTU/t
bMfB4/P2RSyc8rhoyg2InpjhQYzTkBOt/r+XVROCHs0qLQppyUYzlWH8OXcTGG8M
kQ+LwJl77KNkGbCCFFmRxii4+0rpNaeKJHJidR+W5ffSUb/v60A3n2OhKGRIuOaV
N/cdDUIPH1e4W1k9IWAlZWUmxIcVoqkZVZ5Lqoz0REfuqXLJPE8Iy3osk2iipDcd
UYxZrbE43m0zxUBb74Pb4V7ff5Kaqst3zXVeHqXPjxv8/gzbMg2IfXUGRNHdBEbV
pu14fLSXYIjU+gqarybtSDQjfNzE8w==
=LoTK
-----END PGP SIGNATURE-----

--m2wbrdgsmguypckw--
