From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH V2 1/8] regulator: Introduce OMAP regulator to
 control PMIC over VC/VP
Date: Fri, 5 Jul 2013 17:52:35 +0100
Message-ID: <20130705165235.GC27646@sirena.org.uk>
References: <1371849949-12649-1-git-send-email-nm@ti.com>
 <1371849949-12649-2-git-send-email-nm@ti.com>
 <20130704154105.GD27646@sirena.org.uk>
 <20130705135507.GA17439@kahuna>
 <20130705140828.GA27646@sirena.org.uk>
 <51D6DD3A.1030002@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jvFnFFuRZ03nPPdd"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51D6DD3A.1030002@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>, Taras Kondratiuk <taras@ti.com>
List-Id: linux-omap@vger.kernel.org


--jvFnFFuRZ03nPPdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2013 at 09:50:34AM -0500, Nishanth Menon wrote:
> On 07/05/2013 09:08 AM, Mark Brown wrote:

> >>option 1) we just bypass get_voltage/set_voltage to point through to
> >>this function. result will be something similar to what we got here[1]

> >I don't really know what you mean when you say "bypass get_voltage/set_v=
oltage
> >so it's kind of hard to comment...  the link you posted appears to be a
> >link to the code I'm reviewing so it's not terribly enlightening.

> :) it is similar, yes. by bypass get/set_voltage, I mean something like [=
1]

No, that's not a good idea.

> >What makes you think that the existing regulator drivers need to be
> >modified?

> data path difference - Almost all standard regulators use i2c
> (standard i2c APIs) for every other SMPS/LDO except for the ones
> controlled by OMAP custom i2c path(vc/vp), the
> set_voltage/get_voltage needs a different implementation when it
> comes to using the vc/vp path.

> > They already have all the data exported to the core (or
> > should do)...

> I see that twl-regulator does not indeed do it, but, assuming the
> regulators have all the data exported to the core, the data is
> hidden in struct regulator_desc which is private to the device and
> driver. lets go through these:

That's just a simple matter of programming to fix, and any regulator
which can work with this sort of table based stuff you're looking at
here must also be able to be converted to work with the equivalent code
in the regulator core so open coding is a deficiency in the driver.

> > +	.cmd_reg_addr =3D 0x00,

> command register is used for sending low power state commands -
> which is not the same as voltage register or vsel_reg as used in
> depicted in regulator_desc.=09

There's no information about how to use this register in your
bindings...  but anyway, can't be too hard to add this if it's actually
used.

> > +	.i2c_timeout_us =3D 200,

> yep, does not match up.

Like I say I just don't see why this is even specified per device.

> > +	.max_uV =3D 1450000,

> can be used with constraints, but most regulator drivers seem to
> store this internally.

Or just trivially calculate it as we do currently.

> > +	.voltage_selector_offset =3D 0,
> > +	.voltage_selector_mask =3D 0x7F,
> > +	.voltage_selector_setbits =3D 0x0,
> > +	.voltage_selector_zero =3D false,

> to an extent we can map these to vsel_mask, linear_min_sel etc.
> (again assuming the regulator driver has populated it - most that
> implement custom set_voltage, get_voltage do not do that.

Anything that implements a custom set_voltage() won't work with your
data structure either...

> Other option is to make rdev available to omap_pmic regulator -
> which again implies change in existing regulator driver?

Why would any of the drivers need to change to do this?  They're already
exporting the information.

> >the only thing that's missing is the timeouts and it's
> >not at all obvious why those need to be tuned per device.

> OMAP VC hardware has no idea about how long to wait before giving up
> on an ongoing i2c transaction. This may depend on PMIC and what it
> does before acking on i2c.

So pick a high number (it's only for error cases...)?

--jvFnFFuRZ03nPPdd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1vnQAAoJELSic+t+oim9MywP/A3UF19zC0yEOk+GJs65mR+v
2ePgtFDbL3ul1+9YIWKa1m8mdxE/mMVQIbuGGyxPfToU8vqS/aOt+IVTjBe7ZR1t
jRWlux7iIrmUuK3wXklKxyaw++CC/5v7ODL/HvCBNZPPlyBB5r91q0uCz5x5YSnV
3yDjK4UvYrF71JlBZCYFVDB6F5E6YQmtVuSoIwMhnKQRkF67Z2cKf1NsA1XTqGgZ
tlJXrL/CGhI/6Vov1nVYUs5Yp7pgqQ4jWLgkF5nCXDCX7M9Uu7eO7vTxfOzyITTC
tULozWLtGOq2mObdYSA2qD/kDXBtVYiflsi5e5r/Mrd/wY+SXrZXO1r48Fvv2l0U
3G/5JJVcAKLNyIBAYJR4JhpaGh6MvcjbRHkFnICbjabGDxMmRsASmoHuOxGNwLzr
0ZzrloGjERo6UZdqJjnPUAH9M+/KihIefP58DLglRdTIpvCziQ370Mw/Yqvcd5xv
MkxXszRxegTLBkYaYtC8GyoqvBNtIW8I4/BjqpCuAl7/RNp7saJ1MM6PifVO7DeL
9QuH/R1u6rC0kHZDPbIqmTdOOyHFymshFwouD/pVpFinTyAshZUiZ/dbOJ4Jg+28
ghSSJ+0dZfXT0SzQlXypGmnxF/QeLAJ+/tneqnP9ppfL7aIC07QVzA4jsDeqeJQt
fpkMG2KxxzdSHjCesGAO
=K8HC
-----END PGP SIGNATURE-----

--jvFnFFuRZ03nPPdd--
