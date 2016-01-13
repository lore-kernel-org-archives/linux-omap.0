From: Sebastian Reichel <sre@kernel.org>
Subject: Re: /sys/class/power_supply/bq27200-0/capacity changed meaning
 between 4.1 and 4.4?
Date: Wed, 13 Jan 2016 11:26:13 +0100
Message-ID: <20160113102613.GA28729@earth>
References: <20160109230709.GA30551@amd> <5693BB75.70409@ti.com>
 <20160111214247.GA9735@amd> <56942344.9070609@ti.com>
 <56951A2C.9010602@ti.com> <20160112215352.GA5248@amd>
 <20160113084424.GC11560@pali>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2124331731260839941=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160113084424.GC11560@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, a.hajda@samsung.com, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============2124331731260839941==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2016 at 09:44:24AM +0100, Pali Roh=E1r wrote:
> On Tuesday 12 January 2016 22:53:52 Pavel Machek wrote:
> > Hi!
> >=20
> > > >>If not, tell me, and I can do it, but it will involve a lot of swar=
ing...
> > > >
> > > >I'll give it a look over.
> > >=20
> > > OK, I'm still looking for a test setup, but this was definitely a pro=
blem,
> > > could you give this a try?:
> >=20
> > Well, search no more. I tested it and seems to work ok. There's one
> > more blank line in the source, so I had to apply patch by hand.
> >=20
> > Tested-by: Pavel Machek <pavel@ucw.cz>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Reported-by: Pavel Machek <pavel@ucw.cz>
> > Cc: stable@vger.kernel.org
> >=20
> > ? :-).
> >=20
> > And... thanks!
> > 									Pavel
>=20
> There are more pending fixes for bq27xxx... Maybe your is duplicate?

No, it's not a duplicate.

> http://thread.gmane.org/gmane.linux.power-management.general/70090
> http://thread.gmane.org/gmane.linux.power-management.general/69716/focus=
=3D69714
> http://thread.gmane.org/gmane.linux.power-management.general/69716/focus=
=3D2110580
>=20
> Sebastian, please take them and ideally send to stable@ for backporting.

There is no need to send them to stable@, if they are properly
tagged with a 'Fixes: <sha1> ("title")' tag, so please always
include it in your commit messages, if possible :)

-- Sebastian

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWliZCAAoJENju1/PIO/qa1fgP/2eohITCznfWI3be98VGmPHk
nJxo+yTIVVLCqNJ9AzVoF2i48vVTUtmMYy/hUCf+Y4kUCc2AVxdW0y50SM0slpji
MwnsSpGBfImYApG3ovkUgcmH/ApXjbChHcWJ/ulOBb3DM3OoGu8OdO0G5V0wsYkL
FWbX96TZNkxFrnpjjDYrALOPF8F2KMybr1JmJv1bJ7Af2+OOlbaq3h7f+oycAHEy
1RQ2szHfdLVKRuj9EnemGKzAUGgcS6rWEJrxj84ZOK+f6eogJmwc4DL5UGRazrZt
sBOWjyFewr8E7aHqajuZljP42U8uCDvoUC7RGd3AV/7YLILxsHV50Wy4WFc8dzM6
5/kYIIeeCQ0THI74w0WTlBEMViEVxtANssImD02rP53Tr1wx2FMsG2udTn8hAZUe
FK7xzkq+4FANEBnQcl+MeVXFZ/360f7y1i3OtY3c0svhXKiFVg/gdpR+281W2TlO
Fxs4GSnP0LlL+QT9nZcAZ2egErxv8UhFFVu+KhRy+J4XiJ69Q3WP5lm0pK0x9MN4
mPNoiNkF2a3EP9TTpXPTWu6tW88YpKMQb9yuLurL3s/OHzXQK6Sz/LGi6p4RFBNE
u0euEOAbeqe8AlzyL0LLjObKv76fghyHeVnWcG+pPf6JiRbSgBDKDJw2KN1Css62
JACXweMh4m6ZGV1Nh650
=Ddpg
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--


--===============2124331731260839941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2124331731260839941==--
