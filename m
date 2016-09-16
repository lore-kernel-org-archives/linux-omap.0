From: Sebastian Reichel <sre@kernel.org>
Subject: Re: v4.8-rc: GSM audio causes trouble
Date: Fri, 16 Sep 2016 07:52:50 +0200
Message-ID: <20160916055249.h7zw6hguvwwe2zwu@earth>
References: <20160915121755.GA5264@amd>
 <20160915205142.GA6747@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a3erb4upxm6b6rbc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160915205142.GA6747@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--a3erb4upxm6b6rbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 15, 2016 at 10:51:42PM +0200, Pavel Machek wrote:
> > I was trying to improve GSM call quality, and hit problems in
> > v4.8-rc. Sound only worked for a while, then I tried to kill
> > cmtspeech_ofono_test, and could not, not even with -9 and could not
> > even reboot.
> >=20
> > I went back to v4.1 (ok, quite far, I see), and problems are gone.
> >=20
> > Does it work for you? Any ideas what to try... besides bisect?
>=20
> v4.7 is okay.
>=20
> v4.8 with
>=20
> git diff ..mini-v4.7 drivers/hsi/ | git apply
>=20
> Seems to work ok.
>=20
> Best regards,

hsi changes from 4.7 to 4.8 are basically runtime PM enablement.
Does 4.8 work for you with just 9c99e5e51988 reverted?

-- Sebastian

--a3erb4upxm6b6rbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX24ioAAoJENju1/PIO/qaBagQAJpa2UsvX/tNfatdpR1epCAA
7lIHVVw5dai4TbMjqEOiu2QULkziN6Sn0+NbEwOaOo3DHucZaHq4qx6nIZVZuZIy
YWj9EDMMVXbKXkx/rL0jZMNTofT05aQSCToRL9j26ysRjzQbD7/AXjJDcwIriJUo
+W5AC9MvT4zRW1QoLOAG5cisYxbULolZWUrhSOtCqYcjKUVb9lNJ0zlhk3QP98LP
vDAFcgj4Nmq0mDJQ821JPqbMIujGs6y1aZ+oEI5itxInVtBhMstk/bY6od7IaGxg
yhzrfYHORGf/NlEy59EYNvYY82iN4TIG+cxmc4lXFJQ8R2GcmA+O9hskHbs8Nc/Y
CxNahVqlTINE/GOFDou/P5i33pxt6VEaRVhzfWutgd7JxwxqMeWPlAVoVB4WZC1N
ay+IDqKX4y2ADbbQ7FOQKIBOhRux9Kz1ggmaezB00JzW3zTzSSZ7RanBU6RY/42U
0Nu2j8abkVHKA3nb97tI5ntrFnGQrnbGhxHtGpCczH1vpMSYDbPX1iWNQvJZO+xo
4MQsD7U+18QVzjtH9W3ANQG2OsFXfgmG8xvLuBSjyFiQfJDWU9W6fqKIm9MQ1yfL
AdlHQuMftA5O+oNPb3ecPO74AMLCzFLsHGrK/Fij8YO9dnpTFbGCYv7YvotGR4KC
gcmzPoUnbgWTZ3s6one9
=Se/l
-----END PGP SIGNATURE-----

--a3erb4upxm6b6rbc--
