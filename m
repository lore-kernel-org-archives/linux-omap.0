From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: omap: improve duty cycle on SCL
Date: Wed, 17 Jun 2015 13:04:20 -0500
Message-ID: <20150617180420.GG18421@saruman.tx.rr.com>
References: <1434482445-1818-1-git-send-email-balbi@ti.com>
 <55813BA0.3010001@nokia.com>
 <20150617180052.GF18421@saruman.tx.rr.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150617180052.GF18421-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2015 at 01:00:52PM -0500, Felipe Balbi wrote:
> Hi,
>=20
> On Wed, Jun 17, 2015 at 11:19:28AM +0200, Alexander Sverdlin wrote:
> > > With this patch we try to be as close to 50%
> > > duty cycle as possible. The reason for this
> > > is that some devices present an erratic behavior
> > > with certain duty cycles.
> > >=20
> > > One such example is TPS65218 PMIC which fails
> > > to change voltages when running @ 400kHz and
> > > duty cycle is lower than 34%.
> > >=20
> > > The idea of the patch is simple:
> > >=20
> > > calculate desired scl_period from requested scl
> > > and use 50% for tLow and 50% for tHigh.
> > >=20
> > > tLow is calculated with a DIV_ROUND_UP() to make
> > > sure it's slightly higher than tHigh and to make
> > > sure that we end up within I2C specifications.
> > >=20
> > > Kudos to Nishanth Menon and Dave Gerlach for helping
> > > debugging the TPS65218 problem found on AM437x SK.
> > >=20
> > > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> >=20
> > NAK.
> > This is a direct violation of PHILIPS I2C-bus Specification v.2.1,
> > section 15.
> > Namely, you will have LOW period of SCL clock shorter than required
> > 1.3uS.
>=20
> how is this out of spec ?
>=20
> http://i.imgur.com/jEDlZT7.png
>=20
> -Width =3D 1.4us, frequency 373.1kHz, duty cycle of 47.76%
>=20
> In any case, I have to send v2 anyway (found a bug which would show up
> on frequencies above 400kHz), so I'll resend this patch.

Also, let's assume we can generate exactly 400kHz with the same duty
cycle. 400kHz has a period of 2500ns, so:

2500 * (1 - 0.4773) =3D 1306us

How is that out of spec ?

--=20
balbi

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgbakAAoJEIaOsuA1yqREu0UP/Rf+Ne/Q6klgrpxGD41mxatX
fGjh/gXDCIfUGQOfAnAjUwVte74EhwBH3MlcVmkbNgX7jYbOC/c4G3TcdYFeuXN1
kNsR8vRLFGNv9t/h35Jza7lzXmEXe/E22maj1+U7viwT4GUwb+KYWSSfJMpVzMAr
zlbkDclbdDtMV3v9ptU+ZNrFnehU/7JHwB2yKDRbWay2Dq3MdgGVutSJltbx9MPU
RxPV9Ben73Jjjy/f3/HOGMbUpFMe2zPv0of00lJGETRkzWCVZmzoYkBV+UBymBlI
BGxF0m/QczaTSXPiGfhdH80oB5iphN0clf3CRtQKAMbitfJoWER/I74dirJ3vO15
tYOuNz5rbHsIx8XwsRc9XrDhxDvm7swusnKxK1+A5y4SpXfNnmNyp3wqVTYy0FwX
/QU3ORUa6jVdzoBhE5xIwh69x7hBzIlp2OhYQMwY6dNwYU3CB8JFZLr8Adr088ez
2wfrgKfuiWt+oKWumzGQzdO5aJmPB275mJN7bMzDpUm1O/kwjO+NKGROj1AJGwgf
vurvt+Rs6B1eV/RnCX2SEU/o/M8q21ZmNvOKNzWrN6bE/uZ7fPnVUzzqvc4uNRTE
0/3X5eNK66x+X+0UWkoUDFspJdqj7rZJlE7U+E2m15GJKx7ff4pSHCnDXpnaF9bG
D5l60U+0c8owqSydwXHX
=qt/X
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
