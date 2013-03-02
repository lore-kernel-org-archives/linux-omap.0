From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] gpio/omap: warn if bank is not enabled on setting
 irq type
Date: Sat, 2 Mar 2013 13:49:35 +0200
Message-ID: <20130302114934.GB9965@arwen.pp.htv.fi>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
 <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41156 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab3CBLtu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Mar 2013 06:49:50 -0500
Content-Disposition: inline
In-Reply-To: <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2013 at 11:22:48AM -0600, Jon Hunter wrote:
> For OMAP devices, if a gpio is being used as an interrupt source but has
> not been requested by calling gpio_request(), a call to request_irq()
> may cause the kernel hang because the gpio bank may be disabled and
> hence the register access will fail. To prevent such hangs, test for
> this case and warn if this is detected.
>=20
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index c3598d1..0d30c7a 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -427,6 +427,9 @@ static int gpio_irq_type(struct irq_data *d, unsigned=
 type)
>  	int retval;
>  	unsigned long flags;
> =20
> +	if (WARN_ON(!bank->mod_usage))

It would be better to use WARN(!bank->mod_usage, "error message\n") IMO.

no strong feelings however:

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMedOAAoJEIaOsuA1yqREEycP/AigZ00nyfzng2FThb2ONfg4
Wxf++T5PXjcp1S3YvA5Urckcfviqm5vJ66fbCPIRWf6vpveZLtAt4k9nYYTLNQ0w
KVYhj780ge2PxXnYKXcnPtxMpKX3AI8+YWW67ZZTtRHVjGHYBGl4D3tWb3DVaVb+
iYdAMLBkyIj3boegSKyXBDbZ9+mxu1XbzVySKNREBkX4NEmJxR0O3j6CVP/egrg7
vrXYXdAQt0VDySGuRxWX2BVOzWagX8EB9SOtLaJEjg0ycgYeJ6QHyDWQWhDu5GBS
iPJDwLN3BaF+oGmCUSdHV0APoOzHZ/7+Z2tSWi3l9Qr7aDWKQ4s2clr0kgvNjURg
QHqt7OIVm/IlryDcQ5LLC8DaPf4EFG2B3YVtJCXk6bwZezUX/lb6v6k/QFaCwv78
bBCbm4mHAJOwFq8HTrWUE945xafegwzF1CIxlt3gW53L+n/DuEi+GRKahX3Z4Rzk
ad+1S0M+Lb6cdOOcfre87N0a64iBt2dW/AXm8haKAQmT4cxbOz5Pe0zWMLE9Scbe
jQSMKYCHA/zPFwy0Ecgm2cLJcaBzKzvR/BP2qg95ykLG4e+kZCCr/OmHeojkS+wT
jSLvAhwlx1mJfjWllyM6To1xFiSJdgl1kFXayxCUHgczzkrXpKL+bmzVeOz4yWFS
HSRo7Zf6tOC04s/NjJ5l
=1Wws
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
