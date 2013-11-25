From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 4/4] usb: musb: dsps: add support for suspend and
 resume
Date: Mon, 25 Nov 2013 15:29:21 -0600
Message-ID: <20131125212920.GU18046@saruman.home>
References: <1385414803-13212-1-git-send-email-zonque@gmail.com>
 <1385414803-13212-5-git-send-email-zonque@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m0OTIrBz/ErRqy1N"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50256 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111Ab3KYVaQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 16:30:16 -0500
Content-Disposition: inline
In-Reply-To: <1385414803-13212-5-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: balbi@ti.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de

--m0OTIrBz/ErRqy1N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2013 at 10:26:43PM +0100, Daniel Mack wrote:
> +static int dsps_resume(struct device *dev)
> +{
> +	struct dsps_glue *glue =3D dev_get_drvdata(dev);
> +	const struct dsps_musb_wrapper *wrp =3D glue->wrp;
> +	struct musb *musb =3D platform_get_drvdata(glue->musb);
> +	void __iomem *mbase =3D musb->ctrl_base;
> +
> +	dsps_writel(mbase, wrp->control, glue->context.control);
> +	dsps_writel(mbase, wrp->epintr_set, glue->context.epintr);
> +	dsps_writel(mbase, wrp->coreintr_set, glue->context.coreintr);
> +	dsps_writel(mbase, wrp->phy_utmi, glue->context.phy_utmi);
> +	dsps_writel(mbase, wrp->mode, glue->context.mode);
> +	dsps_writel(mbase, wrp->tx_mode, glue->context.tx_mode);
> +	dsps_writel(mbase, wrp->rx_mode, glue->context.rx_mode);
> +
> +	//musb_port_reset(musb, false);

????

--=20
balbi

--m0OTIrBz/ErRqy1N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk8EwAAoJEIaOsuA1yqREDOAP/jVX9Pki/aZMQacvPGcFTksT
X6YmsbvENurBeilMW0ubq8AHwIVdW3uCdQOuPPUAgzo3Pyx7+L7IXjES1t6RDb25
CRvCwpoZ7QFQytnlkleOc2g+Ui4hPk/9M3LpYT42yw/p7FcT5e84NHJBlspM8Dnm
LjtQWNCnUf0paUKGiBotefI9p8cpTdZS00Le1/sWse24ERFdvPp1HmlJgNCtMIS6
hoIj4jBcbeRIao1JS78UXmpode8OnojKwluZdNsvmEIrz6TwyvkLQrk3uakWKC9i
2EzOkkJRoj06oMVv/s6+bzbgf3tkhj3UQcrzR5fPrwx417B75DFsi0abvh5PrScY
NJIYRxdbKcMjoKPX6GZgNz1JUDahs734xziXulPdANmtBPP42tfZuUdF3iKCy1YQ
dCWkI/7mf3JP9Wg28bhdfNaKn9limaNUmi9IKFV9YeTyhQlIIBFEdW/9+nqhg+Tg
wOqpnovtTAFaF2X9eEleSQMpk8f+bOtQUrkO76yw6jdnHjnHusj0x4XvySgU93Q3
BWp8as+p/yZGjuRQBi31wWl1SKsIBhoIz3541m7F5hYtgcLXLyXnyjcmYFk9xuYf
Ayv0H5I+XuEobaSc0JEDKf0o7292fZyoI0yBn2vP61m9T+hKQ8VcCIoe2KK6h1Gx
jYGdNuoi9UkN7Y5K5tI4
=Z8Sg
-----END PGP SIGNATURE-----

--m0OTIrBz/ErRqy1N--
