From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 3/9] ehci: correct EHCI init parameters on OMAP3EVM
Date: Fri, 7 Aug 2009 14:36:20 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940432AF4189@dbde02.ent.ti.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-2-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-3-git-send-email-ajay.gupta@ti.com>
 <20090806124323.GO2358@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56818 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757114AbZHGJGg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 05:06:36 -0400
In-Reply-To: <20090806124323.GO2358@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>

> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> > index 595beac..b497979 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -308,7 +308,9 @@ static void __init omap3_evm_init(void)
> >
> >  	omap_serial_init();
> >  	usb_musb_init();
> > -	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
> > +	/* Setup EHCI phy reset padconfig */
> > +	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
> > +	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, -EINVAL, 135);
> >  	ads7846_dev_init();
> >  }
> 
> Is this safe to do if you don't have the daughter card? If so, maybe
> add a comment for it.

Yes, it is safe for OMAP3EVM even if there is no DC but we can add comment as you suggested.

> 
> I guess the nicest thing would be to wait until the daughter card
> is probed based on some I2C chip id and only then mux the pins.

I agree that this would be the best but this requires OMAP3EVM DC related patch from Vaibhav which is still under review.

I feel we can add this logic once other dependent patches are accepted.

-Ajay
> 
> Tony

