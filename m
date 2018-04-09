From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv4 08/10] backlight: add TI LMU backlight driver
Date: Mon, 9 Apr 2018 17:54:33 +0200
Message-ID: <20180409155433.zxqs2b2k2xzn6kon@earth.universe>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-9-sebastian.reichel@collabora.co.uk>
 <20180403104908.GD6758@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2na4yo3f6lfp4s6v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180403104908.GD6758@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--2na4yo3f6lfp4s6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 03, 2018 at 12:49:08PM +0200, Pavel Machek wrote:
> > +enum ti_lmu_bl_type {
> > +	TI_LMU_BL,  /* backlight userspace interface */
> > +	TI_LMU_LED, /* led userspace interface */
> > +};
> ...
> > +static int ti_lmu_bl_add_device(struct ti_lmu_bank *lmu_bank)
> > +{
> > +	switch (lmu_bank->type) {
> > +	case TI_LMU_BL:
> > +		return ti_lmu_bl_register_backlight(lmu_bank);
> > +	case TI_LMU_LED:
> > +		return ti_lmu_bl_register_led(lmu_bank);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
>=20
> Ok, this is somehow unusual/crazy. Single driver with two
> interfaces.
>=20
> Do we need the LED interface for something?
>
> If yes, I believe reasonable solution would be to always provide LED
> interface, and then have "backlight-trigger" which that would provide
> backlight interface for arbitrary LED.

Userspace expects keyboard backlight to be exposed via the LED
subsystem and display backlight via the backlight subsystem.

I considered always exposing the banks via the LED subsystem and
using a generic backlight driver. That brings its own problems,
since there is a dependency between the display and the backlight.
This is described in DT using a phandle. Getting the right backlight
device from the phandle will become very tricky with this approach.

-- Sebastian

--2na4yo3f6lfp4s6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrLjLgACgkQ2O7X88g7
+pppyw//R/dfe0kUn3Hw+xarTc6IIQBywupoH2tSnHBQYjj/KOsw5vhmwcJn1oOb
PHPVyykxEF8UG7Ef1vwZrU1T7bAO374vL5VR6kI2BWjZWU43o7r5TunQRwLANRcg
3QbRlkoHXt503LgaYKsVA6jZ7AW421IMJtzlaEw2Fh+jMuyHfPdC2tGP2H8tAej0
TQTMnMmW5fxI01FkLrtgco4ixBRN0kpURex0VtAurI92wYXwXLnmerMgu2DLZs3e
YNEvDOtFUgZUNLB+6IhwVUTP4Sra2XYpb451+fHMIv9qMy1asDGXzgtFh6362pv3
gvwIkR7i3nmCnkIqX/aNk30kyVUE6OpFCMoJIRHKCZSsWx+jOIC+xTHXxiEHdh5t
qWQEtRGdQUkUH3mOGOqEcxW3GmBVugWFAN4J4ViSfXi3YCZ+sDZt4lXSn0ku2oT+
pqxVR6W54bNBtNFwWqQI9uauop+thVGeBK6j5mAuxCNs/F2RqlyePFSDczAFpq0L
nckhvk8XzdYlkgpBxBKNO8qaqT4j0Zi5VIFonzQmSf3hfU2t1aC/TW5AtimO7fk4
Zf1v/bMdhJW6ta1R/9yi+AubJ+WXkFWfX4xumPYnx63qJGwelX+7LB12GxEv84Zz
VOL46e8lW767dhBkTfE9qxW8kVpA9jxiAc/rEBqvPvjGxgs0yos=
=TEg9
-----END PGP SIGNATURE-----

--2na4yo3f6lfp4s6v--
