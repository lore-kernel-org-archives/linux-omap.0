From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] USB: musb-gadget: fix bulk IN infinite hangs in
 double buffer case
Date: Sat, 28 Aug 2010 10:51:47 +0800
Message-ID: <AANLkTimcRHayXoVr8UaOrDV0F_cD6owW06fSBGpEXc8L@mail.gmail.com>
References: <1282909040-2936-1-git-send-email-tom.leiming@gmail.com>
	<201008271627.08137.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201008271627.08137.vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2010/8/28 Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>:
> On Friday, August 27, 2010 07:37:20 tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> This patch fixes one infinite hang of bulk IN transfer in double buf=
fer
>> case, the hang can be observed easily by test #6 of usbtest if musb =
is
>> configured as g_zero and fifo mode 3 is taken to enable double fifo.
>>
>> In fact, the patch only removes the check for non-empty fifo before
>> loading data from new request into fifo since the check is not corre=
ct:
>>
>> =A0 =A0 =A0 -in double buffer case, fifo may accommodate more than o=
ne packet,
>> =A0 =A0 =A0 even though it has contained one packet already and is n=
on-empty
>>
>> =A0 =A0 =A0 -since last DMA is completed before calling musb_g_tx, i=
t is sure
>> =A0 =A0 =A0 that fifo may accommodate at least one packet
>>
>> Without applying the patch, new requst enqueued from .complte may no=
t
>> have a chance to be loaded into fifo, then will never be completed a=
nd
>> cause infinite hangs.
>>
>> With the patch, on my beagle B5, test#6(queued bulk in) can be passe=
d and
>> test result may go beyond 33Mbyte/s if musb is configured as g_zero =
and
>> fifo mode 3 is taken, follows the test command:
>>
>> =A0 =A0 =A0 #testusb -D DEV_NAME -c 1024 -t 6 -s 32768 -g 8 =A0 [1]
>>
>> [1],
>> =A0 =A0 -source of testusb : tools/usb/testusb.c under linux kernel;
>>
>> Signed-off-by: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
>> Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
>> Cc: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
>>
>> ---
>> =A0drivers/usb/musb/musb_gadget.c | =A0 12 ------------
>> =A01 files changed, 0 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_gadget.c
>> b/drivers/usb/musb/musb_gadget.c index 550b397..e0bd1c1 100644
>> --- a/drivers/usb/musb/musb_gadget.c
>> +++ b/drivers/usb/musb/musb_gadget.c
>> @@ -506,18 +506,6 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* ... or if not, then c=
omplete it. */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_g_giveback(musb_ep,=
 request, 0);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Kickstart next transf=
er if appropriate;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the packet that just =
completed might not
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* be transmitted for ho=
urs or days.
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* REVISIT for double bu=
ffering...
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* FIXME revisit for sta=
lls too...
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_ep_select(mbase, epnu=
m);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csr =3D musb_readw(epio, M=
USB_TXCSR);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (csr & MUSB_TXCSR_FIFON=
OTEMPTY)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 request =3D musb_ep->des=
c ? next_request(musb_ep) : NULL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!request) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG(4, "=
%s idle now\n",
>
> maybe this change will make a difference ?

No,  only your change can not prevent the infinite  hangs for OUT trans=
fer,
see the explanation in my commit log. Even the change may cause infinit=
e
hangs  again, once return if request->actual is less than request->leng=
th,
musb will stop loading data from requst->buf into fifo, so hangs...

> From 13fa6c9cec387893e2b22db6c055028f96fea5b8 Mon Sep 17 00:00:00 200=
1
> From: Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Date: Fri, 3 Jul 2009 06:32:02 +0000
> Subject: [PATCH] USB: musb: only complete the request when all data h=
as been
> transfered [local/log]
>
> bug[#5269],bug[#5268],bug[#5264]only complete the request when all da=
ta has
> been transfered

Oh, another local change...

>
> git-svn-id: svn://localhost/svn/linux-kernel/trunk@6915 526b6c2d-f592=
-4532-
> a319-5dd88ccb003d
> ---
> =A0drivers/usb/musb/musb_gadget.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_g=
adget.c
> index 6fca870..f019843 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -500,6 +500,8 @@ void musb_g_tx(struct musb *musb, u8 epnum)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0| MUSB_TXCSR_TXPKTRDY);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reques=
t->zero =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (request->actual < r=
equest->length)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;

As said above, this change above should be wrong, follows the fix which
may complete request only if data is transfered over for the request.

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gad=
get.c
index e898228..1cf6d28 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -503,14 +503,14 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 				request->zero =3D 0;
 			}

-			/* ... or if not, then complete it. */
-			musb_g_giveback(musb_ep, request, 0);
