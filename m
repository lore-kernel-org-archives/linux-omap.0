From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: usb: fix sparse warnings
Date: Fri, 26 Oct 2012 14:28:41 -0700
Message-ID: <20121026212841.GW11908@atomide.com>
References: <alpine.DEB.2.00.1210262051290.11258@utopia.booyaka.com>
 <20121026212059.GV11908@atomide.com>
 <alpine.DEB.2.00.1210262125410.11258@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:35308 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945941Ab2JZV2o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 17:28:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210262125410.11258@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

* Paul Walmsley <paul@pwsan.com> [121026 14:27]:
> On Fri, 26 Oct 2012, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [121026 13:54]:
> > > 
> > > Resolve the following sparse warnings:
> > > 
> > > arch/arm/mach-omap1/usb.c:304:12: warning: symbol 'omap1_usb0_init' was not declared. Should it be static?
> > > arch/arm/mach-omap1/usb.c:412:12: warning: symbol 'omap1_usb1_init' was not declared. Should it be static?
> > > arch/arm/mach-omap1/usb.c:478:12: warning: symbol 'omap1_usb2_init' was not declared. Should it be static?
> > > 
> > > by declaring those functions as static.  Also remove the unneeded
> > > prototypes and related code from the plat/usb.h header file.
> > > 
> > > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > ---
> > > 
> > > Tony, care to take this one?
> > 
> > Let's apply just the usb.c changes on omap-for-v3.8/cleanup-headers
> > as plat/usb.h is now gone?
> 
> OK no problem, thought you might want it for the -rc series...

Looks like it's not urgent for the -rc series, so let's not
introduce more self-inflicted merge conflicts. If that's OK
with you, I can apply it to omap-for-v3.8/cleanup-headers
without the header changes.

Regards,

Tony
