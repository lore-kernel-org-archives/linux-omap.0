From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] USB: musb-gadget: fix OUT transfer in double buffer case
Date: Fri, 27 Aug 2010 22:23:12 +0800
Message-ID: <AANLkTikogXSNmjb5VFP15jaj6_VCodBFzCina-DdpSXc@mail.gmail.com>
References: <1282909068-2968-1-git-send-email-tom.leiming@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0328C1CB4B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CB4B-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Thanks for your review.

2010/8/27 Gadiyar, Anand <gadiyar-l0cyMroinI0@public.gmane.org>:
> tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> This patch fixes two bugs of OUT transfer in double buffer case:
>>
>> =A0 =A0 =A0 -USE_MODE1 should be enabled except for ANOMALY_05000456=
 case, or
>> =A0 =A0 =A0 else may cause infinite hang and data error bug in doubl=
e buffer
>>
>
> Double buffering should still work with or without mode1 DMA.
> I'm not sure using Mode1 DMA is the fix for enabling double buffering=
=2E

I see why enabling mode 1 may fix the TX transfer in double buffer case=
=2E

We only enable auto clear for dma mode 1 case and for dma mode 0,
so it should be a bug.

>
>> =A0 =A0 =A0 -DMA length should not go beyond the availabe space of r=
equest buffer
>>
>> Without this patch, test #5 of usbtest can't be passed if we configu=
re musb as
>> g_zero and use fifo mode 3 to enable double buffer mode.
>>
>> With this patch, on my beagle B5, test#5(queued bulk out) may go bey=
ond 14Mbyte/s
>> if musb is configured as g_zero and fifo mode 3 is taken, follows th=
e test command:
>>
>> =A0 =A0 =A0 #./testusb -D DEV_NAME -c 1024 -t 5 -s 32768 -g 8 =A0 [1=
]
>>
>> [1],
>> =A0 =A0 -source of testusb : tools/usb/testusb.c under linux kernel;
>>
>> Signed-off-by: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
>> Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
>> Cc: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
>
> The DMA length part is a good fix. However, I'm not so sure I like th=
e
> combining of the MODE1 RX change here.

I will submit two patches to fix the issue, one is to add  'auto clear'
for both dma 0 and dma 1, another fix the DMA length.  I will submit th=
e
two patches later for your review.

>
> With current code, only g_zero and g_file_storage work well with
> Mode1 DMA RX. g_ether used to break (have not tested recently with mo=
de1).
> Did you test g_ether with your patch?

Yes, I test the g_ether just now and find it is broken with the previou=
s patch.

>
> We know that at least on OMAPs, MODE1 DMA RX works reliably with patc=
hes
> Felipe submitted last December. These have not been resubmitted and w=
e're
> waiting on that.
>
> - Anand
>
>
>>
>> ---
>> =A0drivers/usb/musb/musb_dma.h =A0 =A0| =A0 =A02 ++
>> =A0drivers/usb/musb/musb_gadget.c | =A0 =A05 +++--
>> =A02 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma=
=2Eh
>> index 916065b..dff91ce 100644
>> --- a/drivers/usb/musb/musb_dma.h
>> +++ b/drivers/usb/musb/musb_dma.h
>> @@ -89,6 +89,8 @@ struct musb_hw_ep;
>> =A0# if !ANOMALY_05000456
>> =A0# =A0define USE_MODE1
>> =A0# endif
>> +#else
>> +# =A0define USE_MODE1
>> =A0#endif
>>
>> =A0/*
>> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_=
gadget.c
>> index e0bd1c1..f1c44b9 100644
>> --- a/drivers/usb/musb/musb_gadget.c
>> +++ b/drivers/usb/musb/musb_gadget.c
>> @@ -662,10 +662,11 @@ static void rxstate(struct musb *musb,
>> struct musb_request *req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (requ=
est->actual < request->length) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 int transfer_size =3D 0;
>> =A0#ifdef USE_MODE1
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 transfer_size =3D min(request->length,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 transfer_size =3D min(request->length - request->actual,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 channel->max_len);
>> =A0#else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 transfer_size =3D len;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 transfer_size =3D min(request->length - request->actual,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len);
>> =A0#endif
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if (transfer_size <=3D musb_ep->packet_sz)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 musb_ep->dma->desired_mode =3D 0;
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
