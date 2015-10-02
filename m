From: Felipe Balbi <balbi@ti.com>
Subject: Re: Queueing b0a688ddcc50 "usb: musb: cppi41: allow it to work
 again" for -stable
Date: Fri, 2 Oct 2015 11:09:02 -0500
Message-ID: <20151002160902.GF5552@saruman.tx.rr.com>
References: <CAAEAJfC7z=dvw_5vgXDBWVQdKA5jDpfECYv4Jy67YaT7219uJA@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAEAJfC7z=dvw_5vgXDBWVQdKA5jDpfECYv4Jy67YaT7219uJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2015 at 02:23:45AM -0300, Ezequiel Garcia wrote:
> Hello,
>=20
> Commit b0a688ddcc50 "usb: musb: cppi41: allow it to work again" seems
> to fix a regression. It applies cleanly on v4.1 and removes the
> "musb-hdrc musb-hdrc.1.auto: Need DT for the DMA engine." error.
>=20
> Any chance you can queue it for -stable?

Have a look at Documentation/stable_kernel_rules.txt, you can do a proper
request for Greg and he will make sure it gets there.

--=20
balbi

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWDqweAAoJEIaOsuA1yqREW1wP/jXv3mLIfiN1KXkHQUM6/tSi
HaItNhlnNZn0JxUJuYQQGmAHX2NLiH142uyZOJgW9Td5NH+iFdrowpM0KK/hJfTW
yIM3oYtulhQtlIrY+V+w7xROFdA+McjMtejYn8jTN+a/9tpJlGi/XoQKCh7oTYVt
Fnzjt4siHc6A08Yc9aH527AZw6oWMIdNneztEuvSCmiC07nNOVYHvQ7UB8sxp9v8
AKYsYrBeDLCTbCSGI3Q+PlCJF5yE2kYZlnCINMy69hiVaNwnYrZru+iYua0MG9G2
0Dh96Ledtb/41SwWr/CKwlNYh9yvS88y9rL2h5C7KvbUPqxadmsOmx14Hzwqzshw
se7mQHRW7JT/yXkTG0WPeTncyC1Vo+EasH7bHUYnqXBqy84/XjpiLUxra/mefN/a
sKXFGUZ5JODeXljjg4/+yg4NKh+jzYluvA5M9BkmewuwC2egNbEcUxL6aHke8USz
cgCJo6zUU80/mDjvyUIf4QSwUeJDoeO6zEFp8s77Peh0Y1CTPcC+z4IDmVOgOW2y
cbDURnGAiXCmj7/822Nf53prGG/9Qumb9ukH3FvJVLYBR0PFkpKQV2+PfQ7NMnLo
UojcWuCjY+XXDHs3AIueiCtop/HIYm+0xavD4Qfw9HoF6apR1YKv03pXYfHYUx3U
btMl5/I+PF92vDYlIzXp
=s7so
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
