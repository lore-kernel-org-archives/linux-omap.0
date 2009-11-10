From: Brad Parker <brad@heeltoe.com>
Subject: Re: omap3 otg host not working since 2.6.28? (sys_boot affects this)
Date: Tue, 10 Nov 2009 08:10:23 -0500
Message-ID: <4AF9663F.6090209@heeltoe.com>
References: <4AF77A53.2050908@heeltoe.com> (sfid-20091108_212116_372818_F5ADC3B1)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway.heeltoe.com ([66.134.219.32]:12126 "EHLO
	gateway.heeltoe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153AbZKJNKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 08:10:03 -0500
Received: from brad-parkers-macbook.local (localhost [127.0.0.1])
	by gateway.heeltoe.com (Postfix) with ESMTP id 6282FCC06C
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 08:10:08 -0500 (EST)
In-Reply-To: <4AF77A53.2050908@heeltoe.com> (sfid-20091108_212116_372818_F5ADC3B1)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Brad Parker wrote:
> I can't get OTG host mode to work with any recent kernels.  I'm 
> curious if anyone else has tried this.
> It may well be something most people don't do.
I know it's poor form to respond to you own posts, but I thought I'd 
add/ask the following:

I've found that the sys_boot settings can affect whether OTG host mode 
works or does not work (when it works :-)

Has anyone else seen this? 

OMAP3530; the beagleboard uses 01111 for sys_boot[4:0];  If you set them 
to say,  00110,
USB OTG host won't work, even in older kernels which normally work.

01111 is  nand,usb,uart3,mmc
00110 is mmc,usb

So in the second case it looks like the ROM has not touched the USB 
hardware when it
boots from from mmc.  In the first case it has set up the USB OTG hardware.

It seems that the OMAP ROM is doing something in the way of hardware 
initialization which
the linux driver is depending on...

-brad

