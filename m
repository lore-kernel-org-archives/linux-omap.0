From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/5] mfd: tps65218: make INT1 our status_base register
Date: Tue, 6 Jan 2015 11:37:40 -0600
Message-ID: <20150106173740.GM6502@saruman>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-3-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lbQeYSs6J2ITmUo7"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419622104-25812-3-git-send-email-balbi@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

--lbQeYSs6J2ITmUo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2014 at 01:28:21PM -0600, Felipe Balbi wrote:
> If we don't tell regmap-irq that our first status
> register is at offset 1, it will try to read offset
> zero, which is the chipid register.
>=20
> Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> Cc: <stable@vger.kernel.org> # v3.15+
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

ping

> ---
>  drivers/mfd/tps65218.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 2243f75..d6b7643 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -204,6 +204,7 @@ static struct regmap_irq_chip tps65218_irq_chip =3D {
> =20
>  	.num_regs =3D 2,
>  	.mask_base =3D TPS65218_REG_INT_MASK1,
> +	.status_base =3D TPS65218_REG_INT1,
>  };
> =20
>  static const struct of_device_id of_tps65218_match_table[] =3D {
> --=20
> 2.2.0
>=20

--=20
balbi

--lbQeYSs6J2ITmUo7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrB1kAAoJEIaOsuA1yqREbIwQAKFbW/mGnM8mjE33chmFyqpy
OIQy9ABEXu023jPX8umnkQ2DKspPQS1AGftaQ/sKWtTVApXg3BErqm40htRDueBa
GOQ/qNyO3FtZuSokksj6iYfphRJ4myds7gTBZxjEk4EIRZKMGNfK2HFS4/gsiHPi
TXIvqJUBuYBULF7faLkuXHw/xVLnJf37xx1JEIr0WpxTP9xshdiJ1m8lfF8T96Lf
Rq0UzRbszy2Sl73wXELgxrBVMXWWN9Dwwg83A7zGOPmGNAIQj1HdrFYuEK6fXGs9
HcQ9wCaKveMJIvRN9Zk6Lx2v/XkJolUmHNjdizYWb66RV1las58mFE+Qyt/alrDi
sCQxFilF7nTEwVjfHSJnJ0ZTZ8CVjywupygmiwCiJi/KZRC3O3Lvi1+HMQqQr4JN
5lWvrZeS7IYuKoqps81nPsBj4HrUy1YsoqKnpxnClIQMZnHSXYHBxtNeABGLgcHO
P3hS096uRtjDND6hsQsyBqwsQGdow+QpqQR8n4g14TqJDQSv1jrtIxMH61Kqon4B
ci+y4LS8stuObl2gmWwaOmkbmOOJ8dK9PEaHGg39+OCtc982xyJzDR9JL8XlE61f
EgmCXKfXKVGaY2dacDAJYab21ZjQ1G4vOiI6P4UTBfbwmUsBr8Q3Jj/V9eUkgd28
iSim5SPsMWHnng+BfRfF
=OJyK
-----END PGP SIGNATURE-----

--lbQeYSs6J2ITmUo7--
