From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 1/2] USB: musb-gadget: fix bulk IN infinite hangs in double buffer case
Date: Fri, 27 Aug 2010 16:27:05 -0400
Message-ID: <201008271627.08137.vapier@gentoo.org>
References: <1282909040-2936-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart183287204.MsGFDPsjbQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:35209 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278Ab0H0U1t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Aug 2010 16:27:49 -0400
In-Reply-To: <1282909040-2936-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tom.leiming@gmail.com
Cc: greg@kroah.com, dbrownell@users.sourceforge.net, felipe.balbi@nokia.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

--nextPart183287204.MsGFDPsjbQ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday, August 27, 2010 07:37:20 tom.leiming@gmail.com wrote:
> From: Ming Lei <tom.leiming@gmail.com>
>=20
> This patch fixes one infinite hang of bulk IN transfer in double buffer
> case, the hang can be observed easily by test #6 of usbtest if musb is
> configured as g_zero and fifo mode 3 is taken to enable double fifo.
>=20
> In fact, the patch only removes the check for non-empty fifo before
> loading data from new request into fifo since the check is not correct:
>=20
> 	-in double buffer case, fifo may accommodate more than one packet,
> 	even though it has contained one packet already and is non-empty
>=20
> 	-since last DMA is completed before calling musb_g_tx, it is sure
> 	that fifo may accommodate at least one packet
>=20
> Without applying the patch, new requst enqueued from .complte may not
> have a chance to be loaded into fifo, then will never be completed and
> cause infinite hangs.
>=20
> With the patch, on my beagle B5, test#6(queued bulk in) can be passed and
> test result may go beyond 33Mbyte/s if musb is configured as g_zero and
> fifo mode 3 is taken, follows the test command:
>=20
> 	#testusb -D DEV_NAME -c 1024 -t 6 -s 32768 -g 8   [1]
>=20
> [1],
>     -source of testusb : tools/usb/testusb.c under linux kernel;
>=20
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> Cc: Anand Gadiyar <gadiyar@ti.com>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>=20
> ---
>  drivers/usb/musb/musb_gadget.c |   12 ------------
>  1 files changed, 0 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/usb/musb/musb_gadget.c
> b/drivers/usb/musb/musb_gadget.c index 550b397..e0bd1c1 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -506,18 +506,6 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>  			/* ... or if not, then complete it. */
>  			musb_g_giveback(musb_ep, request, 0);
>=20
> -			/*
> -			 * Kickstart next transfer if appropriate;
> -			 * the packet that just completed might not
> -			 * be transmitted for hours or days.
> -			 * REVISIT for double buffering...
> -			 * FIXME revisit for stalls too...
> -			 */
> -			musb_ep_select(mbase, epnum);
> -			csr =3D musb_readw(epio, MUSB_TXCSR);
> -			if (csr & MUSB_TXCSR_FIFONOTEMPTY)
> -				return;
> -
>  			request =3D musb_ep->desc ? next_request(musb_ep) : NULL;
>  			if (!request) {
>  				DBG(4, "%s idle now\n",

maybe this change will make a difference ?

=46rom 13fa6c9cec387893e2b22db6c055028f96fea5b8 Mon Sep 17 00:00:00 2001
=46rom: Cliff Cai <cliff.cai@analog.com>
Date: Fri, 3 Jul 2009 06:32:02 +0000
Subject: [PATCH] USB: musb: only complete the request when all data has bee=
n=20
transfered [local/log]

bug[#5269],bug[#5268],bug[#5264]only complete the request when all data has=
=20
been transfered

git-svn-id: svn://localhost/svn/linux-kernel/trunk@6915 526b6c2d-f592-4532-
a319-5dd88ccb003d
=2D--
 drivers/usb/musb/musb_gadget.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 6fca870..f019843 100644
=2D-- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -500,6 +500,8 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 						| MUSB_TXCSR_TXPKTRDY);
 				request->zero =3D 0;
 			}
+			if (request->actual < request->length)
+				return;
=20
 			/* ... or if not, then complete it. */
 			musb_g_giveback(musb_ep, request, 0);
=2D-=20
1.7.2.2

--nextPart183287204.MsGFDPsjbQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJMeB+cAAoJEEFjO5/oN/WBn9AQAIXbOSZki1429vSokj3jvbxb
WDMVdyG9THQraEwXhLZ2K9N8ztGLn+vKfoc2AkjI+vCc62strBvllsYIcYhHKga7
6UOQCixQhT7+oTXfV6eiW3PbjyFbaYQhHzPdUDTyl4y+CgXuVtZq8xC8MVMd+LWq
lQIgsu4xe9b06oklIq/BZxQQseHVU4qq+kOiGuxQuEKB1+ASkTvC/dJXIRzuCxi4
YMS3emzCPaB7brLChorKz3yKgZ2glw6qyX/5qO2T8RskS9waMUUlKu5Ks5a5xnO+
CYfSA+tJ57AuhdltE38h68YCiA6VnkHhM6Uxc14nNLja0cQcKRMj72nSnVbzVJqj
+573bFf+gxaHooLq5+m2aij2Es4QqmeZ/2ZFUOioxHDNAo2dpEYtE6QXt6DFmM4I
gL5tI9D5iNdgSddmwnY4RwOPMjim8lcMea3DAlwMm7jfRW2+elcB8MOCBb7LN9YV
fiBoUVw+VtH2VGvCvI6sORpZFvkI5AYaHucg4HxKwCbTAIYZOxIB3vNdB0oXJa6+
5uUWuenxyShoQRpXIuVaDPfg3LrZVdz7txR1FxNDUiNX9GE0X7Q4OxsZDOUlAaAh
VeL+GsL+iTgyJVKO27VZaKvQttMSBopErba5K0OvlLR06xCraFo12izGdUriS8Zy
15jYDmDvg2bCHx05XK1K
=Zbx9
-----END PGP SIGNATURE-----

--nextPart183287204.MsGFDPsjbQ--
