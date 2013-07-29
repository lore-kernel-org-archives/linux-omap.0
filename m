From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv6 1/2] drivers: spi: Add qspi flash controller
Date: Mon, 29 Jul 2013 14:09:02 +0300
Message-ID: <20130729110902.GE24801@radagast>
References: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com>
 <1375082550-30544-2-git-send-email-sourav.poddar@ti.com>
 <20130729093128.GE23710@radagast>
 <51F63FF3.5070304@ti.com>
 <20130729102038.GK23710@radagast>
 <51F64C49.4080606@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55401 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab3G2LJW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 07:09:22 -0400
Content-Disposition: inline
In-Reply-To: <51F64C49.4080606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: balbi@ti.com, broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com

--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 29, 2013 at 04:34:41PM +0530, Sourav Poddar wrote:
> >>>>+	irq =3D platform_get_irq(pdev, 0);
> >>>>+	if (irq<   0) {
> >>>>+		dev_err(&pdev->dev, "no irq resource?\n");
> >>>>+		return irq;
> >>>>+	}
> >>>>+
> >>>>+	spin_lock_init(&qspi->lock);
> >>>>+
> >>>>+	qspi->base =3D devm_ioremap_resource(&pdev->dev, r);
> >>>>+	if (IS_ERR(qspi->base)) {
> >>>>+		ret =3D PTR_ERR(qspi->base);
> >>>>+		goto free_master;
> >>>>+	}
> >>>>+
> >>>>+	ret =3D devm_request_threaded_irq(&pdev->dev, irq, ti_qspi_isr,
> >>>>+			ti_qspi_threaded_isr, IRQF_NO_SUSPEND | IRQF_ONESHOT,
> >>>why do you need IRQF_NO_SUSPEND ?
> >>>
> >>I should get away with this.
> >why ? Do you need or do you *not* need it ? And in either case, why ?
> >
> I was thinking, this will keep the irqs up even when we are
> hitting suspend, we will not be prepared to handle it. ?

won't be prepared in what way ?

--=20
balbi

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR9k1OAAoJEIaOsuA1yqREjw0QALCjIlQXH6pi6IIsARBJXG3J
zd6jfnIgjnI1OP0E1Banu/NqUWWiqzqgqkGnWesGV3OmeliyWoW7GVItZ9+SP2+Q
a6qLtBNQWYFrcb59bf4myahqjqFFaPqI07auxk3TM5zraaW8MdmT0z4jUn9VTQ4T
fpgAsrMLwrFTBJAznpAHU4FYHenq4xZB+lpTIHfwtW67wTGKI8M6iXQBRII+v+nw
CNNbwEw59b86Az17pFWpb12SWhe1fozKZhdwcFXlKNtCdrfY06c0mGs4XccRRT6R
YxUinVDf5nwpaa/QzgwEvn4SytSLI2NK2Ehl0wH3cJqLZpEWsmQ5LxJZCiW/r3by
PN4E7jNDLv33FIZn9dz30LVIiOHKEHYuOB+J8XYzJkq61liqxeMWvG2A8Ohwvu8B
HrtaiXtKQe95leJwnmlqmLjM5g4xq08Y9F0QKqB1BHpAXAC59jj58P1HbQM9g40F
hkLgsLw/zU6kg345csyhBYaKar3VDja2oA+mFCKGwTvNaLiByW8CbZMaFFbmaU7A
wVW1vcg64E9A2REmkPribEpztpntb2GRHIVAObYC898A/Dn1vpdnCb4h/w8Xe8DU
X2eQYrBLcoAaV7El/UacOT0jTcQXupN9IKJz7MUo8KdiXkKHDWtLFRXMrogsISKs
OHBHX7llpJmFm5zAvFCx
=fE7u
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
