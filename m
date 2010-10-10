From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: g_ether broken on musb
Date: Sun, 10 Oct 2010 21:30:44 +0300
Message-ID: <AANLkTik_MNGaMRBBpX3_sPTwF9+en=qX=O52DrfLTGuW@mail.gmail.com>
References: <AANLkTinVTKaJ9XcL7rbnBMmw0dLEJqQKZEQ=ypk3tikV@mail.gmail.com>
	<AANLkTin0_RR+m5-BArOhWAGhJY4Mvd3mE53nzEK-9YRk@mail.gmail.com>
	<AANLkTi=gw7EzLdhBPrLkraRtuRiE5e9oUC5LOxGHfReU@mail.gmail.com>
	<AANLkTintN9anKx1JVGVjusyEX9Q9cr-Bo_oiNdkvwa_m@mail.gmail.com>
	<AANLkTimfCnCL6NzJEThNDSeNx_Axxdyct88-hyDFQvjJ@mail.gmail.com>
	<AANLkTik5X=ypNxu4QgiLUFia0b42T=r-Di1MsZCrCsCx@mail.gmail.com>
	<AANLkTikRe-U4sXPW6U7obCQen-wT=f6JC9wsH5hG04G6@mail.gmail.com>
	<AANLkTin7PBPvHOpRJPh1_nABxhvTYNDJtVEGXUWN0mtF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTin7PBPvHOpRJPh1_nABxhvTYNDJtVEGXUWN0mtF-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

hello,

> Reproduce the test with your setup script, no your 'ping' issue
> happened on my beagle B5.

ok I've updated to next-20101008 (from next-20101006) and the network
no longer works at all on fresh boot, it starts working only after
replugging the cable. I think it's because patch "usb: musb: gadget:
Unmapping the dma buffer when switching to PIO mode" was dropped,
which effectively disables DMA due to a bug in it, so it's probably
DMA problems on my board. Here is my log:

http://notaz.gp2x.de/misc/pnd/linux_next_20101008_musb

There is some lock backtrace in the log, but I don't think it's
related, as with "Unmapping the dma buffer when switching to PIO mode"
patch network works, but I guess I lose DMA.
I'm using omap2plus_defconfig with OMAP2 and OMAP4 disabled (otherwise
did not boot for some reason), and musb, g_ether and earlyprintk
enabled.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
