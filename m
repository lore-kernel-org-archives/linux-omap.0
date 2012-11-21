From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 03/16] mfd: omap-usb-tll: introduce and use
 mode_needs_tll()
Date: Wed, 21 Nov 2012 13:57:05 +0200
Message-ID: <20121121115705.GE10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-4-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39814 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab2KUMDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 07:03:36 -0500
Content-Disposition: inline
In-Reply-To: <1352990054-14680-4-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:34:01PM +0200, Roger Quadros wrote:
> This is a handy macro to check if the port requires the
> USB TLL module or not. Use it to Enable the TLL module and manage
> the clocks.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-tll.c |   20 ++++++++++++--------
>  1 files changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index 943ac14..7054395e 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -99,6 +99,10 @@
> =20
>  #define is_ehci_tll_mode(x)	(x =3D=3D OMAP_EHCI_PORT_MODE_TLL)
> =20
> +/* only PHY and UNUSED modes don't need TLL */
> +#define mode_needs_tll(x)	((x !=3D OMAP_USBHS_PORT_MODE_UNUSED) && \

prepend with omap_usb_

> +				 (x !=3D OMAP_EHCI_PORT_MODE_PHY))
> +
>  struct usbtll_omap {
>  	void __iomem				*base;
>  	int					nch;	/* number of channels */
> @@ -216,6 +220,7 @@ static int __devinit usbtll_omap_probe(struct platfor=
m_device *pdev)
>  	unsigned long				flags;
>  	int					ret =3D 0;
>  	int					i, ver;
> +	bool needs_tll;
> =20
>  	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
> =20
> @@ -282,12 +287,11 @@ static int __devinit usbtll_omap_probe(struct platf=
orm_device *pdev)
>  		tll->ch_clk[i] =3D fck;
>  	}
> =20
> -	if (is_ehci_tll_mode(pdata->port_mode[0]) ||
> -	    is_ehci_tll_mode(pdata->port_mode[1]) ||
> -	    is_ehci_tll_mode(pdata->port_mode[2]) ||
> -	    is_ohci_port(pdata->port_mode[0]) ||
> -	    is_ohci_port(pdata->port_mode[1]) ||
> -	    is_ohci_port(pdata->port_mode[2])) {
> +	needs_tll =3D false;
> +	for (i =3D 0; i < tll->nch; i++)
> +		needs_tll |=3D mode_needs_tll(pdata->port_mode[i]);
> +
> +	if (needs_tll) {
> =20
>  		/* Program Common TLL register */
>  		reg =3D usbtll_read(base, OMAP_TLL_SHARED_CONF);
> @@ -386,7 +390,7 @@ static int usbtll_runtime_resume(struct device *dev)
>  	spin_lock_irqsave(&tll->lock, flags);
> =20
>  	for (i =3D 0; i < tll->nch; i++) {
> -		if (is_ehci_tll_mode(pdata->port_mode[i])) {
> +		if (mode_needs_tll(pdata->port_mode[i])) {
>  			int r;
>  			r =3D clk_enable(tll->ch_clk[i]);
>  			if (r) {
> @@ -419,7 +423,7 @@ static int usbtll_runtime_suspend(struct device *dev)
>  	spin_lock_irqsave(&tll->lock, flags);
> =20
>  	for (i =3D 0; i < tll->nch; i++) {
> -		if (is_ehci_tll_mode(pdata->port_mode[i]))
> +		if (mode_needs_tll(pdata->port_mode[i]))
>  			clk_disable(tll->ch_clk[i]);
>  	}
> =20
> --=20
> 1.7.4.1
>=20

--=20
balbi

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrMGRAAoJEIaOsuA1yqRE9SIP/0xq0QqxpjrX9lMx7p/bgLDq
oyiV1vv6EeY/QWV92K9pNTCLpGkJ6Wquj5W02n0cJALyYRV5+cylOf7RIBZgCTUC
HiAToWzrJ7SJXcSL2QWFTc46wXFxPxKEZl3movHZvFQyZnyRK2O8aGKZnIBa7nVb
3xJC7Oqp9P484hATZm3E6kFS19HAHddXA55XcpcopLAGVAPR4Shvp9/TCAz8+s7C
RE7mKTevJUlS1mq3S0THVGWOlC/GxkzV2EwrFZo1Zz3ZAb9UgjSml0qXae4cs81A
DSKoh1eqZEB49RuVlfW0tNvt7CIn2KrlKASQ+E6Cn/3KV28+u6e6RYVFAIOwfw0B
CWOYi7C69HRQiON84e1HNvhC+RFW8Y6WtH/03egrz8QptKsYX70UlBDS12t/Hhbw
zMiUXJs9coEliez/LtdYVGsnPvtWLZ4M09uHZ9wMAMHL5auyU/3x/zVD/6czoojx
4/2oAuPOsw+EivQaDLiz/3qF2FsKv1Nj1RR5D2M72SfzrgpOD7LV5bDDEqUR5vX4
c0n4/FD+XRj6kSm3ljxfZftr3RHw2+O7k1v2Uglr5QfAdGNqv16HWyhhzj29oIyS
HSJg1ZjL1IdAaNqJpZrrGWUmBxQngcbYBMjcZVLgd7cjUDr7ZBGvBsg90sw3HxKq
tPcUgLtURnGbJFKt0wlU
=4Xwu
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--
