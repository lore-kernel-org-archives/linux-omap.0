From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] usb: musb: fix build break due to partial rename
Date: Mon, 4 Oct 2010 08:46:51 +0200
Message-ID: <20101004064651.GI28679@pengutronix.de>
References: <1285965264-17972-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42428 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab0JDGqx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 02:46:53 -0400
Content-Disposition: inline
In-Reply-To: <1285965264-17972-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Michal Nazarewicz <m.nazarewicz@samsung.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>

On Sat, Oct 02, 2010 at 02:04:24AM +0530, Anand Gadiyar wrote:
> Patch "usb gadget: don't save bind callback in struct usb_gadget_driv=
er"
> in Greg's USB queue missed one conversion of
> usb_gadget_register_driver to usb_gadget_probe_driver,
> causing a build break when MUSB is built in gadget mode.
>=20
> Fix this.
>=20
> Reported-by: Grazvydas Ignotas <notasas@gmail.com>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Uwe Kleine-Koenig<u.kleine-koenig@pengutronix.de>
> Cc: Michal Nazarewicz <m.nazarewicz@samsung.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

> ---
> Greg,
>=20
> Since Uwe's original patch isn't yet in mainline, maybe you could
> fold this patch into the original.
>=20
>  drivers/usb/musb/musb_gadget.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: linux-2.6/drivers/usb/musb/musb_gadget.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/usb/musb/musb_gadget.c
> +++ linux-2.6/drivers/usb/musb/musb_gadget.c
> @@ -1786,7 +1786,7 @@ int usb_gadget_probe_driver(struct usb_g
> =20
>  	return retval;
>  }
> -EXPORT_SYMBOL(usb_gadget_register_driver);
> +EXPORT_SYMBOL(usb_gadget_probe_driver);
> =20
>  static void stop_activity(struct musb *musb, struct usb_gadget_drive=
r *driver)
>  {
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
