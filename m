From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2] drivers: spi: Add qspi flash controller
Date: Tue, 2 Jul 2013 12:44:04 +0300
Message-ID: <20130702094404.GL3352@arwen.pp.htv.fi>
References: <1372755399-21769-1-git-send-email-sourav.poddar@ti.com>
 <20130702093247.GY27646@sirena.org.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UeXZ3FjlYZvuln/G"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130702093247.GY27646@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Sourav Poddar <sourav.poddar@ti.com>, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, balbi@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--UeXZ3FjlYZvuln/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 02, 2013 at 10:32:47AM +0100, Mark Brown wrote:
> On Tue, Jul 02, 2013 at 02:26:39PM +0530, Sourav Poddar wrote:
>=20
> > 1. Placed pm specific calls in prepare/unprepare apis.
> > 2. Put a mask to support upto 32 bits word length.
>=20
> Does this hardware really support anything other than 8 bits per word?
> There is no code in the driver which pays any attention to the word
> size...

the HW has a 128-bit shift register ;-) but driver doesn't look
complete.

--=20
balbi

--UeXZ3FjlYZvuln/G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR0qDkAAoJEIaOsuA1yqRELPMP/ibCAUoD9mPj+FpjcWSbW3yf
l8e7S9SniOka9cPbzRM+yJLLpYUJ52Ohs1S+SKG2RBVcSgv99ESncUcdk7m2jsbe
dQgLYamCPbIdUQoUFY2lugM59jF43rAfCRgo/UUIoW9A/sHGrfkevWZictWJQGM8
KjsIQLVZKbcb7L5fn+Sm8qaNkJuMzuEz387Sh2C0Z0wofo00xGxjWJUU0Uoi8AUz
tdHxjDiweHt2cPLvFQExtrjYndx8xnGQ8HmqCwwnA52kdBmCrX+QNcQYKAkJ8kAN
4aocYH9jjI40oCkMDVR0SKIb7AhsIMvacOeWyvmdDWTjO7TZnU+1f9pdDIyRN3uM
dljS/wT7NC+/TKwy2mNte1zFpnp7d1jXhPTfSNzfAaekbG6HXiZfsTAWJ0ni/h23
b0iedt1RXBxkjTpUlWkb47J1X9WsnLh4fFEAcde2O3PZOZ/nxQSqqULQG9CrdhR3
SzPLEdLe8PcVIfuNYDu50Btd7b5H9a7ufgDwR+2y2JNLkDdiCsmJK+qo4KAXa+2Y
/seEpURox2bMCQbqUeAgMzbLH7HZF5u92mIQ7UyXthouZXNOMQRF/JkTH9LSOk+Q
g/JQs0QM+z0fWNHJA0trjpH0xkKpt5TEvsnXLRgfG0z9dfOpT1e+Bm7zlE4/iq7K
scPrhQX/HpID6lnONLSr
=Q7MU
-----END PGP SIGNATURE-----

--UeXZ3FjlYZvuln/G--
