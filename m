From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/4] USB: MUSB: Enable MUSB for OMAP4 in Kconfig
Date: Thu, 25 Feb 2010 18:42:33 -0600
Message-ID: <20100226004233.GA3241@lixom.net>
References: <1267079758-14480-1-git-send-email-x0082077@ti.com> <20100225184833.GG28173@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.lixom.net ([66.141.50.11]:35946 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934688Ab0BZAgU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Feb 2010 19:36:20 -0500
Content-Disposition: inline
In-Reply-To: <20100225184833.GG28173@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Maulik Mankad <x0082077@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <david-b@pacbell.net>

On Thu, Feb 25, 2010 at 10:48:34AM -0800, Tony Lindgren wrote:
> * Maulik Mankad <x0082077@ti.com> [100224 22:33]:
> > This patch adds the OMAP4 Kconfig options for MUSB.
> > 
> > Signed-off-by: Maulik Mankad <x0082077@ti.com>
> > Cc: Felipe Balbi <felipe.balbi@nokia.com>
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> > Cc: David Brownell <david-b@pacbell.net
> > ---
> > Index: mainline/drivers/usb/musb/Kconfig
> > ===================================================================
> > --- mainline.orig/drivers/usb/musb/Kconfig
> > +++ mainline/drivers/usb/musb/Kconfig
> > @@ -38,6 +38,7 @@ config USB_MUSB_SOC
> >  	default y if ARCH_DAVINCI
> >  	default y if ARCH_OMAP2430
> >  	default y if ARCH_OMAP34XX
> > +	default y if ARCH_OMAP4
> >  	default y if (BF54x && !BF544)
> >  	default y if (BF52x && !BF522 && !BF523)
> >  
> > @@ -50,6 +51,9 @@ comment "OMAP 243x high speed USB suppor
> >  comment "OMAP 343x high speed USB support"
> >  	depends on USB_MUSB_HDRC && ARCH_OMAP34XX
> >  
> > +comment "OMAP 44xx high speed USB support"
> > +	depends on USB_MUSB_HDRC && ARCH_OMAP4
> > +
> >  comment "Blackfin high speed USB Support"
> >  	depends on USB_MUSB_HDRC && ((BF54x && !BF544) || (BF52x && !BF522 && !BF523))
> >  
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

Adding more and more depends also doesn't scale well. It's time for
someone to switch the test around, add a ARCH_HAS_MUSB, select it on
the platforms that has it and make the config option depend on that,
similar to how (some) platforms to EHCI today.

(i.e. if there's a janitor out there reading this, feel free to go ahead
and do it. :-)


-Olof
