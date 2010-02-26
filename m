From: "Maulik" <x0082077@ti.com>
Subject: RE: [PATCH 2/4] USB: MUSB: Enable MUSB for OMAP4 in Kconfig
Date: Fri, 26 Feb 2010 14:10:31 +0530
Message-ID: <000001cab6bf$5df75720$808918ac@apr.dhcp.ti.com>
References: <1267079758-14480-1-git-send-email-x0082077@ti.com> <20100225184833.GG28173@atomide.com> <20100226004233.GA3241@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54562 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935550Ab0BZIkt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 03:40:49 -0500
In-Reply-To: <20100226004233.GA3241@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Olof Johansson' <olof@lixom.net>, 'Tony Lindgren' <tony@atomide.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, 'Felipe Balbi' <felipe.balbi@nokia.com>, 'Greg Kroah-Hartman' <gregkh@suse.de>, 'David Brownell' <david-b@pacbell.net>

> > @@ -153,7 +157,7 @@ config MUSB_PIO_ONLY
> >  config USB_INVENTRA_DMA
> >  	bool
> >  	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
> > -	default ARCH_OMAP2430 || ARCH_OMAP34XX || BLACKFIN
> > +	default ARCH_OMAP2430 || ARCH_OMAP34XX || BLACKFIN || ARCH_OMAP4
> >  	help
> >  	  Enable DMA transfers using Mentor's engine.
> 
> FYI, this needs to be updated as I have patches queued up
> to replace ARCH_OMAP34XX and with ARCH_OMAP3. You might
> want to check all these patches for that and make sure
> they build and work with the omap-for-linus branch.

Tony,

I shall post a newer version after rebasing and fixing the comments. 
I believe your patches will soon make to mainline :-)

>>Adding more and more depends also doesn't scale well. It's time for
>>someone to switch the test around, add a ARCH_HAS_MUSB, select it on
>>the platforms that has it and make the config option depend on that,
>>similar to how (some) platforms to EHCI today.

>>(i.e. if there's a janitor out there reading this, feel free to go ahead
>>and do it. :-)

Olof,

We have such an option "USB_MUSB_SOC" that takes care of all platforms where
MUSB is present. But the Inventra DMA case is typical. Not all architectures
that have MUSB use Inventra DMA for e.g Davinci uses CPPI DMA.

Thanks,
Maulik

