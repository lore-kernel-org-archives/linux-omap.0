From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 07/15] twl4030_charger: allow fine control of charger
 current.
Date: Wed, 4 Mar 2015 17:47:41 +1100
Message-ID: <20150304174741.4b3af1ac@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150224043351.4243.88962.stgit@notabene.brown>
	<20150302210501.GJ13270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/uPqXHqnPbh+Mw_s1EM2vjBU"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302210501.GJ13270@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/uPqXHqnPbh+Mw_s1EM2vjBU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2015 22:05:01 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
>=20
> > +	/* ichg values in uA. If any are 'large', we set CGAIN to
> > +	 * '1' which doubles the range for half the precision.
> > +	 */
> > +	int			ichg_eoc, ichg_lo, ichg_hi, cur;
>=20
> We should really get uA_t.

Maybe. 32bits allows for  4000A, which should be plenty...
I made it unsigned int.

>=20
> [Plus, this is not kernel comment style, but...]

Fixed

>=20
> > +	/* For ichg_eoc, reg value must be 100XXXX000, we only
> > +	 * set the XXXX in high nibble.
> > +	 */
>=20
> Confused. High nibble is 0xf0, right?

does this help?

	/*
	 * For ichg_eoc, the hardware only supports reg values matching
	 * 100XXXX000, and requires the XXXX be stored in the high nibble
	 * of TWL4030_BCIMFTH8
	 */


>=20
> > +	/* And finally, set the current.  This is stored in
> > +	 * two registers. */
> > +	reg =3D ua2regval(bci->cur, cgain);
> > +	/* we have only 10 bit */
>=20
> bits
>=20
> > @@ -562,6 +698,14 @@ static int __init twl4030_bci_probe(struct platfor=
m_device *pdev)
> >  	if (!pdata)
> >  		pdata =3D twl4030_bci_parse_dt(&pdev->dev);
> > =20
> > +	bci->ichg_eoc =3D 80100; /* Stop charging when current drops to here =
*/
> > +	bci->ichg_lo =3D 241000; /* low threshold */
>=20
> Low
>=20
> > +	bci->ichg_hi =3D 500000; /* High threshold */
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20

Thanks again!

NeilBrown

--Sig_/uPqXHqnPbh+Mw_s1EM2vjBU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPaqjTnsnt1WYoG5AQIMQQ/9EvdT1SYfUsQC5j4DjydKNmnqGJlsA5s5
aFjA3MbP7pd08l7BS5FWeRIZVaZJMV5tZHuIE36rwHGG5lHOwjH6CI4gwzJ0HBLb
oJz93BCdmEleqDx88p1kkoMpE/1d126ode8uTvkwfsHWgovfjpNagL4qUx/lSsSM
E6XCb6Z01KxddSaYS3rRFmhvQcPYyzvp1Z/lHw6xq5XcJdp7SXLsOt9SffUKTjUC
fnvDIJvPwmg13xGKUtl2vpx+29OQNC6Eccf4s6aWGZA8RZmvTIfwapdhF+1cJH+5
lFoJgtk2JtcR61jowWwVW/ekdDK7NQkSXHk69TnsPvjZKWMQIT9xANcPbznzn9ps
6zUq07UxR53cQ6yD7ZjQT1u6tejFj2rr7nQhLZ05DuWlWmDzI6OoBbo1cehlmNkg
bKsawDZbzSrq89kcpoPB6lGDZgOe/M0GrI4ozJJcE6K5bRpg7IPbVhTjtQhwupWd
iUnqRHD6m7C1UUuevvJ/E6rr4OuY48buyKl8R4XLHNa+f3z37lV48TpKB6gaafUy
Bw/tLiHdq4JTK87AKyX4lET7fhKxj0Ovjk7DqDwc960JhfRudUWafc/hdq/gDIgk
j1MgFc7mJIRNBH47Whtuk7vgEjf9TRrh6qukjayzCm0lzuy9/MWUdouHGF3xZCiY
k5S8pBTYuJk=
=Dqh7
-----END PGP SIGNATURE-----

--Sig_/uPqXHqnPbh+Mw_s1EM2vjBU--
