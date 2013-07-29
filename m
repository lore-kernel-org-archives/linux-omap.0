From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv6 1/2] drivers: spi: Add qspi flash controller
Date: Mon, 29 Jul 2013 13:20:38 +0300
Message-ID: <20130729102038.GK23710@radagast>
References: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com>
 <1375082550-30544-2-git-send-email-sourav.poddar@ti.com>
 <20130729093128.GE23710@radagast>
 <51F63FF3.5070304@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GOzekVbrLdOLv44p"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50808 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3G2KUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 06:20:55 -0400
Content-Disposition: inline
In-Reply-To: <51F63FF3.5070304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: balbi@ti.com, broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com

--GOzekVbrLdOLv44p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 29, 2013 at 03:42:03PM +0530, Sourav Poddar wrote:
> >>+	frame_length =3D (m->frame_length<<  3) / spi->bits_per_word;
> >there's another way to optimize this. If you assume bits_per_word to
> >always be power of two you can:
> >
> >	frame_length =3D (m->frame_length<<  3)>>  __ffs(spi->bits_per_word);
> >
> >but that would need a comment stating that you're assuming bits_per_word
> >to always be a power of two. Not sure if this is a correct assumption.
> >
> I dont think it will be a correct assumption, since our controller is
> flexible to
> handle anything from 1 to 128 as bits_per_word.

right, but can the framework handle non-power-of-two bits_per_word ?

> >>+	spin_unlock(&qspi->lock);
> >You should, before releasing the lock, mask your IRQs, so that you can
> >get rid of IRQF_ONESHOT. Unmask them before returning from the IRQ
> >thread.
> >
> Sorry, did not get  you here?
>  I am reading interrupt status register before and clearing them in
> the threaded irq.

you need to mask the IRQs, clear WC and FIRQ in IRQENABLE register...
set them back at the end of the thread handler.

> >>+static int ti_qspi_probe(struct platform_device *pdev)
> >>+{
> >>+	struct  ti_qspi *qspi;
> >>+	struct spi_master *master;
> >>+	struct resource         *r;
> >>+	struct device_node *np =3D pdev->dev.of_node;
> >>+	u32 max_freq;
> >>+	int ret =3D 0, num_cs, irq;
> >>+
> >>+	master =3D spi_alloc_master(&pdev->dev, sizeof(*qspi));
> >>+	if (!master)
> >>+		return -ENOMEM;
> >>+
> >>+	master->mode_bits =3D SPI_CPOL | SPI_CPHA;
> >>+
> >>+	master->num_chipselect =3D 1;
> >again with the num_chipselect =3D 1 ? IIRC this controller has 4
> >chipselects, just read 24.5.1 on your TRM.
> >
> this is unnecessary. I intended to configure chip selects through
> dt)as done below).
> Will remove.

which brings me to the point of:

Do you review your own code before sending it out ? Doesn't look like...

> >>+	irq =3D platform_get_irq(pdev, 0);
> >>+	if (irq<  0) {
> >>+		dev_err(&pdev->dev, "no irq resource?\n");
> >>+		return irq;
> >>+	}
> >>+
> >>+	spin_lock_init(&qspi->lock);
> >>+
> >>+	qspi->base =3D devm_ioremap_resource(&pdev->dev, r);
> >>+	if (IS_ERR(qspi->base)) {
> >>+		ret =3D PTR_ERR(qspi->base);
> >>+		goto free_master;
> >>+	}
> >>+
> >>+	ret =3D devm_request_threaded_irq(&pdev->dev, irq, ti_qspi_isr,
> >>+			ti_qspi_threaded_isr, IRQF_NO_SUSPEND | IRQF_ONESHOT,
> >why do you need IRQF_NO_SUSPEND ?
> >
> I should get away with this.

why ? Do you need or do you *not* need it ? And in either case, why ?

--=20
balbi

--GOzekVbrLdOLv44p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR9kH2AAoJEIaOsuA1yqRE6m4QAK3cwXOJ8v0kAoG0DoSmIUVi
xpWDr+cDsaUHgNqG+GiZElVZ7se62ig+ET5qjamsOmZmfYG4K4/LfvaIbU3Oot1L
sbFZckdfCYLBcowRUhDoWB9Nm4cFX1Tz+9P+5BT8INHXJjbygcP+L9bgowgAkxRS
zkkhENVaCCcT09NE+YAoZNEidgr+2aAPQjDxC9Lmfuamim89czKX6vpxpyHaa6ZA
z8GeHOP0eIx7i/7GgozhVVCWCC4sm3iRUwh1UAqf/bJDafNbCkB6JnlefsbmYixG
MHZ67mqwrA2K5dpY3NZjU4sf3XsSmIGf51CXYQASrUJ2HJrpUafAnMvkefi5lWiJ
G+I0pIJIohwbExPgjkht3+7Y4tt1QFwdUhvytNYWHM408lVhyqIDmOkhe36DQaEZ
CfDhTdBriJ3+FDydkhVDbzsKNrEUrcNTeofk7lmVE6CEvafjePjr+v1+n3ivskEa
Vj/4vW8iPBa1NuMBQrvyDGi9H3IePZmkUexZL+hMBoj188VLpxvn1MhcH+txzpwp
Ymwp9VmFvL21RrFmi4SFfEkSz8HiVH4/zxRzZYlTUwb66fN7THQ8B8Ay3QLhyXh4
SVF5TSq8d7KXhVGqN6qar+MbUtRDKfwOhirRWySCJ8DKwvOjlZHL0NGFxBxdTd0v
l8aoWZHnWjJysHlLe6bz
=otby
-----END PGP SIGNATURE-----

--GOzekVbrLdOLv44p--
