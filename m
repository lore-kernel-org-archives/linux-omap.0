From: Mark D Rustad <mrustad@gmail.com>
Subject: Re: [PATCH 07/11] mfd: Drop unnecessary static
Date: Sat, 15 Jul 2017 13:49:26 -0700
Message-ID: <D2DCD2EA-E216-45D4-87F5-375C30F4AC76@gmail.com>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
 <1500149266-32357-8-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: multipart/signed;
 boundary="Apple-Mail=_59775874-8A42-4E20-BB79-999D580CC8D4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1500149266-32357-8-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Tony Lindgren <tony@atomide.com>, keescook@chromium.org, kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_59775874-8A42-4E20-BB79-999D580CC8D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On Jul 15, 2017, at 1:07 PM, Julia Lawall <Julia.Lawall@lip6.fr> =
wrote:
>=20
> Drop static on a local variable, when the variable is initialized =
before
> any possible use.  Thus, the static has no benefit.

I think in this case the use relies on the structure continuing to =
exist, so a stack object is not an acceptable substitute. Just because =
it is initialized doesn't mean that it doesn't need a persistent =
lifetime.

> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @bad exists@
> position p;
> identifier x;
> type T;
> @@
> static T x@p;
> ...
> x =3D <+...x...+>
>=20
> @@
> identifier x;
> expression e;
> type T;
> position p !=3D bad.p;
> @@
> -static
> T x@p;
> ... when !=3D x
>     when strict
> ?x =3D e;
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
> These patches are all independent of each other.
>=20
> drivers/mfd/twl4030-irq.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff -u -p a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -685,7 +685,7 @@ int twl4030_sih_setup(struct device *dev
>=20
> int twl4030_init_irq(struct device *dev, int irq_num)
> {
> -	static struct irq_chip	twl4030_irq_chip;
> +	struct irq_chip		twl4030_irq_chip;
> 	int			status, i;
> 	int			irq_base, irq_end, nr_irqs;
> 	struct			device_node *node =3D dev->of_node;

--
Mark Rustad, MRustad@gmail.com


--Apple-Mail=_59775874-8A42-4E20-BB79-999D580CC8D4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCAAGBQJZan/aAAoJEDwO/+eO4+5uKdYP/jRLx/kwK1YaaPtDtrk9a3ES
Tnfr/arPejQk28jpsIf4kGmwlGGnf6wWO2c9548x8TaxEYBicQzPobYjLlbFM+RO
F/9ZGhaREZBMkM7ySSs3okAQ3ZMx3ly375ax570rS/3l+ukXIhY/fCDBWh0KZ7io
334In3j01qhp+o9Vqhoj4KOVGn/FPZqiIUx40DhH0A3TFe7Ik3JRV/3vbV51O1fF
STjeHRe6mLn8kH/+LpEmoiCBma5zRQu+kixQO/6iBYA32n76X1i588DsDg4rWcmA
Yr8Z76JDL8tzX9Yt5GDpt8l6CswsEGNF+rr4C+9YURBD5aykGR2yVLR4tM2YI9Fk
HwhC5m3crFvNDfY+xLFs5yOyHE8bGNHdB0Owv0XLr9EMvMX+p4BovcIUsssdmKGR
bsdUOHBOP3nY+wLoOh/GVAGKYQ+5siBwcdavplLPlekJPf1OrZl4jY3ljgD6h9nq
BCwO6gmM3+IzqAMgte2uTcepSPAr3Zo8tUOxtQOS070TdtjfSoXoTg5rOBVoedb2
7B+CyLeDNwTIXIbwS+H5MCLSh6yWDKZupa6eYiu1GkX26OMi9AmVLpk8DqmG2S0E
mGpD626E5ANmLjOQCLTZ3CMmvWmSCiBAFsDCKnDk+KTFwWNiyojevT8eeDI4zTfz
KxKq6IpsJrhDWmz3NHwb
=Uvit
-----END PGP SIGNATURE-----

--Apple-Mail=_59775874-8A42-4E20-BB79-999D580CC8D4--
