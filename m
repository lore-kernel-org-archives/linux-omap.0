From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Fri, 26 Oct 2012 23:01:37 +0300
Message-ID: <20121026200137.GC29548@arwen.pp.htv.fi>
References: <20121026114250.GA26342@arwen.pp.htv.fi>
 <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52287 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966288Ab2JZUHZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Oct 2012 16:07:25 -0400
Content-Disposition: inline
In-Reply-To: <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tim Niemeyer <tim.niemeyer@corscience.de>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, balbi@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>

--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 26, 2012 at 03:19:13PM +0200, Tim Niemeyer wrote:
> Adds support for configuring the omap-gpio driver use autosuspend for
> runtime power management. This can reduce the latency in using it by
> not suspending the device immediately on idle. If another access takes
> place before the autosuspend timeout (2 secs), the call to resume the
> device can return immediately saving some save/ restore cycles.
>=20
> This removes also the bank->mod_usage counter, because this is already
> handled in pm_runtime.
>=20
> I use a gpio to monitor a spi transfer which occurs every 250=B5s. The
> suspend overhead is to high, so almost every second transfer is lost.
> This patch fixes that.
>=20
> Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
> ---
>  drivers/gpio/gpio-omap.c |   81 ++++++++++++++++++++++++----------------=
-----
>  1 files changed, 43 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 94cbc84..708d5a9 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -31,6 +31,7 @@
>  #include <asm/mach/irq.h>
> =20
>  #define OFF_MODE	1
> +#define GPIO_AUTOSUSPEND_TIMEOUT                2000

something just hit me... If you keep timeout at 2000 ms and you hook
this up to an IRQ line, it's very unlikely GPIO will ever sleep.

Why did you choose 2000 ms ? Arbitrary value ?

--=20
balbi

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiuwhAAoJEIaOsuA1yqREdrkP/0AGgmRTIRdrHzIyXbdgv/Ld
NcQtVr8idUgHpJxKygkyrXpFUBa0EluYu5BJ2Ntlh2b6MdxWsck+XcMc2dWt2Uf/
Uzkh12qiLbShGIho3SKbKjTV5EinRK/iC6o10r3lHolid4RRSVra7+jdequV9XgF
zwbxHkUb/YUXXM9b44/PCJmpjN9epCff0OJgNvOXDDDAsMpWwpjOyd1n5m6aQDue
irQVFaOAqeuShWLE5LRTNrGRj6HGhGW36uMobT/gtE5k8kk93/bh7XXToZ7EL2kv
492DNbAC1e6+qvehKUqLdXo/IBfWEatshFhX5mLeMKMqjpbNwpNXbYUkqHLM3or9
cXy4YZJFpQW9DYrhQ6fQM5mw2EI04zysLQnoKQpnckRvjOCzUdpuTRkADqTtpg1t
PuGIzCvHfekq46JMJwbXwZzK+EsxX9/JlwaEWUnLm7QC6PFkRmISWIkcPIt+upJq
oUYUC2D3AYXJak3MXBrSraQD5cCDPit9IBNckKNbH/R4V6GJWlbT2uI5CboakglL
P/pZy+v5G1VKIJcxd/YSBIo86rSsq5Hca4gelYt725XoLkqw1D9lXKcJmOb1FwaN
pvm+z0txLx1y7k26//0r/HuZDFhiMysbqKlccLG56xwV6Ygm5ciivHN8IhV4rEGB
4dPGeIqhl8YURE+YN0NW
=BhoN
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
