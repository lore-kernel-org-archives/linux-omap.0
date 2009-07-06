From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 2/2] ehci: Fix EHCI init for OMAP3EVM
Date: Mon, 6 Jul 2009 14:25:05 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404328C675C@dbde02.ent.ti.com>
References: <1246867091-13495-1-git-send-email-ajay.gupta@ti.com>
 <4A51B500.1080004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45708 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754059AbZGFIzO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jul 2009 04:55:14 -0400
In-Reply-To: <4A51B500.1080004@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: no To-header on input <"unlisted-recipients:;"@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "tony@atomide.com" <tony@atomide.com>

> >
> > +#ifdef CONFIG_MACH_OMAP3EVM
> > +	/* Setup phy reset pin for EHCI on OMAP3EVM */
> > +	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
> > +#endif
> Why don't put this into board-omap3evm.c?
> 
> For example, on beagle the phy reset signal is routed to GPIO147. I
> don't think we want to see several "#ifdef CONFIG_MACH_..." here.

Looks better but if USB itself is not included in the build then this part of code would be unnecessary in board-omap3evm.c. We again need to add some #ifdef there to avoid this.

Another solution is to add something like board_is_omap3evm() in <mach/board.h> and use them in usb-ehci.c.

Felipe, what do you suggest?

> 
> Moreover, that setup_ehci_io_mux() function is also board-specific since
> different boards may use different pinmux settings  or  different USB
> ports may be enabled/disabled there. Well, at least the function should
> allow to configure only required USB ports.

This is coming very soon.

-Ajay
> 
> 
> Dmitry
> >  	if (platform_device_register(&ehci_device) < 0) {
> >  		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
> >  		return;
> 

