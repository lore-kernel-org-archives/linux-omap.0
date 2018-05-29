From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.17-rc1: regressions on N900, N950
Date: Tue, 29 May 2018 22:45:17 +0200
Message-ID: <20180529204517.GA6765@amd>
References: <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd>
 <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
 <20180523140615.GA27180@amd>
 <20180523201208.GA31731@amd>
 <20180523220456.GY98604@atomide.com>
 <20180524094705.GA16705@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180524094705.GA16705@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, laurent.pinchart@ideasonboard.com, sebastian.reichel@collabora.co.uk
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
List-Id: linux-omap@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > still results in working touchscreen, removing any of the three fields
> > > breaks it again.
> >=20
> > I bisected one regression down, see "omapdrm regression in v4.17-rc ser=
ies"
> > not sure if it covers all the issues being discussed here though.
>=20
> Reverting 24aac6011f70 fixes screen on n900 in v4.17-rc for me. (But
> strange dependency on tsc2005@0 is still there).

Laurent, your patch looks pretty obvious, but unfortunately breaks
display on Nokia N900.

The patch is pretty big as is, perhaps you have version split to sdi
=3D> *sdi and then static =3D> dynamic allocation?

Thanks,
								Pavel

commit 24aac6011f704d69b5f34514923413f85669f282
Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Tue Feb 13 14:00:47 2018 +0200

    drm: omapdrm: sdi: Allocate the sdi private data structure
    dynamically

    The sdi private data structure is currently stored as a global
        variable. While no platform with multiple SDI encoders
        currently exists
	    nor is planned, this doesn't comply with the kernel device
        model and
	    should thus be fixed.
   =20


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsNu90ACgkQMOfwapXb+vL0LwCgsJGrRsTD6Pg7Yc6Xzu9dL0Ry
KIIAoMFfIOLGvB8Gq+XC8w0ly8rFbRe+
=x9u2
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
