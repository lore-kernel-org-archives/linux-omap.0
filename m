From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 18:29:55 +0000
Message-ID: <20170125182955.uznr5ehpx4dabcon@sirena.org.uk>
References: <20170125000641.25520-1-furquan@chromium.org>
 <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
 <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
 <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
 <20170125182319.GB25470@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qoxy7iombucoqky4"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125182319.GB25470@leverpostej>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Furquan Shaikh <furquan@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, ACPI
List-Id: linux-omap@vger.kernel.org


--qoxy7iombucoqky4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2017 at 06:23:20PM +0000, Mark Rutland wrote:
> On Wed, Jan 25, 2017 at 08:56:42AM -0800, Furquan Shaikh wrote:

> > That is the reason why the recent change to add ACPI support to fixed
> > regulators was done
> > (https://github.com/torvalds/linux/blob/master/drivers/regulator/fixed.c#L100).

> To be honest, I'm surprised this got merged.

My understanding was that it was instantiated from another device as an
implementation detail of that device, letting it say "this GPIO should
be handled as a regulator".

> Mark, this was added in this cycle; can we please rip that out for now?

If it's instantiated directly we probably should.

> We can certainly come up with something that allows drivers to support
> both, but trying to do this without updating drivers opens a huge set of
> problems.

I think there's a reasonable chance that any ACPI specs could be written
in such a way as to allow transparent support in Linux, the main thing
I'd worry about is naming issues.

--qoxy7iombucoqky4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliI7qIACgkQJNaLcl1U
h9Ak9gf9Fv8FQw78/lGnnfUEXDJpzb1xaYReLretUjNYUM6Kn7B+rcKrUg7kogZE
itGupSiNw1rcwgV2MrazN+SYKYxImjDtpYtZWilWIuO8giyFjn2qadLKxDE1ca1f
GleeWCiAh4Kbfz5+qNzwnD4EkyIud40hTehGvvBxkoBhqfFHvslKk/5RDcRPWD7T
AukmpXC4yCFXaq93sQ7seS5xwnGQ94fr+tVYccKiR+dz1mf7jfATUH7rAFBRHyA0
Zvgx6qIHvw3xBjm31TlLxj8wHAhN2DfgK1XAAOl88mHHuDxM95OQD6pfGeUsPakf
UHB5vPru63TslnVDMRfQI3QuEa1vJw==
=BSGp
-----END PGP SIGNATURE-----

--qoxy7iombucoqky4--
