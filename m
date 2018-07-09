From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/2] pwm-tiehrpwm: fixes for disabling PWMs
Date: Mon, 9 Jul 2018 18:58:46 +0200
Message-ID: <20180709165846.GC26651@ulmo>
References: <20180611060956.27999-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180611060956.27999-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 11:39:54AM +0530, Vignesh R wrote:
> EHRPWM has two PWM outputs. Currently with pwm-tiehrpwm driver, if PWMA
> is enabled and then disabled, and then PWMB is enabled, it is seen that
> PWMA turns on automatically. This series fixes the bug.
>=20
> Vignesh R (2):
>   pwm: pwm-tiehrpwm: Don't use emulation mode bits to control PWM output
>   pwm: pwm-tiehrpwm: Fix disabling of output of PWMs
>=20
>  drivers/pwm/pwm-tiehrpwm.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Applied, thanks.

Thierry

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDlEYACgkQ3SOs138+
s6GPIxAAtvbBhGo4Kk614u3dQM6GF4zNASDL37o87buK0flh7zac0nvaVs0GV3De
P7BAj5Dir0zk03E4SwqWvM/Sg4ZVY/w/GP4oWWu7I9nWv6/KVmjg07fOhNuGZ3Cm
POnixN3GP80JBkD9HXK4uvtGAnaKGOZnWHyMfp+a9+oMDJdT7U3uocPAvFzpnrm3
QJjXOU8ETxLZzBU1Di/slXlcquzCyZmG0d2JFUco+sFy03FwQruSW4gy43CvscgI
1z7wSwBb3vEnPgzZi9ipFItDDhsntIPuWeaKdPuf5VEr+pOd/Yk6gIhJAqMaLyrD
W/jzSRortAb4qiZBT/SPYE73ST+z99Hy24LlSHe8B6u0gVzCM9nVKwGbWvlV2lHd
43eLelo3jlACFVVoIdrBUle5pWDoJKBqeYRFG339nKuTP3/WJkBsAx3qUmAM8vJ6
U9I+/UvACNXbo6g64udicy8oZNeHAAyqcRXRoNxjaWuwZKxbQtOh5j7Reom64ee0
+Ul4gEIGcKkXXlmVhHuiA6+Ced5ST76cGf5Bg6VpeZzZ8Wmc2spdTxuicSul5dn9
ctQM4fLbDDNdUCTkJh5zq7MDw/e+uVYfBXGApaQskzHI3Io+9QnAK7bTqkD8rEAz
hbkvsxroglzqbj5xa8XCS7w/QMxUYeIkvEZN5FVUOLUpIdXHbVM=
=ZWzG
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
