From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: g_ether broken on musb
Date: Mon, 11 Oct 2010 21:49:13 +0300
Message-ID: <AANLkTik3vesFe-RTfm1ogkN9X8kcOXtUeTGgRR+PQwJc@mail.gmail.com>
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
	<AANLkTi=CZamgsj++w4_v=EEdkL1NAQRxZyJ2aWBVyK3m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=CZamgsj++w4_v=EEdkL1NAQRxZyJ2aWBVyK3m-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

>> So maybe it's ep2in issue after all?
>>
>
> Yes, it is really with ep2in, and musb ep2in always return more data =
to
> host so cause overflow in host.
>
> I see what triggered your issue, please try the patch in the link bel=
ow:
>
> =A0 =A0 =A0 http://marc.info/?l=3Dlinux-usb&m=3D128576496614332&w=3D2

This has fixed my problem, thank you!
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
