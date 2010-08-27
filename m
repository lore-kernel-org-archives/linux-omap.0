From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] USB: musb-gadget: fix bulk IN infinite hangs in
 double buffer case
Date: Fri, 27 Aug 2010 23:01:27 +0800
Message-ID: <AANLkTinY5XoknTuB670atr5dRHPgF0bL0t4qD+_HxXws@mail.gmail.com>
References: <1282909040-2936-1-git-send-email-tom.leiming@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0328C1CB42@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CB42-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2010/8/27 Gadiyar, Anand <gadiyar-l0cyMroinI0@public.gmane.org>:
> tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> This patch fixes one infinite hang of bulk IN transfer in double buf=
fer
>> case, the hang can be observed easily by test #6 of usbtest if musb =
is
>> configured as g_zero and fifo mode 3 is taken to enable double fifo.
>>
>> In fact, the patch only removes the check for non-empty fifo before
>> loading data from new request into fifo since the check is
>> not correct:
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
>
> For OMAPs,
> Acked-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
>
> I sent out this patch a while ago [1]. I've tested it on
> OMAP3 and OMAP4 silicon.

Oh, I did not see your patch before,  you have seen the issue
for long time,  why not merge into mainline?

>
> It does look like a logic bug to me, but I'd like the Blackfin
> and Davinci guys to take a look at the code as well.
>
> - Anand
>
> [1] <http://marc.info/?l=3Dlinux-usb&m=3D127055442703499&w=3D2>
>
>> ---
>> =A0drivers/usb/musb/musb_gadget.c | =A0 12 ------------
>> =A01 files changed, 0 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_=
gadget.c
>> index 550b397..e0bd1c1 100644
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
>> --
>> 1.6.2.5
>>
>>



--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
