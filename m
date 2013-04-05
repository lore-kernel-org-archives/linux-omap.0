From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5] gpio/omap: optimise interrupt service routine
Date: Fri, 5 Apr 2013 12:19:02 +0300
Message-ID: <20130405091902.GA9626@arwen.pp.htv.fi>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
 <1365106576-31816-4-git-send-email-jon-hunter@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0847517519849373494=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365106576-31816-4-git-send-email-jon-hunter@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============0847517519849373494==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2013 at 03:16:14PM -0500, Jon Hunter wrote:
> The OMAP GPIO interrupt service routine is checking each bit in the
> GPIO interrupt status register to see which bits are set. It is not
> efficient to check every bit especially if only a few bits are set.
> Therefore, instead of checking every bit use the __ffs() function,
> which returns the location of the first set bit, to find all the set
> bits.
>=20
> This optimisation was suggested-by and developed in collaboration
> with Felipe Balbi.
>=20
> Cc: Felipe Balbi <balbi@ti.com>
>=20
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

looks alright:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/gpio/gpio-omap.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 5af7acd..685e850 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -689,7 +689,7 @@ static void gpio_irq_handler(unsigned int irq, struct=
 irq_desc *desc)
>  {
>  	void __iomem *isr_reg =3D NULL;
>  	u32 isr;
> -	unsigned int i;
> +	unsigned int bit;
>  	struct gpio_bank *bank;
>  	int unmasked =3D 0;
>  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> @@ -730,9 +730,9 @@ static void gpio_irq_handler(unsigned int irq, struct=
 irq_desc *desc)
>  		if (!isr)
>  			break;
> =20
> -		for (i =3D 0; isr !=3D 0; isr >>=3D 1, i++) {
> -			if (!(isr & 1))
> -				continue;
> +		while (isr) {
> +			bit =3D __ffs(isr);
> +			isr &=3D ~(1 << bit);
> =20
>  			/*
>  			 * Some chips can't respond to both rising and falling
> @@ -741,10 +741,10 @@ static void gpio_irq_handler(unsigned int irq, stru=
ct irq_desc *desc)
>  			 * to respond to the IRQ for the opposite direction.
>  			 * This will be indicated in the bank toggle_mask.
>  			 */
> -			if (bank->toggle_mask & (1 << i))
> -				_toggle_gpio_edge_triggering(bank, i);
> +			if (bank->toggle_mask & (1 << bit))
> +				_toggle_gpio_edge_triggering(bank, bit);
> =20
> -			generic_handle_irq(irq_find_mapping(bank->domain, i));
> +			generic_handle_irq(irq_find_mapping(bank->domain, bit));
>  		}
>  	}
>  	/* if bank has any level sensitive GPIO pin interrupt
> --=20
> 1.7.10.4
>=20

--=20
balbi

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXpcGAAoJEIaOsuA1yqREFMYP/3nJzJjW38yHtk+TZtbT/X31
srZXK/50hgRbtW9Jsm+nWIS/9vWSiqXlFJVqClmLyTmtdW9lFRkbpYjJz4ktFvhA
egtpUyzopyz31x2p/wLTqJGbQzx6yDeJzrTnbQuOLSU0AzTDp1/u0XNb1lS7AAKI
DFisbsLjgNt+X02bV43ZNnML4QsLkNuPHjqE6+/siVbG0QU3DPwGogiykdCAbEUn
wijYeUXl66Olouo7IDX6WTbMu3++eQ4LyjHXm/Qafdrufjx52k2ypmDNJmChqX+R
7pFNtwgPVwFgS+PJbJ04J3P5aR11F6DZFDuBZb5dbwax21rvVckJOzoOgExbr3tv
6XO7fNZbaTOeJea2HRJn3qCiTo2Uecmk2c6TcOgJCCaH/MSaN4VBPptSyD4eC6x0
i58rlDsM4iLzxaFHNwim2v+FE/G/Hn3Xk1Qjburg2z2tUmIBGK8T4cbGVySAdTnB
kceXvtCXtiPOq7mg/1usHx5EFS9wn2zbivPQge+lNdnS0Xzo8WGwkZU6xhRZsZB8
I/fVMDCyqX6/Y8bYLRGu2ZbYawN/woHKTRC5hiasE7HI1RIcmDqHxtT3zorS4rMD
923W2ZaUSXVrRkwdo+tedpXoTMU/lR6LwpoLo4V20cLUwE4siszjNVuVcox3KHZ8
1o/4KSfQv0hmQpAWxbg+
=jcxI
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--


--===============0847517519849373494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0847517519849373494==--
