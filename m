From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv6 1/2] drivers: spi: Add qspi flash controller
Date: Mon, 29 Jul 2013 15:35:35 +0300
Message-ID: <20130729123515.GJ24801@radagast>
References: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com>
 <1375082550-30544-2-git-send-email-sourav.poddar@ti.com>
 <20130729093128.GE23710@radagast>
 <51F63FF3.5070304@ti.com>
 <20130729102038.GK23710@radagast>
 <51F64C49.4080606@ti.com>
 <20130729110902.GE24801@radagast>
 <51F64EB6.5020807@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60711 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab3G2Mfy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 08:35:54 -0400
Content-Disposition: inline
In-Reply-To: <51F64EB6.5020807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: balbi@ti.com, broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com

--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 29, 2013 at 04:45:02PM +0530, Sourav Poddar wrote:
> >>>>>>+	irq =3D platform_get_irq(pdev, 0);
> >>>>>>+	if (irq<    0) {
> >>>>>>+		dev_err(&pdev->dev, "no irq resource?\n");
> >>>>>>+		return irq;
> >>>>>>+	}
> >>>>>>+
> >>>>>>+	spin_lock_init(&qspi->lock);
> >>>>>>+
> >>>>>>+	qspi->base =3D devm_ioremap_resource(&pdev->dev, r);
> >>>>>>+	if (IS_ERR(qspi->base)) {
> >>>>>>+		ret =3D PTR_ERR(qspi->base);
> >>>>>>+		goto free_master;
> >>>>>>+	}
> >>>>>>+
> >>>>>>+	ret =3D devm_request_threaded_irq(&pdev->dev, irq, ti_qspi_isr,
> >>>>>>+			ti_qspi_threaded_isr, IRQF_NO_SUSPEND | IRQF_ONESHOT,
> >>>>>why do you need IRQF_NO_SUSPEND ?
> >>>>>
> >>>>I should get away with this.
> >>>why ? Do you need or do you *not* need it ? And in either case, why ?
> >>>
> >>I was thinking, this will keep the irqs up even when we are
> >>hitting suspend, we will not be prepared to handle it. ?
> >won't be prepared in what way ?
> >
> Our driver will be down, so the irq might go un-serviced.

only if you wrote the driver that way. IRQ subsystem doesn't know the
state of the device, all it knows is that in case an IRQ fires, it needs
to call the registered IRQ handler.

Now the thing is:

Initially you had the flag setup, so I asked why you needed it. I
expected you to tell me why you think QSPI's IRQ shouldn't be disabled
during suspend and the implications of disabling it.

Instead you just changed your mind and decided to remove the flag.

Because you changed your mind with no explanation, that tells me you
haven't fully grasped how that flag works and what it means to set (or
not set) it.

My question now is simply: why don't you need that flag ? What are the
implications of setting that flag ? How would your driver behave if an
IRQ fired while your driver was suspended ? Unless you understand what
it does, how can you understand the behavior or the driver ?

cheers

--=20
balbi

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR9mGXAAoJEIaOsuA1yqREBk0P/jJgUqsrkekg7n1oaIPUZdrB
xbtx5CtKGtuUjCYlq8YABCAkrGKyIoVx7slmSF2DOL2J2oau2SYWE1XPpkvWXZwD
KS+3JBqUM3DLMUXFyzAvnZ4cX15hJ4IVKy1ENAtAx19Agay8Pbydjr5koc3cnwFG
ieVMS7NAIltmA9SbEsmcaIsmk3phv9SDpYhukL/BRerWy6RrK5KbzybOtJxZJ5aH
OUH7KcVXZBPHJZFe8Tux1hCGyxi7CFXghk5xB0Qzd8fx/dYNwctGfb1UHIWLcuFe
L1Jf+btTy2LHDa/FDwpK43xUiEKDLT4o/dFGOwvUU/2Q2aKoin5nFkHO0Qwdd7w3
cJVchVElq/Umc8gVt5ipaTGdB763wMcfiFShgUQdcU2ZuzSbjx/+aI6lbu4lMue0
R+ILmz1Q0FOH1NzZ9dXGf36I2MjadoHFt8dSn69r2fe+wAv2tGBm09jQugTmq0P5
k+4T9oNh4yQm+uXdbflNdBSkbk3ZT5oOL9YXRHcR/hXK/ZduBqusqajM7Nussm25
UM5aYyH5x9oMheaa/uJShjYzn2gbqpNncF2oRCDMnXpsQOtfYlxThId2GN9BJY6I
c0skpzmWZ+jpf2EVou6zpsx2NhwuStJSCW5INDgbf4LI8ncmSLTG9snt61uW5MWe
D8r4HGH0vbRw8C5RipAm
=b7+6
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--
