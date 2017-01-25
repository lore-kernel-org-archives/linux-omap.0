From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 20:39:07 +0000
Message-ID: <20170125203907.df2elgy3ao2o2e3h@sirena.org.uk>
References: <20170125000641.25520-1-furquan@chromium.org>
 <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
 <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
 <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
 <20170125182319.GB25470@leverpostej>
 <20170125182955.uznr5ehpx4dabcon@sirena.org.uk>
 <20170125184432.GA27255@dtor-ws>
 <20170125192711.GB27255@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="deas7tsgysxd6b3q"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125192711.GB27255@dtor-ws>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Furquan Shaikh <furquan@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, ACPI Devel Maling List <linux-acp>
List-Id: linux-omap@vger.kernel.org


--deas7tsgysxd6b3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2017 at 11:27:11AM -0800, Dmitry Torokhov wrote:

> For the record, the main issue for the drivers, which is being solved by
> exposing power supplies to the driver, is the following:

> 1. We suspend the device. Since there is no regulators the driver
> assumes that it will retain it's state upon resume

That's *not* a sensible thing for drivers to assume regardless of the
presence or absence of explicitly controlled regulators, that just seems
like a plain old driver bug.  Even if there are regulators that doesn't
mean there isn't a suspend mode configuration that disables those
regulators.

> I would really hate to go through _every_ driver and add the following
> code to the resume path:
>=20
> #if IS_ENABLED(CONFIG_ACPI)
> 	if (acpi_device_was_powered_off_between_suspend_and_now(dev)) {
> 		completely_reinitialize_device(dev);
> 	}
> #endif

That's not an ACPI thing, unless the device thinks it's actively
providing a wakeup source then if the system suspends the driver should
not be surprised to have power pulled - that's pretty normal.  If the
driver is a wakeup source then it's a bit different.

--deas7tsgysxd6b3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliJDOoACgkQJNaLcl1U
h9AJIgf/WuozW4tMkZN6VzQISlbBTvuM9Q3W0PolUl6SWT5LDWJUqrn7FCk7dLPn
rh+54V0wN+2U1nR0MzHUP66pNKWuHkfiCsbagFJKe+y8qcfVlArb4LZu9sO83WBo
G+jIFKYsrMBhsCX+8B7/viBY8AM5V3yrXYDHIMM8lunTW3zKBKD9uVidlkzQ/CmC
77nugo21dNEA13O7QCI8yGKkudF0vECjUkwB8orVU5ltkRfsT733Q0rrW0l790KM
8SzRO8KGvLQX5W2+xx2Yg4UoktOqK9VfzvuqlzzVTqqZNq7E5CSBclXeonHYvcGu
gBRhfC2u2pjKwshngZCt4Ryfg6X3BQ==
=iIal
-----END PGP SIGNATURE-----

--deas7tsgysxd6b3q--
