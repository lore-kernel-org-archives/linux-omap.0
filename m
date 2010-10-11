From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: g_ether broken on musb
Date: Mon, 11 Oct 2010 23:09:23 +0800
Message-ID: <AANLkTi=CZamgsj++w4_v=EEdkL1NAQRxZyJ2aWBVyK3m@mail.gmail.com>
References: <AANLkTinVTKaJ9XcL7rbnBMmw0dLEJqQKZEQ=ypk3tikV@mail.gmail.com>
	<AANLkTin0_RR+m5-BArOhWAGhJY4Mvd3mE53nzEK-9YRk@mail.gmail.com>
	<AANLkTi=gw7EzLdhBPrLkraRtuRiE5e9oUC5LOxGHfReU@mail.gmail.com>
	<AANLkTintN9anKx1JVGVjusyEX9Q9cr-Bo_oiNdkvwa_m@mail.gmail.com>
	<AANLkTimfCnCL6NzJEThNDSeNx_Axxdyct88-hyDFQvjJ@mail.gmail.com>
	<AANLkTik5X=ypNxu4QgiLUFia0b42T=r-Di1MsZCrCsCx@mail.gmail.com>
	<AANLkTikRe-U4sXPW6U7obCQen-wT=f6JC9wsH5hG04G6@mail.gmail.com>
	<AANLkTin7PBPvHOpRJPh1_nABxhvTYNDJtVEGXUWN0mtF@mail.gmail.com>
	<AANLkTik_MNGaMRBBpX3_sPTwF9+en=qX=O52DrfLTGuW@mail.gmail.com>
	<AANLkTikcMaQZViXOBWM3roiyOZcpUzjAqV49k=4pMA+9@mail.gmail.com>
	<AANLkTinonnO05D9Y5oGrpMZLT6rYT_5sUp9_RSONDLfr@mail.gmail.com>
	<AANLkTikMbMFWp4GqZqF1csU1GOfGypcCteFZx_KPJxqx@mail.gmail.com>
	<AANLkTin21EYbvm68smSL9132rGh5GAYCQmTaCkJE2yGr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTin21EYbvm68smSL9132rGh5GAYCQmTaCkJE2yGr-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2010/10/11 Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> On Mon, Oct 11, 2010 at 1:53 PM, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
>> 2010/10/11 Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>>> which effectively disables DMA due to a bug in it, so it's probab=
ly
>>>>> DMA problems on my board. Here is my log:
>>>>
>>>> Yes, your issue may be related with ep1out Rx DMA, but I am not su=
re
>>>> since the very important message between timestamp 39.256011 and
>>>> 85.210693 is not provided by you, why not post all messages?
>>>
>>> I did not remove any messages (only added annotation), there was
>>> simply no output. I suppose something wrong happens after
>>
>> If so, no any rx interrupt for ep1out comes after request is queued =
since
>> musb_g_rx is not called from your log.
>>
>> There is two possibilities:
>>
>> =A0 =A0 =A0 =A0 - usb host does not send any packets to ep1out
>>
>> =A0 =A0 =A0 =A0 - packets has been sent from usb host to musb gadget=
, but omap3
>> =A0 =A0 =A0 =A0 =A0is not notified by musb rx interrupt, or there is=
 no musb rx
>> interrupt.
>>
>> You can trace usb traffic in usb host to see if there are packets se=
nt
>> to ep1out, usbmon can do it for you, please see Documentation/usb/us=
bmon.txt
>> for reference. =A0If no packets are traced for ep1out, your problem =
is nothing
>> to do with musb, and may should be related with usb host driver(usbn=
et?).
>
> ok here are usbmon logs, taken using same scenario:
> http://notaz.gp2x.de/misc/pnd/linux_next_20101008_usbmon
>
> and here is usbmon log when musb runs in PIO mode and ping works:
> http://notaz.gp2x.de/misc/pnd/linux_next_20101008_usbmon_nodma
>
> So maybe it's ep2in issue after all?
>

Yes, it is really with ep2in, and musb ep2in always return more data to
host so cause overflow in host.

I see what triggered your issue, please try the patch in the link below=
:

       http://marc.info/?l=3Dlinux-usb&m=3D128576496614332&w=3D2


--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
