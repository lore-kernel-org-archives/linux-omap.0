From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 16/42] drivers: gpio: janz-ttl: drop unneccessary temp
 variable dev
Date: Tue, 12 Mar 2019 12:26:07 +0100
Message-ID: <20190312112607.GD31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-16-git-send-email-info@metux.net>
 <539b3cd4-8af3-d6d8-f5a9-2c426a1f0faa@codethink.co.uk>
 <93ae13c0-da78-0e6a-358f-97e358c11f16@metux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <93ae13c0-da78-0e6a-358f-97e358c11f16@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 10:33:44AM +0100, Enrico Weigelt, metux IT consult =
wrote:
> On 12.03.19 10:17, Ben Dooks wrote:
> > On 11/03/2019 18:54, Enrico Weigelt, metux IT consult wrote:
> >> don't need the temporary variable "dev", directly use &pdev->dev
> >>
> >> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> >=20
> > This is quite usual to do, and I like it as it saves typing.
> > Personally I would say don't bother with this change.
>=20
> hmm, both approaches have their valid arguments.
>=20
> I'm not particularily biased to one or another ay, but I'd prefer
> having it consistent  everywhere.

You're not consistent within the series itself. In patch 3 you went the
other way and dropped usage of pdev->dev in favour of the local dev
variable.

Thierry

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHl08ACgkQ3SOs138+
s6HW+g/+MWn1kqxRifMoTc87mFQWgLTMOHS767jDOkb8bWe4+WlBYBNoK1OHJzrx
0xG4+NrwhFmlAZB3trYdB+xowUyASk0FrdaclsAls7ll01VqV8h9XhQ5cDfhhWTK
VfvNWn9B+4xWHFW9Gvuqy5/Hm5SrzwJtOuwnY6gzbS/ab3G26Pzl8Ux9DkO4kKf2
XafQp4WGZptgzrszw0ImctGd6GrCdT14y/tjG5Uz0qDj3qwacxC5oLJfv7A9TVf2
hvtoIHI1jHYim7UZT1ulwActXIAnpIUzDVUvwQJMlFT6LYAZp/9ZEFVfOhW+dZRS
sgYHPQ0GVrVwyRzgPYDSqX3SYwB0XRhlhJiwSW8J98q0dAOm6YpiOqtHJivAbcUK
QhN9aP/r0UGDOsricWT7PJw7JbEi3AHzu2o3ZUnGBapQIEAi2QJ//oxmie1njxPD
b2Xmmyd9728BO5bQQH65h5X4f145oBblh4usaXb8W52C1HG/yhpjZ5Dy5tqo8myA
GzePv5HQhjr9uvJLATFSQJBJbAw7RzdasZiyI95SeQEF74e4sIu1AuCtdvhlyH8k
OX2a/xfoVsaV8YbbRCKPwxjFp+TOsyxlQ9vqOZhU+TnGPZRyzOqGRc8IPQP+sgGh
UcwSoM0Jq+eOidJWA2w7aT1dBMBvqbHQ0A5OBhq3267ppp/VUik=
=zI8x
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
