From: Sebastian Reichel <sre@kernel.org>
Subject: Re: latest version of bluetooth for n950?
Date: Tue, 11 Oct 2016 16:51:40 +0200
Message-ID: <20161011145140.cq3jex2r23wuayph@earth>
References: <20161011074704.GA21003@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3d5jxbhqns6dj2ek"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161011074704.GA21003@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--3d5jxbhqns6dj2ek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 11, 2016 at 09:47:04AM +0200, Pavel Machek wrote:
> Hi, Sebastian!
>=20
> I got some free cycles to play with n900 and bluetooth. There's still
> some unrelated config option that breaks even the old vesion of
> patches, but I'm ready for more debugging now.
>=20
> Could I have the latest version of the (clean) bluetooth patch? I have
> feeling it might work with the right config option, and would like to
> try.
>=20
> For the record, here's working .config and the tricky tricky oneliner
> that took me week to figure out.

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-n900.git/log/?h=3Dn9=
50-bluetooth

My local branch is based on 4.8 and fixes a few of Marcel's
comments. I'm currently at ELCE, but I will push my local
stuff later in the hotel after verifying, that it works as
expected (luckily I brought N950 with me :)).

The work I push will not yet be using Rob's (Herring) work
based on serio (I'm working on that). I think his patches
should go in first, so that we avoid introducing userspace
API, that we do not really want (hciattach).

-- Sebastian

--3d5jxbhqns6dj2ek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX/Px5AAoJENju1/PIO/qabpAP/RpoLEO+KdxGrhDsdFMVu3QV
r+Y9ZyPnly/mYYyEnRlw+Yaa1K7ya41iPodnpTLZZ/s2tfqFScgXsP93hhjHAKgC
Ha2FdO7Wc5wDFC4A7GKVb/1/qsk1yBTtzOEZsxaKz0eoeuL3Qa/R+lEAFYjvA9Em
RwTSgSPqM94QENDH7X0QjilCIYxguHUOp3QwKoBQEZVwfpPdOGerj5Ecx7R/8uhP
RqeSE4Nt7fe8HYo6zeqUEuLmQqv0dPjqiKPjyM8b0F5Q+d9kwkpGS0yTd0snIRqg
4hgN0nhNP3K8VK+SXvvKhFof73IvC07KfMzV/UL1oDrt//I3BIC0nnI9d5oIUZ6L
omL/zgiHzQKq5USndwfxi/Xn9c6lCZAvtXTfnK07RH0Z7aIKf5ekm0I8uMkAjn83
CGU0qCtraLnu6aiX8AWuH3yGmg6TViJtqa4JZoIm6wlZuvdbJ0S2s+fjCXT7uNXt
2G9TTEvDdHmThQdd2bcI4io7c5JEPXnnrpx4ipqO2X4SKy4cFsGF3aDdxBgo7zxf
Q9yHWYpbI87y6HYPtc1nwsJlcKWaLevcaLKacBN8Gt0H1oywrUa88D8d1CfkcPAy
m/r/VH+VjEZm5VpnqZPhxLeujbPMbDR9NmEYLd57xVEHNIK1da0IRNrHwOt1GcqK
Nsko/HAsI9M29fai4wly
=8mI4
-----END PGP SIGNATURE-----

--3d5jxbhqns6dj2ek--
