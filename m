From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: tipwmss: enable on TI DRA7x and AM437x
Date: Mon, 5 Oct 2015 17:20:38 +0200
Message-ID: <20151005152038.GB17612@ulmo>
References: <637af4e1754204dd81677a1290517202eec7f011.1441725097.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <637af4e1754204dd81677a1290517202eec7f011.1441725097.git.nsekhar@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: linux-pwm@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2015 at 08:44:05PM +0530, Sekhar Nori wrote:
> From: Vignesh R <vigneshr@ti.com>
>=20
> TIPWMSS is present on TI's DRA7x and
> AM437x SoCs. Enable its usage.
>=20
> Instead of adding each SoC individually,
> use the more generic ARCH_OMAP2PLUS
> instead.
>=20
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/pwm/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks. In the future, try to make use of the 78 columns. There
is no need to make lines as short as you did.

Thierry

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEpVGAAoJEN0jrNd/PrOhzQYP/3/JkuZD1tX8QUR8Ca0QVMDt
kYWMp6xKJJu5l+9eZzxqMty4aTInEX2xTKMOylNY+CfzIclzV/MkhuP29B0OBbx7
hBsYkicSsOhfTWuRUIIRZAdi0JldZTqWk2qg2anKMF/1QR0S5qwcIdBWET+EGlZm
PsH6ekLV/PsP77WQG0CNjRVqF4CPmLF6xHBLVJ85RWtq/Ja+ACKmfUPQNhL3xvCO
eIEJNAfOBSHmR4fF90I5mTDyibZMaqi7e+U3X4IWpBVjKIdjIFSZs94SXYuosnPs
VbxdIkBVoX+KMT1Mq9xLniUCQCOG04CESUpe1lsT6eIe45fSKGr1+SL77gOdnTyU
Zfsx0ALbrzmjOUCqw7K4qSORuwB+9sZhhr8yGPy03czFul9DAMJ4JiS5jtiyZuW7
FTK5Owfm/y/S/G5Jf5do8Ub07wFzOVv3xdGjPWroWmqzc6QtTQLuwtDSTN8pjHhA
z+7/7Z5PLgIiwFXXHgqDUValouR7QwFr8/PdrSwOWYmicPUTumLNvvIfEgqpcLK1
wIHustMysvtHay4Emxfez2FBzix0JWeeaBbGcwTbVQRZF2KtttewwqfHpXSOiy6V
Kq6o85M9OncvPzUcqAPDPN9+HfQ5X5GvZtOsyquMxL9fluQ1jC1xmvf1ngt4s56R
szy03qX7khMnYrvIimAd
=mw1j
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
