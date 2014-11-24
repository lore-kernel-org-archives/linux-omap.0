From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 2/4] i2c: omap: implement workaround for handling
 invalid BB-bit values
Date: Mon, 24 Nov 2014 13:10:23 -0600
Message-ID: <20141124191023.GG25712@saruman>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
 <1416685634-5864-1-git-send-email-al.kochet@gmail.com>
 <1416685634-5864-3-git-send-email-al.kochet@gmail.com>
 <CAMAWPa8whctBR6fBFaSzPvm3qn+QK06CimRrxFxxH=0kNkF4UA@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMAWPa8whctBR6fBFaSzPvm3qn+QK06CimRrxFxxH=0kNkF4UA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2014 at 11:08:48AM -0800, Kevin Hilman wrote:
> On Sat, Nov 22, 2014 at 11:47 AM, Alexander Kochetkov
> <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > In a multimaster environment, after IP software reset, BB-bit value doe=
sn't
> > correspond to the current bus state. It may happen what BB-bit will be =
0,
> > while the bus is busy due to another I2C master activity.
> >
> > Any transfer started when BB=3D0 and bus is busy wouldn't be completed =
by IP
> > and results in controller timeout. More over, in some cases IP could
> > interrupt another master's transfer and corrupt data on wire.
> >
> > The commit implement method allowing to prevent IP from entering into
> > "controller timeout" state and from "data corruption" state.
> >
> > The one drawback is the need to wait for 10ms before the first transfer.
> >
> > Tested on Beagleboard XM C.
> > Tested on BBB and AM437x Starter Kit by Felipe Balbi.
> >
> > Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>=20
> This patch recently hit linux-next (as commit 903c3859f77f) and boot
> breakage[1] in next-20141124 on OMAP3530 Beagle and Overo/Tobi boards
> was bisected down to this commit.
>=20
> Kevin
>=20
> [1] http://status.armcloud.us/boot/?next-20141124&omap

btw, based on Kevin's boot test, only OMAP3530 is failing.

--=20
balbi

--bO4vSxwwZtUjUWHo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUc4KeAAoJEIaOsuA1yqRECs0P/j0/YbGcdhL8RQSJlX3WaQWW
BiTrZhDA0dS27z14x7dnyO0xdl1B2gxUAfDl3gATWq2ILP206Thn4tbO5l3VJ0Hv
LfO2MLKmd+zWuaFAo4pCFg4makM5MEDw0ctFDeg4b44hH5hVebGcV/pUf9wS5K/v
75Fd02xKKtNacuAr7J+JprQvbvUZ0K54gWco/VeDN0sbE4Gcq3a2opV1mooPOcWK
k/qZZ9aDtSsUT9sT97h5c8tDCVp0/PxUZirzkRCq9M5dV2mkj0hQZM9wBSbemCJ5
33YqEiz6oKSOpxcsMd2XuLbjsum/r5ciraCzjlPKkSqVIxAP4NNXzU7U5iScuxI5
fVtfomz1SkTgAkeRsGF7AW6fmhpDt9aEcvjJPLSYx200nSn6QcE095M8BMY2yizF
GdZlA088FjMWWyMbgeko8PvjJJI4WTzQyKGpxkoqufIIxWicdKz4kQn/k1JK0Nsb
9NcbAZZpWQ1jfkl45pPAJFqrfRhNZNnHaXahNB+9tPML7V8JMKoSC9DBbc9wPGRv
shS9LJ6gnbKXA09T58pALPKohmxB1SiI4ijE8NhogiXzfM/rjoiwqvNxgXuvOV1l
QnSDG1oppYCziUjKI19BfPHUddLQjGCZLNNNwuo1j2gv0HuXlAm4c8Pi7OGsD8Jm
MUM3miJZZZXeAPqAwsAN
=UY+Q
-----END PGP SIGNATURE-----

--bO4vSxwwZtUjUWHo--
