From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 4/4] usb: musb: dsps: add support for suspend and
 resume
Date: Mon, 25 Nov 2013 15:32:36 -0600
Message-ID: <20131125213236.GW18046@saruman.home>
References: <1385414803-13212-1-git-send-email-zonque@gmail.com>
 <1385414803-13212-5-git-send-email-zonque@gmail.com>
 <20131125212920.GU18046@saruman.home>
 <5293C17D.3020508@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="anW2uJ7hcMI/vMa8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48602 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab3KYVdg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 16:33:36 -0500
Content-Disposition: inline
In-Reply-To: <5293C17D.3020508@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: balbi@ti.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de

--anW2uJ7hcMI/vMa8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 10:30:37PM +0100, Daniel Mack wrote:
> On 11/25/2013 10:29 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Nov 25, 2013 at 10:26:43PM +0100, Daniel Mack wrote:
> >> +static int dsps_resume(struct device *dev)
> >> +{
> >> +	struct dsps_glue *glue =3D dev_get_drvdata(dev);
> >> +	const struct dsps_musb_wrapper *wrp =3D glue->wrp;
> >> +	struct musb *musb =3D platform_get_drvdata(glue->musb);
> >> +	void __iomem *mbase =3D musb->ctrl_base;
> >> +
> >> +	dsps_writel(mbase, wrp->control, glue->context.control);
> >> +	dsps_writel(mbase, wrp->epintr_set, glue->context.epintr);
> >> +	dsps_writel(mbase, wrp->coreintr_set, glue->context.coreintr);
> >> +	dsps_writel(mbase, wrp->phy_utmi, glue->context.phy_utmi);
> >> +	dsps_writel(mbase, wrp->mode, glue->context.mode);
> >> +	dsps_writel(mbase, wrp->tx_mode, glue->context.tx_mode);
> >> +	dsps_writel(mbase, wrp->rx_mode, glue->context.rx_mode);
> >> +
> >> +	//musb_port_reset(musb, false);
> >=20
> > ????
> >=20
>=20
> Urgs. Development left-over. Sorry. You want me to resend the whole
> series or just this last patch?

just the last patch is fine :-)

--=20
balbi

--anW2uJ7hcMI/vMa8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk8H0AAoJEIaOsuA1yqREXqIP/3Km17azKW51gFm+X1Kccp3S
u8cwUuyIIw+6duI1frBcQ+HGmxpHSJSlvzWTc3BDnC4IOON5I6gRhf1+5NPtOuUl
pb4TnZjdKbWnR7Fx06N1yaqmMurZdJI+hGojOBSwUqcGHi/faMc0NVCkP+AXehun
LEMRqyuG8L0KlNnlMFTuiwcibRFJfQxqEJYRUFbKKgNt1PbZvFNOExeJGXUoezrz
PpIb12RrDqq+8VY79s8c2GkXuSNRbPPoZgzn3v/zXUT7ZsGr4dYO3ymv4f4BXWZv
U5+njxSjeFnIZmVD6bnLFspCc6P3tkglCEj6lWTvCKLPS8l95tO8TNbVrXDsy/3x
t/O5jlLuiIl2eGR2g8eU12doOMI+d/duB+tXZdeBnkkonyEyyrsJb6HMsBxQBwiE
Bpj4X7Z9pbdU0OWEJdbCxF6ZYrgyp/lGjGqKiMRE6AzSYAhJULtvhrorH6e7nNnK
aDpRRepSjMGi3+H5N4DgJozHkeeyNGZeiNEqSq++5TRuLjv0ka/YD7UDzFJBQL+C
Wgmbe3IGuv6vrpByUpyv60gCuZFx5QeaOI3+u2NLynSwhXHjoa2pE9XFhdCNn6v/
qCBGoZ6S+FoUEHuE2312QlFWFchEMDS8ftZclQVMHu6cZc9j3iyT6QYHnsz6qXF2
tdfWPUw+4xez2VsJ5AgZ
=Eg5n
-----END PGP SIGNATURE-----

--anW2uJ7hcMI/vMa8--
