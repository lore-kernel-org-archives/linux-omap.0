From: Tony Lindgren <tony@atomide.com>
Subject: Re: USB OTG doesn't work in HOST mode on OMAP3 processor on 3.18-rc5
Date: Mon, 17 Nov 2014 10:04:13 -0800
Message-ID: <20141117180413.GF7046@atomide.com>
References: <CAFqH_53hyYO9DHfhzDhYkTnimKR0FOQuUw4OGCM4myKoOJSQRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60106 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaKQSEg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2014 13:04:36 -0500
Content-Disposition: inline
In-Reply-To: <CAFqH_53hyYO9DHfhzDhYkTnimKR0FOQuUw4OGCM4myKoOJSQRA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, balbi@ti.com

* Enric Balletbo Serra <eballetbo@gmail.com> [141117 07:15]:
>  Hi all,
> 
> I'm trying to use the USB OTG driver of OMAP3 processor in HOST mode
> when it's configured in dual role mode (CONFIG_USB_MUSB_DUAL_ROLE=y)
> 
> The test case that I'm trying to solve is as follows.
> 
> 1) Boot the board.
> 2) Put the USB ID pin to ground
> 3) Connect a pendrive.
> 
> In such case doesn't work as expected and pendrive is never detected.
> 
> Enabling debug information, I see that the phyter (twl4030) is
> constantly polling the STS_HW_CONDITIONS register, who reports:
> 
>   twl4030_usb 48070000.i2c:twl@48:twl4030-usb: HW_CONDITIONS 0x54/84; link 1
> 
> The STS_HW_CONDITIONS register reports:
> 
> Bit 2: STS_USB : 1: USB is plugged in.
> Bit 4: STS_WAKEUP1: Level status of WAKEUP1 pad (active high) = nSLEEP1
> Bit 6: STS_WAKEUP3: Level status of WAKEUP3 pad (active high) = CLKREQ
> 
> I guess that in this case the state machine is waiting for VBUS, and
> looks for bit 7 STS_VBUS (Level status of VBUS port), but this never
> occurs. Using an oscilloscope I checked VBUS level and I can confirm
> that it's a 0 level.
> 
> My understand is that in this case the driver should enable VBUS but I
> didn't find where is the best place to do this and why is not doing
> this already. Any clue on this?

Just tested v3.18-rc5 with beagleboard xm, and the host mode
enumerates the devices, then may fail with "insufficient bus power"
at least for the WLAN device I tried with.

I noticed that this only works with CONFIG_USB_MUSB_HDRC and
CONFIG_TWL4030_USB built into the kernel. No luck so far with them
as loadable modules for some reason. Looks like also USB gadgets
fail with MUSB as modules.

And on the 37xx EVM, I've never had any luck getting any twl4030_usb
interrupts for some reason.

Regards,

Tony
