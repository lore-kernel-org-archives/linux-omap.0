From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 22:25:33 +0000
Message-ID: <20170125222533.l6sgeqoi7fmpzgne@sirena.org.uk>
References: <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
 <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
 <20170125182319.GB25470@leverpostej>
 <20170125182955.uznr5ehpx4dabcon@sirena.org.uk>
 <20170125184432.GA27255@dtor-ws>
 <20170125192711.GB27255@dtor-ws>
 <20170125203907.df2elgy3ao2o2e3h@sirena.org.uk>
 <20170125211714.GA36291@dtor-ws>
 <20170125213040.2et4wkgt6y72zn5i@sirena.org.uk>
 <20170125220558.GB36291@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="52djq6jrftn2uwpd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125220558.GB36291@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Furquan Shaikh <furquan@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, ACPI Devel Maling List <linux-acp>
List-Id: linux-omap@vger.kernel.org


--52djq6jrftn2uwpd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2017 at 02:05:58PM -0800, Dmitry Torokhov wrote:

> > Yes.  Querying the suspend mode configuration would be one way to do it
> > already.

> Suspend mode of what though? Regulator? I would not mind cleaning up at
> least some of the drivers if we had a generic API for doing such
> query... Would it be something like:

Yes, though there's some fun working out exactly when to query them.
Early resume should be safe.

> 	bool device_has_lost_state(struct device *dev,
> 				   struct regulator *supplies)

> with DT systems going strictly off regulator data and ACPI throwing
> its internal state in the mix?

> Or you meant something else?

I meant looking at individual regulators, though I guess that does have
a list of supplied as an argument.

--52djq6jrftn2uwpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliJJdwACgkQJNaLcl1U
h9BqTAf/T4vOYKvt4Z1pyK5TPgC7tul6mboPtdy85852jrC0Spe8tBvwSAlskEHk
ZeSIYe7ERlwRIARce9xeR44/5bOTVKEoIP7v1afHhlFOn4ZmGuAZdDjY8XwBkrGA
PS5v+AhW0P6p0VvZoE8HVOd8bDDCNJ8rfjYx48BnwcjMwWSiRFf6wznYO4noSD6d
qxn0qjEl9J7XhBq93b+oIfPijkTWfrFDAsnZsmvY3f4eNeQM/Rhl8uKgGRV01dPN
6X+J9ytwcCtw5YGlx1sk7ow4fgV0/3Zm5pqolvKxSFspSWP9ASvNV2UfJguIvOi1
IVknghRlFAdy+M/hbh9+cRT70+MY4A==
=nKKz
-----END PGP SIGNATURE-----

--52djq6jrftn2uwpd--
