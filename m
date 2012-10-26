From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP1: usb: fix sparse warnings
Date: Fri, 26 Oct 2012 21:25:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210262125410.11258@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210262051290.11258@utopia.booyaka.com> <20121026212059.GV11908@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41144 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966609Ab2JZV0A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 17:26:00 -0400
In-Reply-To: <20121026212059.GV11908@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

On Fri, 26 Oct 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [121026 13:54]:
> > 
> > Resolve the following sparse warnings:
> > 
> > arch/arm/mach-omap1/usb.c:304:12: warning: symbol 'omap1_usb0_init' was not declared. Should it be static?
> > arch/arm/mach-omap1/usb.c:412:12: warning: symbol 'omap1_usb1_init' was not declared. Should it be static?
> > arch/arm/mach-omap1/usb.c:478:12: warning: symbol 'omap1_usb2_init' was not declared. Should it be static?
> > 
> > by declaring those functions as static.  Also remove the unneeded
> > prototypes and related code from the plat/usb.h header file.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > ---
> > 
> > Tony, care to take this one?
> 
> Let's apply just the usb.c changes on omap-for-v3.8/cleanup-headers
> as plat/usb.h is now gone?

OK no problem, thought you might want it for the -rc series...

- Paul
