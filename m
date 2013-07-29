From: Paul Walmsley <paul@pwsan.com>
Subject: Re: USB & hwmon on am33xx
Date: Mon, 29 Jul 2013 09:04:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307290856490.30864@utopia.booyaka.com>
References: <51DC3B39.6000104@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53705 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab3G2JEo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 05:04:44 -0400
In-Reply-To: <51DC3B39.6000104@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Hello Sebastian,

On Tue, 9 Jul 2013, Sebastian Andrzej Siewior wrote:

> I'm slowly losing my mind with hwmod.

Well, look on the bright side, its days are numbered...

> arch/arm/boot/dts/am33xx.dtsi has the ti,musb-am33xx node.
> 
> That one has "usb_otg_hs" as hwmod property.
> The entry for it arch/arm/mach-omap2/omap_hwmod_33xx_data.c uses
> AM33XX_CM_PER_USB0_CLKCTRL_OFFSET (0x1c) as the clk. The TRM only
> mentions this one, i.e. no USB1.
> 
> Now I have the following logical devices here:
> - usb0 instance + its glue code for irqs
> - usb1 instance + its glue code for irqs
> - two phy instances, one for USB0 and one USB1
> - one dma engine which serves both usb instances.
> 
> Shouldn't I have for each device (usb0/1, phy0/1, dma) a hwmod entry?
> Or is it enough to use the same entry for each device?

When hwmod was designed, it followed OMAP architectural conventions, which 
was that devices didn't share enable/disable register bitfields.  AM33xx 
seems not to have followed that convention.  This is not completely 
surprising since it was designed by a different group of people.

But when hwmod support was added for AM33xx, no one added code to deal 
with the AM33xx shared-bitfield model.  And I did not realize that this 
situation existed.

So ideally, what should happen is that the AM33xx guys should add code to 
deal with the problem.  Maybe by adding a hwmod flag to indicate that the 
IP block shares an enable/disable bitfield with other IP blocks, and that 
the hwmod code should find the other devices, and then implement some kind 
of use-counting for that case?


- Paul
