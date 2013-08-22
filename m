From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv11] drivers: spi: Add qspi flash controller
Date: Thu, 22 Aug 2013 13:08:41 +0100
Message-ID: <20130822120841.GE26118@sirena.org.uk>
References: <1377005148-6983-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aPOcx+xoD6gZZHnz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:37852 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab3HVMIu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 08:08:50 -0400
Content-Disposition: inline
In-Reply-To: <1377005148-6983-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org


--aPOcx+xoD6gZZHnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2013 at 06:55:48PM +0530, Sourav Poddar wrote:
> The patch add basic support for the quad spi controller.
>=20
> QSPI is a kind of spi module that allows single,
> dual and quad read access to external spi devices. The module
> has a memory mapped interface which provide direct interface
> for accessing data form external spi devices.

Applied, but please use subject lines appropraite for the subsystem and
one other thing...

> +static irqreturn_t ti_qspi_threaded_isr(int this_irq, void *dev_id)
> +{
> +	struct ti_qspi *qspi =3D dev_id;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&qspi->lock, flags);
> +
> +	if (qspi->stat & WC)
> +		complete(&qspi->transfer_complete);
> +
> +	spin_unlock_irqrestore(&qspi->lock, flags);
> +
> +	ti_qspi_write(qspi, QSPI_WC_INT_EN, QSPI_INTR_ENABLE_SET_REG);

This is doing a NAPI style thing where it suppresses interrupts while
the interrupt completes however the transfer functions expect an
interrupt per word.

Then again there's no FIFO in the hardware so we'd overflow or underflow
anyway - is there any way of detecting the underflow or overflow other
than a timeout later on (which the driver will do)?

--aPOcx+xoD6gZZHnz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFf9GAAoJELSic+t+oim9p6UQAJAicVLtda2Wwx1jfP9rAL5f
wQYHHgD/Ejc87cNdysRijigV1ZtPa59wvNeDixFDmuXfbIbj4djzYrHeQM6U4eg7
w+OSFn4WvvxdKoKgzkvZnF7STNeumPIO2Of3aKNkcWwYIchabpWGpwhymyXap2Qk
PSdR19nSI5UoyHnUJL/Tl0/0NUCgaWXy0US0Owtm38XNwkxor71quULrylKtW+sp
WVaQ2Nw3U/E5nF02mGo8VyPlsMwsOcWfoQh6TUa1o6EsHGZ+klq25XW06jkklEGl
KP5IpZ4ng2seE0zCRnF/Oygjq9+/JfXftR9Uip4YQQjS27PaChtNLVbx3JjcPbPZ
beYsTvCRCly/UqCJOPQwUJPj/HjkmtGB2HlKyqS0cG9nHw4q4OA094Ul/WTWK5xU
dZ1DJ1W74qQ9dmLXF3lvo2Zze5sTUdjy4Ti3R7xw1A+v92ia26rUl6RmfUtV70D+
uRLgxVgVCRCOpaZVWvszoQWEC00oGJ4eMVuOz54+TmSzVVtRnECYphpXz2lSlow2
oNa9s5rQm//MGDZoborR3/hUaYqFeXnetAUxAo0doe+9LeOmYy8EJnoYcwhasbE9
+G6RGW+r1EwaQC2HGfmvZIXXDBJjsdscdY8H5laheaVJAhih5RTiDIy0XVmKk/qE
KNxZ0XGkdKa8J283trNi
=wR99
-----END PGP SIGNATURE-----

--aPOcx+xoD6gZZHnz--
