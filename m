From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] fbdev: kill fb_rotate
Date: Fri, 26 Feb 2016 13:30:54 +0200
Message-ID: <56D0376E.6070908@ti.com>
References: <87d1swdk90.fsf@rasmusvillemoes.dk>
 <1455044172-17488-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="e1gXMQ1LL3xrJ0oLvqTwqDvDIW5jAa6cU"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455044172-17488-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--e1gXMQ1LL3xrJ0oLvqTwqDvDIW5jAa6cU
Content-Type: multipart/mixed; boundary="gNB6FiBEu7MO4fXiRhCuWTLoabHaBpCqS"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Message-ID: <56D0376E.6070908@ti.com>
Subject: Re: [PATCH] fbdev: kill fb_rotate
References: <87d1swdk90.fsf@rasmusvillemoes.dk>
 <1455044172-17488-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1455044172-17488-1-git-send-email-linux@rasmusvillemoes.dk>

--gNB6FiBEu7MO4fXiRhCuWTLoabHaBpCqS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/02/16 20:56, Rasmus Villemoes wrote:
> The fb_rotate method in struct fb_ops is never actually invoked, and
> it's been that way in the entire history of git (in fact, the last
> occurrence of the string '->fb_rotate' vanished over 10 years ago,
> with b4d8aea6d6, and that merely tested whether the callback
> existed). So remove some dead code and make struct fb_obs a little
> smaller.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/video/fbdev/atafb.c            |  3 ---
>  drivers/video/fbdev/au1100fb.c         | 22 ----------------------
>  drivers/video/fbdev/bf537-lq035.c      | 23 -----------------------
>  drivers/video/fbdev/omap/omapfb_main.c | 22 ----------------------
>  drivers/video/fbdev/skeletonfb.c       | 17 -----------------
>  include/linux/fb.h                     |  3 ---
>  6 files changed, 90 deletions(-)

Thanks, queued for 4.6.

 Tomi


--gNB6FiBEu7MO4fXiRhCuWTLoabHaBpCqS--

--e1gXMQ1LL3xrJ0oLvqTwqDvDIW5jAa6cU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0DduAAoJEPo9qoy8lh71SfgP/3Izpuhl9VtscXOmkl6nSaYP
la/a1VFNAUFjePiSXmRG4FqaBUQbHB2ogxN9+89s/RWKM8GkjwDvZKdMgNVq93aB
1nzJLv8Y06bjdvkRmO/Tobejmy68QuwM3lOLEfMhkVEQ3I0ZxZQtkOQ6/Oil/aVS
vSAwaLzSyyueH6YXt3ss45QBatHB+7mHiPovLsDUJHtZG1S15M9IXf1X9Ok8WvyM
4+44+O9XERietSF/Lk1Dxnh1jGPWgjQ5zoh5rSv9SWCHAQUL3QfSAzJGM7HMmp36
XZUxKkRwzxZdoJ7y6nznRq8eu1NFHmLF6uOp73YqkE38MPCD9+/muEPKznFh/1NS
aeXlraEY/FlyOaRuhqwT8dfVAw6TG1g/efdoltVplDCA6yi3jlH/KZ8rNQJAFdiD
gk9bGNeBeZ/Zr9AfX0oVOVZeITa2aS6sFKsQevq0+c1NUwXGEy97+ONOROQ4C/O/
xClVw2mcNCmPKiaQYDwL8QjxZXEX8BcrdViK755S+sd9B7T4Lh4wjmtaogt4vbCy
CsSP3ZE/JjICOQJxJ7yGIyY4uYE/GC7p1D8u/k+e12EtkiknFdjk58Ii26pwJwOy
Vrsukibu71EdaS51WtzB1mxgqqnulsXWewNAMMYjfsjN0vz0GkCC796YD7WfOceX
nWatTL8EqiAF6q5LXddd
=+Xt6
-----END PGP SIGNATURE-----

--e1gXMQ1LL3xrJ0oLvqTwqDvDIW5jAa6cU--
