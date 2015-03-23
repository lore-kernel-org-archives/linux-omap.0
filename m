From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv2] thermal: add omap3 support
Date: Mon, 23 Mar 2015 13:55:12 -0400
Message-ID: <20150323175508.GA28302@developer>
References: <20150103111146.GB7065@amd>
 <20150118202824.GB29014@amd>
 <20150323143149.GA18339@developer.hsd1.ca.comcast.net>
 <20150323155830.GB13297@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150323155830.GB13297@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com
List-Id: linux-omap@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2015 at 04:58:30PM +0100, Pavel Machek wrote:
> On Mon 2015-03-23 10:31:51, Eduardo Valentin wrote:
> > On Sun, Jan 18, 2015 at 09:28:24PM +0100, Pavel Machek wrote:
> > >=20
> > > Add support for omap3430 sensor. Tested on Nokia N900.
> > >=20
> > > Fix help text to be closer to english.
> > >=20
> > > Ifdefs in ti-bandgap.h are not neccessary, as users have #ifdefs,
> > > already.
> > >=20
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > You need to update the driver device tree binding documentation. Please
> > include an example of its usage there.
> >=20
> > Also, a separate patch with the required DT changes is always
> > welcome.
>=20
> I can do it, but can you merge:
>=20
> Date: Sun, 18 Jan 2015 21:24:47 +0100
> From: Pavel Machek <pavel@ucw.cz>
> Subject: [PATCHv2] ti-soc-thermal: request temperature periodically if
> hw can't do that itself
>=20
>=20
> Date: Sun, 18 Jan 2015 21:20:51 +0100
> From: Pavel Machek <pavel@ucw.cz>
> Subject: [PATCHv2] ti-soc-thermal: implement eocz bit to make driver
> useful on omap3
>=20
> Date: Sun, 18 Jan 2015 21:17:10 +0100
> From: Pavel Machek <pavel@ucw.cz>
> Subject: [PATCHv2] cleanup ti-soc-thermal
>=20
> First? They are nicely split, as you requested, and I already have too
> many patches in flight.
>=20
> Thanks for the comments, I'll fix them in my local tree.
> 								Pavel

Somehow I really thought I already sent those above. I really apologize
for the inconvenience. It seams like they've fallen into the cracks.


I will check those and apply accordingly.

>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVEFNwAAoJEMLUO4d9pOJWmDsH/2dlkDuo4lNVubAQjoFO+iyh
DyV9o0o121ulZf58XIrzshE7vCbhDytJNdueLM89IOvghHJVMZJVbSGV2IB2WLBn
0e9POltV8PfOr+R6bhpiYea6YfhusQhr4zephm4Z9jo+EG6/HLYT06ZlUgrFyoou
czSb12Eg4dGoim1jg3NFxnabVYZjC45VC53l7IMpcOYBoYfpFE8eg9uwh/OYFPZ7
PAzzgDTv46gF7W2bYfi4DQy1JqTv5GQ/L1SLKbB5BST78IpBIVcdc0vG+3GlaIKg
JRDHC4/VWIV6h5zeI0nIH/lSQpHUq2OtjvsYBzebc9mj+UCB2y9+gUvfsnR8+Rg=
=fm3X
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
