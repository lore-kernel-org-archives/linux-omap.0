From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC 0/5] i2c: omap: new fixes 2
Date: Tue, 13 Jan 2015 11:04:42 +0100
Message-ID: <20150113100442.GE1059@katana>
References: <1417617242-16869-1-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417617242-16869-1-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2014 at 06:33:57PM +0400, Alexander Kochetkov wrote:
> This pacth series intended for fixing problem reported
> by Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> here[1]
>=20
> One of first four patched could fix the problem.
> Last patch provide event trace so I could resolve problem.
> It could be applied using 'git am' or 'patch -p1 ...'
>=20
> Patches are rebased on branch 'i2c/for-next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
> (6e79807443cba7397cd855ed29d6faba51d4c893)
>=20
> Tony, could you check, does the series fix the problem reported[1]?
> If yes, could you bisect and point commit that solve.
> If no, could you provide trace output (with or without the patches
> from series).
> If no, could you check does i2c-omap.c from commit ca1f8da9ac5ce6e63d8f69=
33f83fabc1f3f961f4.
> (the commit before my changes to kernel) work for you?
>=20
> Thank you.
>=20
> Regards,
> Alexander.

Thanks for working hard on this driver. I'll mark these patches as RFC,
since they did not get any additional tags from other people. If they
are intended for upstream, please resend a rebased version.

   Wolfram


--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtO25AAoJEBQN5MwUoCm2WTIP/3yeDfwW+YPU5jX22S2voNSr
zUvokzfqpB0PpphFc5MB8Xw3T/+Q9pkKLKPPT9UtaMUDWVVev8mZQGU1aZxzzcPY
Gg8518XkM3beD3msc62VAB/wveDctN5UnI0/mXm8i+M5M/wqlJGKvWL9RLow6N5E
Oovnm72jEImSg6vJPog2wDFh0NETjgym6U1pl6kyoBmS6jWqzmw72CM8Djjs7nJL
8J9XpFqdlSAdX8KdslBAzoAojPfrNK1mPEJkdHocywb6U7eNJEroOZpgK5yhAQ8l
SjKA3QchtdCUhqaWHXVvs1Bv9QJxCBC5UmHWEOFIfKz4/WNE0QudlhSKEZnFSLQa
2v+z5o/io+enDGGo4NfPJca3bVKWo0ClyK9M2wBEO9IF2xwXsW1cTQjdpCbC0Fq8
LDkZ7G9OSZMfdtw9CZ56/nOxKf83wUYUYX3/pKN3kk6+pFdQaW53HEa+jmseWDsA
KijQeCbIgwCvygaSTMa0DR+ltqCe5qU73vNsHnvk8wxplXptvnFoJtGJTp1nI0Q6
7wYL7iImfYnu1klUR1DRYYtrQbOtL9CEGSUKHmop2uwRNkUQ67iuVcrF20W4o7tW
8A5KPV7a6V148QvUaO98CvV7QFAyRIENJIW7lnNY3NQtEpbdYpOEh9IMAIfGUu5P
nz2hPgT2sFJYDvBzCvw0
=ar5K
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
