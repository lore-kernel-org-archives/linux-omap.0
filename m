From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] omap3-n900: enable autofocus
Date: Mon, 13 Nov 2017 11:29:40 +0100
Message-ID: <20171113102940.GC31566@amd>
References: <20171112112528.GA21009@amd>
 <20171112142918.rqxd2uk7ljyhpctt@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171112142918.rqxd2uk7ljyhpctt@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2017-11-12 15:29:18, Sebastian Reichel wrote:
> Hi,
>=20
> On Sun, Nov 12, 2017 at 12:25:29PM +0100, Pavel Machek wrote:
> >=20
> > Connect auto-focus coil to the camera sensor, so that it can be used
> > by camera applications.
> >=20
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> I think you should replace auto-focus with lens-focus. This is not
> automatic. Otherwise:

You are right... althrough the lens is really meant for auto-focus.

Anyway, I can send the updated patch if neccessary.

Best regards,
								Pavel=20
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloJdBQACgkQMOfwapXb+vIAYgCgtcOHbVBj6y6ZVlM13ZpX2b4r
hCEAoMFW11Vo7sAAwqjEZXNfRd5OunlR
=samv
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
