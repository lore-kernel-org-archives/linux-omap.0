From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
 usb: ehci: fix use of hcd->regs)
Date: Tue, 16 Sep 2008 11:35:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C4347F19@dbde02.ent.ti.com>
References: <20080912121024.GG759@gandalf.research.nokia.com>
 <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com>
 <20080914185721.GB6943@frodo> <200809152248.19959.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51695 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550AbYIPGFr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 02:05:47 -0400
In-Reply-To: <200809152248.19959.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

> [patch] omap: usb: ehci: fix use of hcd->regs)
> 
> > Subject: [PATCH 2/4] omap: usb: ehci: switch to use gpiolib
> >
> > Quit using omap-specific gpio handling and start using
> > gpiolib for ehci-omap.c
> >
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> ... yes, but also move all the pinmuxing to arch/arm/plat-omap/something
> 

Pin-muxing is done in the board file. Is there a problem with that?

- Anand