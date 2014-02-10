From: Kevin Hilman <khilman@linaro.org>
Subject: Re: regression(ti platforms): next-20140210 (ehci?)
Date: Mon, 10 Feb 2014 10:28:54 -0800
Message-ID: <7h61omakk9.fsf@paris.lan>
References: <52F8F77B.70605@ti.com> <52F9117C.8000405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:55504 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbaBJS25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Feb 2014 13:28:57 -0500
Received: by mail-pd0-f173.google.com with SMTP id y10so6427420pdj.32
        for <linux-omap@vger.kernel.org>; Mon, 10 Feb 2014 10:28:57 -0800 (PST)
In-Reply-To: <52F9117C.8000405@ti.com> (Roger Quadros's message of "Mon, 10
	Feb 2014 19:50:52 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-usb@vger.kernel.org, "Balbi, Felipe" <balbi@ti.com>, linux-next@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Roger Quadros <rogerq@ti.com> writes:

> +devicetree
>
> On 02/10/2014 05:59 PM, Nishanth Menon wrote:
>> Hi,
>> 
>> A quick note to report that I saw regression in today's next tag (logs
>> indicate around EHCI) boot on various TI platforms:
>> 
>> Note: crane and sdp2430 are not expected to pass with
>> multi_v7_defconfig (note: omap2plus_defconfig boot seems to be sane
>> but USB is disabled there)
>> 
>> next-20140210-multi_v7_defconfig
>>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2zYHdPb94
>>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2UChLyzSE
>>  3: am3517-evm:  Boot FAIL: http://slexy.org/raw/s20Br9XLO1
>> around ehci
>> 
>>  4:  am37x-evm:  Boot FAIL: http://slexy.org/raw/s20mVz9Wc7
>> around ehci
>> 
>>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2byveBYtT
>>  6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s21sOgJNwK
>> around ehci
>> 
>>  7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s2ovVNAmO7
>>  8:      crane: No Image built - Missing platform support?:
>>  9:       dra7:  Boot PASS: http://slexy.org/raw/s217qwaXsM
>> 10:        ldp:  Boot FAIL: http://slexy.org/raw/s203IvjE23
>> around ehci
>> 
>> 11: PandaBoard-ES:  Boot FAIL: http://slexy.org/raw/s2NvkRx2YJ
>> around ehci
>
> I think the problem is that ehci-platform driver gets loaded instead of ehci-omap.
>
> In the DT node we have compatible ids for both. e.g. for omap4.dtsi
>
>                         usbhsehci: ehci@4a064c00 {
>                                 compatible = "ti,ehci-omap", "usb-ehci";
>                                 reg = <0x4a064c00 0x400>;
>                                 interrupt-parent = <&gic>;
>                                 interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>                         };
>
> Shouldn't ehci-omap driver be getting a higher priority than usb-ehci?
>
> A quick fix would be to eliminate "usb-ehci" from the DT node of all failing platforms.

I can confirm that simply remvoing usb-ehci from omap[34].dtsi nodes
fixed the problem for me on 3530/overo, 3730/beagle-xM and
4460/panda-es.  But I don't think that's the right fix.  First we have
to figure out why ehci-omap stopped getting loaded first.

Kevin
