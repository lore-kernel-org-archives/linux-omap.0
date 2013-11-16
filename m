From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] ARM: dts: Add basic support for omap3 LDP zoom1
 labrador
Date: Sat, 16 Nov 2013 06:40:34 -0800
Message-ID: <20131116144033.GG10317@atomide.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-5-git-send-email-tony@atomide.com>
 <20131116080408.GA15300@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46660 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab3KPOkj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 09:40:39 -0500
Content-Disposition: inline
In-Reply-To: <20131116080408.GA15300@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>

* Sebastian Reichel <sre@ring0.de> [131116 00:05]:
> On Fri, Nov 15, 2013 at 04:36:06PM -0800, Tony Lindgren wrote:
> > Basic things like serial, Ethernet, MMC, NAND, DSS, touchscreen
> > and GPIO keys work.
> > 
> > For twl4030-keypad we're still missing the binding, but
> > support for that should be trivial to add once the driver
> > has been updated.
> 
> DT bindings for twl4030-keypad are being worked on:
> 
> https://lkml.org/lkml/2013/11/8/463
> 
> > MUSB I'm pretty sure I got got to enumerate once, but I
> > suspect the battery charging somehow disrupts it and it's
> > not enumerating in general for some reason.
> 
> Try to add this:
> 
> &usb_otg_hs {
> 	phys = <&usb2_phy>;
> 	phy-names = "usb2-phy";
> };
> 
> Those were introduced by the new generic PHY framework, see
> for example: https://lkml.org/lkml/2013/9/27/37

Thanks yeah those should be added. No luck with those either
though, I do have MUSB working fine on the 37xx-evm with the
same image.

I seem to get twl4030_usb interrupts on cable insert and remove,
then enabling debugging I see the following:

connect
HW_CONDITIONS 0xe0/224; link 3

disconnect
HW_CONDITIONS 0x60/96; link 4

Regards,

Tony
