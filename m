From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: g_ether broken on musb
Date: Sun, 10 Oct 2010 11:49:22 +0800
Message-ID: <AANLkTin7PBPvHOpRJPh1_nABxhvTYNDJtVEGXUWN0mtF@mail.gmail.com>
References: <AANLkTinVTKaJ9XcL7rbnBMmw0dLEJqQKZEQ=ypk3tikV@mail.gmail.com>
	<AANLkTin0_RR+m5-BArOhWAGhJY4Mvd3mE53nzEK-9YRk@mail.gmail.com>
	<AANLkTi=gw7EzLdhBPrLkraRtuRiE5e9oUC5LOxGHfReU@mail.gmail.com>
	<AANLkTintN9anKx1JVGVjusyEX9Q9cr-Bo_oiNdkvwa_m@mail.gmail.com>
	<AANLkTimfCnCL6NzJEThNDSeNx_Axxdyct88-hyDFQvjJ@mail.gmail.com>
	<AANLkTik5X=ypNxu4QgiLUFia0b42T=r-Di1MsZCrCsCx@mail.gmail.com>
	<AANLkTikRe-U4sXPW6U7obCQen-wT=f6JC9wsH5hG04G6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTikRe-U4sXPW6U7obCQen-wT=f6JC9wsH5hG04G6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,


2010/10/9 Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> Also, you may take Gadiyar's suggestion to post your musb debug info=
=2E
>
> Thanks for ideas, I've found why it happens for me. It's because my
> network setup script looks like this:
> ifconfig usb0 10.0.1.2 down
> ifconfig usb0 10.0.1.2 up
>
> So to reproduce, just load up g_ether, and run:
> # ifconfig usb0 10.0.1.2 down
> (must be with IP, it somehow affects things)

Reproduce the test with your setup script, no your 'ping' issue
happened on my beagle B5.

> Then I get:
> [ =A0 21.253662] musb_gadget_queue 1211: <=3D=3D to ep1out request=3D=
c193ed00
> [ =A0 21.260192] musb_ep_restart 1179: <=3D=3D RX/OUT request c193ed0=
0 len
> 1536 on hw_ep1
> [ =A0 21.267974] musb_gadget_queue 1211: <=3D=3D to ep1out request=3D=
c193ed40
> ...
> [ =A0 21.319854] musb_gadget_queue 1211: <=3D=3D to ep1out request=3D=
c193ef40
> [ =A0 21.326751] musb_gadget_disable 1129: ep1in
> [ =A0 21.331115] musb_g_giveback 186: ep1out request c193ed00, 0/1536=
 fault -108
> [ =A0 21.338409] musb_g_giveback 186: ep1out request c193ed40, 0/1536=
 fault -108
> [ =A0 21.345672] musb_g_giveback 18ut request c193ed80, 0/1536 fault =
-108
> [ =A0 21.352966] musb_g_giveback 186: ep1out request c193edc0, 0/1536=
 fault -108
> [ =A0 21.360229] musb_g_giveback 186: ep1out request c193ee00, 0/1536=
 fault -108
> [ =A0 21.367523] musb_g_giveback 186: ep1out request c193ee40, 0/1536=
 fault -108
> [ =A0 21.374786] musb_g_giveback 186: ep1out request c193ee80, 0/1536=
 fault -108
> [ =A0 21.382049] musb_g_giveback 186: ep1out request c193eec0, 0/1536=
 fault -108
> [ =A0 21.389343] musb_g_giveback 186: ep1out request c193ef00, 0/1536=
 fault -108
> [ =A0 21.396606] musb_g_giveback 186: ep1out request c193ef40, 0/1536=
 fault -108
> [ =A0 21.403869] musb_gadget_disable 1129: ep1out
> [ =A0 21.408355] musb_hdrc periph: enabled ep1in for bulk IN, dma, ma=
xpacket 512
> [ =A0 21.415618] musb_hdrc periph: enabled ep1out for bulk OUT, dma, =
maxpacket 512

The log info above is very normal and caused by 'ifconfig usb0 down',
so it is useless.

> (my serial is dropping some output, it's due to my hardware)
>
> At this point musb begins acting up, but seems to recover after some
> cable replugs.
>

We need the musb log info when the ping packet is out of order or lost,
instead of the log info triggered by 'ifconfig usb0 down' only.

Also I suggest you capture the ethernet interface traffic first, then
enable musg debug switch and post musb debug message out if the
ethernet traffic is OK but 'ping' is still not OK since your issue may =
be
related network instead of musb driver.

thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
