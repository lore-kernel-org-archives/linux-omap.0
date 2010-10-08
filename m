From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: g_ether broken on musb
Date: Fri, 8 Oct 2010 23:25:26 +0300
Message-ID: <AANLkTikRe-U4sXPW6U7obCQen-wT=f6JC9wsH5hG04G6@mail.gmail.com>
References: <AANLkTinVTKaJ9XcL7rbnBMmw0dLEJqQKZEQ=ypk3tikV@mail.gmail.com>
	<AANLkTin0_RR+m5-BArOhWAGhJY4Mvd3mE53nzEK-9YRk@mail.gmail.com>
	<AANLkTi=gw7EzLdhBPrLkraRtuRiE5e9oUC5LOxGHfReU@mail.gmail.com>
	<AANLkTintN9anKx1JVGVjusyEX9Q9cr-Bo_oiNdkvwa_m@mail.gmail.com>
	<AANLkTimfCnCL6NzJEThNDSeNx_Axxdyct88-hyDFQvjJ@mail.gmail.com>
	<AANLkTik5X=ypNxu4QgiLUFia0b42T=r-Di1MsZCrCsCx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39587 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757026Ab0JHUZa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 16:25:30 -0400
In-Reply-To: <AANLkTik5X=ypNxu4QgiLUFia0b42T=r-Di1MsZCrCsCx@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Anand Gadiyar <gadiyar@ti.com>

> Also, you may take Gadiyar's suggestion to post your musb debug info.

Thanks for ideas, I've found why it happens for me. It's because my
network setup script looks like this:
ifconfig usb0 10.0.1.2 down
ifconfig usb0 10.0.1.2 up

So to reproduce, just load up g_ether, and run:
# ifconfig usb0 10.0.1.2 down
(must be with IP, it somehow affects things)

Then I get:
[   21.253662] musb_gadget_queue 1211: <== to ep1out request=c193ed00
[   21.260192] musb_ep_restart 1179: <== RX/OUT request c193ed00 len
1536 on hw_ep1
[   21.267974] musb_gadget_queue 1211: <== to ep1out request=c193ed40
...
[   21.319854] musb_gadget_queue 1211: <== to ep1out request=c193ef40
[   21.326751] musb_gadget_disable 1129: ep1in
[   21.331115] musb_g_giveback 186: ep1out request c193ed00, 0/1536 fault -108
[   21.338409] musb_g_giveback 186: ep1out request c193ed40, 0/1536 fault -108
[   21.345672] musb_g_giveback 18ut request c193ed80, 0/1536 fault -108
[   21.352966] musb_g_giveback 186: ep1out request c193edc0, 0/1536 fault -108
[   21.360229] musb_g_giveback 186: ep1out request c193ee00, 0/1536 fault -108
[   21.367523] musb_g_giveback 186: ep1out request c193ee40, 0/1536 fault -108
[   21.374786] musb_g_giveback 186: ep1out request c193ee80, 0/1536 fault -108
[   21.382049] musb_g_giveback 186: ep1out request c193eec0, 0/1536 fault -108
[   21.389343] musb_g_giveback 186: ep1out request c193ef00, 0/1536 fault -108
[   21.396606] musb_g_giveback 186: ep1out request c193ef40, 0/1536 fault -108
[   21.403869] musb_gadget_disable 1129: ep1out
[   21.408355] musb_hdrc periph: enabled ep1in for bulk IN, dma, maxpacket 512
[   21.415618] musb_hdrc periph: enabled ep1out for bulk OUT, dma, maxpacket 512
(my serial is dropping some output, it's due to my hardware)

At this point musb begins acting up, but seems to recover after some
cable replugs.
