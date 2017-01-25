From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 20:40:53 +0000
Message-ID: <20170125204053.st2ce7wfjttnk65k@sirena.org.uk>
References: <20170125000641.25520-1-furquan@chromium.org>
 <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
 <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
 <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
 <20170125182319.GB25470@leverpostej>
 <20170125182955.uznr5ehpx4dabcon@sirena.org.uk>
 <20170125192135.GA8605@red-moon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bsnujbg4nv4stoln"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125192135.GA8605@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Furquan Shaikh <furquan@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.orgACPI Devel Maling List <lin>
List-Id: linux-omap@vger.kernel.org


--bsnujbg4nv4stoln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2017 at 07:21:35PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Jan 25, 2017 at 06:29:55PM +0000, Mark Brown wrote:

> > I think there's a reasonable chance that any ACPI specs could be written
> > in such a way as to allow transparent support in Linux, the main thing
> > I'd worry about is naming issues.

> I think that the difference between ACPI and DT firmware models,
> in particular in relation to power states handling (and what piece
> of SW is in charge of power management) is significant and goes beyond
> naming conventions, therefore the code (and reasoning behind it - ie
> to have an identical driver interface to a completely different FW
> model) in this series is just not acceptable, that's a plain shortcut.

> We will see how this should be implemented in ACPI, not with this
> code (and FW bindings).

Oh, absolutely - what I'm saying is that once that's done I'd expect
implementing it to be almost entirely a regulator core change in the
same way that implementing DT support was.

--bsnujbg4nv4stoln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliJDVQACgkQJNaLcl1U
h9BB4wgAhh3OzA9CSmBkVpndf2LFUQEJjzErsxWTFwL5UNZXyp+PfV5wAIbWW8gj
jurtGyWqY9Zq8balWsfZgEgEyoO/rOgt16ZzST2HyN8moljNTHeu1niZRMpySord
kjs/IrFr1IkJ4T0GBQXzFgoDXTuTs7hxvVoNHaVm3pcCW11GGcM5p2PyFZFCWG2J
erp7JCgsyEObFTrDFlkmen+IWVBo07IKI6bQLGPrkvPU2CRWRQrjpAqCf3nmEOKC
HCFlhMjpZVSJss48GAl+uCiqD0zKHiH5qy6Ef2kMXCY+UzV4Du7gnhVCfomXHoqw
UzWsg6/h01P14/bxbaW434bdXJ6geg==
=EAiU
-----END PGP SIGNATURE-----

--bsnujbg4nv4stoln--
