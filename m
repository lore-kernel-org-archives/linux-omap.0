From: Felipe Balbi <balbi@ti.com>
Subject: Re: beagleboard-xm network with mainline?
Date: Tue, 7 Dec 2010 12:38:41 +0200
Message-ID: <20101207103841.GW2576@legolas.emea.dhcp.ti.com>
References: <Pine.LNX.4.64.1012071042220.10621@axis700.grange>
 <20101207094924.GP2576@legolas.emea.dhcp.ti.com>
 <Pine.LNX.4.64.1012071054430.10621@axis700.grange>
 <20101207101223.GS2576@legolas.emea.dhcp.ti.com>
 <Pine.LNX.4.64.1012071113320.10621@axis700.grange>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47766 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754469Ab0LGKip (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 05:38:45 -0500
Received: by eyd10 with SMTP id 10so6842839eyd.3
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 02:38:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1012071113320.10621@axis700.grange>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

On Tue, Dec 07, 2010 at 11:17:18AM +0100, Guennadi Liakhovetski wrote:
>On Tue, 7 Dec 2010, Felipe Balbi wrote:
>
>> Hi,
>>
>> On Tue, Dec 07, 2010 at 10:56:45AM +0100, Guennadi Liakhovetski wrote:
>> > > On Tue, Dec 07, 2010 at 10:42:45AM +0100, Guennadi Liakhovetski wrote:
>> > > > I managed to bring a mainline 2.6.36 kinda kernel to run on my bbxm,
>> > > > Debian rootfs in mmcblk0p2, but I'm getting no connection - neither over
>> > > > the SMSC chip, nor over usb-device in gadget mode, nor can I power on
>> > > the
>> > > > on-board hub to plug in a usb-to-eth dongle. What's the catch? How do I
>> > > > configure the kernel to get any of those to work?
>> > >
>> > > how about you try with current linux-omap HEAD ? Or linux-mainline HEAD ?
>> >
>> > Sure, can try, but do you have a specific change in mind or is it just a
>> > general suggestion? Which interface should work then?
>>
>> Just a general suggestion. Compile with omap2plus_defconfig. Should boot
>> fine AFAIK.
>
>That's the one I used, right.
>
>> Also, do you have the driver for the external hub + ethernet enabled ? I
>> think it's called sms9x or something similar.
>
>Yes for
>
>CONFIG_USB_NET_SMSC95XX=y
>
>but I don't see any config option for the hub?

just load that driver :-) should be fine, then you need to enable ehci
under Device Drivers -> USB

-- 
balbi
