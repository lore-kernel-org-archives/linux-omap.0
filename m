From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] MAINTAINERS: add more files under OMAP SUPPORT
Date: Mon, 3 Nov 2014 18:42:41 -0600
Message-ID: <20141104004241.GC16754@saruman>
References: <1415061173-9338-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51245 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaKDAm3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2014 19:42:29 -0500
Content-Disposition: inline
In-Reply-To: <1415061173-9338-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2014 at 06:32:53PM -0600, Felipe Balbi wrote:
> These files are very important to the healt
> of the OMAP architecture, specially when it
> comes to PM support which currently we have
> working for at least OMAP3 and we'd like
> to know about any changes being made to our
> PMICs and IRQ controllers.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---

I wonder if we should list file-by-file since some of hte tps devices
are rather used by NVidia and other SoCs.

If you prefer, I'll go grep around on our DTS files and list one-by-one,
no issues.

>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c64271..4fc2a2c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6594,6 +6594,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/g=
it/tmlind/linux-omap.git
>  S:	Maintained
>  F:	arch/arm/*omap*/
>  F:	drivers/i2c/busses/i2c-omap.c
> +F:	drivers/irqchip/irq-omap-intc.c
> +F:	drivers/mfd/*omap*.c
> +F:	drivers/mfd/menelaus.c
> +F:	drivers/mfd/palmas.c
> +F:	drivers/mfd/tps6*.c
> +F:	drivers/mfd/twl4030*.c
> +F:	drivers/regulator/palmas-regulator*.c
> +F:	drivers/regulator/pbias-regulator.c
> +F:	drivers/regulator/tps6*.c
> +F:	drivers/regulator/twl*.c
>  F:	include/linux/i2c-omap.h
> =20
>  OMAP DEVICE TREE SUPPORT
> --=20
> 2.1.0.GIT
>=20

--=20
balbi

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWCEBAAoJEIaOsuA1yqREtgoP/0HthPnXBO64nhehIt4ecg8q
uMXfMJAMnPE+Adk9K6bSs3ONZ6MYoSyJ8qqHAeWtIpmCz1AOHmLsRMtSNP1D5NXo
xMWzkrlO6+L1yMx/oCCY+dxx+FWWx989ZSz7/832LiCNY8A2TZTBugJ8mJ+xi6QU
SHqZApqLaFYdPYoXx6Oi6aYtAXbzok/wTcQdezSU0lM4CLRYGrWua0Jj0XWDu+fm
X/dyJ/B79TVRuIpGfGDB2rBE0sz91Y+2XGuj9MKjEhWOgSDi6dkFCHzDt6rERYpY
CJSVEGMWt5YW2XMC+OfDwjwQUGcTfiq/3TdNylVapOqh8AsF/sDC1qzCuJWB4m1W
sBcpdaKXaCMSgICEvaBtjsvJ9zzsHDFPr69wJVA/aZ2GbUfvlFSTGcU3YU8pkmok
C3mJtEb1iJ7xZFlRdH4GHxNKpS/ccxg9ChZq3CnhDiwkjStlTC6UKPulnzLhTWHv
YZf0SFOT6wkb5xcxj+444n2ZuC1ylB3BDMZBPQA7EfqrchF8zM+ZrERhHkoCXC5F
oH0jwM4kn4nNdjWTrsJYy56ocydxdzgumi4jvmMbcqSycvQiVwG66V5PRBi35jRI
/ssAECxPJB5swcZdTB/foy1mSXkqu5vm9zsJZi1eZ599+aMTUK+WImK30Xl5mr1O
5eTsjZARaNBJuXLZC5hM
=cb0O
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
