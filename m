From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] gpio/omap: convert gpio irq domain to linear mapping
Date: Sat, 2 Mar 2013 13:48:11 +0200
Message-ID: <20130302114742.GA9965@arwen.pp.htv.fi>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
 <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55264 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab3CBLs0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Mar 2013 06:48:26 -0500
Content-Disposition: inline
In-Reply-To: <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2013 at 11:22:47AM -0600, Jon Hunter wrote:
> Currently the OMAP GPIO driver uses a legacy mapping for the GPIO IRQ
> domain. This is not necessary because we do not need to assign a
> specific interrupt number to the GPIO IRQ domain. Therefore, convert
> the OMAP GPIO driver to use a linear mapping instead.
>=20
> Please note that this also allows to simplify the logic in the OMAP
> gpio_irq_handler() routine, by using irq_find_mapping() to obtain the
> virtual irq number from the GPIO bank and bank index.
>=20
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

Just one suggestion below for a later patch.

> @@ -680,7 +686,7 @@ static void gpio_irq_handler(unsigned int irq, struct=
 irq_desc *desc)
>  {
>  	void __iomem *isr_reg =3D NULL;
>  	u32 isr;
> -	unsigned int gpio_irq, gpio_index;
> +	unsigned int i;
>  	struct gpio_bank *bank;
>  	int unmasked =3D 0;
>  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> @@ -721,15 +727,10 @@ static void gpio_irq_handler(unsigned int irq, stru=
ct irq_desc *desc)
>  		if (!isr)
>  			break;
> =20
> -		gpio_irq =3D bank->irq_base;
> -		for (; isr !=3D 0; isr >>=3D 1, gpio_irq++) {
> -			int gpio =3D irq_to_gpio(bank, gpio_irq);
> -
> +		for (i =3D 0; isr !=3D 0; isr >>=3D 1, i++) {
>  			if (!(isr & 1))
>  				continue;

this will iterate over all 32 GPIOs, a better way to handle this would
be to have something like:

while (isr) {
	unsigned long bit =3D __ffs(isr);

	/* clear this bit */
	isr &=3D ~bit;

	generic_handle_irq(irq_find_mapping(bank->domain, bit);
}

this way you will only iterate the amount of bits enabled in the isr
register.

ps: completely untested ;-)

--=20
balbi

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMeb7AAoJEIaOsuA1yqREiGIQAKHLwunnP0wjxwIemuYj92p+
MVaW8i+i/xKKC01b/AQhKOKc3p6IqqDPrfVsqMZSyJvPsEdketmm228IMb/7Dcuq
lvs2LOVicB+QHlmg3LNi2UdERELGqiOZOl0wEHq+zS6PS2++wRb4efwkTNtOWpmd
9qEh641qW+1LIZSj6yadUPysiqpL9w/iZK7pfHGPjKpcCAopQKfItKu5D1Xah0X+
9tDmW47ea2+g8K6UEnEaA3aB5/YZ1pJtAwOiuqtm7UHNx64m7RIvm/kilm5PqddO
zstic88VtyrZ2ZE8cDlrMckUyp0mpRqZZSoftDGczOkCIyHryKillEy58e4yeDbf
Kfvo5o/qTYZbGUQX0aHxHBF+yQ89wjJJ57HjbyzUjxW+ZCFXN/5RkTV5kQhFQ/qX
X/iMSE0RJnbUHAFmBmtWljqmBMQJL0wpL6Gtvh2HOz53eFnCXrJ3aE1hPet6pf8m
NNeQhGEd35g3xJxhxhajQcJlve6HOM9nAkUYbJAv/21gALF7NfpHd9OeFB/5o5xD
JvNe3BJFvq/iwMFspv+5/yEoWSn4JV+6pOELIWM068J124yQZtO2cOvnTrOoV7sD
Cw59xoRQfG6cYymqsEgAw0C/H7LN7Q8wLni3ab9Npfr2BaCqM8r+zDlO21HKRm5f
3PycDtmwPkPW/Nc12bPf
=2npb
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
