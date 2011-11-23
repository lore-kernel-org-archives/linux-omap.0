From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 6/6] cbus: retu: implement irq_domain support
Date: Wed, 23 Nov 2011 18:59:00 +0200
Message-ID: <20111123165857.GA1839@legolas.emea.dhcp.ti.com>
References: <1322056848-1188-1-git-send-email-balbi@ti.com>
 <1322056848-1188-7-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:39834 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754652Ab1KWQ7D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 11:59:03 -0500
Received: by mail-yw0-f53.google.com with SMTP id 19so429217ywm.40
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 08:59:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1322056848-1188-7-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 23, 2011 at 04:00:48PM +0200, Felipe Balbi wrote:
> Then, when moving to devicetree, we can list
> IRQs as 1, 2, 3. It's the only way to have a
> sane devicetree actually.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/cbus/retu.c |   42 +++++++++++++++++++++++++++---------------
>  1 files changed, 27 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
> index 25fa405..f25e0a3 100644
> --- a/drivers/cbus/retu.c
> +++ b/drivers/cbus/retu.c
> @@ -25,7 +25,7 @@
> =20
>  #include <linux/module.h>
>  #include <linux/init.h>
> -
> +#include <linux/irqdomain.h>
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> @@ -46,6 +46,7 @@ struct retu {
>  	struct mutex		mutex;
>  	struct device		*dev;
> =20
> +	struct irq_domain	irq_domain;
>  	struct irq_chip		irq_chip;
> =20
>  	int			irq_base;
> @@ -199,11 +200,9 @@ static irqreturn_t retu_irq_handler(int irq, void *_=
retu)
> =20
>  	while (idr) {
>  		unsigned long	pending =3D __ffs(idr);
> -		unsigned int	irq;
> =20
>  		idr &=3D ~BIT(pending);
> -		irq =3D pending + retu->irq_base;
> -		handle_nested_irq(irq);
> +		handle_nested_irq(pending);

This is particular, I'm not sure if it's correct. Not sure if we should
use hw IRQ number of linux IRQ number. A boot test should be enough to
verify though.

--=20
balbi

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOzSZRAAoJEIaOsuA1yqREg3wP/jmFibzLIAhNw2p2uIWD8Hsa
HwT/qPmMpgGWAOvB1JichUEoNsFxe8vQMH4EapzBVia8/9/9ZhtIfYoEjDeBb35g
/tYT7ACoVEBoHZPuSlTrwxysaIp2Vh+aU5SPXHiq4Or4pjabSTxTz+8kihQh1vJu
6XWyeZt6PnCN2Dzg/364+VHNvBZjSJqew4JTywqsUsGxuT2+yoJ6RhoeAOG8wGSX
NQW8caamNzUbxaM0UhysTNuQNPQtCYJQJAYKR9TdgHNyNuzEzKl1znr+BcOBOb08
vlGAvzgxeXM7ZqovwwFZvLTODB+bm7USbQM5ZS+ge2IfCemRfFciZzds3DTx5jRL
uU+VmQwgHeSbcGHRrwuFM1RJI9qDYByBXBdXsxKPH63rIpgcGeomh+fGnf+6jT7p
sPTH9kj4im700lr5VwKaQAYmh48c2CGhg5bWz2AtLlX74d17FcOXFyX6BfwqLFRS
0hNNHL1Kl9GLDJVRAUN/WrCYLQA7G32Ld/6EoMHzdOMzqjs29yrP27MOjjFgQRNb
6swdrIBCI61cXKjoHxx41EIKrtbKye0UuXKMzgoa90zK16uiLU33F9m+5ftR8Dn8
m+EQMFI6zcxGukI30h1Ju15brAMh2629SowOxR19+K1wyibKZwBs7ivrbZya+rsp
VLqTNDPtseQv/5VwCA5n
=uHdp
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
