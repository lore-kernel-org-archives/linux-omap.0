From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v4] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Wed, 20 Jul 2011 11:04:28 +0530
Message-ID: <CABb+yY3E69J6vbHNP92k-b6ScFMcU2LY71rqEZMY_9+E+vx=fA@mail.gmail.com>
References: <1311138718-5072-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:35687 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab1GTFfQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jul 2011 01:35:16 -0400
In-Reply-To: <1311138718-5072-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, gadiyar@ti.com, linux-omap@vger.kernel.org, Moiz Sonasath <m-sonasath@ti.com>

On Wed, Jul 20, 2011 at 10:41 AM, Vikram Pandita <vikram.pandita@ti.com=
> wrote:
> From: Anand Gadiyar <gadiyar@ti.com>
>
> This patch enables the DMA mode1 RX support.
> This feature is enabled based on the short_not_ok flag passed from
> gadget drivers.
>
> This will result in a thruput performance gain of around
> 40% for USB mass-storage/mtp use cases.
>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Tested-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
> v1 - initial push
> v2 - fixed whitespace issues as per Sergei Shtylyov<sshtylyov@mvista.=
com> comments
> v3 - restor authorship to Anand Gadiyar <gadiyar@ti.com>
> v4 - adding my signed-off as per Kevin Hilman <khilman@ti.com>
>
> =C2=A0drivers/usb/musb/musb_gadget.c | =C2=A0 68 ++++++++++++++++++++=
++++---------------
> =C2=A01 files changed, 42 insertions(+), 26 deletions(-)

> @@ -683,6 +684,18 @@ static void rxstate(struct musb *musb, struct mu=
sb_request *req)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (csr & MUSB_RXCSR_RXPKTRDY) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D musb_r=
eadw(epio, MUSB_RXCOUNT);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Enable Mod=
e 1 for RX transfers only for mass-storage
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* use-case, =
based on short_not_ok flag which is set only
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* from file_=
storage and f_mass_storage drivers
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (request->short=
_not_ok && len =3D=3D musb_ep->packet_sz)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 use_mode_1 =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 use_mode_1 =3D 0;
> +
There is nothing UMS class specific in this patch...
(request->short_not_ok && len =3D=3D musb_ep->packet_sz) may not be the
signature of, and only of, Mass Storage Functions. So maybe removing
the UMS mention from
comment and change-log is a good idea.
You might want to add is-ep-type-bulk-out check to the condition
though, so that it doesn't affect
cases that you didn't verify.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
