From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix compile error in usb-musb.c
Date: Sun, 18 Jan 2009 13:33:31 +0200
Message-ID: <20090118113324.GC7976@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B88@dbde02.ent.ti.com> <200901161327.52661.david-b@pacbell.net> <20090116221920.GC8189@frodo> <200901161431.00469.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50186 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764949AbZARLdj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Jan 2009 06:33:39 -0500
Content-Disposition: inline
In-Reply-To: <200901161431.00469.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [090117 00:31]:
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

Might be worth looking what it would take to make dummy CONFIG_PM
compile in mainline for mach-omap2.

Tony
