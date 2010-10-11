From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: g_ether broken on musb
Date: Mon, 11 Oct 2010 15:45:37 +0300
Message-ID: <AANLkTin21EYbvm68smSL9132rGh5GAYCQmTaCkJE2yGr@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTikMbMFWp4GqZqF1csU1GOfGypcCteFZx_KPJxqx-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 11, 2010 at 1:53 PM, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
> 2010/10/11 Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>> which effectively disables DMA due to a bug in it, so it's probabl=
y
>>>> DMA problems on my board. Here is my log:
>>>
>>> Yes, your issue may be related with ep1out Rx DMA, but I am not sur=
e
>>> since the very important message between timestamp 39.256011 and
>>> 85.210693 is not provided by you, why not post all messages?
>>
>> I did not remove any messages (only added annotation), there was
>> simply no output. I suppose something wrong happens after
>
> If so, no any rx interrupt for ep1out comes after request is queued s=
ince
> musb_g_rx is not called from your log.
>
> There is two possibilities:
>
> =A0 =A0 =A0 =A0 - usb host does not send any packets to ep1out
>
> =A0 =A0 =A0 =A0 - packets has been sent from usb host to musb gadget,=
 but omap3
> =A0 =A0 =A0 =A0 =A0is not notified by musb rx interrupt, or there is =
no musb rx
> interrupt.
>
> You can trace usb traffic in usb host to see if there are packets sen=
t
> to ep1out, usbmon can do it for you, please see Documentation/usb/usb=
mon.txt
> for reference. =A0If no packets are traced for ep1out, your problem i=
s nothing
> to do with musb, and may should be related with usb host driver(usbne=
t?).

ok here are usbmon logs, taken using same scenario:
http://notaz.gp2x.de/misc/pnd/linux_next_20101008_usbmon

and here is usbmon log when musb runs in PIO mode and ping works:
http://notaz.gp2x.de/misc/pnd/linux_next_20101008_usbmon_nodma

So maybe it's ep2in issue after all?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
