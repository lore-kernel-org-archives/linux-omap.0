From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] i2c: omap: fix draining irq handling
Date: Mon, 21 Jan 2013 10:44:31 +0200
Message-ID: <20130121084431.GG8777@arwen.pp.htv.fi>
References: <1358707022-26477-1-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55659 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404Ab3AUIpF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jan 2013 03:45:05 -0500
Content-Disposition: inline
In-Reply-To: <1358707022-26477-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: w.sang@pengutronix.de, ben-linux@fluff.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, balbi@ti.com

--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Sun, Jan 20, 2013 at 08:37:02PM +0200, Aaro Koskinen wrote:
> Commit 0bdfe0cb803dce699ff337c35d8e97ac355fa417 (i2c: omap: sanitize
> exit path) changed the interrupt handler to exit early and complete
> the transfer after the draining IRQ is handled. As a result, the ARDY
> may not be cleared properly, and it may cause all future I2C transfers
> to timeout with "timeout waiting for bus ready". This is reproducible
> at least with N900 when twl4030_gpio makes a long write (> FIFO size)
> during the probe (http://marc.info/?l=3Dlinux-omap&m=3D135818882610432&w=
=3D2).
>=20
> The fix is to continue until we get ARDY interrupt that completes the
> transfer. Tested with 3.8-rc4 + N900: 20 boots in a row without errors;
> without the patch the problem triggers after few reboots.

fair enough, but ...

> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/i2c/busses/i2c-omap.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 832f16e..4cc2f05 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -963,7 +963,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
>  				i2c_omap_errata_i207(dev, stat);
> =20
>  			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
> -			break;
> +			continue;

=2E.. when we get draining Interrupt, it means we're receiving the last
few bytes, meaning that by the time we handle it there's nothing pending
to be transferred.

I would rather wait for ARDY before exiting omap_i2c_xfer_msg() rather
than here. Specially since that was the programming model suggested by
our IP engineers. Such handling is part of my other patchset and can be
easily ported.

OTOH, we might decide to go with this during this -rc and fix it all up
for v3.9 on my other patchset.

--=20
balbi

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ/P/vAAoJEIaOsuA1yqREnPMQAIWekhOO5KS9ZmEKqqLJ0aof
P3xtJaHk1ZXHqVYrH5JHRSNwteMwkOPG1IFewXGWZEZx30H/M0Kfjrj8rQ5dzZKY
NMcFNOtTxtTXwxOPqh0TLZgm/duNkjS8xa2uHc+pT1t1PkV1aCZwmczQVT/k6JOd
rvcU4S5JIJ/A2NfOhSiqaoqa9lhurlk/fS89v+52G0R3Y//7/UtRm5reR/d7HUHX
CRd/kzJ4cHG5taczkIIPJFkaBxULpjbZMFnDLtr/uvS3ItZ7L6WvfhP+mOVPgp0R
aZecWBbD9xkYvs3iAWkc7p/7c0QWR093qE0fU1F27MLQj5PX4AzIFWYJuhZy3/OS
Od5wdLdMSUqBgI4b+6cq7zkuVt1MVYhf5XRc03kiyBPcbiFEEevDNX8oA2LezDz0
X0Clg1LBPPryogXNr30YbLcSZi32WEShCZ5SqUmmqkxBtrNqf+ox5089TtYqrXlC
WAfyTcN13GE6mEQGQLGlYKprYRfPA0z7JolirqKUiF+eSDNbw6RYDOAfFX91Eqnh
4rCdKZpdxQAWnbloCcGOU8HXKcnIqccv/iHWicPpJAvgiSRiZvYK76xzoC4H+UM1
4uZAzOIOJU/i2MHd/PpCcOSex79afzT87UJfOMzbQMKpxaO/e+LsMoPcPAZF81ap
yx54Xw5Gj0oE980ZfMNM
=2zBS
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
