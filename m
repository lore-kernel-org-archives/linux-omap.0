From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix compile error in usb-musb.c
Date: Sat, 17 Jan 2009 00:41:11 +0200
Message-ID: <20090116224111.GD8189@frodo>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B88@dbde02.ent.ti.com> <200901161327.52661.david-b@pacbell.net> <20090116221920.GC8189@frodo> <200901161431.00469.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51122 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759510AbZAPWlU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 17:41:20 -0500
Content-Disposition: inline
In-Reply-To: <200901161431.00469.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Tony Lindgren <tony@atomide.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Jan 16, 2009 at 02:31:00PM -0800, David Brownell wrote:
> On Friday 16 January 2009, Felipe Balbi wrote:
> > On Fri, Jan 16, 2009 at 01:27:52PM -0800, David Brownell wrote:
> > > So why not just enable PM=y in the configuration?  It's not
> > > actually required to do much, beyond not being broken.
> > 
> > That patch would have to go through tony
> > 
> > arch/arm/plat-omap/include/mach/pm.h:
> > 
> > #if     !defined(CONFIG_ARCH_OMAP730) && \
> > 	!defined(CONFIG_ARCH_OMAP15XX) && \
> > 	!defined(CONFIG_ARCH_OMAP16XX) && \
> > 	!defined(CONFIG_ARCH_OMAP24XX) && \
> > 	!defined(CONFIG_ARCH_OMAP34XX)
> > #error "Power management for this processor not implemented yet"
> > #endif
> 
> I didn't realize anyone outside of TI had their hands
> on OMAP4 chips yet.  :)

hehe, the last line isn't in mainline ;-)

-- 
balbi
