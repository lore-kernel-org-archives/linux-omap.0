From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/7] ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
Date: Sat, 9 Feb 2013 22:56:52 +0200
Message-ID: <20130209205632.GA14543@arwen.pp.htv.fi>
References: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360427896-12004-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130209165335.GA13338@arwen.pp.htv.fi>
 <20130209181432.GD32349@localhost>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41904 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932572Ab3BIU5A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 9 Feb 2013 15:57:00 -0500
Content-Disposition: inline
In-Reply-To: <20130209181432.GD32349@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>

--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 09, 2013 at 03:14:33PM -0300, Ezequiel Garcia wrote:
> > >  static int gpmc_cs_reserved(int cs)
> > >  {
> > >  	if (cs > GPMC_CS_NUM)
> > >  		return -ENODEV;
> > > =20
> > > -	return gpmc_cs_map & (1 << cs);
> > > +	if (gpmc_cs_map & (1 << cs))
> > > +		return -EBUSY;
> > > +
> > > +	return 0;
> >=20
> > you could use a ternary operator here:
> >=20
> > bit =3D gpmc_cs_map & (1 << cs);
> >=20
> > return bit ? -EBUSY : 0;
> >=20
> > But to be frank, I'm not sure this makes that much sense, I'd expect
> > gpmc_cs_reserved() to return 0 or 1 depending on the state (just as it
> > was before). The name of the method asks for a boolean return value.
> >=20
>=20
> Well, we can change the return value to a boolean.
>=20
> However, note that the function 'as it was before' was somewhat inconsist=
ent:
> gpmc_cs_reserved returned -ENODEV if the given 'cs' was out of range and
> a non-negative integer otherwise, 0 if the cs is available and positive
> integer otherwise.
>=20
> So, what I'm doing here is fixing this by returning an appropriate error
> condition or 0 if the CS is available.
>=20
> If we change it to return a boolean, we won't be able to distinguish
> between EBUSY and ENODEV.

that's the thing. IMO this should return 1 if it is available and 0 if
it's not. The method looks like a yes/no question:

Q: Is this GPMC CS reserved ?
A: Yes (1)

or

A: No (0)

then it's als far easier to use, just as code was before:

if (gpmc_cs_reserved(cs)) {
	dev_dbg(dev, "Oops, CS #%d is busy\n", cs);
	return -EBUSY;
} else {
	dev_dbg(dev, "Hurray!\n");
	return 0;
}

--=20
balbi

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFrgUAAoJEIaOsuA1yqREst0P/0CkCAFZmiOErk4U2CY77fEg
Vm7agtj1ORr8UG3+WNOD9NZakQbQk3Y6WNuGezECVTWbBTvHnR/c94LIsA25gZpk
oRK2Xc/SjYRwBglmCqAvJ2Msf2vggfg3BtC+6cZcRcT0nMTqRIF+qKF3i6psQelP
3d7i7JPj3SRdj5oVcWS0pIXtU4BOMSvV+bQslIh3JulmHMt6fdKh4rlp/R6c9BaZ
ikztwTAbjEnARrRmrd9GxcNWaynzL5CDrvqQS6T9Dbbb/EktF3rNB1mU1vPxg0ol
mmtb60K7BsK+Fpu4Vkz7aOU/DN0DULz+ROrXejkKJrDcUYOh7owN+l7y0hcV14Fi
/UiqCCwYqJ8hmwnUb9FmDnttDL7ueMeSPxAGgOdWy1IkhMaAN3n72c6WtgVmB0ec
sjg4RypAIMFQKp6piCvyzGK81XYsB1oSgTklIym43Y1omd26iw6nR8MGfjS+ieL8
dDKT1yekru16ijsuxAgpcY6tWR/14N3BTeDd4VifyKPJLSTKiLZgvsgfWNGna/H2
gcvukNZl3+Bev6/QEHQN2DfHIi6Nnbphm4HICFsO7UC6IsBZnhejER7zYptubc/n
Ql7H8LQLWwBnbdBQaMf8XrFWRew8qYJdIKlXooSLRRGkh+KrYt6R3aQ57i7XawYI
yOs5zByU1uiim6ruScWS
=gAUk
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
