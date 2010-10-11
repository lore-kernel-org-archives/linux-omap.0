From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: g_ether broken on musb
Date: Mon, 11 Oct 2010 18:08:06 +0800
Message-ID: <AANLkTikcMaQZViXOBWM3roiyOZcpUzjAqV49k=4pMA+9@mail.gmail.com>
References: <AANLkTinVTKaJ9XcL7rbnBMmw0dLEJqQKZEQ=ypk3tikV@mail.gmail.com>
	<AANLkTin0_RR+m5-BArOhWAGhJY4Mvd3mE53nzEK-9YRk@mail.gmail.com>
	<AANLkTi=gw7EzLdhBPrLkraRtuRiE5e9oUC5LOxGHfReU@mail.gmail.com>
	<AANLkTintN9anKx1JVGVjusyEX9Q9cr-Bo_oiNdkvwa_m@mail.gmail.com>
	<AANLkTimfCnCL6NzJEThNDSeNx_Axxdyct88-hyDFQvjJ@mail.gmail.com>
	<AANLkTik5X=ypNxu4QgiLUFia0b42T=r-Di1MsZCrCsCx@mail.gmail.com>
	<AANLkTikRe-U4sXPW6U7obCQen-wT=f6JC9wsH5hG04G6@mail.gmail.com>
	<AANLkTin7PBPvHOpRJPh1_nABxhvTYNDJtVEGXUWN0mtF@mail.gmail.com>
	<AANLkTik_MNGaMRBBpX3_sPTwF9+en=qX=O52DrfLTGuW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41461 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab0JKKII (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 06:08:08 -0400
In-Reply-To: <AANLkTik_MNGaMRBBpX3_sPTwF9+en=qX=O52DrfLTGuW@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Anand Gadiyar <gadiyar@ti.com>

Hi,

2010/10/11 Grazvydas Ignotas <notasas@gmail.com>:
> hello,
>
>> Reproduce the test with your setup script, no your 'ping' issue
>> happened on my beagle B5.
>
> ok I've updated to next-20101008 (from next-20101006) and the network
> no longer works at all on fresh boot, it starts working only after
> replugging the cable. I think it's because patch "usb: musb: gadget:
> Unmapping the dma buffer when switching to PIO mode" was dropped,

If the patch is not dropped, DMA will not be used to unload fifo for out ep,
otherwise DMA will be used for out ep.

> which effectively disables DMA due to a bug in it, so it's probably
> DMA problems on my board. Here is my log:

Yes, your issue may be related with ep1out Rx DMA, but I am not sure
since the very important message between timestamp 39.256011 and
85.210693 is not provided by you, why not post all messages?

So we can't know if there are any rx interrupts after requests are queued
into ep1out queue, then don't know anything about the dma handling after
rx interrupt comes.

If possible, please provide all the debug message instead of just selecting
part of them.

Except for above, no other abnormal things wrt. musb are found from
your log.

>
> http://notaz.gp2x.de/misc/pnd/linux_next_20101008_musb
>
> There is some lock backtrace in the log, but I don't think it's

It is lockdep warning, which touches me too, nothing to do
with your issue.

> related, as with "Unmapping the dma buffer when switching to PIO mode"
> patch network works, but I guess I lose DMA.
> I'm using omap2plus_defconfig with OMAP2 and OMAP4 disabled (otherwise
> did not boot for some reason), and musb, g_ether and earlyprintk
> enabled.
>


thanks,
-- 
Lei Ming
