From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] gpio/omap: convert gpio irq domain to linear mapping
Date: Mon, 4 Mar 2013 19:11:59 +0200
Message-ID: <20130304171159.GB14507@arwen.pp.htv.fi>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
 <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
 <20130302114742.GA9965@arwen.pp.htv.fi>
 <5134D484.8070307@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60328 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757398Ab3CDRMU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Mar 2013 12:12:20 -0500
Content-Disposition: inline
In-Reply-To: <5134D484.8070307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: balbi@ti.com, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 11:06:12AM -0600, Jon Hunter wrote:
>=20
> On 03/02/2013 05:48 AM, Felipe Balbi wrote:
> > On Fri, Mar 01, 2013 at 11:22:47AM -0600, Jon Hunter wrote:
> >> Currently the OMAP GPIO driver uses a legacy mapping for the GPIO IRQ
> >> domain. This is not necessary because we do not need to assign a
> >> specific interrupt number to the GPIO IRQ domain. Therefore, convert
> >> the OMAP GPIO driver to use a linear mapping instead.
> >>
> >> Please note that this also allows to simplify the logic in the OMAP
> >> gpio_irq_handler() routine, by using irq_find_mapping() to obtain the
> >> virtual irq number from the GPIO bank and bank index.
> >>
> >> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> >> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> >=20
> > Reviewed-by: Felipe Balbi <balbi@ti.com>
> >=20
> > Just one suggestion below for a later patch.
> >=20
> >> @@ -680,7 +686,7 @@ static void gpio_irq_handler(unsigned int irq, str=
uct irq_desc *desc)
> >>  {
> >>  	void __iomem *isr_reg =3D NULL;
> >>  	u32 isr;
> >> -	unsigned int gpio_irq, gpio_index;
> >> +	unsigned int i;
> >>  	struct gpio_bank *bank;
> >>  	int unmasked =3D 0;
> >>  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> >> @@ -721,15 +727,10 @@ static void gpio_irq_handler(unsigned int irq, s=
truct irq_desc *desc)
> >>  		if (!isr)
> >>  			break;
> >> =20
> >> -		gpio_irq =3D bank->irq_base;
> >> -		for (; isr !=3D 0; isr >>=3D 1, gpio_irq++) {
> >> -			int gpio =3D irq_to_gpio(bank, gpio_irq);
> >> -
> >> +		for (i =3D 0; isr !=3D 0; isr >>=3D 1, i++) {
> >>  			if (!(isr & 1))
> >>  				continue;
> >=20
> > this will iterate over all 32 GPIOs, a better way to handle this would
> > be to have something like:
>=20
> Worse case, if only bit 31 was set then I agree this is not that
> efficient. Or even if one bit is set. However, the loop itself will
> iterate while isr !=3D 0 so not always over each bit. No different to the
> existing code.
>=20
> > while (isr) {
> > 	unsigned long bit =3D __ffs(isr);
> >
> > 	/* clear this bit */
> > 	isr &=3D ~bit;
> >=20
> > 	generic_handle_irq(irq_find_mapping(bank->domain, bit);
> > }
> >=20
> > this way you will only iterate the amount of bits enabled in the isr
> > register.
>=20
> Definitely cleaner but I am wondering which approach would be more
> efficient from an instruction standpoint. This could definitely be much
> more efficient if there is only a couple bits set.

__ffs() is done with CLZ instruction, so it's pretty fast.

--=20
balbi

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNNXfAAoJEIaOsuA1yqREj4cP/R+LxULY5Mw+dKEty+miOLx3
OSnzVR5F/MQeFYzYQgkcIWBxPSL24WnwCRUOGDSDztWFENlN8dwHADTY9tvTnT+7
Kw1hpvjGojyaLFJntM/8/bVsnwweo4ZVQYWkCGZY3bABnuTQXzbR7683BVFCqqxG
qlgv8sF7CsWhz3CXM/Sr0lHBht04qgAW5zVJHazmVlQ0c3tbEUkVj4mZMk6wMvdi
/NZbDcLGtw7tVyMRHpLgwPgWs2AGYXoe7brOxwT0mKWEnU98+4fQRgMW9QoYe1wO
kD/YeWfDzi4ex//wsoTeF+lBdAy0DkMJ2WjxcouBuC/I1nPler/EjHUb5iJDeUaq
rzaZ+Q2te/m4+SAGKT9n0x8nxPKCmxvV7yCcTvxgCdSi3x5Eop2aYD3QxlXilpQD
cEsN3dA/+MBsJj8lKuxft7+PNctqo7btqu1X+L3IMtPPU2HwDuWcKCJfcalYAkP9
pzWwK1L9G/zwHGmh19+IkwHR5ZQicuADe4Jeua7mw9cjlEP+lYR2egI5uqYna8Vg
H2unmNQnzOOGunbaW4egxb8gfi8sWxcBaHOfIZs9WroclwoR7MYXWCCUp1OQVk+p
wRdI4QEfgMLgcZpPNs/5H6SMKCB+nXCITFuhu1nheDjgCyOijgE7r10b8xYVUWxP
nkpgjbZ4hA0gZ0x5fqxd
=Ny48
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
