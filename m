From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4 08/10] backlight: add TI LMU backlight driver
Date: Tue, 10 Apr 2018 08:38:20 +0200
Message-ID: <20180410063820.GA5793@amd>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-9-sebastian.reichel@collabora.co.uk>
 <20180403104908.GD6758@amd>
 <20180409155433.zxqs2b2k2xzn6kon@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409155433.zxqs2b2k2xzn6kon@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +static int ti_lmu_bl_add_device(struct ti_lmu_bank *lmu_bank)
> > > +{
> > > +	switch (lmu_bank->type) {
> > > +	case TI_LMU_BL:
> > > +		return ti_lmu_bl_register_backlight(lmu_bank);
> > > +	case TI_LMU_LED:
> > > +		return ti_lmu_bl_register_led(lmu_bank);
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> >=20
> > Ok, this is somehow unusual/crazy. Single driver with two
> > interfaces.
> >=20
> > Do we need the LED interface for something?
> >
> > If yes, I believe reasonable solution would be to always provide LED
> > interface, and then have "backlight-trigger" which that would provide
> > backlight interface for arbitrary LED.
>=20
> Userspace expects keyboard backlight to be exposed via the LED
> subsystem and display backlight via the backlight subsystem.

Ok.

> I considered always exposing the banks via the LED subsystem and
> using a generic backlight driver. That brings its own problems,
> since there is a dependency between the display and the backlight.
> This is described in DT using a phandle. Getting the right backlight
> device from the phandle will become very tricky with this approach.

I believe we have to do this.

Virtually any LED can be used as a backlight, and we don't really want
to add two personalities to all the LED drivers.

And it should not be too bad: LED will just have default trigger,
which will say this LED corresponds to this display device. I believe
someone wanted to do that for USB/ethernet activity.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrMW9wACgkQMOfwapXb+vIkBACfZR1KTKRlSldNfZMrF8WODxgj
MYsAn3UeGWYrf6edRoHD6WA/OeY7EWcj
=Ma6V
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
