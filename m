From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: How to handle named resources with DT?
Date: Fri, 12 Aug 2011 16:40:21 +0200
Message-ID: <201108121640.22199.arnd@arndb.de>
References: <4E40FC88.5090403@ti.com> <20110812041016.GA6618@S2100-06.ap.freescale.net> <4E44EAAD.1030805@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57874 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab1HLOk3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 10:40:29 -0400
In-Reply-To: <4E44EAAD.1030805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Shawn Guo <shawn.guo@freescale.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>

On Friday 12 August 2011, Cousson, Benoit wrote:
> > Arnd Bergmann:
> > But I really don't think there is value in using IORESOURCE_DMA for this.
> > We don't have the code to manage DMA resources for more than one DMA
> > controller AFAICT, and I think we should not add it. Globally
> > unique interrupt numbers cause us a lot of trouble and we go to great
> > lengths to fake them on modern devices.
> 
> Yeah, that totally makes sense. We do have several DMA engines in OMAP 
> anyway, so unique number is clearly not the best approach.
> But in that case, it means adding a new kernel API for that and not only 
> an of_XXX one. Because driver should then rely on it with or without DT.
> 
> > It would be much better
> > not to have them visible in the OS, and I don't want to add them to
> > a modern API like the dmaengine.
> 
> That part is less clear to me, what does it means?
> 

I mean you can have DMA channel numbers visible in the device
tree, relative to a 'parent' dma controller, but I would not
expose them as numbers on a device driver interface. Instead,
I think the interface we provide to the device driver is one
where we pass the device using the DMA channel into a generic
dmaengine API and let that figure out where it's connected
in order to return a struct dma_chan pointer.

	ARnd
