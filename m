From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] phy: Group vendor specific phy drivers
Date: Fri, 1 Apr 2016 13:42:19 +0200
Message-ID: <20160401114219.GG4227@lukather>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>
Cc: vireshk@kernel.org, shiraz.linux.kernel@gmail.com, kishon@ti.com, heiko@sntech.de, wens@csie.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, cpgs@samsung.com
List-Id: linux-omap@vger.kernel.org


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 01, 2016 at 04:59:15PM +0530, Vivek Gautam wrote:
>  create mode 100644 drivers/phy/sunxi/Kconfig
>  create mode 100644 drivers/phy/sunxi/Makefile
>  rename drivers/phy/{ =3D> sunxi}/phy-sun4i-usb.c (100%)
>  rename drivers/phy/{ =3D> sunxi}/phy-sun9i-usb.c (100%)

That would be allwinner in this case, sunxi is the SoC family
Allwinner produces.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/l6bAAoJEBx+YmzsjxAgqhoP/AuPseyVl/IzPyOcqjAnnYZW
C321M8Tqynwpf3Jmoo8qaZ7D/tQ2wHkh11+PXE5n5Bbx1IcYy+JUsOE+JPW/I/JD
VOmi8vnZRRhZl8jv2pn5gW+97QcNSi919W8zrefXwqrYpsNDBi+H4+BmWnHJL6gr
tmBjwpX500GhZRx4IVrMXnrZNfiq328dF83lAN+7+pMCD9F2+LLm8ad+QAw1nQBt
0h2q50gWZenxWdqu/RERAl8+zRLeuYP8AO71iAhXsLYrjSyQnmXGF9GgCEFFqck7
M2ysxwJB29XqV8/jiv3EiqQpophWdEct7Cts//yW/cJgsfXQHzm+A2C7eWuXxEzb
pH0vSf7aubND0ZByBo7R8YPawL3uXtd8xn+ZX+hrsTpLKaK5cMaF+T+HnLj1C0ea
7Q3bUQEPbfdBqTJy4i9Dg3RYITl5RR/vThg0PZ4k6Kz6SUR9pl+WtjrGHhUOLNCi
oDdQGEUVApr9ZeyR8EggZFFk9sTfIchPgqgsJNypRLdaZwYwQHokYqAFGC/RPt9V
BbJwqGGcju5qVHqg5slwec8JGnjHaut45OyDSiga7qec6gMXkWq7lbY3Jz9aHgdI
j8zf/5SsbuLSuAukSVcmttWkwcDli8r0WtvKnUldTF/dktsynGmUiiMeqtVWHPAY
P68RkBIdt5yigY+rYlEm
=bi7k
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
