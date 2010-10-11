From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: g_ether broken on musb
Date: Mon, 11 Oct 2010 13:25:04 +0300
Message-ID: <AANLkTinonnO05D9Y5oGrpMZLT6rYT_5sUp9_RSONDLfr@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48780 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0JKKZG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 06:25:06 -0400
In-Reply-To: <AANLkTikcMaQZViXOBWM3roiyOZcpUzjAqV49k=4pMA+9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Anand Gadiyar <gadiyar@ti.com>

>> which effectively disables DMA due to a bug in it, so it's probably
>> DMA problems on my board. Here is my log:
>
> Yes, your issue may be related with ep1out Rx DMA, but I am not sure
> since the very important message between timestamp 39.256011 and
> 85.210693 is not provided by you, why not post all messages?

I did not remove any messages (only added annotation), there was
simply no output. I suppose something wrong happens after

[   29.816711] txstate 286: ep2in old packet still ready , txcsr 2003

There should be an interrupt?

> If possible, please provide all the debug message instead of just selecting
> part of them.

The log I posted is full, I do not get any more output.
