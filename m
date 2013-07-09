From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: USB & hwmon on am33xx
Date: Tue, 09 Jul 2013 18:32:57 +0200
Message-ID: <51DC3B39.6000104@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58394 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab3GIQdC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jul 2013 12:33:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Hi Paul,

I'm slowly losing my mind with hwmod.

arch/arm/boot/dts/am33xx.dtsi has the ti,musb-am33xx node.

That one has "usb_otg_hs" as hwmod property.
The entry for it arch/arm/mach-omap2/omap_hwmod_33xx_data.c uses
AM33XX_CM_PER_USB0_CLKCTRL_OFFSET (0x1c) as the clk. The TRM only
mentions this one, i.e. no USB1.

Now I have the following logical devices here:
- usb0 instance + its glue code for irqs
- usb1 instance + its glue code for irqs
- two phy instances, one for USB0 and one USB1
- one dma engine which serves both usb instances.

Shouldn't I have for each device (usb0/1, phy0/1, dma) a hwmod entry?
Or is it enough to use the same entry for each device?

Sebastian
