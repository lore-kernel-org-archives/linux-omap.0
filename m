From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable
 mask on disable
Date: Tue, 23 Oct 2012 22:09:14 +0300
Message-ID: <20121023190914.GA853@arwen.pp.htv.fi>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38507 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932144Ab2JWTPe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Oct 2012 15:15:34 -0400
Content-Disposition: inline
In-Reply-To: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 23, 2012 at 11:09:31AM -0700, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
>=20
> When debounce clocks are disabled, ensure that the banks
> dbck_enable_mask is cleared also.  Otherwise, context restore on
> subsequent off-mode transition will restore previous value from the
> shadow copies (bank->context.debounce*) leading to mismatch state
> between driver state and hardware state.
>=20
> This was discovered when board code was doing
>=20
>   gpio_request_one()
>   gpio_set_debounce()
>   gpio_free()
>=20
> which was leaving the GPIO debounce settings in a confused state.
> Then, enabling off mode causing bogus state to be restored, leaving
> GPIO debounce enabled which then prevented the CORE powerdomain from
> transitioning.
>=20
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

looks like this deserves a Cc: stable@vger.kernel.org tag.

> ---
> Applies on v3.7-rc2, targetted for v3.7.
>=20
>  drivers/gpio/gpio-omap.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 94cbc84..dee2856 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -187,6 +187,7 @@ static inline void _gpio_dbck_disable(struct gpio_ban=
k *bank)
>  		 * to detect events and generate interrupts at least on OMAP3.
>  		 */
>  		__raw_writel(0, bank->base + bank->regs->debounce_en);
> +		bank->dbck_enable_mask =3D 0;

shouldn't omap_gpio_restore_context() check for dbck_enabled instead of
the mask ? I mean:

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 94cbc84..b3a39a7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1371,7 +1371,7 @@ static void omap_gpio_restore_context(struct gpio_ban=
k *bank)
 				bank->base + bank->regs->dataout);
 	__raw_writel(bank->context.oe, bank->base + bank->regs->direction);
=20
-	if (bank->dbck_enable_mask) {
+	if (bank->dbck_enabled) {
 		__raw_writel(bank->context.debounce, bank->base +
 					bank->regs->debounce);
 		__raw_writel(bank->context.debounce_en,

the outcome would be the same, so it doesn't really matter. Just that,
at least to me, it would look better.

No strong feelings though.

--=20
balbi

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhutaAAoJEIaOsuA1yqREi/gP/0Y/hJIOBYmRolURQiIFtLuD
qhfIsSyrO8BirBt2rD5HVhYxEfBBDvbvhy3kWCysHvRINllTNVE0BFeBzAYusObP
IFzymivwcgvm4/pHrAF1OrjA7skXkEL8QtwUqqVzd1I+puVfSsyjpQ3BWWRGAWT+
+g/5YlE/mgIQ+1OFzMygy5dtVK/Visxw858pLpoFnCtKQVKBbDWVarZE5kqJHSAV
5gvLqtbqdb3A4fc202vAPinXzvCP3ehuzMlWqqrLZRX4E1uPHN5S7dmx4EdzdNMA
MOTNgcLYWSOAzr1KU9gM924hGadlBOWcaV8e9GkKo+j94nN6GrGIW3TNM/9N3jhB
xZPG+onjH10rLUKJSoweZR0ErT+WYFzZZeSNfQ0cZkrLGYSEVxUI589DmglgIxVI
QDOL0DJJwC7z6X2CNDCGIp7Uj938c+rjmucm8/KpIRiUgk0/X2/BQDmbzlWKKnAf
IUHQ4SRR3fwXQ7WpfvO3vQ8jAUNqsi7e3eIfWvjS4+1X65mQNX5+h9oeEkoO2hFJ
rPCp9TzNGByjAuGK+92NWFlbavJ50PX1h5QRngRQOkzlG9tkBKbNP+xouTzeh7VY
Onr65JzaXQ4QMcp8ozPmjdeaHdyqzBt00iRtlu7mxjbwGqas7aiNlhZHxUX6A9A4
bFu8W9VE3KUMKsblNjDY
=0INv
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
