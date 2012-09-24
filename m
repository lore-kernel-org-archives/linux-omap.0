From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] usb: Include generic_interrupt for OMAP2_PLUS
Date: Mon, 24 Sep 2012 15:15:39 +0300
Message-ID: <20120924121538.GH2892@arwen.pp.htv.fi>
References: <1348487604-7202-1-git-send-email-philippe.deswert@jollamobile.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k9xkV0rc9XGsukaG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:42526 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753775Ab2IXMUd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 08:20:33 -0400
Received: by lbbgj3 with SMTP id gj3so6596782lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 05:20:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1348487604-7202-1-git-send-email-philippe.deswert@jollamobile.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: philippedeswert@gmail.com
Cc: Philippe De Swert <philippe.deswert@jollamobile.com>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org


--k9xkV0rc9XGsukaG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 24, 2012 at 02:53:24PM +0300, philippedeswert@gmail.com wrote:
> From: Philippe De Swert <philippe.deswert@jollamobile.com>
>=20
> Unless generic_interrupt is defined the irq setup
> in musb_init_controller fails for the omap2430 driver
> since that one does not set it's own interrupt handler.
> Which leaves usb non-functional.
>=20
> Tested on N950/N9.
>=20
> Signed-off-by: Philippe De Swert <philippedeswert@gmail.com>

SoB's mail doesn't From mail.

> ---
>  drivers/usb/musb/musb_core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index db3dff8..ff9e482 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1499,7 +1499,8 @@ static int __devinit musb_core_init(u16 musb_type, =
struct musb *musb)
>  /*----------------------------------------------------------------------=
---*/
> =20
>  #if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430) || \
> -	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500)
> +	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500) || \
> +	defined(CONFIG_ARCH_OMAP2PLUS)

Weird, how can you build OMAP2PLUS without SOC_OMAPXXXX ??

BTW, this is also wrong as OMAP2PLUS is also used to enable AM3xxx and
TI8xxx, and those platforms don't use generic_interrupt().

--=20
balbi

--k9xkV0rc9XGsukaG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQYE7pAAoJEIaOsuA1yqRE73kP/2GxpJ5z4IRnzDKrpPOP6yF1
+fR/SRUzmqV7laih6EkUuRo0IOuHKZKONhEeVvVEPTe1trKwGqAbjXILbsVV9H+8
l42/ctnbSb3MxUeokLNZ+GJ+vnpaIptmkJbZsxohtl8Vx4HCGfN84aY8NvCnjMPr
y58RQaPKA2dPn6Lhzpr47b6iK+mafrljyutxsFOwoB6zveucdiBU27csWRGQ5++n
J+nU6ZZyJQxiIgjsxX52M06jxhsy9On8TazXm/FPfS9A30BeFwteDl7L3Fb3biKg
XP6qnhJwPGfTETK0tOzWn0vblfQO65qYdRkDqQEgV6WYkWuPnE2IaqKOssWulmp4
6I0d3/dfsGCqokclp3xm/bZNnnkgRan1fgOfmLZhwLgZyvwfTlR++7rkDofLmhl0
iQls5FOVEbmQDjVhiwoj+Is3M/a7tbXg+JKAl/kubOTLp0E6gYyv1BTo8OjwIZas
GcFQGzz9VOn+lqZ8V4u1npceUE/Gr1KVUCF70tmPokbg7kzY14wjKHOlhrDdCMzF
hxbWiLcZQwh352k8zZ6P4ttpqcvdvHvBO706lPZSkpSfxPYwcOu2hbW79Q3UJQP3
eF3Z+8QUdV20bIKKaP+ZOrqgeGzz6pEOgiJmGtKb1QiyEQSD94lmrZfws9mwwDwW
gqhNoh/8kLu5eVB35S1b
=Zugb
-----END PGP SIGNATURE-----

--k9xkV0rc9XGsukaG--
