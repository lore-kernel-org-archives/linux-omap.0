From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 42/42] drivers: gpio: use devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 12:38:52 +0100
Message-ID: <20190312113852.GH31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-42-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552330521-4276-42-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:55:21PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-zynq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Subject prefix doesn't seem to match for this driver.

Thierry

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHmkwACgkQ3SOs138+
s6Gx6xAAv1mQgIEYsiEOG3auFjK4NyqWTcTVKmRK/0r5f71zWRytjqe4lKn75wI+
5PytZXa7xc67Qx6cVyqtLsdTBQ0kyShxwlRX4weQpR98ogYazQeEa+uzpDI8ywLa
xrNmbePWN8RvJPtnksoHn36mNLIRHx5GB7ZdpnM5SpXufT0EH0+jZ5qJcZLmFrVr
ctvRo3YzlLFsnaETSUOzP3uEEUZoa1cP18ul+36Xl+YBDUGpiXBVgyYvVGj8ZICw
iq+/HA/MvPMTytFk81aEDMIH+K8mSP5uIXHsLFc/9hB8kb1vT3M70pt3yTdUdIJ6
cuPcmSNtuLEe6lQm2UnBS7zUNblU5WVR7jz5bqAXDD2hI78PgXP9mZeT4jJyIV+e
JS4juLof2V2V717jwL1iaJjgsrgetKAzfWV9EovIHiMVTCBQlALrl9hwi3rA/LL4
0h5Zre1NaZ5OHFy/lM48NCcamK83rfFtfrzT8E1znKgN/AUvOyDbPKuA8gRrt+et
NQrxijZW3aHPwtnFy4NYRtltYyI7XYNt7rIOSPFtFT40T6CcQRdJlETsFXYutVU/
FLEyWQYPGSt+KzlPXWb1julgTWuA8n6/n6AgldDEL/wdV8f2SoBLmUtGjJ7NQ547
B796Pe8juq+0bpjOWveScK46skLniGOrAyjltkR8PTotXq77kzo=
=GdEd
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
