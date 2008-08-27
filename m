From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Enabling MUSB support
Date: Wed, 27 Aug 2008 16:38:25 +0300
Message-ID: <20080827133825.GC7354@gandalf.research.nokia.com>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19067 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbYH0Nim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 09:38:42 -0400
Content-Disposition: inline
In-Reply-To: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ashwin Bihari <abihari@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wed, Aug 27, 2008 at 09:26:34AM -0400, ext Ashwin Bihari wrote:
> Greetings,
> 
> I'm trying to test out the MUSB support on my OMAP-3530 based device
> with the TWL4030 Phy. I'm using 2.6.22.18 and have tried to enable all

I'll probably start the same discussion again, that's a rather old
kernel. It would be nice to try out current git tree from [1] and report
again if it works or not.

I tried musb on omap2420 (with tusb), omap3430 and omap3530 (beagle
board) and all of them are working.

> different settings related to MUSB and nothing seems to happen. The
> TWL4030_USB driver builds and loads and claims that a cable is plugged
> in even when nothing is plugged in.

Sounds like a bug in twl4030-usb.c

> The "musb_hdrc" driver loads up and registers with IRQs 92 and 93. The
> TWL4030_USB driver registers with IRQ 373. As I plug-in and remove the
> cable from the USB port, no interrupts are generated and the driver is
> completely oblivious to what's happening..

Do you have id pin grounded ?

> I'm trying to configure the MUSB driver as a Host-only to start with,
> I've also tried to set it as OTG with no change.

Use it as otg and put a gadget driver as well, it's better.

> My current ".config" is as follows, could someone point me to any
> configuration option or anything that I'm missing..

I'd just suggest you to use as otg and put a gadget driver.

Which board are you using ? Is it some development board or a custom
board ?

Development boards have a defconfig that might help you.

-- 
balbi
