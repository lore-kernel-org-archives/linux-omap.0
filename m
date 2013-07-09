From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: USB & hwmon on am33xx
Date: Tue, 9 Jul 2013 23:38:05 +0530
Message-ID: <51DC5185.4000804@ti.com>
References: <51DC3B39.6000104@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52994 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab3GISI0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jul 2013 14:08:26 -0400
In-Reply-To: <51DC3B39.6000104@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On 7/9/2013 10:02 PM, Sebastian Andrzej Siewior wrote:
> Hi Paul,
>
> I'm slowly losing my mind with hwmod.
>
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
Yes, you need hwmod entry for each of the above device. Since USB has only only
clock ctrl register, have one as parrent and make other  devices as child node.
you can take CPSW as an example.

Regards
Mugunthan V N
