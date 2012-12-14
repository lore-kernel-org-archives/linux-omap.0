From: Tony Lindgren <tony@atomide.com>
Subject: Re: MUSB-HDRC Gadget driving VBUS inappropriately
Date: Fri, 14 Dec 2012 10:43:11 -0800
Message-ID: <20121214184309.GE4989@atomide.com>
References: <C3E8C797-AE49-4638-B41B-B3AE180D3426@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16834 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756964Ab2LNSnO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 13:43:14 -0500
Content-Disposition: inline
In-Reply-To: <C3E8C797-AE49-4638-B41B-B3AE180D3426@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ian Coolidge <iancoolidge@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, notasas@gmail.com, balbi@ti.com, felipe.contreras@gmail.com, icoolidge@trellisware.com

* Ian Coolidge <iancoolidge@gmail.com> [121214 01:55]:
> Hi,
> 
> We're using Linux 3.3 on DM3730 with TPS6595xx PMIC for an embedded product.
> For a particular board, we have musb-hdrc (RTL 1.4) configured in peripheral mode.
> We use the Ethernet gadget configured for cdc_eem to use Ethernet emulation over USB for this link, and the robustness of the link is mission-critical. To assure this, we have performed some massive reboot testing to ensure that this usb link reliably comes up.

Hehehe I've never seen MUSB and mission critical in the same
sentence before :)
 
> After working through an issue which required pulling in the following patch,
> -----
> commit b1b552a69b8805e7e338074a9e8b670b4a795218
> Author: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Date:   Wed Aug 8 11:48:10 2012 +0200
> 
>     usb: gadget: u_ether: fix kworker 100% CPU issue with still used interfaces in eth_stop
> -----
> 
> we find that with about a 2% chance, the gadget comes up in some kind of firmware failed state, driving VBUS.
> In this condition, we found that MUSB_DEVCTL_SESSION bit was set.
> I understand this to be indicative of MUSB thinking it is in host mode, which agrees with the driven VBUS.
> Further, in this state, I found that usually, there was one interrupt from twl4030_usb, but NO interrupts from musb-hdrc.
> 
> So, as a hack, I cleared MUSB_DEVCTL_SESSION in omap2430.c in the notifier block from the VBUS interrupt.
> This appears to reduce the frequency of the problem -- I now always at least one instance of the musb-hdrc interrupt.
> However, sometimes, it looks like the MUSB PHY dies shortly thereafter.
> So, I don't think this hack is fully effective.
> 
> I reviewed commits that post-date 3.3 in omap2430.c, musb_core.c, twl4030-usb.c, musb_gadget.c, and I couldn't find anything interesting -- it looks like mostly reorganization has taken place.
> 
> We have also engaged TI to try to get some silicon errata from Mentor Graphics, and maybe a register manual for the MUSB HDRC IP, but this is slow going, and that has little guarantee of paying off anyways.
> 
> Are there any ideas, or patches that anyone might suggest?

Don't know if this is related, but it might.

I've noticed and issu with MUSB host mode where MUSB with
USB-A cable plugged in fails to come up properly in host mode.

It seems to require replugging the USB cable to get it to
work in host mode. To reproduce this issue:

1. Boot system with USB-A cable connected and some devices

2. Load g_ether or some gadget module and notice how the
   USB devices are not discovered, and reloading g_ether
   does not help.

3. Unplug the USB-A cable, plug in USB-B cable, then
   plug in USB-A cable again, and the devices are discovered.

This one is annoying as it means that trying to use Panda
with USB HID devices connected to the MUSB port does not
discover them. And the reason to do that is to keep the
EHCI ports free for other use naturally..

Regards,

Tony
