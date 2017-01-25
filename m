From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 12:49:11 +0000
Message-ID: <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
References: <20170125000641.25520-1-furquan@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z634xx5lmuoq5bka"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125000641.25520-1-furquan@chromium.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Furquan Shaikh <furquan@chromium.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mark.rutland@arm.co
List-Id: linux-omap@vger.kernel.org


--z634xx5lmuoq5bka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 24, 2017 at 04:06:34PM -0800, Furquan Shaikh wrote:

> Since regulator properties remain the same across OF and ACPI
> regulators, this series of patches provides common routine for
> obtaining regulation constraints from device tree and ACPI nodes. In

As Lorenzo explained this is really not a good idea, ACPI has a power
management model which is just being ignored here.  If you're producing
systems using ACPI you really need to use ACPI in a joined up fashion
rather than just blindly importing all DT bindings into ACPI.  While
there are many areas where ACPI just doesn't do anything and as a result
it does make sense to reuse existing DT bindings there are also plenty
of areas where work has been done on the ACPI side.  Regulators and
power management are definitely one of those areas.

--z634xx5lmuoq5bka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliInsYACgkQJNaLcl1U
h9C7Agf9EsQsUbRHtngdJwUJ8Bsz0Ohb9jMUsXdJG04BEkzD4PQ6k2kuW8HavI4a
DDrHzX1+2TENr1q8RFM54+KWAPacaBCLP+1zqRHn5EyGkB5Bn+W0jD442e4otqg/
2xr0U7Hr8AWAkaJIDeJYY0yQ94PGdLyQNWIX0figBoMszyrjnqeB4hMzeYLcFNRC
OrjoJgZH1lsP5rwzk0XSlMJV7R9/AdHZ2dQgpa8/BmhsS/vU5UkWLLXTWpyqboDa
sZmUJujCEgr8IGYn2hbnpBXl6yVkBhbDcEFwq2InttEqlKiHVgGHXfEXBzMm1qR9
9RUiXEmUutXrVAlnwftrInJ9TUSpHA==
=EkRk
-----END PGP SIGNATURE-----

--z634xx5lmuoq5bka--
