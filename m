From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: g_ether broken on musb
Date: Fri, 8 Oct 2010 18:17:09 +0800
Message-ID: <AANLkTik5X=ypNxu4QgiLUFia0b42T=r-Di1MsZCrCsCx@mail.gmail.com>
References: <AANLkTinVTKaJ9XcL7rbnBMmw0dLEJqQKZEQ=ypk3tikV@mail.gmail.com>
	<AANLkTin0_RR+m5-BArOhWAGhJY4Mvd3mE53nzEK-9YRk@mail.gmail.com>
	<AANLkTi=gw7EzLdhBPrLkraRtuRiE5e9oUC5LOxGHfReU@mail.gmail.com>
	<AANLkTintN9anKx1JVGVjusyEX9Q9cr-Bo_oiNdkvwa_m@mail.gmail.com>
	<AANLkTimfCnCL6NzJEThNDSeNx_Axxdyct88-hyDFQvjJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimfCnCL6NzJEThNDSeNx_Axxdyct88-hyDFQvjJ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2010/10/8 Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> I have tried patch-v2.6.36-rc6-next-20101006 on my beagle B5, seems
>> no such problem.
>
> Did you try booting with the cable attached? The problem only shows u=
p

Yes, my beagle is powered by usb cable connected with PC.

> if I boot the board with cable attached, no such problem after replug=
=2E
> I also have g_ether compiled into kernel, maybe that makes a

I use g_ether module, which may avoid your problem? Seems not possible,
but you may have a try...

> difference. Could also be bootloader messing things up..
>
>> Are your musb working at fullspeed? =A0I know musb at fullspeed has =
bee
>> broken for some time.
>
> I think it's hi-speed, PC lists the gadget attached to EHCI root hub
> (not sure how to confirm).
>

If the gadget device is in the same bus with ehci root hub, which can b=
e
observed from'/proc/bus/usb/devices', it is high speed.

Also, you may take Gadiyar's suggestion to post your musb debug info.

thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
