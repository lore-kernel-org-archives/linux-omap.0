From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC] usb: musb: fail unaligned DMA transfers on v1.8 and above
Date: Sun, 31 Oct 2010 17:59:27 +0800
Message-ID: <AANLkTimAmGNtH3OTF9+G55jVYrokwe6bqENhaxHmtdv+@mail.gmail.com>
References: <1288502759-18618-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1288502759-18618-1-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, hemahk-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Cc Hema

2010/10/31 Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>:
> The Inventra DMA engine in version 1.8 and later of the MUSB
> controller cannot handle DMA addresses that are not aligned
> to a 4 byte boundary. It ends up ignoring the last two bits
> programmed in the DMA_ADDR register. This is a deliberate
> design change in the controller and is documented in the
> programming guide.
>
> Earlier versions of the controller could handle these
> accesses just fine.
>
> Fail dma_channel_program if we see an unaligned address when
> using the newer controllers, so that the caller can carry out
> the transfer using PIO mode.
> (Current callers already have this backup path in place).
>
> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Cc: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>

Tested-by: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch is verified OK about g_ether function on beagle xM board,
but the revised patch "usb: musb: gadget: Unmapping the dma buffer
when switching to PIO mode" [1] should be applied first.

> ---
> Patch based on linux-next as of 20101029.
>
> I believe Blackfin is also affected by this, but I'm not sure how
> they're working around this. Mike?

MUSB on Blackfin will fallback to PIO too, so no any working around
for it, right?

>
> =A0drivers/usb/musb/musbhsdma.c | =A0 14 ++++++++++++++
> =A01 file changed, 14 insertions(+)
>
> Index: mainline/drivers/usb/musb/musbhsdma.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- mainline.orig/drivers/usb/musb/musbhsdma.c
> +++ mainline/drivers/usb/musb/musbhsdma.c
> @@ -158,6 +158,8 @@ static int dma_channel_program(struct dm
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_ad=
dr_t dma_addr, u32 len)
> =A0{
> =A0 =A0 =A0 =A0struct musb_dma_channel *musb_channel =3D channel->pri=
vate_data;
> + =A0 =A0 =A0 struct musb_dma_controller *controller =3D musb_channel=
->controller;
> + =A0 =A0 =A0 struct musb *musb =3D controller->private_data;
>
> =A0 =A0 =A0 =A0DBG(2, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mo=
de %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0musb_channel->epnum,
> @@ -167,6 +169,18 @@ static int dma_channel_program(struct dm
> =A0 =A0 =A0 =A0BUG_ON(channel->status =3D=3D MUSB_DMA_STATUS_UNKNOWN =
||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0channel->status =3D=3D MUSB_DMA_STATUS=
_BUSY);
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The DMA engine in RTL1.8 and above cannot handle
> + =A0 =A0 =A0 =A0* DMA addresses that are not aligned to a 4 byte bou=
ndary.
> + =A0 =A0 =A0 =A0* It ends up masking the last two bits of the addres=
s
> + =A0 =A0 =A0 =A0* programmed in DMA_ADDR.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* Fail such DMA transfers, so that the backup PIO mo=
de
> + =A0 =A0 =A0 =A0* can carry out the transfer
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if ((musb->hwvers >=3D MUSB_HWVERS_1800) && (dma_addr %=
4))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> +
> =A0 =A0 =A0 =A0channel->actual_len =3D 0;
> =A0 =A0 =A0 =A0musb_channel->start_addr =3D dma_addr;
> =A0 =A0 =A0 =A0musb_channel->len =3D len;
>

[1], http://marc.info/?l=3Dlinux-usb&m=3D128532510705381&w=3D2

--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
