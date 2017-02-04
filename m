From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Sat, 4 Feb 2017 17:08:28 +0100
Message-ID: <20170204160828.e5dqpqg5g3cd7rmy@sirena.org.uk>
References: <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
 <8e10714e-1795-d5df-630e-8303bf36abfd@redhat.com>
 <20170126003342.GF36291@dtor-ws>
 <3026976.Qjk9AeF3Vr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nwc5loy6626yupv6"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3026976.Qjk9AeF3Vr@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Al Stone <ahs3@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Furquan Shaikh <furquan@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--nwc5loy6626yupv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2017 at 11:35:55AM +0100, Rafael J. Wysocki wrote:

> but that doesn't work if drivers expect to be able to control regulators directly
> (which BTW isn't an good idea overall IMO, because that may need to be done
> differently on different platforms even without ACPI AFAICS).

We've really not encountered anything that has any issues here outside
of what's supported in the constraints already (basically what voltages
can be set and if the supply can be turned on and off).  I'd be pretty
surprised if we did TBH, it's hard to do something radically different
with a single piece of silicon which is the abstraction level we tend to
be operating at if we are controlling regulators.  AFAICT a higher level
of abstraction is generally going to go along with physically hiding the
regulators even in a DT world.

--nwc5loy6626yupv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliV/HgACgkQJNaLcl1U
h9Cucgf9GkPk+LlttlegDpiUQeMql9oKwPjs56WKBkaww6NCQvdzmo0lxIEgO9bn
OHmOcfLtNax8Yy9UAdK+1DO1yicNAf1QW7VAhJO+6Q4kGu6dC+1Z+G/848BFN9ii
Mm1C/swxGekI1NhSckCUuk4QXnqApLv9XdeZ7UvX/6LY6hCQpHAGxxvBuUT/NEOe
LNNRm95TMRAJYYuZmk0bkR9EKUS4CKgGacgj2VAhQtN5K09vZTqRIwdnkIdRzEOh
QhHN/hnEDZbiR4OTr6/wVGEYEKrR6WYPPA9l9+MhR/GpOI2ZNZPRJcHAjvbqxeKX
vTP/LZT1O6ehNve1Uza3l37/sPZeMA==
=L5IL
-----END PGP SIGNATURE-----

--nwc5loy6626yupv6--
